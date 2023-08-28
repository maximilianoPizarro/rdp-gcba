--
-- PostgreSQL database dump
--

-- Dumped from database version 10.15
-- Dumped by pg_dump version 14.2

-- Started on 2023-08-28 16:07:48

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 2304 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 211 (class 1255 OID 16386)
-- Name: activos_hoy(); Type: FUNCTION; Schema: public; Owner: infraestructura
--

CREATE FUNCTION public.activos_hoy() RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
    _respuesta varchar;
    _contador int4;
    inf RECORD;
    cursorInf CURSOR FOR SELECT a.type as area, COUNT(*) as cantidad FROM public.traer_host h, host_area a WHERE h.hostarea_id=a.id and h.fechahora >=now()::date GROUP BY a.type; 
 
BEGIN  
OPEN cursorInf;
    IF cursorInf IS NULL THEN
        _respuesta=CONCAT(_respuesta,'null');
        RETURN _respuesta;
    ELSE 
         FETCH cursorInf INTO inf;
         WHILE( FOUND ) LOOP
		_respuesta=CONCAT(_respuesta,'{"c":[{"v":"',inf.area,'","f":null }',',{"v":',inf.cantidad,',"f":null}]},');
                    FETCH cursorInf INTO inf;
                    END LOOP;
              _respuesta=SUBSTRING(_respuesta,1,char_length(_respuesta)-1);
        RETURN _respuesta;    
    END IF;    
END;
$$;


ALTER FUNCTION public.activos_hoy() OWNER TO infraestructura;

--
-- TOC entry 212 (class 1255 OID 16387)
-- Name: pc_por_area(); Type: FUNCTION; Schema: public; Owner: infraestructura
--

CREATE FUNCTION public.pc_por_area() RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
    _respuesta varchar;
    _contador int4;
    inf RECORD;
    cursorInf CURSOR FOR SELECT a.type as area, COUNT(*) as cantidad FROM host h, host_area a WHERE h.hostarea_id=a.id GROUP BY a.type; 
BEGIN  
OPEN cursorInf;
    IF cursorInf IS NULL THEN
        _respuesta=CONCAT(_respuesta,'null');
        RETURN _respuesta;
    ELSE 
         FETCH cursorInf INTO inf;
         WHILE( FOUND ) LOOP
		_respuesta=CONCAT(_respuesta,'{"c":[{"v":"',inf.area,'","f":null }',',{"v":',inf.cantidad,',"f":null}]},');
                    FETCH cursorInf INTO inf;
                    END LOOP;
              _respuesta=SUBSTRING(_respuesta,1,char_length(_respuesta)-1);
        RETURN _respuesta;    
    END IF;    
END;
$$;


ALTER FUNCTION public.pc_por_area() OWNER TO infraestructura;

--
-- TOC entry 213 (class 1255 OID 16388)
-- Name: traer_host(character varying); Type: FUNCTION; Schema: public; Owner: infraestructura
--

CREATE FUNCTION public.traer_host(_cant character varying) RETURNS TABLE(idhost integer, cpu_vendedor character varying, cpu_modelo character varying, cpu_mhz character varying, cpu_fisicas character varying, cpu_nucleos character varying, mac character varying, red_host character varying, so_fabricante character varying, so_arquitectura character varying, so_version character varying, java_version character varying, usuario character varying, hostarea_id bigint, ram bigint, hdd bigint, observacion character varying, loginultimomov bigint, fechahora timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
DECLARE	
BEGIN
RETURN query
SELECT * from traer_host h
WHERE CAST(h.fechahora AS DATE) + CAST((CONCAT(_cant,'days')) AS INTERVAL) <= (now()::date);
END;
$$;


ALTER FUNCTION public.traer_host(_cant character varying) OWNER TO infraestructura;

--
-- TOC entry 226 (class 1255 OID 16389)
-- Name: traer_host_update(character varying); Type: FUNCTION; Schema: public; Owner: infraestructura
--

CREATE FUNCTION public.traer_host_update(_cant character varying) RETURNS TABLE(idhost integer, mac character varying, red_host character varying, fechahora timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
DECLARE	
BEGIN
RETURN query
SELECT h.idhost,h.mac,h.red_host,h.fechahora from traer_host h
WHERE CAST(h.fechahora AS DATE) + CAST((CONCAT(_cant,'days')) AS INTERVAL) <= (now()::date);
END;
$$;


ALTER FUNCTION public.traer_host_update(_cant character varying) OWNER TO infraestructura;

--
-- TOC entry 227 (class 1255 OID 16390)
-- Name: trigger_host(); Type: FUNCTION; Schema: public; Owner: infraestructura
--

CREATE FUNCTION public.trigger_host() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE BEGIN
	INSERT INTO movimiento VALUES(nextval('movimiento_id_seq'::regclass),current_timestamp(1), NEW.observacion, NEW.mac, NEW.loginultimomov);
        	RETURN NULL;
END;
$$;


ALTER FUNCTION public.trigger_host() OWNER TO infraestructura;

--
-- TOC entry 196 (class 1259 OID 16391)
-- Name: app_user_id_seq; Type: SEQUENCE; Schema: public; Owner: infraestructura
--

CREATE SEQUENCE public.app_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_user_id_seq OWNER TO infraestructura;

SET default_tablespace = '';

--
-- TOC entry 197 (class 1259 OID 16393)
-- Name: app_user; Type: TABLE; Schema: public; Owner: infraestructura
--

CREATE TABLE public.app_user (
    id bigint DEFAULT nextval('public.app_user_id_seq'::regclass) NOT NULL,
    sso_id character varying(30) NOT NULL,
    password character varying(100) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(50) NOT NULL
);


ALTER TABLE public.app_user OWNER TO infraestructura;

--
-- TOC entry 198 (class 1259 OID 16397)
-- Name: app_user_user_profile; Type: TABLE; Schema: public; Owner: infraestructura
--

CREATE TABLE public.app_user_user_profile (
    user_id bigint NOT NULL,
    user_profile_id bigint NOT NULL
);


ALTER TABLE public.app_user_user_profile OWNER TO infraestructura;

--
-- TOC entry 199 (class 1259 OID 16400)
-- Name: host_idhost_seq; Type: SEQUENCE; Schema: public; Owner: infraestructura
--

CREATE SEQUENCE public.host_idhost_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.host_idhost_seq OWNER TO infraestructura;

--
-- TOC entry 200 (class 1259 OID 16402)
-- Name: host; Type: TABLE; Schema: public; Owner: infraestructura
--

CREATE TABLE public.host (
    idhost integer DEFAULT nextval('public.host_idhost_seq'::regclass) NOT NULL,
    cpu_vendedor character varying,
    cpu_modelo character varying,
    cpu_mhz character varying,
    cpu_fisicas character varying,
    cpu_nucleos character varying,
    mac character varying NOT NULL,
    red_host character varying,
    so_fabricante character varying,
    so_arquitectura character varying,
    so_version character varying,
    java_version character varying,
    usuario character varying,
    hostarea_id bigint,
    ram bigint,
    hdd bigint,
    observacion character varying,
    loginultimomov bigint
);


ALTER TABLE public.host OWNER TO infraestructura;

--
-- TOC entry 201 (class 1259 OID 16409)
-- Name: host_area_id_seq; Type: SEQUENCE; Schema: public; Owner: infraestructura
--

CREATE SEQUENCE public.host_area_id_seq
    START WITH 5
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.host_area_id_seq OWNER TO infraestructura;

--
-- TOC entry 202 (class 1259 OID 16411)
-- Name: host_area; Type: TABLE; Schema: public; Owner: infraestructura
--

CREATE TABLE public.host_area (
    id bigint DEFAULT nextval('public.host_area_id_seq'::regclass) NOT NULL,
    type character varying(80) NOT NULL
);


ALTER TABLE public.host_area OWNER TO infraestructura;

--
-- TOC entry 203 (class 1259 OID 16415)
-- Name: host_update_id_seq; Type: SEQUENCE; Schema: public; Owner: infraestructura
--

CREATE SEQUENCE public.host_update_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.host_update_id_seq OWNER TO infraestructura;

--
-- TOC entry 204 (class 1259 OID 16417)
-- Name: host_update; Type: TABLE; Schema: public; Owner: infraestructura
--

CREATE TABLE public.host_update (
    id integer DEFAULT nextval('public.host_update_id_seq'::regclass) NOT NULL,
    fkhost integer,
    fechahora timestamp(6) without time zone,
    ip character varying
);


ALTER TABLE public.host_update OWNER TO infraestructura;

--
-- TOC entry 205 (class 1259 OID 16424)
-- Name: movimiento_id_seq; Type: SEQUENCE; Schema: public; Owner: infraestructura
--

CREATE SEQUENCE public.movimiento_id_seq
    START WITH 118
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.movimiento_id_seq OWNER TO infraestructura;

--
-- TOC entry 206 (class 1259 OID 16426)
-- Name: movimiento; Type: TABLE; Schema: public; Owner: infraestructura
--

CREATE TABLE public.movimiento (
    id integer DEFAULT nextval('public.movimiento_id_seq'::regclass) NOT NULL,
    fechahoramov timestamp(6) without time zone NOT NULL,
    operacion character varying(400) NOT NULL,
    fkhost character varying NOT NULL,
    fkuser bigint NOT NULL
);


ALTER TABLE public.movimiento OWNER TO infraestructura;

--
-- TOC entry 207 (class 1259 OID 16433)
-- Name: traer_host; Type: VIEW; Schema: public; Owner: infraestructura
--

CREATE VIEW public.traer_host AS
 SELECT h.idhost,
    h.cpu_vendedor,
    h.cpu_modelo,
    h.cpu_mhz,
    h.cpu_fisicas,
    h.cpu_nucleos,
    h.mac,
    h.red_host,
    h.so_fabricante,
    h.so_arquitectura,
    h.so_version,
    h.java_version,
    h.usuario,
    h.hostarea_id,
    h.ram,
    h.hdd,
    h.observacion,
    h.loginultimomov,
    hu.fechahora,
    hu.ip
   FROM ((public.host h
     JOIN ( SELECT host_update.fkhost,
            max(host_update.fechahora) AS maxdate
           FROM public.host_update
          GROUP BY host_update.fkhost) maxdates ON ((h.idhost = maxdates.fkhost)))
     JOIN public.host_update hu ON (((maxdates.fkhost = hu.fkhost) AND (maxdates.maxdate = hu.fechahora))));


ALTER TABLE public.traer_host OWNER TO infraestructura;

--
-- TOC entry 208 (class 1259 OID 16438)
-- Name: traer_host_dos_semanas; Type: VIEW; Schema: public; Owner: infraestructura
--

CREATE VIEW public.traer_host_dos_semanas AS
 SELECT h.idhost,
    h.cpu_vendedor,
    h.cpu_modelo,
    h.cpu_mhz,
    h.cpu_fisicas,
    h.cpu_nucleos,
    h.mac,
    h.red_host,
    h.so_fabricante,
    h.so_arquitectura,
    h.so_version,
    h.java_version,
    h.usuario,
    h.hostarea_id,
    h.ram,
    h.hdd,
    h.observacion,
    h.loginultimomov,
    h.fechahora
   FROM public.traer_host h
  WHERE (((h.fechahora)::date + (concat(15, 'days'))::interval) <= (now())::date);


ALTER TABLE public.traer_host_dos_semanas OWNER TO infraestructura;

--
-- TOC entry 209 (class 1259 OID 16443)
-- Name: user_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: infraestructura
--

CREATE SEQUENCE public.user_profile_id_seq
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_profile_id_seq OWNER TO infraestructura;

--
-- TOC entry 210 (class 1259 OID 16445)
-- Name: user_profile; Type: TABLE; Schema: public; Owner: infraestructura
--

CREATE TABLE public.user_profile (
    id bigint DEFAULT nextval('public.user_profile_id_seq'::regclass) NOT NULL,
    type character varying(30) NOT NULL
);


ALTER TABLE public.user_profile OWNER TO infraestructura;

--
-- TOC entry 2287 (class 0 OID 16393)
-- Dependencies: 197
-- Data for Name: app_user; Type: TABLE DATA; Schema: public; Owner: infraestructura
--

INSERT INTO public.app_user VALUES (2, 'mateodecu', '123', 'mateo', 'decurgez', 'mateodecu@hotmail.com');
INSERT INTO public.app_user VALUES (12, 'abish', '123', 'Alejo', 'Bish', 'alejobish@gmail.com');
INSERT INTO public.app_user VALUES (1, 'maxpizarro', '123', 'maximiliano', 'pizarro', 'maximiliano.pizarro.5@gmail.com');
INSERT INTO public.app_user VALUES (17, 'vcumiano', '123', 'vanesa', 'cumiano', 'vanecumiano@buenosaires.gob.ar');
INSERT INTO public.app_user VALUES (18, 'admin', 'admin', 'admin', 'admin', 'admin@admin');


--
-- TOC entry 2288 (class 0 OID 16397)
-- Dependencies: 198
-- Data for Name: app_user_user_profile; Type: TABLE DATA; Schema: public; Owner: infraestructura
--

INSERT INTO public.app_user_user_profile VALUES (12, 2);
INSERT INTO public.app_user_user_profile VALUES (2, 2);
INSERT INTO public.app_user_user_profile VALUES (17, 7);
INSERT INTO public.app_user_user_profile VALUES (1, 6);
INSERT INTO public.app_user_user_profile VALUES (1, 2);
INSERT INTO public.app_user_user_profile VALUES (1, 7);
INSERT INTO public.app_user_user_profile VALUES (18, 6);
INSERT INTO public.app_user_user_profile VALUES (18, 2);
INSERT INTO public.app_user_user_profile VALUES (18, 7);


--
-- TOC entry 2290 (class 0 OID 16402)
-- Dependencies: 200
-- Data for Name: host; Type: TABLE DATA; Schema: public; Owner: infraestructura
--

INSERT INTO public.host VALUES (190, 'GenuineIntel', 'Intel(R) Core(TM) i5-7400T CPU @ 2.40GHz', '2400', '4', '4', '97-E0-0C-D4-53-C3', 'equipo9', 'Microsoft Windows', 'x64', '7', '1.8.0_181', '', 34, 8, 500, 'Alta de Host', 1);
INSERT INTO public.host VALUES (188, 'AMD', 'AMD', '1200', '2', '2', 'D7-E5-82-BE-18-F0', 'equipo8', 'Microsoft Windows', 'x32', '8', '1.8.0_171', '', 34, 4, 500, 'Actualizacion de contenido', 17);
INSERT INTO public.host VALUES (181, 'GenuineIntel', 'Intel(R) Core(TM) i5-7400T CPU @ 2.40GHz', '2400', '4', '4', 'BD-0E-AB-FD-7C-94', 'equipo1', 'Microsoft Windows', 'x64', '7', '1.8.0_181', '', 19, 4, 800, 'Actualizacion de contenido', 2);
INSERT INTO public.host VALUES (182, 'GenuineIntel', 'Intel(R) Core(TM) i5-7400T CPU @ 2.40GHz', '2400', '4', '4', '13-4C-46-AA-69-BF', 'equipo2', 'Microsoft Windows', 'x64', '10', '1.8.0_181', '', 2, 4, 800, 'Alta de Host', 1);
INSERT INTO public.host VALUES (183, 'AMD', 'AMD', '2400', '2', '2', '65-7F-3D-84-43-AE', 'equipo3', 'Microsoft Windows', 'x64', '7', '1.8.0_171', '', 3, 8, 800, 'Alta de Host', 1);
INSERT INTO public.host VALUES (185, 'GenuineIntel', 'Intel(R) Core(TM) i5-7400T CPU @ 2.40GHz', '2400', '4', '4', 'FB-82-3F-26-51-59', 'equipo5', 'Microsoft Windows', 'x32', '8', '1.8.0_171', '', 3, 4, 500, 'Alta de Host', 1);
INSERT INTO public.host VALUES (184, 'AMD', 'AMD', '2400', '4', '4', '73-0B-26-8C-2D-95', 'equipo4', 'Microsoft Windows', 'x32', '7', '1.8.0_181', '', 3, 4, 800, 'Actualizacion de contenido', 17);
INSERT INTO public.host VALUES (186, 'AMD', 'AMD', '2400', '4', '4', '8F-9C-FC-AD-48-C8', 'equipo6', 'Microsoft Windows', 'x64', '7', '1.8.0_181', '', 29, 4, 800, 'Alta de Host', 1);
INSERT INTO public.host VALUES (187, 'GenuineIntel', 'Intel(R) Core(TM) i5-7400T CPU @ 2.40GHz', '2400', '2', '4', '59-25-3C-D7-46-FE', 'equipo7', 'Microsoft Windows', 'x64', '10', '1.8.0_171', '', 34, 8, 500, 'Alta de Host', 1);
INSERT INTO public.host VALUES (189, 'GenuineIntel', 'Intel(R) Core(TM) i5-7400T CPU @ 2.40GHz', '2400', '4', '4', '9B-E8-2F-FD-95-E8', 'equipo9', 'Microsoft Windows', 'x64', '10', '1.8.0_171', '', 17, 8, 500, 'Alta de Host', 1);
INSERT INTO public.host VALUES (165, 'GenuineIntel', 'Intel(R) Core(TM) i5-7400T CPU @ 2.40GHz', '2401', '4', '4', '80-FA-5B-2C-72-49', 'equipo', 'Microsoft Windows', 'x64', '10', '1.8.0_181', 'Max', 1, 8, 385, 'Actualizacion de contenido', 1);


--
-- TOC entry 2292 (class 0 OID 16411)
-- Dependencies: 202
-- Data for Name: host_area; Type: TABLE DATA; Schema: public; Owner: infraestructura
--

INSERT INTO public.host_area VALUES (1, 'PROGRAMACION');
INSERT INTO public.host_area VALUES (2, 'ACTAS');
INSERT INTO public.host_area VALUES (3, 'ASUNTOS LEGALES');
INSERT INTO public.host_area VALUES (6, 'AUTOMOTORES');
INSERT INTO public.host_area VALUES (7, 'CENTRO DE GESTION DE LA MOVILIDAD');
INSERT INTO public.host_area VALUES (9, 'CENTRO DE GESTION DE LA MOVILIDAD(MONITOREO)
');
INSERT INTO public.host_area VALUES (10, 'CENTRO DE PROCESAMIENTO DE INFRACCIONES');
INSERT INTO public.host_area VALUES (11, 'CENTRO DE PROCESAMIENTO DE INFRACCIONES(ANPR)');
INSERT INTO public.host_area VALUES (12, 'CENTRO DE PROCESAMIENTO DE INFRACCIONES(CADV)');
INSERT INTO public.host_area VALUES (13, 'CENTRO DE PROCESAMIENTO DE INFRACCIONES(CECAITRA)');
INSERT INTO public.host_area VALUES (14, 'CENTRO DE PROCESAMIENTO DE INFRACCIONES(MOTOS)');
INSERT INTO public.host_area VALUES (15, 'COMBIS');
INSERT INTO public.host_area VALUES (16, 'COMPRAS Y PRESUPUESTO');
INSERT INTO public.host_area VALUES (17, 'CUCC');
INSERT INTO public.host_area VALUES (18, 'DCER');
INSERT INTO public.host_area VALUES (19, 'DESARROLLO HUMANO');
INSERT INTO public.host_area VALUES (20, 'DIRECCION	');
INSERT INTO public.host_area VALUES (21, 'DIRECCION GENERAL');
INSERT INTO public.host_area VALUES (22, 'DPTO. ALCOHOLEMIA');
INSERT INTO public.host_area VALUES (23, 'EDUCACION VIAL');
INSERT INTO public.host_area VALUES (24, 'GERENCIA OPERATIVA DE GESTIÓN DE OPERACIONES');
INSERT INTO public.host_area VALUES (25, 'GERENCIA OPERATIVA OBSERVATORIO VIAL');
INSERT INTO public.host_area VALUES (26, 'GESTION DE PLAYAS Y ABANDONADOS');
INSERT INTO public.host_area VALUES (27, 'GRUAS');
INSERT INTO public.host_area VALUES (28, 'INCORPORACION Y FORMACION DE AGENTES');
INSERT INTO public.host_area VALUES (29, 'MESA DE ENTRADA');
INSERT INTO public.host_area VALUES (30, 'OBSERVATORIO VIAL');
INSERT INTO public.host_area VALUES (31, 'PARQUE VIAL');
INSERT INTO public.host_area VALUES (32, 'PLANEAMIENTO');
INSERT INTO public.host_area VALUES (33, 'PLAYA DE ACARREO');
INSERT INTO public.host_area VALUES (34, 'RELACIONES INSTITUCIONALES');
INSERT INTO public.host_area VALUES (35, 'SISTEMA DE ESTACIONAMIENTO ORDENADO');
INSERT INTO public.host_area VALUES (37, 'SUBGERENCIA OPERATIVA DE ADMINISTRACION DE RECURSOS MATERIALES(COMUNICACIONES)	');
INSERT INTO public.host_area VALUES (38, 'SUBGERENCIA OPERATIVA DE ADMINISTRACION DE RECURSOS MATERIALES(MANTENIMIENTO)');
INSERT INTO public.host_area VALUES (39, 'SUBGERENCIA OPERATIVA DE ADMINISTRACION DE RECURSOS MATERIALES(PAÑOL)');
INSERT INTO public.host_area VALUES (40, 'SUBGERENCIA OPERATIVA DE ADMINISTRACION DE RECURSOS MATERIALES(SISTEMAS)');
INSERT INTO public.host_area VALUES (41, 'SUBGERENCIA OPERATIVA DE ADMINISTRACION DE RECURSOS MATERIALES(TALLER)');
INSERT INTO public.host_area VALUES (42, 'SUBGERENCIA OPERATIVA DE ADMINISTRACION DE RECURSOS MATERIALES(UNIFORMES)');
INSERT INTO public.host_area VALUES (43, 'SUBGERENCIA OPERATIVA DE RECURSOS MATERIALES');
INSERT INTO public.host_area VALUES (44, 'SUBGERENCIA OPERATIVA DE ZONA NORTE');
INSERT INTO public.host_area VALUES (45, 'SUBGERENCIA OPERATIVA ZONA CENTRO');
INSERT INTO public.host_area VALUES (46, 'SUBGERENCIA OPERATIVA ZONA NORTE');
INSERT INTO public.host_area VALUES (47, 'SUBGERENCIA OPERATIVA ZONA SUR');
INSERT INTO public.host_area VALUES (48, 'TALLER');
INSERT INTO public.host_area VALUES (36, 'SGO DE ADMIN DE RECURSOS HUMANOS');


--
-- TOC entry 2294 (class 0 OID 16417)
-- Dependencies: 204
-- Data for Name: host_update; Type: TABLE DATA; Schema: public; Owner: infraestructura
--

INSERT INTO public.host_update VALUES (61, 165, '2018-08-22 14:14:31.513', '10.68.11.36');
INSERT INTO public.host_update VALUES (62, 165, '2018-08-22 15:42:52.059', '10.68.11.36');
INSERT INTO public.host_update VALUES (74, 165, '2018-08-28 18:37:47.781', '10.68.11.36');
INSERT INTO public.host_update VALUES (75, 165, '2018-08-28 18:39:16.315', '10.68.11.36');
INSERT INTO public.host_update VALUES (76, 165, '2018-08-28 18:40:40.234', '10.68.11.36');
INSERT INTO public.host_update VALUES (77, 165, '2018-08-28 18:47:51.767', '10.68.11.36');
INSERT INTO public.host_update VALUES (78, 165, '2018-08-28 18:48:41.455', '10.68.11.36');
INSERT INTO public.host_update VALUES (79, 165, '2018-08-28 18:49:07.533', '10.68.11.36');
INSERT INTO public.host_update VALUES (80, 165, '2018-08-28 18:50:30.786', '10.68.11.36');
INSERT INTO public.host_update VALUES (81, 165, '2018-08-28 18:54:50.077', '10.68.11.36');
INSERT INTO public.host_update VALUES (82, 165, '2018-08-28 18:55:33.258', '10.68.11.36');
INSERT INTO public.host_update VALUES (87, 181, '2018-09-10 16:53:29.348', 'S/D');
INSERT INTO public.host_update VALUES (88, 182, '2018-09-10 16:55:56.445', 'S/D');
INSERT INTO public.host_update VALUES (89, 183, '2018-09-10 16:58:03.937', 'S/D');
INSERT INTO public.host_update VALUES (90, 184, '2018-09-10 16:59:17.717', 'S/D');
INSERT INTO public.host_update VALUES (91, 185, '2018-09-10 17:01:08.233', 'S/D');
INSERT INTO public.host_update VALUES (92, 186, '2018-09-10 17:39:05.101', 'S/D');
INSERT INTO public.host_update VALUES (93, 187, '2018-09-10 17:40:57.332', 'S/D');
INSERT INTO public.host_update VALUES (94, 188, '2018-09-10 17:44:51.232', 'S/D');
INSERT INTO public.host_update VALUES (95, 189, '2018-09-10 17:46:04.654', 'S/D');
INSERT INTO public.host_update VALUES (96, 190, '2018-09-10 17:48:44.631', 'S/D');


--
-- TOC entry 2296 (class 0 OID 16426)
-- Dependencies: 206
-- Data for Name: movimiento; Type: TABLE DATA; Schema: public; Owner: infraestructura
--

INSERT INTO public.movimiento VALUES (239, '2018-08-22 14:14:27.4', 'Alta de Host', '80-FA-5B-2C-72-49', 1);
INSERT INTO public.movimiento VALUES (240, '2018-08-22 15:42:54.2', 'Modificación de Host', '80-FA-5B-2C-72-49', 1);
INSERT INTO public.movimiento VALUES (243, '2018-08-24 18:32:52.6', 'cambio de monitor', '80-FA-5B-2C-72-49', 1);
INSERT INTO public.movimiento VALUES (259, '2018-08-28 18:37:50', 'Modificación de Host', '80-FA-5B-2C-72-49', 1);
INSERT INTO public.movimiento VALUES (263, '2018-09-07 18:51:52.9', 'Actualizacion de contenido', '80-FA-5B-2C-72-49', 17);
INSERT INTO public.movimiento VALUES (267, '2018-09-10 16:53:25', 'Alta de Host', 'BD-0E-AB-FD-7C-94', 1);
INSERT INTO public.movimiento VALUES (268, '2018-09-10 16:54:12.9', 'Actualizacion de contenido', 'BD-0E-AB-FD-7C-94', 1);
INSERT INTO public.movimiento VALUES (269, '2018-09-10 16:55:52.3', 'Alta de Host', '13-4C-46-AA-69-BF', 1);
INSERT INTO public.movimiento VALUES (270, '2018-09-10 16:57:59.8', 'Alta de Host', '65-7F-3D-84-43-AE', 1);
INSERT INTO public.movimiento VALUES (271, '2018-09-10 16:59:13.6', 'Alta de Host', '73-0B-26-8C-2D-95', 1);
INSERT INTO public.movimiento VALUES (272, '2018-09-10 17:01:04.1', 'Alta de Host', 'FB-82-3F-26-51-59', 1);
INSERT INTO public.movimiento VALUES (273, '2018-09-10 17:06:04.1', 'Actualizacion de contenido', '73-0B-26-8C-2D-95', 17);
INSERT INTO public.movimiento VALUES (274, '2018-09-10 17:39:00.9', 'Alta de Host', '8F-9C-FC-AD-48-C8', 1);
INSERT INTO public.movimiento VALUES (275, '2018-09-10 17:40:53.2', 'Alta de Host', '59-25-3C-D7-46-FE', 1);
INSERT INTO public.movimiento VALUES (276, '2018-09-10 17:44:47', 'Alta de Host', 'D7-E5-82-BE-18-F0', 1);
INSERT INTO public.movimiento VALUES (277, '2018-09-10 17:46:00.5', 'Alta de Host', '9B-E8-2F-FD-95-E8', 1);
INSERT INTO public.movimiento VALUES (278, '2018-09-10 17:47:46.7', 'Actualizacion de contenido', '80-FA-5B-2C-72-49', 1);
INSERT INTO public.movimiento VALUES (279, '2018-09-10 17:48:40.5', 'Alta de Host', '97-E0-0C-D4-53-C3', 1);
INSERT INTO public.movimiento VALUES (280, '2018-09-10 17:55:59.3', 'Actualizacion de contenido', 'D7-E5-82-BE-18-F0', 17);
INSERT INTO public.movimiento VALUES (281, '2018-09-10 20:29:49', 'Actualizacion de contenido', 'BD-0E-AB-FD-7C-94', 2);


--
-- TOC entry 2298 (class 0 OID 16445)
-- Dependencies: 210
-- Data for Name: user_profile; Type: TABLE DATA; Schema: public; Owner: infraestructura
--

INSERT INTO public.user_profile VALUES (1, 'Usuario');
INSERT INTO public.user_profile VALUES (2, 'Coordinador');
INSERT INTO public.user_profile VALUES (6, 'Administrador');
INSERT INTO public.user_profile VALUES (7, 'Gerencia');


--
-- TOC entry 2305 (class 0 OID 0)
-- Dependencies: 196
-- Name: app_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: infraestructura
--

SELECT pg_catalog.setval('public.app_user_id_seq', 18, true);


--
-- TOC entry 2306 (class 0 OID 0)
-- Dependencies: 201
-- Name: host_area_id_seq; Type: SEQUENCE SET; Schema: public; Owner: infraestructura
--

SELECT pg_catalog.setval('public.host_area_id_seq', 48, true);


--
-- TOC entry 2307 (class 0 OID 0)
-- Dependencies: 199
-- Name: host_idhost_seq; Type: SEQUENCE SET; Schema: public; Owner: infraestructura
--

SELECT pg_catalog.setval('public.host_idhost_seq', 190, true);


--
-- TOC entry 2308 (class 0 OID 0)
-- Dependencies: 203
-- Name: host_update_id_seq; Type: SEQUENCE SET; Schema: public; Owner: infraestructura
--

SELECT pg_catalog.setval('public.host_update_id_seq', 96, true);


--
-- TOC entry 2309 (class 0 OID 0)
-- Dependencies: 205
-- Name: movimiento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: infraestructura
--

SELECT pg_catalog.setval('public.movimiento_id_seq', 281, true);


--
-- TOC entry 2310 (class 0 OID 0)
-- Dependencies: 209
-- Name: user_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: infraestructura
--

SELECT pg_catalog.setval('public.user_profile_id_seq', 7, true);


--
-- TOC entry 2133 (class 2606 OID 16450)
-- Name: app_user app_user_pkey; Type: CONSTRAINT; Schema: public; Owner: infraestructura
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_pkey PRIMARY KEY (id);


--
-- TOC entry 2135 (class 2606 OID 16452)
-- Name: app_user app_user_sso_id_key; Type: CONSTRAINT; Schema: public; Owner: infraestructura
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_sso_id_key UNIQUE (sso_id);


--
-- TOC entry 2137 (class 2606 OID 16454)
-- Name: app_user_user_profile app_user_user_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: infraestructura
--

ALTER TABLE ONLY public.app_user_user_profile
    ADD CONSTRAINT app_user_user_profile_pkey PRIMARY KEY (user_id, user_profile_id);


--
-- TOC entry 2145 (class 2606 OID 16456)
-- Name: host_area host_area_pkey; Type: CONSTRAINT; Schema: public; Owner: infraestructura
--

ALTER TABLE ONLY public.host_area
    ADD CONSTRAINT host_area_pkey PRIMARY KEY (id);


--
-- TOC entry 2147 (class 2606 OID 16458)
-- Name: host_area host_area_type_key; Type: CONSTRAINT; Schema: public; Owner: infraestructura
--

ALTER TABLE ONLY public.host_area
    ADD CONSTRAINT host_area_type_key UNIQUE (type);


--
-- TOC entry 2139 (class 2606 OID 16460)
-- Name: host host_id; Type: CONSTRAINT; Schema: public; Owner: infraestructura
--

ALTER TABLE ONLY public.host
    ADD CONSTRAINT host_id UNIQUE (idhost);


--
-- TOC entry 2141 (class 2606 OID 16462)
-- Name: host host_mac; Type: CONSTRAINT; Schema: public; Owner: infraestructura
--

ALTER TABLE ONLY public.host
    ADD CONSTRAINT host_mac UNIQUE (mac);


--
-- TOC entry 2143 (class 2606 OID 16464)
-- Name: host host_pkey; Type: CONSTRAINT; Schema: public; Owner: infraestructura
--

ALTER TABLE ONLY public.host
    ADD CONSTRAINT host_pkey PRIMARY KEY (mac);


--
-- TOC entry 2149 (class 2606 OID 16466)
-- Name: host_update host_update_pkey; Type: CONSTRAINT; Schema: public; Owner: infraestructura
--

ALTER TABLE ONLY public.host_update
    ADD CONSTRAINT host_update_pkey PRIMARY KEY (id);


--
-- TOC entry 2151 (class 2606 OID 16468)
-- Name: movimiento pkmov; Type: CONSTRAINT; Schema: public; Owner: infraestructura
--

ALTER TABLE ONLY public.movimiento
    ADD CONSTRAINT pkmov PRIMARY KEY (id);


--
-- TOC entry 2153 (class 2606 OID 16470)
-- Name: user_profile user_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: infraestructura
--

ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT user_profile_pkey PRIMARY KEY (id);


--
-- TOC entry 2155 (class 2606 OID 16472)
-- Name: user_profile user_profile_type_key; Type: CONSTRAINT; Schema: public; Owner: infraestructura
--

ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT user_profile_type_key UNIQUE (type);


--
-- TOC entry 2162 (class 2620 OID 16473)
-- Name: host trigger_host; Type: TRIGGER; Schema: public; Owner: infraestructura
--

CREATE TRIGGER trigger_host AFTER INSERT OR UPDATE ON public.host FOR EACH ROW EXECUTE PROCEDURE public.trigger_host();


--
-- TOC entry 2156 (class 2606 OID 16474)
-- Name: app_user_user_profile fk_app_user; Type: FK CONSTRAINT; Schema: public; Owner: infraestructura
--

ALTER TABLE ONLY public.app_user_user_profile
    ADD CONSTRAINT fk_app_user FOREIGN KEY (user_id) REFERENCES public.app_user(id);


--
-- TOC entry 2157 (class 2606 OID 16479)
-- Name: app_user_user_profile fk_user_profile; Type: FK CONSTRAINT; Schema: public; Owner: infraestructura
--

ALTER TABLE ONLY public.app_user_user_profile
    ADD CONSTRAINT fk_user_profile FOREIGN KEY (user_profile_id) REFERENCES public.user_profile(id);


--
-- TOC entry 2159 (class 2606 OID 16484)
-- Name: host_update fkhost_pkey; Type: FK CONSTRAINT; Schema: public; Owner: infraestructura
--

ALTER TABLE ONLY public.host_update
    ADD CONSTRAINT fkhost_pkey FOREIGN KEY (fkhost) REFERENCES public.host(idhost) ON DELETE CASCADE;


--
-- TOC entry 2160 (class 2606 OID 16489)
-- Name: movimiento fkhostmov; Type: FK CONSTRAINT; Schema: public; Owner: infraestructura
--

ALTER TABLE ONLY public.movimiento
    ADD CONSTRAINT fkhostmov FOREIGN KEY (fkhost) REFERENCES public.host(mac);


--
-- TOC entry 2161 (class 2606 OID 16494)
-- Name: movimiento fkusermov; Type: FK CONSTRAINT; Schema: public; Owner: infraestructura
--

ALTER TABLE ONLY public.movimiento
    ADD CONSTRAINT fkusermov FOREIGN KEY (fkuser) REFERENCES public.app_user(id);


--
-- TOC entry 2158 (class 2606 OID 16499)
-- Name: host host_hostarea_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: infraestructura
--

ALTER TABLE ONLY public.host
    ADD CONSTRAINT host_hostarea_id_fkey FOREIGN KEY (hostarea_id) REFERENCES public.host_area(id);


-- Completed on 2023-08-28 16:08:17

--
-- PostgreSQL database dump complete
--

