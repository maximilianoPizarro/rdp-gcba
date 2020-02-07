--Tabla host_reas
--1)crear secuencia del id
CREATE SEQUENCE public.host_area_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 5
  CACHE 1;
ALTER TABLE public.host_area_id_seq
  OWNER TO postgres;
  
  
--2)crear tabla de las areas 
CREATE TABLE public.host_area
(
  id bigint NOT NULL DEFAULT nextval('host_area_id_seq'::regclass),
  type character varying(30) NOT NULL,
  CONSTRAINT host_area_pkey PRIMARY KEY (id),
  CONSTRAINT host_area_type_key UNIQUE (type)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.host_area
  OWNER TO postgres;      
  
--3)insertar areas en la tabla, se puede hacer manualmente con pgadmin
COPY host_area (id, type) FROM stdin;
1	RRHH
2	RRMM
3	LEGALES
\.
  
--Tabla host
--1)agregar atributo a la tabla
  hostarea_id bigint
--2)relacion con la tabla de areas
  CONSTRAINT host_hostarea_id_fkey FOREIGN KEY (hostarea_id)
      REFERENCES public.host_area (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
	  
-- movimiento
CREATE OR REPLACE FUNCTION public.trigger_host()
  RETURNS trigger AS
$BODY$
DECLARE BEGIN
	INSERT INTO movimiento VALUES(current_timestamp(1), NEW.observacion, NEW.mac, NEW.loginultimomov);
        	RETURN NULL;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.trigger_host()
  OWNER TO postgres;


CREATE TRIGGER trigger_host
  AFTER INSERT OR UPDATE
  ON public.host
  FOR EACH ROW
  EXECUTE PROCEDURE public.trigger_host();


UPDATE public.host
SET observacion='cambio disco rigido', loginultimomov=1
WHERE host.mac='80-FA-5B-2C-72-49';

select * from host;

select * from app_user;

select * from movimiento;
	  
	  
      
  