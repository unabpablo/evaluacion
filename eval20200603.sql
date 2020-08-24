--
-- PostgreSQL database dump
--

-- Dumped from database version 12.1
-- Dumped by pg_dump version 12.1

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO postgres;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO postgres;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: background_task; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.background_task (
    id integer NOT NULL,
    task_name character varying(190) NOT NULL,
    task_params text NOT NULL,
    task_hash character varying(40) NOT NULL,
    verbose_name character varying(255),
    priority integer NOT NULL,
    run_at timestamp with time zone NOT NULL,
    repeat bigint NOT NULL,
    repeat_until timestamp with time zone,
    queue character varying(190),
    attempts integer NOT NULL,
    failed_at timestamp with time zone,
    last_error text NOT NULL,
    locked_by character varying(64),
    locked_at timestamp with time zone,
    creator_object_id integer,
    creator_content_type_id integer,
    CONSTRAINT background_task_creator_object_id_check CHECK ((creator_object_id >= 0))
);


ALTER TABLE public.background_task OWNER TO postgres;

--
-- Name: background_task_completedtask; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.background_task_completedtask (
    id integer NOT NULL,
    task_name character varying(190) NOT NULL,
    task_params text NOT NULL,
    task_hash character varying(40) NOT NULL,
    verbose_name character varying(255),
    priority integer NOT NULL,
    run_at timestamp with time zone NOT NULL,
    repeat bigint NOT NULL,
    repeat_until timestamp with time zone,
    queue character varying(190),
    attempts integer NOT NULL,
    failed_at timestamp with time zone,
    last_error text NOT NULL,
    locked_by character varying(64),
    locked_at timestamp with time zone,
    creator_object_id integer,
    creator_content_type_id integer,
    CONSTRAINT background_task_completedtask_creator_object_id_check CHECK ((creator_object_id >= 0))
);


ALTER TABLE public.background_task_completedtask OWNER TO postgres;

--
-- Name: background_task_completedtask_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.background_task_completedtask_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.background_task_completedtask_id_seq OWNER TO postgres;

--
-- Name: background_task_completedtask_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.background_task_completedtask_id_seq OWNED BY public.background_task_completedtask.id;


--
-- Name: background_task_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.background_task_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.background_task_id_seq OWNER TO postgres;

--
-- Name: background_task_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.background_task_id_seq OWNED BY public.background_task.id;


--
-- Name: celery_taskmeta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.celery_taskmeta (
    id integer NOT NULL,
    task_id character varying(255) NOT NULL,
    status character varying(50) NOT NULL,
    result text,
    date_done timestamp with time zone NOT NULL,
    traceback text,
    hidden boolean NOT NULL,
    meta text
);


ALTER TABLE public.celery_taskmeta OWNER TO postgres;

--
-- Name: celery_taskmeta_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.celery_taskmeta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.celery_taskmeta_id_seq OWNER TO postgres;

--
-- Name: celery_taskmeta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.celery_taskmeta_id_seq OWNED BY public.celery_taskmeta.id;


--
-- Name: celery_tasksetmeta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.celery_tasksetmeta (
    id integer NOT NULL,
    taskset_id character varying(255) NOT NULL,
    result text NOT NULL,
    date_done timestamp with time zone NOT NULL,
    hidden boolean NOT NULL
);


ALTER TABLE public.celery_tasksetmeta OWNER TO postgres;

--
-- Name: celery_tasksetmeta_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.celery_tasksetmeta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.celery_tasksetmeta_id_seq OWNER TO postgres;

--
-- Name: celery_tasksetmeta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.celery_tasksetmeta_id_seq OWNED BY public.celery_tasksetmeta.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: djcelery_crontabschedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.djcelery_crontabschedule (
    id integer NOT NULL,
    minute character varying(64) NOT NULL,
    hour character varying(64) NOT NULL,
    day_of_week character varying(64) NOT NULL,
    day_of_month character varying(64) NOT NULL,
    month_of_year character varying(64) NOT NULL
);


ALTER TABLE public.djcelery_crontabschedule OWNER TO postgres;

--
-- Name: djcelery_crontabschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.djcelery_crontabschedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.djcelery_crontabschedule_id_seq OWNER TO postgres;

--
-- Name: djcelery_crontabschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.djcelery_crontabschedule_id_seq OWNED BY public.djcelery_crontabschedule.id;


--
-- Name: djcelery_intervalschedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.djcelery_intervalschedule (
    id integer NOT NULL,
    every integer NOT NULL,
    period character varying(24) NOT NULL
);


ALTER TABLE public.djcelery_intervalschedule OWNER TO postgres;

--
-- Name: djcelery_intervalschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.djcelery_intervalschedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.djcelery_intervalschedule_id_seq OWNER TO postgres;

--
-- Name: djcelery_intervalschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.djcelery_intervalschedule_id_seq OWNED BY public.djcelery_intervalschedule.id;


--
-- Name: djcelery_periodictask; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.djcelery_periodictask (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    task character varying(200) NOT NULL,
    args text NOT NULL,
    kwargs text NOT NULL,
    queue character varying(200),
    exchange character varying(200),
    routing_key character varying(200),
    expires timestamp with time zone,
    enabled boolean NOT NULL,
    last_run_at timestamp with time zone,
    total_run_count integer NOT NULL,
    date_changed timestamp with time zone NOT NULL,
    description text NOT NULL,
    crontab_id integer,
    interval_id integer,
    CONSTRAINT djcelery_periodictask_total_run_count_check CHECK ((total_run_count >= 0))
);


ALTER TABLE public.djcelery_periodictask OWNER TO postgres;

--
-- Name: djcelery_periodictask_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.djcelery_periodictask_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.djcelery_periodictask_id_seq OWNER TO postgres;

--
-- Name: djcelery_periodictask_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.djcelery_periodictask_id_seq OWNED BY public.djcelery_periodictask.id;


--
-- Name: djcelery_periodictasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.djcelery_periodictasks (
    ident smallint NOT NULL,
    last_update timestamp with time zone NOT NULL
);


ALTER TABLE public.djcelery_periodictasks OWNER TO postgres;

--
-- Name: djcelery_taskstate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.djcelery_taskstate (
    id integer NOT NULL,
    state character varying(64) NOT NULL,
    task_id character varying(36) NOT NULL,
    name character varying(200),
    tstamp timestamp with time zone NOT NULL,
    args text,
    kwargs text,
    eta timestamp with time zone,
    expires timestamp with time zone,
    result text,
    traceback text,
    runtime double precision,
    retries integer NOT NULL,
    hidden boolean NOT NULL,
    worker_id integer
);


ALTER TABLE public.djcelery_taskstate OWNER TO postgres;

--
-- Name: djcelery_taskstate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.djcelery_taskstate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.djcelery_taskstate_id_seq OWNER TO postgres;

--
-- Name: djcelery_taskstate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.djcelery_taskstate_id_seq OWNED BY public.djcelery_taskstate.id;


--
-- Name: djcelery_workerstate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.djcelery_workerstate (
    id integer NOT NULL,
    hostname character varying(255) NOT NULL,
    last_heartbeat timestamp with time zone
);


ALTER TABLE public.djcelery_workerstate OWNER TO postgres;

--
-- Name: djcelery_workerstate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.djcelery_workerstate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.djcelery_workerstate_id_seq OWNER TO postgres;

--
-- Name: djcelery_workerstate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.djcelery_workerstate_id_seq OWNED BY public.djcelery_workerstate.id;


--
-- Name: eval_collection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eval_collection (
    id integer NOT NULL,
    "Nombre" character varying(300) NOT NULL,
    "Peso" character varying(300) NOT NULL,
    "Conf_id" integer,
    note text NOT NULL,
    created_by_id integer
);


ALTER TABLE public.eval_collection OWNER TO postgres;

--
-- Name: eval_collection_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eval_collection_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.eval_collection_id_seq OWNER TO postgres;

--
-- Name: eval_collection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.eval_collection_id_seq OWNED BY public.eval_collection.id;


--
-- Name: eval_collectiontitle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eval_collectiontitle (
    id integer NOT NULL,
    collection_id integer NOT NULL,
    "Nombre" character varying(500) NOT NULL,
    "Peso" character varying(500)
);


ALTER TABLE public.eval_collectiontitle OWNER TO postgres;

--
-- Name: eval_collectiontitle_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eval_collectiontitle_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.eval_collectiontitle_id_seq OWNER TO postgres;

--
-- Name: eval_collectiontitle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.eval_collectiontitle_id_seq OWNED BY public.eval_collectiontitle.id;


--
-- Name: eval_conf_auto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eval_conf_auto (
    id integer NOT NULL,
    "Nombre" character varying(50) NOT NULL,
    tipo_periodo character varying(30) NOT NULL,
    tolerancia double precision,
    umbral double precision
);


ALTER TABLE public.eval_conf_auto OWNER TO postgres;

--
-- Name: eval_conf_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eval_conf_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.eval_conf_auto_id_seq OWNER TO postgres;

--
-- Name: eval_conf_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.eval_conf_auto_id_seq OWNED BY public.eval_conf_auto.id;


--
-- Name: eval_criterios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eval_criterios (
    id integer NOT NULL,
    "Nombre" character varying(500) NOT NULL,
    "Peso" character varying(50),
    "Conf_id" integer NOT NULL
);


ALTER TABLE public.eval_criterios OWNER TO postgres;

--
-- Name: eval_criterios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eval_criterios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.eval_criterios_id_seq OWNER TO postgres;

--
-- Name: eval_criterios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.eval_criterios_id_seq OWNED BY public.eval_criterios.id;


--
-- Name: eval_etiquetas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eval_etiquetas (
    id integer NOT NULL,
    "Etiqueta" character varying(50) NOT NULL,
    "Peso" character varying(50) NOT NULL,
    conf_id integer NOT NULL,
    criterio_id integer NOT NULL
);


ALTER TABLE public.eval_etiquetas OWNER TO postgres;

--
-- Name: eval_etiquetas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eval_etiquetas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.eval_etiquetas_id_seq OWNER TO postgres;

--
-- Name: eval_etiquetas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.eval_etiquetas_id_seq OWNED BY public.eval_etiquetas.id;


--
-- Name: eval_eval_conf; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eval_eval_conf (
    id integer NOT NULL,
    "Nombre" character varying(50) NOT NULL,
    fecha timestamp with time zone NOT NULL,
    tipo_periodo character varying(30) NOT NULL,
    booleano boolean,
    fecha_termino timestamp with time zone,
    metodo_ranking character varying(30),
    modo character varying(50),
    status character varying(50),
    frecuencia_ranking character varying(50),
    tolerancia double precision NOT NULL,
    umbral double precision NOT NULL,
    tipo_automatico character varying(50) NOT NULL,
    img character varying(100)
);


ALTER TABLE public.eval_eval_conf OWNER TO postgres;

--
-- Name: eval_eval_conf_evaluado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eval_eval_conf_evaluado (
    id integer NOT NULL,
    eval_conf_id integer NOT NULL,
    evaluados_id integer NOT NULL
);


ALTER TABLE public.eval_eval_conf_evaluado OWNER TO postgres;

--
-- Name: eval_eval_conf_evaluado_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eval_eval_conf_evaluado_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.eval_eval_conf_evaluado_id_seq OWNER TO postgres;

--
-- Name: eval_eval_conf_evaluado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.eval_eval_conf_evaluado_id_seq OWNED BY public.eval_eval_conf_evaluado.id;


--
-- Name: eval_eval_conf_evaluador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eval_eval_conf_evaluador (
    id integer NOT NULL,
    eval_conf_id integer NOT NULL,
    evaluadores_id integer NOT NULL
);


ALTER TABLE public.eval_eval_conf_evaluador OWNER TO postgres;

--
-- Name: eval_eval_conf_evaluador_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eval_eval_conf_evaluador_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.eval_eval_conf_evaluador_id_seq OWNER TO postgres;

--
-- Name: eval_eval_conf_evaluador_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.eval_eval_conf_evaluador_id_seq OWNED BY public.eval_eval_conf_evaluador.id;


--
-- Name: eval_eval_conf_experto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eval_eval_conf_experto (
    id integer NOT NULL,
    eval_conf_id integer NOT NULL,
    expertos_id integer NOT NULL
);


ALTER TABLE public.eval_eval_conf_experto OWNER TO postgres;

--
-- Name: eval_eval_conf_experto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eval_eval_conf_experto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.eval_eval_conf_experto_id_seq OWNER TO postgres;

--
-- Name: eval_eval_conf_experto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.eval_eval_conf_experto_id_seq OWNED BY public.eval_eval_conf_experto.id;


--
-- Name: eval_eval_conf_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eval_eval_conf_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.eval_eval_conf_id_seq OWNER TO postgres;

--
-- Name: eval_eval_conf_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.eval_eval_conf_id_seq OWNED BY public.eval_eval_conf.id;


--
-- Name: eval_eval_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eval_eval_data (
    id integer NOT NULL,
    "Nombre" character varying(50) NOT NULL,
    conf_id integer,
    "Peso1" character varying(50),
    "Peso2" character varying(50),
    "Peso3" character varying(50),
    "Peso4" character varying(50),
    "Peso5" character varying(50),
    booleano boolean,
    tiempo timestamp with time zone,
    "Evaluado_id" integer NOT NULL,
    "Evaluador_id" integer NOT NULL
);


ALTER TABLE public.eval_eval_data OWNER TO postgres;

--
-- Name: eval_eval_data_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eval_eval_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.eval_eval_data_id_seq OWNER TO postgres;

--
-- Name: eval_eval_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.eval_eval_data_id_seq OWNED BY public.eval_eval_data.id;


--
-- Name: eval_evaluadores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eval_evaluadores (
    "Nombre" character varying(50) NOT NULL,
    peso character varying(50),
    evaluador boolean,
    id integer NOT NULL
);


ALTER TABLE public.eval_evaluadores OWNER TO postgres;

--
-- Name: eval_evaluados; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eval_evaluados (
    "Nombre" character varying(50) NOT NULL,
    evaluado boolean,
    id integer NOT NULL
);


ALTER TABLE public.eval_evaluados OWNER TO postgres;

--
-- Name: eval_expertos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eval_expertos (
    id integer NOT NULL,
    "Nombre" character varying(50) NOT NULL,
    experto boolean
);


ALTER TABLE public.eval_expertos OWNER TO postgres;

--
-- Name: eval_periodos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eval_periodos (
    id integer NOT NULL,
    conf_id integer NOT NULL,
    "Peso" double precision
);


ALTER TABLE public.eval_periodos OWNER TO postgres;

--
-- Name: eval_periodos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eval_periodos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.eval_periodos_id_seq OWNER TO postgres;

--
-- Name: eval_periodos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.eval_periodos_id_seq OWNED BY public.eval_periodos.id;


--
-- Name: eval_resultados; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eval_resultados (
    "Nombre" character varying(50) NOT NULL,
    "E_periodo_id" integer NOT NULL
);


ALTER TABLE public.eval_resultados OWNER TO postgres;

--
-- Name: eval_userprofileinfo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eval_userprofileinfo (
    id integer NOT NULL,
    user_id integer NOT NULL,
    cargo character varying(50) NOT NULL,
    portfolio_site character varying(200) NOT NULL,
    usuario_id integer,
    profile_pic character varying(100) NOT NULL
);


ALTER TABLE public.eval_userprofileinfo OWNER TO postgres;

--
-- Name: eval_userprofileinfo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eval_userprofileinfo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.eval_userprofileinfo_id_seq OWNER TO postgres;

--
-- Name: eval_userprofileinfo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.eval_userprofileinfo_id_seq OWNED BY public.eval_userprofileinfo.id;


--
-- Name: schedule_calendar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schedule_calendar (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    slug character varying(200) NOT NULL
);


ALTER TABLE public.schedule_calendar OWNER TO postgres;

--
-- Name: schedule_calendar_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.schedule_calendar_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.schedule_calendar_id_seq OWNER TO postgres;

--
-- Name: schedule_calendar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.schedule_calendar_id_seq OWNED BY public.schedule_calendar.id;


--
-- Name: schedule_calendarrelation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schedule_calendarrelation (
    id integer NOT NULL,
    object_id integer NOT NULL,
    distinction character varying(20) NOT NULL,
    inheritable boolean NOT NULL,
    calendar_id integer NOT NULL,
    content_type_id integer NOT NULL
);


ALTER TABLE public.schedule_calendarrelation OWNER TO postgres;

--
-- Name: schedule_calendarrelation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.schedule_calendarrelation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.schedule_calendarrelation_id_seq OWNER TO postgres;

--
-- Name: schedule_calendarrelation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.schedule_calendarrelation_id_seq OWNED BY public.schedule_calendarrelation.id;


--
-- Name: schedule_event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schedule_event (
    id integer NOT NULL,
    start timestamp with time zone NOT NULL,
    "end" timestamp with time zone NOT NULL,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    created_on timestamp with time zone NOT NULL,
    updated_on timestamp with time zone NOT NULL,
    end_recurring_period timestamp with time zone,
    calendar_id integer NOT NULL,
    creator_id integer,
    rule_id integer,
    color_event character varying(10) NOT NULL
);


ALTER TABLE public.schedule_event OWNER TO postgres;

--
-- Name: schedule_event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.schedule_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.schedule_event_id_seq OWNER TO postgres;

--
-- Name: schedule_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.schedule_event_id_seq OWNED BY public.schedule_event.id;


--
-- Name: schedule_eventrelation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schedule_eventrelation (
    id integer NOT NULL,
    object_id integer NOT NULL,
    distinction character varying(20) NOT NULL,
    content_type_id integer NOT NULL,
    event_id integer NOT NULL
);


ALTER TABLE public.schedule_eventrelation OWNER TO postgres;

--
-- Name: schedule_eventrelation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.schedule_eventrelation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.schedule_eventrelation_id_seq OWNER TO postgres;

--
-- Name: schedule_eventrelation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.schedule_eventrelation_id_seq OWNED BY public.schedule_eventrelation.id;


--
-- Name: schedule_occurrence; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schedule_occurrence (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    start timestamp with time zone NOT NULL,
    "end" timestamp with time zone NOT NULL,
    cancelled boolean NOT NULL,
    original_start timestamp with time zone NOT NULL,
    original_end timestamp with time zone NOT NULL,
    created_on timestamp with time zone NOT NULL,
    updated_on timestamp with time zone NOT NULL,
    event_id integer NOT NULL
);


ALTER TABLE public.schedule_occurrence OWNER TO postgres;

--
-- Name: schedule_occurrence_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.schedule_occurrence_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.schedule_occurrence_id_seq OWNER TO postgres;

--
-- Name: schedule_occurrence_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.schedule_occurrence_id_seq OWNED BY public.schedule_occurrence.id;


--
-- Name: schedule_rule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schedule_rule (
    id integer NOT NULL,
    name character varying(32) NOT NULL,
    description text NOT NULL,
    frequency character varying(10) NOT NULL,
    params text NOT NULL
);


ALTER TABLE public.schedule_rule OWNER TO postgres;

--
-- Name: schedule_rule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.schedule_rule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.schedule_rule_id_seq OWNER TO postgres;

--
-- Name: schedule_rule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.schedule_rule_id_seq OWNED BY public.schedule_rule.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: background_task id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.background_task ALTER COLUMN id SET DEFAULT nextval('public.background_task_id_seq'::regclass);


--
-- Name: background_task_completedtask id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.background_task_completedtask ALTER COLUMN id SET DEFAULT nextval('public.background_task_completedtask_id_seq'::regclass);


--
-- Name: celery_taskmeta id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.celery_taskmeta ALTER COLUMN id SET DEFAULT nextval('public.celery_taskmeta_id_seq'::regclass);


--
-- Name: celery_tasksetmeta id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.celery_tasksetmeta ALTER COLUMN id SET DEFAULT nextval('public.celery_tasksetmeta_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: djcelery_crontabschedule id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_crontabschedule ALTER COLUMN id SET DEFAULT nextval('public.djcelery_crontabschedule_id_seq'::regclass);


--
-- Name: djcelery_intervalschedule id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_intervalschedule ALTER COLUMN id SET DEFAULT nextval('public.djcelery_intervalschedule_id_seq'::regclass);


--
-- Name: djcelery_periodictask id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_periodictask ALTER COLUMN id SET DEFAULT nextval('public.djcelery_periodictask_id_seq'::regclass);


--
-- Name: djcelery_taskstate id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_taskstate ALTER COLUMN id SET DEFAULT nextval('public.djcelery_taskstate_id_seq'::regclass);


--
-- Name: djcelery_workerstate id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_workerstate ALTER COLUMN id SET DEFAULT nextval('public.djcelery_workerstate_id_seq'::regclass);


--
-- Name: eval_collection id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_collection ALTER COLUMN id SET DEFAULT nextval('public.eval_collection_id_seq'::regclass);


--
-- Name: eval_collectiontitle id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_collectiontitle ALTER COLUMN id SET DEFAULT nextval('public.eval_collectiontitle_id_seq'::regclass);


--
-- Name: eval_conf_auto id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_conf_auto ALTER COLUMN id SET DEFAULT nextval('public.eval_conf_auto_id_seq'::regclass);


--
-- Name: eval_criterios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_criterios ALTER COLUMN id SET DEFAULT nextval('public.eval_criterios_id_seq'::regclass);


--
-- Name: eval_etiquetas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_etiquetas ALTER COLUMN id SET DEFAULT nextval('public.eval_etiquetas_id_seq'::regclass);


--
-- Name: eval_eval_conf id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_eval_conf ALTER COLUMN id SET DEFAULT nextval('public.eval_eval_conf_id_seq'::regclass);


--
-- Name: eval_eval_conf_evaluado id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_eval_conf_evaluado ALTER COLUMN id SET DEFAULT nextval('public.eval_eval_conf_evaluado_id_seq'::regclass);


--
-- Name: eval_eval_conf_evaluador id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_eval_conf_evaluador ALTER COLUMN id SET DEFAULT nextval('public.eval_eval_conf_evaluador_id_seq'::regclass);


--
-- Name: eval_eval_conf_experto id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_eval_conf_experto ALTER COLUMN id SET DEFAULT nextval('public.eval_eval_conf_experto_id_seq'::regclass);


--
-- Name: eval_eval_data id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_eval_data ALTER COLUMN id SET DEFAULT nextval('public.eval_eval_data_id_seq'::regclass);


--
-- Name: eval_periodos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_periodos ALTER COLUMN id SET DEFAULT nextval('public.eval_periodos_id_seq'::regclass);


--
-- Name: eval_userprofileinfo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_userprofileinfo ALTER COLUMN id SET DEFAULT nextval('public.eval_userprofileinfo_id_seq'::regclass);


--
-- Name: schedule_calendar id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_calendar ALTER COLUMN id SET DEFAULT nextval('public.schedule_calendar_id_seq'::regclass);


--
-- Name: schedule_calendarrelation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_calendarrelation ALTER COLUMN id SET DEFAULT nextval('public.schedule_calendarrelation_id_seq'::regclass);


--
-- Name: schedule_event id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_event ALTER COLUMN id SET DEFAULT nextval('public.schedule_event_id_seq'::regclass);


--
-- Name: schedule_eventrelation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_eventrelation ALTER COLUMN id SET DEFAULT nextval('public.schedule_eventrelation_id_seq'::regclass);


--
-- Name: schedule_occurrence id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_occurrence ALTER COLUMN id SET DEFAULT nextval('public.schedule_occurrence_id_seq'::regclass);


--
-- Name: schedule_rule id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_rule ALTER COLUMN id SET DEFAULT nextval('public.schedule_rule_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
1	admin
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add evaluados	7	add_evaluados
26	Can change evaluados	7	change_evaluados
27	Can delete evaluados	7	delete_evaluados
28	Can view evaluados	7	view_evaluados
29	Can add expertos	8	add_expertos
30	Can change expertos	8	change_expertos
31	Can delete expertos	8	delete_expertos
32	Can view expertos	8	view_expertos
33	Can add evaluadores	9	add_evaluadores
34	Can change evaluadores	9	change_evaluadores
35	Can delete evaluadores	9	delete_evaluadores
36	Can view evaluadores	9	view_evaluadores
37	Can add eval_ conf	10	add_eval_conf
38	Can change eval_ conf	10	change_eval_conf
39	Can delete eval_ conf	10	delete_eval_conf
40	Can view eval_ conf	10	view_eval_conf
41	Can add conf_ auto	11	add_conf_auto
42	Can change conf_ auto	11	change_conf_auto
43	Can delete conf_ auto	11	delete_conf_auto
44	Can view conf_ auto	11	view_conf_auto
45	Can add collection	12	add_collection
46	Can change collection	12	change_collection
47	Can delete collection	12	delete_collection
48	Can view collection	12	view_collection
49	Can add collection title	13	add_collectiontitle
50	Can change collection title	13	change_collectiontitle
51	Can delete collection title	13	delete_collectiontitle
52	Can view collection title	13	view_collectiontitle
53	Can add user profile info	14	add_userprofileinfo
54	Can change user profile info	14	change_userprofileinfo
55	Can delete user profile info	14	delete_userprofileinfo
56	Can view user profile info	14	view_userprofileinfo
57	Can add eval_ data	15	add_eval_data
58	Can change eval_ data	15	change_eval_data
59	Can delete eval_ data	15	delete_eval_data
60	Can view eval_ data	15	view_eval_data
61	Can add criterios	16	add_criterios
62	Can change criterios	16	change_criterios
63	Can delete criterios	16	delete_criterios
64	Can view criterios	16	view_criterios
65	Can add etiquetas	17	add_etiquetas
66	Can change etiquetas	17	change_etiquetas
67	Can delete etiquetas	17	delete_etiquetas
68	Can view etiquetas	17	view_etiquetas
69	Can add periodos	18	add_periodos
70	Can change periodos	18	change_periodos
71	Can delete periodos	18	delete_periodos
72	Can view periodos	18	view_periodos
73	Can add resultados	19	add_resultados
74	Can change resultados	19	change_resultados
75	Can delete resultados	19	delete_resultados
76	Can view resultados	19	view_resultados
77	Can add calendar	20	add_calendar
78	Can change calendar	20	change_calendar
79	Can delete calendar	20	delete_calendar
80	Can view calendar	20	view_calendar
81	Can add calendar relation	21	add_calendarrelation
82	Can change calendar relation	21	change_calendarrelation
83	Can delete calendar relation	21	delete_calendarrelation
84	Can view calendar relation	21	view_calendarrelation
85	Can add event	22	add_event
86	Can change event	22	change_event
87	Can delete event	22	delete_event
88	Can view event	22	view_event
89	Can add event relation	23	add_eventrelation
90	Can change event relation	23	change_eventrelation
91	Can delete event relation	23	delete_eventrelation
92	Can view event relation	23	view_eventrelation
93	Can add occurrence	24	add_occurrence
94	Can change occurrence	24	change_occurrence
95	Can delete occurrence	24	delete_occurrence
96	Can view occurrence	24	view_occurrence
97	Can add rule	25	add_rule
98	Can change rule	25	change_rule
99	Can delete rule	25	delete_rule
100	Can view rule	25	view_rule
101	Can add crontab	26	add_crontabschedule
102	Can change crontab	26	change_crontabschedule
103	Can delete crontab	26	delete_crontabschedule
104	Can view crontab	26	view_crontabschedule
105	Can add interval	27	add_intervalschedule
106	Can change interval	27	change_intervalschedule
107	Can delete interval	27	delete_intervalschedule
108	Can view interval	27	view_intervalschedule
109	Can add periodic task	28	add_periodictask
110	Can change periodic task	28	change_periodictask
111	Can delete periodic task	28	delete_periodictask
112	Can view periodic task	28	view_periodictask
113	Can add periodic tasks	29	add_periodictasks
114	Can change periodic tasks	29	change_periodictasks
115	Can delete periodic tasks	29	delete_periodictasks
116	Can view periodic tasks	29	view_periodictasks
117	Can add task state	30	add_taskmeta
118	Can change task state	30	change_taskmeta
119	Can delete task state	30	delete_taskmeta
120	Can view task state	30	view_taskmeta
121	Can add saved group result	31	add_tasksetmeta
122	Can change saved group result	31	change_tasksetmeta
123	Can delete saved group result	31	delete_tasksetmeta
124	Can view saved group result	31	view_tasksetmeta
125	Can add task	32	add_taskstate
126	Can change task	32	change_taskstate
127	Can delete task	32	delete_taskstate
128	Can view task	32	view_taskstate
129	Can add worker	33	add_workerstate
130	Can change worker	33	change_workerstate
131	Can delete worker	33	delete_workerstate
132	Can view worker	33	view_workerstate
133	Can add completed task	34	add_completedtask
134	Can change completed task	34	change_completedtask
135	Can delete completed task	34	delete_completedtask
136	Can view completed task	34	view_completedtask
137	Can add task	35	add_task
138	Can change task	35	change_task
139	Can delete task	35	delete_task
140	Can view task	35	view_task
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
3	pbkdf2_sha256$150000$ArwlmKEPZfUF$WBpxSWB0ZgTP56N3H9j0JbthZAaKIFY9ad16j9pdP6Y=	\N	f	evaluado1	Enrique	Silva	raulsilvajeldes@hotmail.com	f	t	2019-12-12 15:55:16.847715+00
5	pbkdf2_sha256$150000$reS6lv60rRtJ$mYBSm+WcfBD6LEj3LF6vcCbwlsUot/MtUiaaGsN+fB8=	2019-12-12 15:57:12.124684+00	f	Raul	Raul	Silva	raulsilvajeldes@hotmail.com	f	t	2019-12-12 15:56:11.429348+00
4	pbkdf2_sha256$150000$K0tfRThHbwle$kB8C8tZcDnphfjWSKK6S3KkMyxRDyw4atma7f3qm5rE=	2019-12-12 15:57:57.293438+00	f	evaluador1	Pedro	Silva	raulsilvajeldes@hotmail.com	f	t	2019-12-12 15:55:45.287408+00
2	pbkdf2_sha256$150000$RTOF1wAdM0Bl$/QYoHuTyXpOQl32rDhA/l8ENeaBRJOm5IkaBkeQVGvE=	2019-12-12 15:58:14.560734+00	t	admin	admin			t	t	2019-12-12 15:52:33+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
1	2	1
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: background_task; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.background_task (id, task_name, task_params, task_hash, verbose_name, priority, run_at, repeat, repeat_until, queue, attempts, failed_at, last_error, locked_by, locked_at, creator_object_id, creator_content_type_id) FROM stdin;
1	eval.tasks.get_csv	[[3], {}]	2f0fd3c0d1bfc26b0c5051b438299fc2ee2714b7	\N	0	2019-12-12 15:56:41.090139+00	60	\N	\N	0	\N		\N	\N	\N	\N
\.


--
-- Data for Name: background_task_completedtask; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.background_task_completedtask (id, task_name, task_params, task_hash, verbose_name, priority, run_at, repeat, repeat_until, queue, attempts, failed_at, last_error, locked_by, locked_at, creator_object_id, creator_content_type_id) FROM stdin;
\.


--
-- Data for Name: celery_taskmeta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.celery_taskmeta (id, task_id, status, result, date_done, traceback, hidden, meta) FROM stdin;
\.


--
-- Data for Name: celery_tasksetmeta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.celery_tasksetmeta (id, taskset_id, result, date_done, hidden) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
2	2019-12-12 15:53:32.49236+00	1	admin	1	[{"added": {}}]	3	2
3	2019-12-12 15:53:48.950158+00	2	admin	2	[{"changed": {"fields": ["first_name", "groups"]}}]	4	2
4	2019-12-12 15:53:49.528309+00	2	admin	2	[]	4	2
5	2019-12-12 15:54:14.700975+00	1	Test	3		10	2
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	eval	evaluados
8	eval	expertos
9	eval	evaluadores
10	eval	eval_conf
11	eval	conf_auto
12	eval	collection
13	eval	collectiontitle
14	eval	userprofileinfo
15	eval	eval_data
16	eval	criterios
17	eval	etiquetas
18	eval	periodos
19	eval	resultados
20	schedule	calendar
21	schedule	calendarrelation
22	schedule	event
23	schedule	eventrelation
24	schedule	occurrence
25	schedule	rule
26	djcelery	crontabschedule
27	djcelery	intervalschedule
28	djcelery	periodictask
29	djcelery	periodictasks
30	djcelery	taskmeta
31	djcelery	tasksetmeta
32	djcelery	taskstate
33	djcelery	workerstate
34	background_task	completedtask
35	background_task	task
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2019-12-12 15:30:58.288162+00
2	auth	0001_initial	2019-12-12 15:30:58.397552+00
3	admin	0001_initial	2019-12-12 15:30:58.569447+00
4	admin	0002_logentry_remove_auto_add	2019-12-12 15:30:58.616305+00
5	admin	0003_logentry_add_action_flag_choices	2019-12-12 15:30:58.63193+00
6	contenttypes	0002_remove_content_type_name	2019-12-12 15:30:58.694483+00
7	auth	0002_alter_permission_name_max_length	2019-12-12 15:30:58.710054+00
8	auth	0003_alter_user_email_max_length	2019-12-12 15:30:58.710054+00
9	auth	0004_alter_user_username_opts	2019-12-12 15:30:58.725697+00
10	auth	0005_alter_user_last_login_null	2019-12-12 15:30:58.741302+00
11	auth	0006_require_contenttypes_0002	2019-12-12 15:30:58.756932+00
12	auth	0007_alter_validators_add_error_messages	2019-12-12 15:30:58.772556+00
13	auth	0008_alter_user_username_max_length	2019-12-12 15:30:58.819454+00
14	auth	0009_alter_user_last_name_max_length	2019-12-12 15:30:58.835055+00
15	auth	0010_alter_group_name_max_length	2019-12-12 15:30:58.850703+00
16	auth	0011_update_proxy_permissions	2019-12-12 15:30:58.866311+00
17	background_task	0001_initial	2019-12-12 15:30:58.944432+00
18	background_task	0002_auto_20170927_1109	2019-12-12 15:30:59.475701+00
19	djcelery	0001_initial	2019-12-12 15:30:59.756957+00
20	schedule	0001_initial	2019-12-12 15:31:00.085103+00
21	schedule	0002_event_color_event	2019-12-12 15:31:00.194484+00
22	schedule	0003_auto_20160715_0028	2019-12-12 15:31:00.319475+00
23	schedule	0006_update_text_fields_empty_string	2019-12-12 15:31:00.366358+00
24	schedule	0004_text_fields_not_null	2019-12-12 15:31:00.506982+00
25	schedule	0005_verbose_name_plural_for_calendar	2019-12-12 15:31:00.522612+00
26	schedule	0007_merge_text_fields	2019-12-12 15:31:00.522612+00
27	schedule	0008_gfk_index	2019-12-12 15:31:00.694504+00
28	schedule	0009_merge_20180108_2303	2019-12-12 15:31:00.694504+00
29	schedule	0010_events_set_missing_calendar	2019-12-12 15:31:00.741365+00
30	schedule	0011_event_calendar_not_null	2019-12-12 15:31:00.788251+00
31	schedule	0012_auto_20191025_1852	2019-12-12 15:31:00.835117+00
32	sessions	0001_initial	2019-12-12 15:31:00.866379+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
2qva1x6oafvpbiykpeq4gsvs21emvbap	Yjk0NTZjNDU0ZGZkNDNlYTY5ODRjZDQwNTRmMTEzMzUwYjBhY2Y1Yjp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4YTZiNzBmY2MzODg4NzU5OWY3Yzg0YmI4MmYxMGFjMjk0ZmIwNzM5In0=	2019-12-26 15:58:14.560734+00
\.


--
-- Data for Name: djcelery_crontabschedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.djcelery_crontabschedule (id, minute, hour, day_of_week, day_of_month, month_of_year) FROM stdin;
\.


--
-- Data for Name: djcelery_intervalschedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.djcelery_intervalschedule (id, every, period) FROM stdin;
\.


--
-- Data for Name: djcelery_periodictask; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.djcelery_periodictask (id, name, task, args, kwargs, queue, exchange, routing_key, expires, enabled, last_run_at, total_run_count, date_changed, description, crontab_id, interval_id) FROM stdin;
\.


--
-- Data for Name: djcelery_periodictasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.djcelery_periodictasks (ident, last_update) FROM stdin;
\.


--
-- Data for Name: djcelery_taskstate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.djcelery_taskstate (id, state, task_id, name, tstamp, args, kwargs, eta, expires, result, traceback, runtime, retries, hidden, worker_id) FROM stdin;
\.


--
-- Data for Name: djcelery_workerstate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.djcelery_workerstate (id, hostname, last_heartbeat) FROM stdin;
\.


--
-- Data for Name: eval_collection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eval_collection (id, "Nombre", "Peso", "Conf_id", note, created_by_id) FROM stdin;
1	Responsabilidad	0.5	3		\N
2	Etica	0.5	3		\N
\.


--
-- Data for Name: eval_collectiontitle; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eval_collectiontitle (id, collection_id, "Nombre", "Peso") FROM stdin;
1	1	Malo	0000000
2	1	Bueno	0000000
3	2	Malo	0000000
4	2	Bueno	0000000
\.


--
-- Data for Name: eval_conf_auto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eval_conf_auto (id, "Nombre", tipo_periodo, tolerancia, umbral) FROM stdin;
\.


--
-- Data for Name: eval_criterios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eval_criterios (id, "Nombre", "Peso", "Conf_id") FROM stdin;
\.


--
-- Data for Name: eval_etiquetas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eval_etiquetas (id, "Etiqueta", "Peso", conf_id, criterio_id) FROM stdin;
\.


--
-- Data for Name: eval_eval_conf; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eval_eval_conf (id, "Nombre", fecha, tipo_periodo, booleano, fecha_termino, metodo_ranking, modo, status, frecuencia_ranking, tolerancia, umbral, tipo_automatico, img) FROM stdin;
3	Evaluacion manual	2019-12-12 15:52:39.209357+00	Evaluación Diaria	f	2019-12-31 03:00:00+00	\N	Manual	Activo	\N	1	0.05		
\.


--
-- Data for Name: eval_eval_conf_evaluado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eval_eval_conf_evaluado (id, eval_conf_id, evaluados_id) FROM stdin;
1	3	3
\.


--
-- Data for Name: eval_eval_conf_evaluador; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eval_eval_conf_evaluador (id, eval_conf_id, evaluadores_id) FROM stdin;
1	3	4
\.


--
-- Data for Name: eval_eval_conf_experto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eval_eval_conf_experto (id, eval_conf_id, expertos_id) FROM stdin;
1	3	5
\.


--
-- Data for Name: eval_eval_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eval_eval_data (id, "Nombre", conf_id, "Peso1", "Peso2", "Peso3", "Peso4", "Peso5", booleano, tiempo, "Evaluado_id", "Evaluador_id") FROM stdin;
1	conf	3	Bueno	Malo	\N	\N	\N	f	2019-12-12 15:58:08.966449+00	3	4
\.


--
-- Data for Name: eval_evaluadores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eval_evaluadores ("Nombre", peso, evaluador, id) FROM stdin;
Pedro Evaluador	\N	t	4
\.


--
-- Data for Name: eval_evaluados; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eval_evaluados ("Nombre", evaluado, id) FROM stdin;
Enrique Ingeniero	t	3
\.


--
-- Data for Name: eval_expertos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eval_expertos (id, "Nombre", experto) FROM stdin;
5	Raul Experto	t
\.


--
-- Data for Name: eval_periodos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eval_periodos (id, conf_id, "Peso") FROM stdin;
\.


--
-- Data for Name: eval_resultados; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eval_resultados ("Nombre", "E_periodo_id") FROM stdin;
\.


--
-- Data for Name: eval_userprofileinfo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eval_userprofileinfo (id, user_id, cargo, portfolio_site, usuario_id, profile_pic) FROM stdin;
1	3	Ingeniero		\N	
2	4	Evaluador		\N	
3	5	Experto		\N	
\.


--
-- Data for Name: schedule_calendar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schedule_calendar (id, name, slug) FROM stdin;
\.


--
-- Data for Name: schedule_calendarrelation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schedule_calendarrelation (id, object_id, distinction, inheritable, calendar_id, content_type_id) FROM stdin;
\.


--
-- Data for Name: schedule_event; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schedule_event (id, start, "end", title, description, created_on, updated_on, end_recurring_period, calendar_id, creator_id, rule_id, color_event) FROM stdin;
\.


--
-- Data for Name: schedule_eventrelation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schedule_eventrelation (id, object_id, distinction, content_type_id, event_id) FROM stdin;
\.


--
-- Data for Name: schedule_occurrence; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schedule_occurrence (id, title, description, start, "end", cancelled, original_start, original_end, created_on, updated_on, event_id) FROM stdin;
\.


--
-- Data for Name: schedule_rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schedule_rule (id, name, description, frequency, params) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, true);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 140, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, true);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 5, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: background_task_completedtask_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.background_task_completedtask_id_seq', 1, false);


--
-- Name: background_task_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.background_task_id_seq', 1, true);


--
-- Name: celery_taskmeta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.celery_taskmeta_id_seq', 1, false);


--
-- Name: celery_tasksetmeta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.celery_tasksetmeta_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 5, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 35, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 32, true);


--
-- Name: djcelery_crontabschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.djcelery_crontabschedule_id_seq', 1, false);


--
-- Name: djcelery_intervalschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.djcelery_intervalschedule_id_seq', 1, false);


--
-- Name: djcelery_periodictask_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.djcelery_periodictask_id_seq', 1, false);


--
-- Name: djcelery_taskstate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.djcelery_taskstate_id_seq', 1, false);


--
-- Name: djcelery_workerstate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.djcelery_workerstate_id_seq', 1, false);


--
-- Name: eval_collection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eval_collection_id_seq', 2, true);


--
-- Name: eval_collectiontitle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eval_collectiontitle_id_seq', 4, true);


--
-- Name: eval_conf_auto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eval_conf_auto_id_seq', 1, false);


--
-- Name: eval_criterios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eval_criterios_id_seq', 1, false);


--
-- Name: eval_etiquetas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eval_etiquetas_id_seq', 1, false);


--
-- Name: eval_eval_conf_evaluado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eval_eval_conf_evaluado_id_seq', 1, true);


--
-- Name: eval_eval_conf_evaluador_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eval_eval_conf_evaluador_id_seq', 1, true);


--
-- Name: eval_eval_conf_experto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eval_eval_conf_experto_id_seq', 1, true);


--
-- Name: eval_eval_conf_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eval_eval_conf_id_seq', 3, true);


--
-- Name: eval_eval_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eval_eval_data_id_seq', 1, true);


--
-- Name: eval_periodos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eval_periodos_id_seq', 1, false);


--
-- Name: eval_userprofileinfo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eval_userprofileinfo_id_seq', 3, true);


--
-- Name: schedule_calendar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.schedule_calendar_id_seq', 1, false);


--
-- Name: schedule_calendarrelation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.schedule_calendarrelation_id_seq', 1, false);


--
-- Name: schedule_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.schedule_event_id_seq', 1, false);


--
-- Name: schedule_eventrelation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.schedule_eventrelation_id_seq', 1, false);


--
-- Name: schedule_occurrence_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.schedule_occurrence_id_seq', 1, false);


--
-- Name: schedule_rule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.schedule_rule_id_seq', 1, false);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: background_task_completedtask background_task_completedtask_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.background_task_completedtask
    ADD CONSTRAINT background_task_completedtask_pkey PRIMARY KEY (id);


--
-- Name: background_task background_task_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.background_task
    ADD CONSTRAINT background_task_pkey PRIMARY KEY (id);


--
-- Name: celery_taskmeta celery_taskmeta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.celery_taskmeta
    ADD CONSTRAINT celery_taskmeta_pkey PRIMARY KEY (id);


--
-- Name: celery_taskmeta celery_taskmeta_task_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.celery_taskmeta
    ADD CONSTRAINT celery_taskmeta_task_id_key UNIQUE (task_id);


--
-- Name: celery_tasksetmeta celery_tasksetmeta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.celery_tasksetmeta
    ADD CONSTRAINT celery_tasksetmeta_pkey PRIMARY KEY (id);


--
-- Name: celery_tasksetmeta celery_tasksetmeta_taskset_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.celery_tasksetmeta
    ADD CONSTRAINT celery_tasksetmeta_taskset_id_key UNIQUE (taskset_id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: djcelery_crontabschedule djcelery_crontabschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_crontabschedule
    ADD CONSTRAINT djcelery_crontabschedule_pkey PRIMARY KEY (id);


--
-- Name: djcelery_intervalschedule djcelery_intervalschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_intervalschedule
    ADD CONSTRAINT djcelery_intervalschedule_pkey PRIMARY KEY (id);


--
-- Name: djcelery_periodictask djcelery_periodictask_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_periodictask
    ADD CONSTRAINT djcelery_periodictask_name_key UNIQUE (name);


--
-- Name: djcelery_periodictask djcelery_periodictask_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_periodictask
    ADD CONSTRAINT djcelery_periodictask_pkey PRIMARY KEY (id);


--
-- Name: djcelery_periodictasks djcelery_periodictasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_periodictasks
    ADD CONSTRAINT djcelery_periodictasks_pkey PRIMARY KEY (ident);


--
-- Name: djcelery_taskstate djcelery_taskstate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_taskstate
    ADD CONSTRAINT djcelery_taskstate_pkey PRIMARY KEY (id);


--
-- Name: djcelery_taskstate djcelery_taskstate_task_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_taskstate
    ADD CONSTRAINT djcelery_taskstate_task_id_key UNIQUE (task_id);


--
-- Name: djcelery_workerstate djcelery_workerstate_hostname_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_workerstate
    ADD CONSTRAINT djcelery_workerstate_hostname_key UNIQUE (hostname);


--
-- Name: djcelery_workerstate djcelery_workerstate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_workerstate
    ADD CONSTRAINT djcelery_workerstate_pkey PRIMARY KEY (id);


--
-- Name: eval_collection eval_collection_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_collection
    ADD CONSTRAINT eval_collection_pkey PRIMARY KEY (id);


--
-- Name: eval_collectiontitle eval_collectiontitle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_collectiontitle
    ADD CONSTRAINT eval_collectiontitle_pkey PRIMARY KEY (id);


--
-- Name: eval_conf_auto eval_conf_auto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_conf_auto
    ADD CONSTRAINT eval_conf_auto_pkey PRIMARY KEY (id);


--
-- Name: eval_criterios eval_criterios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_criterios
    ADD CONSTRAINT eval_criterios_pkey PRIMARY KEY (id);


--
-- Name: eval_etiquetas eval_etiquetas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_etiquetas
    ADD CONSTRAINT eval_etiquetas_pkey PRIMARY KEY (id);


--
-- Name: eval_eval_conf_evaluado eval_eval_conf_evaluado_eval_conf_id_evaluados_id_2bc278e6_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_eval_conf_evaluado
    ADD CONSTRAINT eval_eval_conf_evaluado_eval_conf_id_evaluados_id_2bc278e6_uniq UNIQUE (eval_conf_id, evaluados_id);


--
-- Name: eval_eval_conf_evaluado eval_eval_conf_evaluado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_eval_conf_evaluado
    ADD CONSTRAINT eval_eval_conf_evaluado_pkey PRIMARY KEY (id);


--
-- Name: eval_eval_conf_evaluador eval_eval_conf_evaluador_eval_conf_id_evaluadores_1f563338_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_eval_conf_evaluador
    ADD CONSTRAINT eval_eval_conf_evaluador_eval_conf_id_evaluadores_1f563338_uniq UNIQUE (eval_conf_id, evaluadores_id);


--
-- Name: eval_eval_conf_evaluador eval_eval_conf_evaluador_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_eval_conf_evaluador
    ADD CONSTRAINT eval_eval_conf_evaluador_pkey PRIMARY KEY (id);


--
-- Name: eval_eval_conf_experto eval_eval_conf_experto_eval_conf_id_expertos_id_d42fee47_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_eval_conf_experto
    ADD CONSTRAINT eval_eval_conf_experto_eval_conf_id_expertos_id_d42fee47_uniq UNIQUE (eval_conf_id, expertos_id);


--
-- Name: eval_eval_conf_experto eval_eval_conf_experto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_eval_conf_experto
    ADD CONSTRAINT eval_eval_conf_experto_pkey PRIMARY KEY (id);


--
-- Name: eval_eval_conf eval_eval_conf_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_eval_conf
    ADD CONSTRAINT eval_eval_conf_pkey PRIMARY KEY (id);


--
-- Name: eval_eval_data eval_eval_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_eval_data
    ADD CONSTRAINT eval_eval_data_pkey PRIMARY KEY (id);


--
-- Name: eval_evaluadores eval_evaluadores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_evaluadores
    ADD CONSTRAINT eval_evaluadores_pkey PRIMARY KEY (id);


--
-- Name: eval_evaluados eval_evaluados_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_evaluados
    ADD CONSTRAINT eval_evaluados_pkey PRIMARY KEY (id);


--
-- Name: eval_expertos eval_expertos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_expertos
    ADD CONSTRAINT eval_expertos_pkey PRIMARY KEY (id);


--
-- Name: eval_periodos eval_periodos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_periodos
    ADD CONSTRAINT eval_periodos_pkey PRIMARY KEY (id);


--
-- Name: eval_resultados eval_resultados_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_resultados
    ADD CONSTRAINT eval_resultados_pkey PRIMARY KEY ("E_periodo_id");


--
-- Name: eval_userprofileinfo eval_userprofileinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_userprofileinfo
    ADD CONSTRAINT eval_userprofileinfo_pkey PRIMARY KEY (id);


--
-- Name: eval_userprofileinfo eval_userprofileinfo_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_userprofileinfo
    ADD CONSTRAINT eval_userprofileinfo_user_id_key UNIQUE (user_id);


--
-- Name: schedule_calendar schedule_calendar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_calendar
    ADD CONSTRAINT schedule_calendar_pkey PRIMARY KEY (id);


--
-- Name: schedule_calendar schedule_calendar_slug_ba17e861_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_calendar
    ADD CONSTRAINT schedule_calendar_slug_ba17e861_uniq UNIQUE (slug);


--
-- Name: schedule_calendarrelation schedule_calendarrelation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_calendarrelation
    ADD CONSTRAINT schedule_calendarrelation_pkey PRIMARY KEY (id);


--
-- Name: schedule_event schedule_event_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_event
    ADD CONSTRAINT schedule_event_pkey PRIMARY KEY (id);


--
-- Name: schedule_eventrelation schedule_eventrelation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_eventrelation
    ADD CONSTRAINT schedule_eventrelation_pkey PRIMARY KEY (id);


--
-- Name: schedule_occurrence schedule_occurrence_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_occurrence
    ADD CONSTRAINT schedule_occurrence_pkey PRIMARY KEY (id);


--
-- Name: schedule_rule schedule_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_rule
    ADD CONSTRAINT schedule_rule_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: background_task_attempts_a9ade23d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX background_task_attempts_a9ade23d ON public.background_task USING btree (attempts);


--
-- Name: background_task_completedtask_attempts_772a6783; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX background_task_completedtask_attempts_772a6783 ON public.background_task_completedtask USING btree (attempts);


--
-- Name: background_task_completedtask_creator_content_type_id_21d6a741; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX background_task_completedtask_creator_content_type_id_21d6a741 ON public.background_task_completedtask USING btree (creator_content_type_id);


--
-- Name: background_task_completedtask_failed_at_3de56618; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX background_task_completedtask_failed_at_3de56618 ON public.background_task_completedtask USING btree (failed_at);


--
-- Name: background_task_completedtask_locked_at_29c62708; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX background_task_completedtask_locked_at_29c62708 ON public.background_task_completedtask USING btree (locked_at);


--
-- Name: background_task_completedtask_locked_by_edc8a213; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX background_task_completedtask_locked_by_edc8a213 ON public.background_task_completedtask USING btree (locked_by);


--
-- Name: background_task_completedtask_locked_by_edc8a213_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX background_task_completedtask_locked_by_edc8a213_like ON public.background_task_completedtask USING btree (locked_by varchar_pattern_ops);


--
-- Name: background_task_completedtask_priority_9080692e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX background_task_completedtask_priority_9080692e ON public.background_task_completedtask USING btree (priority);


--
-- Name: background_task_completedtask_queue_61fb0415; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX background_task_completedtask_queue_61fb0415 ON public.background_task_completedtask USING btree (queue);


--
-- Name: background_task_completedtask_queue_61fb0415_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX background_task_completedtask_queue_61fb0415_like ON public.background_task_completedtask USING btree (queue varchar_pattern_ops);


--
-- Name: background_task_completedtask_run_at_77c80f34; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX background_task_completedtask_run_at_77c80f34 ON public.background_task_completedtask USING btree (run_at);


--
-- Name: background_task_completedtask_task_hash_91187576; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX background_task_completedtask_task_hash_91187576 ON public.background_task_completedtask USING btree (task_hash);


--
-- Name: background_task_completedtask_task_hash_91187576_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX background_task_completedtask_task_hash_91187576_like ON public.background_task_completedtask USING btree (task_hash varchar_pattern_ops);


--
-- Name: background_task_completedtask_task_name_388dabc2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX background_task_completedtask_task_name_388dabc2 ON public.background_task_completedtask USING btree (task_name);


--
-- Name: background_task_completedtask_task_name_388dabc2_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX background_task_completedtask_task_name_388dabc2_like ON public.background_task_completedtask USING btree (task_name varchar_pattern_ops);


--
-- Name: background_task_creator_content_type_id_61cc9af3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX background_task_creator_content_type_id_61cc9af3 ON public.background_task USING btree (creator_content_type_id);


--
-- Name: background_task_failed_at_b81bba14; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX background_task_failed_at_b81bba14 ON public.background_task USING btree (failed_at);


--
-- Name: background_task_locked_at_0fb0f225; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX background_task_locked_at_0fb0f225 ON public.background_task USING btree (locked_at);


--
-- Name: background_task_locked_by_db7779e3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX background_task_locked_by_db7779e3 ON public.background_task USING btree (locked_by);


--
-- Name: background_task_locked_by_db7779e3_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX background_task_locked_by_db7779e3_like ON public.background_task USING btree (locked_by varchar_pattern_ops);


--
-- Name: background_task_priority_88bdbce9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX background_task_priority_88bdbce9 ON public.background_task USING btree (priority);


--
-- Name: background_task_queue_1d5f3a40; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX background_task_queue_1d5f3a40 ON public.background_task USING btree (queue);


--
-- Name: background_task_queue_1d5f3a40_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX background_task_queue_1d5f3a40_like ON public.background_task USING btree (queue varchar_pattern_ops);


--
-- Name: background_task_run_at_7baca3aa; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX background_task_run_at_7baca3aa ON public.background_task USING btree (run_at);


--
-- Name: background_task_task_hash_d8f233bd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX background_task_task_hash_d8f233bd ON public.background_task USING btree (task_hash);


--
-- Name: background_task_task_hash_d8f233bd_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX background_task_task_hash_d8f233bd_like ON public.background_task USING btree (task_hash varchar_pattern_ops);


--
-- Name: background_task_task_name_4562d56a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX background_task_task_name_4562d56a ON public.background_task USING btree (task_name);


--
-- Name: background_task_task_name_4562d56a_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX background_task_task_name_4562d56a_like ON public.background_task USING btree (task_name varchar_pattern_ops);


--
-- Name: celery_taskmeta_hidden_23fd02dc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX celery_taskmeta_hidden_23fd02dc ON public.celery_taskmeta USING btree (hidden);


--
-- Name: celery_taskmeta_task_id_9558b198_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX celery_taskmeta_task_id_9558b198_like ON public.celery_taskmeta USING btree (task_id varchar_pattern_ops);


--
-- Name: celery_tasksetmeta_hidden_593cfc24; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX celery_tasksetmeta_hidden_593cfc24 ON public.celery_tasksetmeta USING btree (hidden);


--
-- Name: celery_tasksetmeta_taskset_id_a5a1d4ae_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX celery_tasksetmeta_taskset_id_a5a1d4ae_like ON public.celery_tasksetmeta USING btree (taskset_id varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: djcelery_periodictask_crontab_id_75609bab; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_periodictask_crontab_id_75609bab ON public.djcelery_periodictask USING btree (crontab_id);


--
-- Name: djcelery_periodictask_interval_id_b426ab02; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_periodictask_interval_id_b426ab02 ON public.djcelery_periodictask USING btree (interval_id);


--
-- Name: djcelery_periodictask_name_cb62cda9_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_periodictask_name_cb62cda9_like ON public.djcelery_periodictask USING btree (name varchar_pattern_ops);


--
-- Name: djcelery_taskstate_hidden_c3905e57; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_taskstate_hidden_c3905e57 ON public.djcelery_taskstate USING btree (hidden);


--
-- Name: djcelery_taskstate_name_8af9eded; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_taskstate_name_8af9eded ON public.djcelery_taskstate USING btree (name);


--
-- Name: djcelery_taskstate_name_8af9eded_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_taskstate_name_8af9eded_like ON public.djcelery_taskstate USING btree (name varchar_pattern_ops);


--
-- Name: djcelery_taskstate_state_53543be4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_taskstate_state_53543be4 ON public.djcelery_taskstate USING btree (state);


--
-- Name: djcelery_taskstate_state_53543be4_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_taskstate_state_53543be4_like ON public.djcelery_taskstate USING btree (state varchar_pattern_ops);


--
-- Name: djcelery_taskstate_task_id_9d2efdb5_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_taskstate_task_id_9d2efdb5_like ON public.djcelery_taskstate USING btree (task_id varchar_pattern_ops);


--
-- Name: djcelery_taskstate_tstamp_4c3f93a1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_taskstate_tstamp_4c3f93a1 ON public.djcelery_taskstate USING btree (tstamp);


--
-- Name: djcelery_taskstate_worker_id_f7f57a05; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_taskstate_worker_id_f7f57a05 ON public.djcelery_taskstate USING btree (worker_id);


--
-- Name: djcelery_workerstate_hostname_b31c7fab_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_workerstate_hostname_b31c7fab_like ON public.djcelery_workerstate USING btree (hostname varchar_pattern_ops);


--
-- Name: djcelery_workerstate_last_heartbeat_4539b544; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_workerstate_last_heartbeat_4539b544 ON public.djcelery_workerstate USING btree (last_heartbeat);


--
-- Name: eval_collection_Conf_id_bf4132a1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "eval_collection_Conf_id_bf4132a1" ON public.eval_collection USING btree ("Conf_id");


--
-- Name: eval_collection_created_by_id_b497d003; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eval_collection_created_by_id_b497d003 ON public.eval_collection USING btree (created_by_id);


--
-- Name: eval_collectiontitle_collection_id_2b5c465e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eval_collectiontitle_collection_id_2b5c465e ON public.eval_collectiontitle USING btree (collection_id);


--
-- Name: eval_criterios_Conf_id_2b6def4f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "eval_criterios_Conf_id_2b6def4f" ON public.eval_criterios USING btree ("Conf_id");


--
-- Name: eval_etiquetas_conf_id_41318851; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eval_etiquetas_conf_id_41318851 ON public.eval_etiquetas USING btree (conf_id);


--
-- Name: eval_etiquetas_criterio_id_ee4bd880; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eval_etiquetas_criterio_id_ee4bd880 ON public.eval_etiquetas USING btree (criterio_id);


--
-- Name: eval_eval_conf_evaluado_eval_conf_id_165a01fa; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eval_eval_conf_evaluado_eval_conf_id_165a01fa ON public.eval_eval_conf_evaluado USING btree (eval_conf_id);


--
-- Name: eval_eval_conf_evaluado_evaluados_id_a4f740c2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eval_eval_conf_evaluado_evaluados_id_a4f740c2 ON public.eval_eval_conf_evaluado USING btree (evaluados_id);


--
-- Name: eval_eval_conf_evaluador_eval_conf_id_81c73158; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eval_eval_conf_evaluador_eval_conf_id_81c73158 ON public.eval_eval_conf_evaluador USING btree (eval_conf_id);


--
-- Name: eval_eval_conf_evaluador_evaluadores_id_e6f38b9a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eval_eval_conf_evaluador_evaluadores_id_e6f38b9a ON public.eval_eval_conf_evaluador USING btree (evaluadores_id);


--
-- Name: eval_eval_conf_experto_eval_conf_id_ee984dd1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eval_eval_conf_experto_eval_conf_id_ee984dd1 ON public.eval_eval_conf_experto USING btree (eval_conf_id);


--
-- Name: eval_eval_conf_experto_expertos_id_490d019d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eval_eval_conf_experto_expertos_id_490d019d ON public.eval_eval_conf_experto USING btree (expertos_id);


--
-- Name: eval_eval_data_Evaluado_id_fb65b36c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "eval_eval_data_Evaluado_id_fb65b36c" ON public.eval_eval_data USING btree ("Evaluado_id");


--
-- Name: eval_eval_data_Evaluador_id_fcddaaed; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "eval_eval_data_Evaluador_id_fcddaaed" ON public.eval_eval_data USING btree ("Evaluador_id");


--
-- Name: eval_eval_data_conf_id_c9bd1444; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eval_eval_data_conf_id_c9bd1444 ON public.eval_eval_data USING btree (conf_id);


--
-- Name: eval_periodos_conf_id_ced901d7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eval_periodos_conf_id_ced901d7 ON public.eval_periodos USING btree (conf_id);


--
-- Name: eval_userprofileinfo_usuario_id_c63d494a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eval_userprofileinfo_usuario_id_c63d494a ON public.eval_userprofileinfo USING btree (usuario_id);


--
-- Name: schedule_calendar_slug_ba17e861_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX schedule_calendar_slug_ba17e861_like ON public.schedule_calendar USING btree (slug varchar_pattern_ops);


--
-- Name: schedule_calendarrelatio_content_type_id_object_i_3378a516_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX schedule_calendarrelatio_content_type_id_object_i_3378a516_idx ON public.schedule_calendarrelation USING btree (content_type_id, object_id);


--
-- Name: schedule_calendarrelation_calendar_id_0a50be2e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX schedule_calendarrelation_calendar_id_0a50be2e ON public.schedule_calendarrelation USING btree (calendar_id);


--
-- Name: schedule_calendarrelation_content_type_id_f2a42f5b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX schedule_calendarrelation_content_type_id_f2a42f5b ON public.schedule_calendarrelation USING btree (content_type_id);


--
-- Name: schedule_calendarrelation_object_id_1743bce6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX schedule_calendarrelation_object_id_1743bce6 ON public.schedule_calendarrelation USING btree (object_id);


--
-- Name: schedule_event_calendar_id_eb1c700f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX schedule_event_calendar_id_eb1c700f ON public.schedule_event USING btree (calendar_id);


--
-- Name: schedule_event_creator_id_d2ffab6e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX schedule_event_creator_id_d2ffab6e ON public.schedule_event USING btree (creator_id);


--
-- Name: schedule_event_end_674c5848; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX schedule_event_end_674c5848 ON public.schedule_event USING btree ("end");


--
-- Name: schedule_event_end_recurring_period_672addcf; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX schedule_event_end_recurring_period_672addcf ON public.schedule_event USING btree (end_recurring_period);


--
-- Name: schedule_event_rule_id_90b83d31; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX schedule_event_rule_id_90b83d31 ON public.schedule_event USING btree (rule_id);


--
-- Name: schedule_event_start_a11492a7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX schedule_event_start_a11492a7 ON public.schedule_event USING btree (start);


--
-- Name: schedule_event_start_end_89f30672_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX schedule_event_start_end_89f30672_idx ON public.schedule_event USING btree (start, "end");


--
-- Name: schedule_eventrelation_content_type_id_d4187723; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX schedule_eventrelation_content_type_id_d4187723 ON public.schedule_eventrelation USING btree (content_type_id);


--
-- Name: schedule_eventrelation_content_type_id_object_id_c1b1e893_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX schedule_eventrelation_content_type_id_object_id_c1b1e893_idx ON public.schedule_eventrelation USING btree (content_type_id, object_id);


--
-- Name: schedule_eventrelation_event_id_8c57a7b4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX schedule_eventrelation_event_id_8c57a7b4 ON public.schedule_eventrelation USING btree (event_id);


--
-- Name: schedule_eventrelation_object_id_e22334a2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX schedule_eventrelation_object_id_e22334a2 ON public.schedule_eventrelation USING btree (object_id);


--
-- Name: schedule_occurrence_end_ae255624; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX schedule_occurrence_end_ae255624 ON public.schedule_occurrence USING btree ("end");


--
-- Name: schedule_occurrence_event_id_ade47cd8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX schedule_occurrence_event_id_ade47cd8 ON public.schedule_occurrence USING btree (event_id);


--
-- Name: schedule_occurrence_start_b28eeb2f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX schedule_occurrence_start_b28eeb2f ON public.schedule_occurrence USING btree (start);


--
-- Name: schedule_occurrence_start_end_5fc98870_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX schedule_occurrence_start_end_5fc98870_idx ON public.schedule_occurrence USING btree (start, "end");


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: background_task_completedtask background_task_comp_creator_content_type_21d6a741_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.background_task_completedtask
    ADD CONSTRAINT background_task_comp_creator_content_type_21d6a741_fk_django_co FOREIGN KEY (creator_content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: background_task background_task_creator_content_type_61cc9af3_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.background_task
    ADD CONSTRAINT background_task_creator_content_type_61cc9af3_fk_django_co FOREIGN KEY (creator_content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: djcelery_periodictask djcelery_periodictas_crontab_id_75609bab_fk_djcelery_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_periodictask
    ADD CONSTRAINT djcelery_periodictas_crontab_id_75609bab_fk_djcelery_ FOREIGN KEY (crontab_id) REFERENCES public.djcelery_crontabschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: djcelery_periodictask djcelery_periodictas_interval_id_b426ab02_fk_djcelery_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_periodictask
    ADD CONSTRAINT djcelery_periodictas_interval_id_b426ab02_fk_djcelery_ FOREIGN KEY (interval_id) REFERENCES public.djcelery_intervalschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: djcelery_taskstate djcelery_taskstate_worker_id_f7f57a05_fk_djcelery_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_taskstate
    ADD CONSTRAINT djcelery_taskstate_worker_id_f7f57a05_fk_djcelery_ FOREIGN KEY (worker_id) REFERENCES public.djcelery_workerstate(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: eval_collection eval_collection_Conf_id_bf4132a1_fk_eval_eval_conf_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_collection
    ADD CONSTRAINT "eval_collection_Conf_id_bf4132a1_fk_eval_eval_conf_id" FOREIGN KEY ("Conf_id") REFERENCES public.eval_eval_conf(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: eval_collection eval_collection_created_by_id_b497d003_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_collection
    ADD CONSTRAINT eval_collection_created_by_id_b497d003_fk_auth_user_id FOREIGN KEY (created_by_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: eval_collectiontitle eval_collectiontitle_collection_id_2b5c465e_fk_eval_coll; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_collectiontitle
    ADD CONSTRAINT eval_collectiontitle_collection_id_2b5c465e_fk_eval_coll FOREIGN KEY (collection_id) REFERENCES public.eval_collection(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: eval_criterios eval_criterios_Conf_id_2b6def4f_fk_eval_eval_conf_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_criterios
    ADD CONSTRAINT "eval_criterios_Conf_id_2b6def4f_fk_eval_eval_conf_id" FOREIGN KEY ("Conf_id") REFERENCES public.eval_eval_conf(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: eval_etiquetas eval_etiquetas_conf_id_41318851_fk_eval_eval_conf_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_etiquetas
    ADD CONSTRAINT eval_etiquetas_conf_id_41318851_fk_eval_eval_conf_id FOREIGN KEY (conf_id) REFERENCES public.eval_eval_conf(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: eval_etiquetas eval_etiquetas_criterio_id_ee4bd880_fk_eval_criterios_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_etiquetas
    ADD CONSTRAINT eval_etiquetas_criterio_id_ee4bd880_fk_eval_criterios_id FOREIGN KEY (criterio_id) REFERENCES public.eval_criterios(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: eval_eval_conf_evaluado eval_eval_conf_evalu_eval_conf_id_165a01fa_fk_eval_eval; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_eval_conf_evaluado
    ADD CONSTRAINT eval_eval_conf_evalu_eval_conf_id_165a01fa_fk_eval_eval FOREIGN KEY (eval_conf_id) REFERENCES public.eval_eval_conf(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: eval_eval_conf_evaluador eval_eval_conf_evalu_eval_conf_id_81c73158_fk_eval_eval; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_eval_conf_evaluador
    ADD CONSTRAINT eval_eval_conf_evalu_eval_conf_id_81c73158_fk_eval_eval FOREIGN KEY (eval_conf_id) REFERENCES public.eval_eval_conf(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: eval_eval_conf_evaluador eval_eval_conf_evalu_evaluadores_id_e6f38b9a_fk_eval_eval; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_eval_conf_evaluador
    ADD CONSTRAINT eval_eval_conf_evalu_evaluadores_id_e6f38b9a_fk_eval_eval FOREIGN KEY (evaluadores_id) REFERENCES public.eval_evaluadores(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: eval_eval_conf_evaluado eval_eval_conf_evalu_evaluados_id_a4f740c2_fk_eval_eval; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_eval_conf_evaluado
    ADD CONSTRAINT eval_eval_conf_evalu_evaluados_id_a4f740c2_fk_eval_eval FOREIGN KEY (evaluados_id) REFERENCES public.eval_evaluados(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: eval_eval_conf_experto eval_eval_conf_exper_eval_conf_id_ee984dd1_fk_eval_eval; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_eval_conf_experto
    ADD CONSTRAINT eval_eval_conf_exper_eval_conf_id_ee984dd1_fk_eval_eval FOREIGN KEY (eval_conf_id) REFERENCES public.eval_eval_conf(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: eval_eval_conf_experto eval_eval_conf_experto_expertos_id_490d019d_fk_eval_expertos_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_eval_conf_experto
    ADD CONSTRAINT eval_eval_conf_experto_expertos_id_490d019d_fk_eval_expertos_id FOREIGN KEY (expertos_id) REFERENCES public.eval_expertos(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: eval_eval_data eval_eval_data_Evaluado_id_fb65b36c_fk_eval_evaluados_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_eval_data
    ADD CONSTRAINT "eval_eval_data_Evaluado_id_fb65b36c_fk_eval_evaluados_id" FOREIGN KEY ("Evaluado_id") REFERENCES public.eval_evaluados(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: eval_eval_data eval_eval_data_Evaluador_id_fcddaaed_fk_eval_evaluadores_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_eval_data
    ADD CONSTRAINT "eval_eval_data_Evaluador_id_fcddaaed_fk_eval_evaluadores_id" FOREIGN KEY ("Evaluador_id") REFERENCES public.eval_evaluadores(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: eval_eval_data eval_eval_data_conf_id_c9bd1444_fk_eval_eval_conf_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_eval_data
    ADD CONSTRAINT eval_eval_data_conf_id_c9bd1444_fk_eval_eval_conf_id FOREIGN KEY (conf_id) REFERENCES public.eval_eval_conf(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: eval_periodos eval_periodos_conf_id_ced901d7_fk_eval_eval_conf_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_periodos
    ADD CONSTRAINT eval_periodos_conf_id_ced901d7_fk_eval_eval_conf_id FOREIGN KEY (conf_id) REFERENCES public.eval_eval_conf(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: eval_resultados eval_resultados_E_periodo_id_e4f38ee7_fk_eval_periodos_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_resultados
    ADD CONSTRAINT "eval_resultados_E_periodo_id_e4f38ee7_fk_eval_periodos_id" FOREIGN KEY ("E_periodo_id") REFERENCES public.eval_periodos(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: eval_userprofileinfo eval_userprofileinfo_user_id_f8a6f5fe_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_userprofileinfo
    ADD CONSTRAINT eval_userprofileinfo_user_id_f8a6f5fe_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: eval_userprofileinfo eval_userprofileinfo_usuario_id_c63d494a_fk_eval_eval_conf_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_userprofileinfo
    ADD CONSTRAINT eval_userprofileinfo_usuario_id_c63d494a_fk_eval_eval_conf_id FOREIGN KEY (usuario_id) REFERENCES public.eval_eval_conf(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: schedule_calendarrelation schedule_calendarrel_calendar_id_0a50be2e_fk_schedule_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_calendarrelation
    ADD CONSTRAINT schedule_calendarrel_calendar_id_0a50be2e_fk_schedule_ FOREIGN KEY (calendar_id) REFERENCES public.schedule_calendar(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: schedule_calendarrelation schedule_calendarrel_content_type_id_f2a42f5b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_calendarrelation
    ADD CONSTRAINT schedule_calendarrel_content_type_id_f2a42f5b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: schedule_event schedule_event_calendar_id_eb1c700f_fk_schedule_calendar_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_event
    ADD CONSTRAINT schedule_event_calendar_id_eb1c700f_fk_schedule_calendar_id FOREIGN KEY (calendar_id) REFERENCES public.schedule_calendar(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: schedule_event schedule_event_creator_id_d2ffab6e_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_event
    ADD CONSTRAINT schedule_event_creator_id_d2ffab6e_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: schedule_event schedule_event_rule_id_90b83d31_fk_schedule_rule_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_event
    ADD CONSTRAINT schedule_event_rule_id_90b83d31_fk_schedule_rule_id FOREIGN KEY (rule_id) REFERENCES public.schedule_rule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: schedule_eventrelation schedule_eventrelati_content_type_id_d4187723_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_eventrelation
    ADD CONSTRAINT schedule_eventrelati_content_type_id_d4187723_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: schedule_eventrelation schedule_eventrelation_event_id_8c57a7b4_fk_schedule_event_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_eventrelation
    ADD CONSTRAINT schedule_eventrelation_event_id_8c57a7b4_fk_schedule_event_id FOREIGN KEY (event_id) REFERENCES public.schedule_event(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: schedule_occurrence schedule_occurrence_event_id_ade47cd8_fk_schedule_event_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_occurrence
    ADD CONSTRAINT schedule_occurrence_event_id_ade47cd8_fk_schedule_event_id FOREIGN KEY (event_id) REFERENCES public.schedule_event(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

