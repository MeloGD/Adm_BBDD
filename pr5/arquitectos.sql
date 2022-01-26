CREATE DATABASE arquitectos;
\c arquitectos

CREATE TYPE public.tipos_vias AS ENUM (
    'avenida',
    'calle',
    'camino',
    'carretera',
    'rambla'
);

CREATE TYPE public.direccion AS (
    tipo_via public.tipos_vias,
    nombre_via character varying,
    poblacion character varying,
    cp character varying,
    provincia character varying
);

CREATE TYPE public.punto AS (
    x integer,
    y integer
);

CREATE FUNCTION public.actualizar_lineas_de_poligono() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

    DECLARE

        cont_perimetro INT;

        cont_lineas INT;

        cod_fig INT;

    BEGIN

        IF tg_op = 'UPDATE' THEN

            cont_perimetro = NEW.longitud - OLD.longitud;

            cont_lineas = 0;

            cod_fig = NEW.cod_poligono;

        ELSIF tg_op = 'INSERT' then

            cont_perimetro = NEW.longitud;

            cont_lineas = 1;

            cod_fig = NEW.cod_poligono;

        ELSIF tg_op = 'DELETE' then

            cont_perimetro =  -(OLD.longitud);

            cont_lineas = -1;

            cod_fig = OLD.cod_poligono;

        END IF;

        UPDATE poligono SET num_lineas = num_lineas + cont_lineas,

                            perimetro = perimetro + cont_perimetro

            WHERE cod_figura = cod_fig;

        return NEW;

    END;

$$;

CREATE FUNCTION public.actualizar_num_figuras_plano() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

BEGIN

        IF (TG_OP = 'DELETE') THEN

            UPDATE plano SET num_figuras = (SELECT COUNT(*) FROM figura WHERE plano.cod_plano = OLD.cod_plano)

            WHERE cod_plano = OLD.cod_plano;

            return OLD;

        ELSIF (TG_OP = 'UPDATE') THEN

            IF (OLD.cod_plano != NEW.cod_plano) THEN

                UPDATE plano SET num_figuras = (SELECT COUNT(*) FROM figura WHERE plano.cod_plano = OLD.cod_plano)

                WHERE cod_plano = OLD.cod_plano;

                UPDATE plano SET num_figuras = (SELECT COUNT(*) FROM figura WHERE plano.cod_plano = NEW.cod_plano)

                WHERE cod_plano = NEW.cod_plano;

            END IF;

        ELSIF (TG_OP = 'INSERT') THEN

            UPDATE plano SET num_figuras = (SELECT COUNT(*) FROM figura WHERE plano.cod_plano = NEW.cod_plano)

                WHERE cod_plano = NEW.cod_plano;

        END IF;



        return NEW;

    END;

$$;

CREATE TABLE public.arquitecto (
    cod_arquitecto integer NOT NULL,
    nombre character varying NOT NULL
);
CREATE SEQUENCE public.arquitecto_cod_arquitecto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.arquitecto_trabaja_plano (
    cod_arquitecto integer NOT NULL,
    cod_plano integer NOT NULL
);

CREATE TABLE public.figura (
    cod_figura integer NOT NULL,
    nombre character varying NOT NULL,
    color character(6) NOT NULL,
    area double precision DEFAULT 0.0 NOT NULL,
    perimetro double precision DEFAULT 0.0 NOT NULL,
    cod_plano integer NOT NULL
);

CREATE SEQUENCE public.figura_cod_figura_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.jefe_proyecto (
    cod_jefe_proyecto integer NOT NULL,
    nombre character varying,
    telefono character varying,
    direccion public.direccion
);

CREATE SEQUENCE public.jefe_proyecto_cod_jefe_proyecto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.linea (
    cod_linea integer NOT NULL,
    punto_origen public.punto DEFAULT '(0,0)'::public.punto NOT NULL,
    punto_final public.punto DEFAULT '(0,0)'::public.punto NOT NULL,
    cod_poligono integer NOT NULL,
    longitud integer GENERATED ALWAYS AS (sqrt((power((((punto_final).x - (punto_origen).x))::double precision, (2)::double precision) + power((((punto_final).y - (punto_origen).y))::double precision, (2)::double precision)))) STORED
);

CREATE SEQUENCE public.linea_cod_linea_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.plano (
    cod_plano integer NOT NULL,
    fecha_entrega date NOT NULL,
    num_figuras integer DEFAULT 0 NOT NULL,
    dibujo_plano bytea,
    cod_proyecto integer
);

CREATE SEQUENCE public.plano_cod_plano_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.poligono (
    num_lineas integer DEFAULT 0 NOT NULL
)
INHERITS (public.figura);

CREATE TABLE public.proyecto (
    cod_proyecto integer NOT NULL,
    nombre character varying,
    cod_jefe_proyecto integer NOT NULL
);

CREATE SEQUENCE public.proyecto_cod_proyecto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.proyecto_cod_proyecto_seq OWNED BY public.proyecto.cod_proyecto;
ALTER TABLE ONLY public.arquitecto ALTER COLUMN cod_arquitecto SET DEFAULT nextval('public.arquitecto_cod_arquitecto_seq'::regclass);
ALTER TABLE ONLY public.figura ALTER COLUMN cod_figura SET DEFAULT nextval('public.figura_cod_figura_seq'::regclass);
ALTER TABLE ONLY public.jefe_proyecto ALTER COLUMN cod_jefe_proyecto SET DEFAULT nextval('public.jefe_proyecto_cod_jefe_proyecto_seq'::regclass);
ALTER TABLE ONLY public.linea ALTER COLUMN cod_linea SET DEFAULT nextval('public.linea_cod_linea_seq'::regclass);
ALTER TABLE ONLY public.plano ALTER COLUMN cod_plano SET DEFAULT nextval('public.plano_cod_plano_seq'::regclass);
ALTER TABLE ONLY public.poligono ALTER COLUMN cod_figura SET DEFAULT nextval('public.figura_cod_figura_seq'::regclass);
ALTER TABLE ONLY public.poligono ALTER COLUMN area SET DEFAULT 0.0;
ALTER TABLE ONLY public.poligono ALTER COLUMN perimetro SET DEFAULT 0.0;
ALTER TABLE ONLY public.proyecto ALTER COLUMN cod_proyecto SET DEFAULT nextval('public.proyecto_cod_proyecto_seq'::regclass);
ALTER TABLE ONLY public.arquitecto
    ADD CONSTRAINT arquitecto_pk PRIMARY KEY (cod_arquitecto);
ALTER TABLE ONLY public.arquitecto_trabaja_plano
    ADD CONSTRAINT arquitecto_trabaja_plano_pk PRIMARY KEY (cod_plano, cod_arquitecto);
ALTER TABLE ONLY public.figura
    ADD CONSTRAINT figura_pk PRIMARY KEY (cod_figura);
ALTER TABLE ONLY public.jefe_proyecto
    ADD CONSTRAINT jefe_proyecto_pk PRIMARY KEY (cod_jefe_proyecto);
ALTER TABLE ONLY public.linea
    ADD CONSTRAINT linea_pk PRIMARY KEY (cod_linea);
ALTER TABLE ONLY public.plano
    ADD CONSTRAINT plano_pk PRIMARY KEY (cod_plano);
ALTER TABLE ONLY public.poligono
    ADD CONSTRAINT poligono_pk PRIMARY KEY (cod_figura);
ALTER TABLE ONLY public.proyecto
    ADD CONSTRAINT proyecto_pk PRIMARY KEY (cod_proyecto);

CREATE UNIQUE INDEX jefe_proyecto_cod_jefe_proyecto_uindex ON public.jefe_proyecto USING btree (cod_jefe_proyecto);
CREATE UNIQUE INDEX jefe_proyecto_nombre_uindex ON public.jefe_proyecto USING btree (nombre);
CREATE UNIQUE INDEX proyecto_cod_jefe_proyecto_uindex ON public.proyecto USING btree (cod_jefe_proyecto);
CREATE TRIGGER actualizar_lineas_de_poligono_trigger AFTER INSERT OR DELETE OR UPDATE ON public.linea FOR EACH ROW EXECUTE FUNCTION public.actualizar_lineas_de_poligono();
CREATE TRIGGER actualizar_num_figuras_plano_trigger AFTER INSERT OR DELETE OR UPDATE ON public.figura FOR EACH ROW EXECUTE FUNCTION public.actualizar_num_figuras_plano();
CREATE TRIGGER actualizar_num_figuras_plano_trigger AFTER INSERT OR DELETE OR UPDATE ON public.poligono FOR EACH ROW EXECUTE FUNCTION public.actualizar_num_figuras_plano();

ALTER TABLE ONLY public.arquitecto_trabaja_plano
    ADD CONSTRAINT arquitecto_trabaja_plano_arquitecto_cod_arquitecto_fk FOREIGN KEY (cod_arquitecto) REFERENCES public.arquitecto(cod_arquitecto) ON DELETE CASCADE;
ALTER TABLE ONLY public.arquitecto_trabaja_plano
    ADD CONSTRAINT arquitecto_trabaja_plano_plano_cod_plano_fk FOREIGN KEY (cod_plano) REFERENCES public.plano(cod_plano) ON DELETE CASCADE;
ALTER TABLE ONLY public.figura
    ADD CONSTRAINT figura_plano_cod_plano_fk FOREIGN KEY (cod_plano) REFERENCES public.plano(cod_plano) ON DELETE CASCADE;
ALTER TABLE ONLY public.linea
    ADD CONSTRAINT linea_poligono_cod_figura_fk FOREIGN KEY (cod_poligono) REFERENCES public.poligono(cod_figura) ON DELETE CASCADE;
ALTER TABLE ONLY public.plano
    ADD CONSTRAINT plano_proyecto_cod_proyecto_fk FOREIGN KEY (cod_proyecto) REFERENCES public.proyecto(cod_proyecto) ON DELETE SET NULL;
ALTER TABLE ONLY public.poligono
    ADD CONSTRAINT poligono_plano_cod_plano_fk FOREIGN KEY (cod_plano) REFERENCES public.plano(cod_plano) ON DELETE CASCADE;
ALTER TABLE ONLY public.proyecto
    ADD CONSTRAINT proyecto_jefe_proyecto_cod_jefe_proyecto_fk FOREIGN KEY (cod_jefe_proyecto) REFERENCES public.jefe_proyecto(cod_jefe_proyecto);
