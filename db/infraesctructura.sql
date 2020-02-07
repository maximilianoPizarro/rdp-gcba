--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.10
-- Dumped by pg_dump version 9.5.10

-- Started on 2018-09-12 11:31:32

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12355)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2204 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 212 (class 1255 OID 34770)
-- Name: activos_hoy(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION activos_hoy() RETURNS character varying
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


ALTER FUNCTION public.activos_hoy() OWNER TO postgres;

--
-- TOC entry 211 (class 1255 OID 34767)
-- Name: pc_por_area(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pc_por_area() RETURNS character varying
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


ALTER FUNCTION public.pc_por_area() OWNER TO postgres;

--
-- TOC entry 209 (class 1255 OID 34224)
-- Name: traer_host(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION traer_host(_cant character varying) RETURNS TABLE(idhost integer, cpu_vendedor character varying, cpu_modelo character varying, cpu_mhz character varying, cpu_fisicas character varying, cpu_nucleos character varying, mac character varying, red_host character varying, so_fabricante character varying, so_arquitectura character varying, so_version character varying, java_version character varying, usuario character varying, hostarea_id bigint, ram bigint, hdd bigint, observacion character varying, loginultimomov bigint, fechahora timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
DECLARE	
BEGIN
RETURN query
SELECT * from traer_host h
WHERE CAST(h.fechahora AS DATE) + CAST((CONCAT(_cant,'days')) AS INTERVAL) <= (now()::date);
END;
$$;


ALTER FUNCTION public.traer_host(_cant character varying) OWNER TO postgres;

--
-- TOC entry 210 (class 1255 OID 34225)
-- Name: traer_host_update(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION traer_host_update(_cant character varying) RETURNS TABLE(idhost integer, mac character varying, red_host character varying, fechahora timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
DECLARE	
BEGIN
RETURN query
SELECT h.idhost,h.mac,h.red_host,h.fechahora from traer_host h
WHERE CAST(h.fechahora AS DATE) + CAST((CONCAT(_cant,'days')) AS INTERVAL) <= (now()::date);
END;
$$;


ALTER FUNCTION public.traer_host_update(_cant character varying) OWNER TO postgres;

--
-- TOC entry 196 (class 1255 OID 31924)
-- Name: trigger_host(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION trigger_host() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE BEGIN
	INSERT INTO movimiento VALUES(nextval('movimiento_id_seq'::regclass),current_timestamp(1), NEW.observacion, NEW.mac, NEW.loginultimomov);
        	RETURN NULL;
END;
$$;


ALTER FUNCTION public.trigger_host() OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 31826)
-- Name: app_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE app_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE app_user_id_seq OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 185 (class 1259 OID 31830)
-- Name: app_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE app_user (
    id bigint DEFAULT nextval('app_user_id_seq'::regclass) NOT NULL,
    sso_id character varying(30) NOT NULL,
    password character varying(100) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(50) NOT NULL
);


ALTER TABLE app_user OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 31846)
-- Name: app_user_user_profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE app_user_user_profile (
    user_id bigint NOT NULL,
    user_profile_id bigint NOT NULL
);


ALTER TABLE app_user_user_profile OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 31615)
-- Name: host_idhost_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE host_idhost_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE host_idhost_seq OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 31617)
-- Name: host; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE host (
    idhost integer DEFAULT nextval('host_idhost_seq'::regclass) NOT NULL,
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


ALTER TABLE host OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 31874)
-- Name: host_area_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE host_area_id_seq
    START WITH 5
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE host_area_id_seq OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 31880)
-- Name: host_area; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE host_area (
    id bigint DEFAULT nextval('host_area_id_seq'::regclass) NOT NULL,
    type character varying(80) NOT NULL
);


ALTER TABLE host_area OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 33831)
-- Name: host_update_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE host_update_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE host_update_id_seq OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 34155)
-- Name: host_update; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE host_update (
    id integer DEFAULT nextval('host_update_id_seq'::regclass) NOT NULL,
    fkhost integer,
    fechahora timestamp(6) without time zone,
    ip character varying
);


ALTER TABLE host_update OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 31936)
-- Name: movimiento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE movimiento_id_seq
    START WITH 118
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE movimiento_id_seq OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 31957)
-- Name: movimiento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE movimiento (
    id integer DEFAULT nextval('movimiento_id_seq'::regclass) NOT NULL,
    fechahoramov timestamp(6) without time zone NOT NULL,
    operacion character varying(400) NOT NULL,
    fkhost character varying NOT NULL,
    fkuser bigint NOT NULL
);


ALTER TABLE movimiento OWNER TO postgres;

--
-- TOC entry 194 (class 1259 OID 34209)
-- Name: traer_host; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW traer_host AS
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
   FROM ((host h
     JOIN ( SELECT host_update.fkhost,
            max(host_update.fechahora) AS maxdate
           FROM host_update
          GROUP BY host_update.fkhost) maxdates ON ((h.idhost = maxdates.fkhost)))
     JOIN host_update hu ON (((maxdates.fkhost = hu.fkhost) AND (maxdates.maxdate = hu.fechahora))));


ALTER TABLE traer_host OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 34230)
-- Name: traer_host_dos_semanas; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW traer_host_dos_semanas AS
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
   FROM traer_host h
  WHERE (((h.fechahora)::date + (concat(15, 'days'))::interval) <= (now())::date);


ALTER TABLE traer_host_dos_semanas OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 31828)
-- Name: user_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_profile_id_seq
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_profile_id_seq OWNER TO postgres;

--
-- TOC entry 186 (class 1259 OID 31838)
-- Name: user_profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE user_profile (
    id bigint DEFAULT nextval('user_profile_id_seq'::regclass) NOT NULL,
    type character varying(30) NOT NULL
);


ALTER TABLE user_profile OWNER TO postgres;

--
-- TOC entry 2188 (class 0 OID 31830)
-- Dependencies: 185
-- Data for Name: app_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY app_user (id, sso_id, password, first_name, last_name, email) FROM stdin;
12	abish	123	Alejo	Bish	alejobish@gmail.com
17	vcumiano	123	vanesa	cumiano	vanecumiano@buenosaires.gob.ar
2	mateodecu	123	mateo	decurgez	mateodecu@hotmail.com
1	maxpizarro	123	maximiliano	pizarro	maximiliano.pizarro.5@gmail.com
\.


--
-- TOC entry 2205 (class 0 OID 0)
-- Dependencies: 183
-- Name: app_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('app_user_id_seq', 19, true);


--
-- TOC entry 2190 (class 0 OID 31846)
-- Dependencies: 187
-- Data for Name: app_user_user_profile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY app_user_user_profile (user_id, user_profile_id) FROM stdin;
1	6
12	2
17	7
2	1
\.


--
-- TOC entry 2185 (class 0 OID 31617)
-- Dependencies: 182
-- Data for Name: host; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY host (idhost, cpu_vendedor, cpu_modelo, cpu_mhz, cpu_fisicas, cpu_nucleos, mac, red_host, so_fabricante, so_arquitectura, so_version, java_version, usuario, hostarea_id, ram, hdd, observacion, loginultimomov) FROM stdin;
190	GenuineIntel	Intel(R) Core(TM) i5-7400T CPU @ 2.40GHz	2400	4	4	97-E0-0C-D4-53-C3	equipo9	Microsoft Windows	x64	7	1.8.0_181		34	8	500	Alta de Host	1
191	GenuineIntel	Intel(R) Core(TM) i5-7400T CPU @ 2.40GHz	2400	4	4	ED-D4-F9-B6-48-3C	equipo2	Microsoft Windows	x64	10	1.8.0_171		17	4	400	Alta de Host	2
192	amd	AMD	1400	4	4	1F-0B-4A-28-8A-64	equipo1	Microsoft Windows	x32	7	1.8.0_171		36	8	500	Alta de Host	2
193	GenuineIntel	Intel(R) Core(TM) i5-7400T CPU @ 2.40GHz	2400	4	4	BA-A9-C0-11-C0-13	equipo2	Microsoft Windows	x64	10	1.8.0_181		3	4	500	Alta de Host	2
194	AMD	AMD	2400	2	4	F3-10-E0-0A-A0-50	equipo9	Microsoft Windows	x32	7	1.8.0_171		13	4	500	Alta de Host	2
195	GenuineIntel	Intel(R) Core(TM) i5-7400T CPU @ 2.40GHz	2400	4	4	9B-8F-42-8C-D2-B3	equipo1	Microsoft Windows	x64	10	1.8.0_181		26	8	500	Alta de Host	1
188	AMD	AMD	1200	2	2	D7-E5-82-BE-18-F0	equipo8	Microsoft Windows	x32	8	1.8.0_171		34	4	500	cambio de mouse	1
181	GenuineIntel	Intel(R) Core(TM) i5-7400T CPU @ 2.40GHz	2400	4	4	BD-0E-AB-FD-7C-94	equipo1	Microsoft Windows	x64	7	1.8.0_181		29	4	800	Actualizacion de contenido	1
196	GenuineIntel	Intel(R) Core(TM) i5-7400T CPU @ 2.40GHz	2401	4	4	80-FA-5B-2C-72-49	DESKTOP-PDQ7FOA	Microsoft Windows	x64	10	1.8.0_181	Max	\N	8	299	Alta de Host	1
182	GenuineIntel	Intel(R) Core(TM) i5-7400T CPU @ 2.40GHz	2400	4	4	13-4C-46-AA-69-BF	equipo2	Microsoft Windows	x64	10	1.8.0_181		2	4	800	Alta de Host	1
183	AMD	AMD	2400	2	2	65-7F-3D-84-43-AE	equipo3	Microsoft Windows	x64	7	1.8.0_171		3	8	800	Alta de Host	1
185	GenuineIntel	Intel(R) Core(TM) i5-7400T CPU @ 2.40GHz	2400	4	4	FB-82-3F-26-51-59	equipo5	Microsoft Windows	x32	8	1.8.0_171		3	4	500	Alta de Host	1
184	AMD	AMD	2400	4	4	73-0B-26-8C-2D-95	equipo4	Microsoft Windows	x32	7	1.8.0_181		3	4	800	Actualizacion de contenido	17
186	AMD	AMD	2400	4	4	8F-9C-FC-AD-48-C8	equipo6	Microsoft Windows	x64	7	1.8.0_181		29	4	800	Alta de Host	1
187	GenuineIntel	Intel(R) Core(TM) i5-7400T CPU @ 2.40GHz	2400	2	4	59-25-3C-D7-46-FE	equipo7	Microsoft Windows	x64	10	1.8.0_171		34	8	500	Alta de Host	1
189	GenuineIntel	Intel(R) Core(TM) i5-7400T CPU @ 2.40GHz	2400	4	4	9B-E8-2F-FD-95-E8	equipo9	Microsoft Windows	x64	10	1.8.0_171		17	8	500	Alta de Host	1
\.


--
-- TOC entry 2192 (class 0 OID 31880)
-- Dependencies: 189
-- Data for Name: host_area; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY host_area (id, type) FROM stdin;
1	PROGRAMACION
2	ACTAS
3	ASUNTOS LEGALES
6	AUTOMOTORES
7	CENTRO DE GESTION DE LA MOVILIDAD
9	CENTRO DE GESTION DE LA MOVILIDAD(MONITOREO)\r
10	CENTRO DE PROCESAMIENTO DE INFRACCIONES
11	CENTRO DE PROCESAMIENTO DE INFRACCIONES(ANPR)
12	CENTRO DE PROCESAMIENTO DE INFRACCIONES(CADV)
13	CENTRO DE PROCESAMIENTO DE INFRACCIONES(CECAITRA)
14	CENTRO DE PROCESAMIENTO DE INFRACCIONES(MOTOS)
15	COMBIS
16	COMPRAS Y PRESUPUESTO
17	CUCC
18	DCER
19	DESARROLLO HUMANO
20	DIRECCION\t
21	DIRECCION GENERAL
22	DPTO. ALCOHOLEMIA
23	EDUCACION VIAL
24	GERENCIA OPERATIVA DE GESTIÓN DE OPERACIONES
25	GERENCIA OPERATIVA OBSERVATORIO VIAL
26	GESTION DE PLAYAS Y ABANDONADOS
27	GRUAS
28	INCORPORACION Y FORMACION DE AGENTES
29	MESA DE ENTRADA
30	OBSERVATORIO VIAL
31	PARQUE VIAL
32	PLANEAMIENTO
33	PLAYA DE ACARREO
34	RELACIONES INSTITUCIONALES
35	SISTEMA DE ESTACIONAMIENTO ORDENADO
37	SUBGERENCIA OPERATIVA DE ADMINISTRACION DE RECURSOS MATERIALES(COMUNICACIONES)\t
38	SUBGERENCIA OPERATIVA DE ADMINISTRACION DE RECURSOS MATERIALES(MANTENIMIENTO)
39	SUBGERENCIA OPERATIVA DE ADMINISTRACION DE RECURSOS MATERIALES(PAÑOL)
40	SUBGERENCIA OPERATIVA DE ADMINISTRACION DE RECURSOS MATERIALES(SISTEMAS)
41	SUBGERENCIA OPERATIVA DE ADMINISTRACION DE RECURSOS MATERIALES(TALLER)
42	SUBGERENCIA OPERATIVA DE ADMINISTRACION DE RECURSOS MATERIALES(UNIFORMES)
43	SUBGERENCIA OPERATIVA DE RECURSOS MATERIALES
44	SUBGERENCIA OPERATIVA DE ZONA NORTE
45	SUBGERENCIA OPERATIVA ZONA CENTRO
46	SUBGERENCIA OPERATIVA ZONA NORTE
47	SUBGERENCIA OPERATIVA ZONA SUR
48	TALLER
36	SGO DE ADMIN DE RECURSOS HUMANOS
\.


--
-- TOC entry 2206 (class 0 OID 0)
-- Dependencies: 188
-- Name: host_area_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('host_area_id_seq', 48, true);


--
-- TOC entry 2207 (class 0 OID 0)
-- Dependencies: 181
-- Name: host_idhost_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('host_idhost_seq', 196, true);


--
-- TOC entry 2196 (class 0 OID 34155)
-- Dependencies: 193
-- Data for Name: host_update; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY host_update (id, fkhost, fechahora, ip) FROM stdin;
87	181	2018-09-10 16:53:29.348	10.68.11.37
88	182	2018-09-10 16:55:56.445	10.68.11.38
89	183	2018-09-10 16:58:03.937	10.68.11.39
90	184	2018-09-10 16:59:17.717	10.68.11.40
91	185	2018-09-10 17:01:08.233	10.68.11.41
92	186	2018-09-10 17:39:05.101	10.68.11.42
93	187	2018-09-10 17:40:57.332	10.68.11.43
94	188	2018-09-10 17:44:51.232	10.68.11.44
95	189	2018-09-10 17:46:04.654	10.68.11.45
96	190	2018-09-10 17:48:44.631	10.68.11.46
97	191	2018-09-12 14:59:37.837	10.68.11.47
98	192	2018-09-12 15:01:37.016	10.68.11.48
99	193	2018-09-12 15:02:53.778	10.68.11.49
100	194	2018-09-12 15:04:25.101	10.68.11.50
101	195	2018-09-12 15:41:29.935	10.68.11.51
102	196	2018-09-12 20:24:14.686	10.68.11.36
\.


--
-- TOC entry 2208 (class 0 OID 0)
-- Dependencies: 192
-- Name: host_update_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('host_update_id_seq', 102, true);


--
-- TOC entry 2194 (class 0 OID 31957)
-- Dependencies: 191
-- Data for Name: movimiento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY movimiento (id, fechahoramov, operacion, fkhost, fkuser) FROM stdin;
267	2018-09-10 16:53:25	Alta de Host	BD-0E-AB-FD-7C-94	1
268	2018-09-10 16:54:12.9	Actualizacion de contenido	BD-0E-AB-FD-7C-94	1
269	2018-09-10 16:55:52.3	Alta de Host	13-4C-46-AA-69-BF	1
270	2018-09-10 16:57:59.8	Alta de Host	65-7F-3D-84-43-AE	1
271	2018-09-10 16:59:13.6	Alta de Host	73-0B-26-8C-2D-95	1
272	2018-09-10 17:01:04.1	Alta de Host	FB-82-3F-26-51-59	1
273	2018-09-10 17:06:04.1	Actualizacion de contenido	73-0B-26-8C-2D-95	17
274	2018-09-10 17:39:00.9	Alta de Host	8F-9C-FC-AD-48-C8	1
275	2018-09-10 17:40:53.2	Alta de Host	59-25-3C-D7-46-FE	1
276	2018-09-10 17:44:47	Alta de Host	D7-E5-82-BE-18-F0	1
277	2018-09-10 17:46:00.5	Alta de Host	9B-E8-2F-FD-95-E8	1
279	2018-09-10 17:48:40.5	Alta de Host	97-E0-0C-D4-53-C3	1
280	2018-09-10 17:55:59.3	Actualizacion de contenido	D7-E5-82-BE-18-F0	17
281	2018-09-10 20:29:49	Actualizacion de contenido	BD-0E-AB-FD-7C-94	2
282	2018-09-11 14:59:33.6	Alta de Host	ED-D4-F9-B6-48-3C	2
283	2018-09-11 15:01:32.7	Alta de Host	1F-0B-4A-28-8A-64	2
284	2018-09-11 15:02:49.5	Alta de Host	BA-A9-C0-11-C0-13	2
285	2018-09-11 15:04:20.9	Alta de Host	F3-10-E0-0A-A0-50	2
286	2018-09-11 15:41:25.7	Alta de Host	9B-8F-42-8C-D2-B3	1
287	2018-09-11 19:47:13.3	cambio de teclado	D7-E5-82-BE-18-F0	1
289	2018-09-11 20:04:51.8	cambio de mouse	D7-E5-82-BE-18-F0	1
290	2018-09-11 20:05:37	Actualizacion de contenido	BD-0E-AB-FD-7C-94	1
291	2018-09-11 20:24:10.5	Alta de Host	80-FA-5B-2C-72-49	1
\.


--
-- TOC entry 2209 (class 0 OID 0)
-- Dependencies: 190
-- Name: movimiento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('movimiento_id_seq', 291, true);


--
-- TOC entry 2189 (class 0 OID 31838)
-- Dependencies: 186
-- Data for Name: user_profile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_profile (id, type) FROM stdin;
1	Usuario
2	Coordinador
6	Administrador
7	Gerencia
\.


--
-- TOC entry 2210 (class 0 OID 0)
-- Dependencies: 184
-- Name: user_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_profile_id_seq', 7, true);


--
-- TOC entry 2044 (class 2606 OID 31835)
-- Name: app_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY app_user
    ADD CONSTRAINT app_user_pkey PRIMARY KEY (id);


--
-- TOC entry 2046 (class 2606 OID 31837)
-- Name: app_user_sso_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY app_user
    ADD CONSTRAINT app_user_sso_id_key UNIQUE (sso_id);


--
-- TOC entry 2052 (class 2606 OID 31850)
-- Name: app_user_user_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY app_user_user_profile
    ADD CONSTRAINT app_user_user_profile_pkey PRIMARY KEY (user_id, user_profile_id);


--
-- TOC entry 2054 (class 2606 OID 31885)
-- Name: host_area_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY host_area
    ADD CONSTRAINT host_area_pkey PRIMARY KEY (id);


--
-- TOC entry 2056 (class 2606 OID 34769)
-- Name: host_area_type_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY host_area
    ADD CONSTRAINT host_area_type_key UNIQUE (type);


--
-- TOC entry 2038 (class 2606 OID 34180)
-- Name: host_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY host
    ADD CONSTRAINT host_id UNIQUE (idhost);


--
-- TOC entry 2040 (class 2606 OID 32014)
-- Name: host_mac; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY host
    ADD CONSTRAINT host_mac UNIQUE (mac);


--
-- TOC entry 2042 (class 2606 OID 31625)
-- Name: host_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY host
    ADD CONSTRAINT host_pkey PRIMARY KEY (mac);


--
-- TOC entry 2060 (class 2606 OID 34160)
-- Name: host_update_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY host_update
    ADD CONSTRAINT host_update_pkey PRIMARY KEY (id);


--
-- TOC entry 2058 (class 2606 OID 31965)
-- Name: pkmov; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY movimiento
    ADD CONSTRAINT pkmov PRIMARY KEY (id);


--
-- TOC entry 2048 (class 2606 OID 31843)
-- Name: user_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_profile
    ADD CONSTRAINT user_profile_pkey PRIMARY KEY (id);


--
-- TOC entry 2050 (class 2606 OID 31845)
-- Name: user_profile_type_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_profile
    ADD CONSTRAINT user_profile_type_key UNIQUE (type);


--
-- TOC entry 2067 (class 2620 OID 31925)
-- Name: trigger_host; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_host AFTER INSERT OR UPDATE ON host FOR EACH ROW EXECUTE PROCEDURE trigger_host();


--
-- TOC entry 2062 (class 2606 OID 31851)
-- Name: fk_app_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY app_user_user_profile
    ADD CONSTRAINT fk_app_user FOREIGN KEY (user_id) REFERENCES app_user(id);


--
-- TOC entry 2063 (class 2606 OID 31856)
-- Name: fk_user_profile; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY app_user_user_profile
    ADD CONSTRAINT fk_user_profile FOREIGN KEY (user_profile_id) REFERENCES user_profile(id);


--
-- TOC entry 2066 (class 2606 OID 34639)
-- Name: fkhost_pkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY host_update
    ADD CONSTRAINT fkhost_pkey FOREIGN KEY (fkhost) REFERENCES host(idhost) ON DELETE CASCADE;


--
-- TOC entry 2065 (class 2606 OID 32008)
-- Name: fkhostmov; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY movimiento
    ADD CONSTRAINT fkhostmov FOREIGN KEY (fkhost) REFERENCES host(mac);


--
-- TOC entry 2064 (class 2606 OID 31971)
-- Name: fkusermov; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY movimiento
    ADD CONSTRAINT fkusermov FOREIGN KEY (fkuser) REFERENCES app_user(id);


--
-- TOC entry 2061 (class 2606 OID 31893)
-- Name: host_hostarea_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY host
    ADD CONSTRAINT host_hostarea_id_fkey FOREIGN KEY (hostarea_id) REFERENCES host_area(id);


--
-- TOC entry 2203 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2018-09-12 11:31:33

--
-- PostgreSQL database dump complete
--

