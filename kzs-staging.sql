--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: active_admin_comments; Type: TABLE; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE TABLE active_admin_comments (
    id integer NOT NULL,
    resource_id character varying(255) NOT NULL,
    resource_type character varying(255) NOT NULL,
    author_id integer,
    author_type character varying(255),
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    namespace character varying(255)
);


ALTER TABLE public.active_admin_comments OWNER TO babrovka;

--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: babrovka
--

CREATE SEQUENCE active_admin_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_admin_comments_id_seq OWNER TO babrovka;

--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: babrovka
--

ALTER SEQUENCE active_admin_comments_id_seq OWNED BY active_admin_comments.id;


--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE TABLE admin_users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.admin_users OWNER TO babrovka;

--
-- Name: admin_users_id_seq; Type: SEQUENCE; Schema: public; Owner: babrovka
--

CREATE SEQUENCE admin_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_users_id_seq OWNER TO babrovka;

--
-- Name: admin_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: babrovka
--

ALTER SEQUENCE admin_users_id_seq OWNED BY admin_users.id;


--
-- Name: approve_users; Type: TABLE; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE TABLE approve_users (
    id integer NOT NULL,
    document_id integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.approve_users OWNER TO babrovka;

--
-- Name: approve_users_id_seq; Type: SEQUENCE; Schema: public; Owner: babrovka
--

CREATE SEQUENCE approve_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.approve_users_id_seq OWNER TO babrovka;

--
-- Name: approve_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: babrovka
--

ALTER SEQUENCE approve_users_id_seq OWNED BY approve_users.id;


--
-- Name: ckeditor_assets; Type: TABLE; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE TABLE ckeditor_assets (
    id integer NOT NULL,
    data_file_name character varying(255) NOT NULL,
    data_content_type character varying(255),
    data_file_size integer,
    assetable_id integer,
    assetable_type character varying(30),
    type character varying(30),
    width integer,
    height integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.ckeditor_assets OWNER TO babrovka;

--
-- Name: ckeditor_assets_id_seq; Type: SEQUENCE; Schema: public; Owner: babrovka
--

CREATE SEQUENCE ckeditor_assets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ckeditor_assets_id_seq OWNER TO babrovka;

--
-- Name: ckeditor_assets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: babrovka
--

ALTER SEQUENCE ckeditor_assets_id_seq OWNED BY ckeditor_assets.id;


--
-- Name: delete_notices; Type: TABLE; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE TABLE delete_notices (
    id integer NOT NULL,
    user_id integer,
    document_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.delete_notices OWNER TO babrovka;

--
-- Name: delete_notices_id_seq; Type: SEQUENCE; Schema: public; Owner: babrovka
--

CREATE SEQUENCE delete_notices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.delete_notices_id_seq OWNER TO babrovka;

--
-- Name: delete_notices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: babrovka
--

ALTER SEQUENCE delete_notices_id_seq OWNED BY delete_notices.id;


--
-- Name: document_attachments; Type: TABLE; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE TABLE document_attachments (
    id integer NOT NULL,
    attachment_file_name character varying(255),
    attachment_content_type character varying(255),
    attachment_file_size integer,
    attachment_updated_at timestamp without time zone,
    document_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.document_attachments OWNER TO babrovka;

--
-- Name: document_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: babrovka
--

CREATE SEQUENCE document_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.document_attachments_id_seq OWNER TO babrovka;

--
-- Name: document_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: babrovka
--

ALTER SEQUENCE document_attachments_id_seq OWNED BY document_attachments.id;


--
-- Name: document_conversations; Type: TABLE; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE TABLE document_conversations (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.document_conversations OWNER TO babrovka;

--
-- Name: document_conversations_id_seq; Type: SEQUENCE; Schema: public; Owner: babrovka
--

CREATE SEQUENCE document_conversations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.document_conversations_id_seq OWNER TO babrovka;

--
-- Name: document_conversations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: babrovka
--

ALTER SEQUENCE document_conversations_id_seq OWNED BY document_conversations.id;


--
-- Name: document_relations; Type: TABLE; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE TABLE document_relations (
    id integer NOT NULL,
    document_id integer,
    relational_document_id integer
);


ALTER TABLE public.document_relations OWNER TO babrovka;

--
-- Name: document_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: babrovka
--

CREATE SEQUENCE document_relations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.document_relations_id_seq OWNER TO babrovka;

--
-- Name: document_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: babrovka
--

ALTER SEQUENCE document_relations_id_seq OWNED BY document_relations.id;


--
-- Name: documents; Type: TABLE; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE TABLE documents (
    id integer NOT NULL,
    title character varying(255),
    user_id integer,
    organization_id integer,
    deadline character varying(255),
    text text,
    file_file_name character varying(255),
    file_content_type character varying(255),
    file_file_size integer,
    file_updated_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    recipient_id integer,
    sent boolean DEFAULT false,
    approver_id integer,
    approved boolean DEFAULT false,
    opened boolean DEFAULT false,
    for_approve boolean DEFAULT false,
    deleted boolean DEFAULT false,
    archived boolean DEFAULT false,
    callback boolean DEFAULT false,
    prepared boolean DEFAULT false,
    draft boolean DEFAULT true,
    sender_organization_id integer,
    document_type character varying(255),
    with_comments boolean DEFAULT false,
    executed boolean DEFAULT false,
    for_confirmation boolean DEFAULT false,
    project_id integer,
    confidential boolean DEFAULT false,
    executor_id integer,
    attachment_file_name character varying(255),
    attachment_content_type character varying(255),
    attachment_file_size integer,
    attachment_updated_at timestamp without time zone,
    sn character varying(255),
    date timestamp without time zone,
    version integer DEFAULT 1,
    document_conversation_id integer
);


ALTER TABLE public.documents OWNER TO babrovka;

--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: public; Owner: babrovka
--

CREATE SEQUENCE documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.documents_id_seq OWNER TO babrovka;

--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: babrovka
--

ALTER SEQUENCE documents_id_seq OWNED BY documents.id;


--
-- Name: groups; Type: TABLE; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE TABLE groups (
    id integer NOT NULL,
    title character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.groups OWNER TO babrovka;

--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: babrovka
--

CREATE SEQUENCE groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.groups_id_seq OWNER TO babrovka;

--
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: babrovka
--

ALTER SEQUENCE groups_id_seq OWNED BY groups.id;


--
-- Name: open_notices; Type: TABLE; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE TABLE open_notices (
    id integer NOT NULL,
    document_id integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.open_notices OWNER TO babrovka;

--
-- Name: open_notices_id_seq; Type: SEQUENCE; Schema: public; Owner: babrovka
--

CREATE SEQUENCE open_notices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.open_notices_id_seq OWNER TO babrovka;

--
-- Name: open_notices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: babrovka
--

ALTER SEQUENCE open_notices_id_seq OWNED BY open_notices.id;


--
-- Name: organizations; Type: TABLE; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE TABLE organizations (
    id integer NOT NULL,
    title character varying(255),
    parent_id integer,
    lft integer,
    rgt integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    logo_file_name character varying(255),
    logo_content_type character varying(255),
    logo_file_size integer,
    logo_updated_at timestamp without time zone,
    address character varying(255),
    phone character varying(255),
    mail character varying(255),
    director_id integer
);


ALTER TABLE public.organizations OWNER TO babrovka;

--
-- Name: organizations_id_seq; Type: SEQUENCE; Schema: public; Owner: babrovka
--

CREATE SEQUENCE organizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.organizations_id_seq OWNER TO babrovka;

--
-- Name: organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: babrovka
--

ALTER SEQUENCE organizations_id_seq OWNED BY organizations.id;


--
-- Name: permission_groups; Type: TABLE; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE TABLE permission_groups (
    id integer NOT NULL,
    permission_id integer,
    group_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.permission_groups OWNER TO babrovka;

--
-- Name: permission_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: babrovka
--

CREATE SEQUENCE permission_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.permission_groups_id_seq OWNER TO babrovka;

--
-- Name: permission_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: babrovka
--

ALTER SEQUENCE permission_groups_id_seq OWNED BY permission_groups.id;


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE TABLE permissions (
    id integer NOT NULL,
    title character varying(255),
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.permissions OWNER TO babrovka;

--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: babrovka
--

CREATE SEQUENCE permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.permissions_id_seq OWNER TO babrovka;

--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: babrovka
--

ALTER SEQUENCE permissions_id_seq OWNED BY permissions.id;


--
-- Name: permits; Type: TABLE; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE TABLE permits (
    id integer NOT NULL,
    number character varying(255),
    user_id integer,
    purpose character varying(255),
    start_date date,
    expiration_date date,
    requested_duration character varying(255),
    granted_area character varying(255),
    granted_object character varying(255),
    permit_type character varying(255),
    agreed boolean DEFAULT false,
    canceled boolean DEFAULT false,
    released boolean DEFAULT false,
    issued boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    rejected boolean DEFAULT false
);


ALTER TABLE public.permits OWNER TO babrovka;

--
-- Name: permits_id_seq; Type: SEQUENCE; Schema: public; Owner: babrovka
--

CREATE SEQUENCE permits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.permits_id_seq OWNER TO babrovka;

--
-- Name: permits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: babrovka
--

ALTER SEQUENCE permits_id_seq OWNED BY permits.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE TABLE projects (
    id integer NOT NULL,
    title character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.projects OWNER TO babrovka;

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: babrovka
--

CREATE SEQUENCE projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.projects_id_seq OWNER TO babrovka;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: babrovka
--

ALTER SEQUENCE projects_id_seq OWNED BY projects.id;


--
-- Name: responsible_users; Type: TABLE; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE TABLE responsible_users (
    id integer NOT NULL,
    document_id integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.responsible_users OWNER TO babrovka;

--
-- Name: responsible_users_id_seq; Type: SEQUENCE; Schema: public; Owner: babrovka
--

CREATE SEQUENCE responsible_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.responsible_users_id_seq OWNER TO babrovka;

--
-- Name: responsible_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: babrovka
--

ALTER SEQUENCE responsible_users_id_seq OWNED BY responsible_users.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO babrovka;

--
-- Name: statement_approvers; Type: TABLE; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE TABLE statement_approvers (
    id integer NOT NULL,
    user_id integer,
    statement_id integer,
    accepted boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.statement_approvers OWNER TO babrovka;

--
-- Name: statement_approvers_id_seq; Type: SEQUENCE; Schema: public; Owner: babrovka
--

CREATE SEQUENCE statement_approvers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.statement_approvers_id_seq OWNER TO babrovka;

--
-- Name: statement_approvers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: babrovka
--

ALTER SEQUENCE statement_approvers_id_seq OWNED BY statement_approvers.id;


--
-- Name: statements; Type: TABLE; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE TABLE statements (
    id integer NOT NULL,
    title character varying(255),
    user_id integer,
    sender_organization_id integer,
    organization_id integer,
    document_id integer,
    text text,
    file_file_name character varying(255),
    file_content_type character varying(255),
    file_file_size integer,
    file_updated_at timestamp without time zone,
    draft boolean DEFAULT true,
    prepared boolean DEFAULT false,
    opened boolean DEFAULT false,
    accepted boolean DEFAULT false,
    not_accepted boolean DEFAULT false,
    sent boolean DEFAULT false,
    deleted boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.statements OWNER TO babrovka;

--
-- Name: statements_id_seq; Type: SEQUENCE; Schema: public; Owner: babrovka
--

CREATE SEQUENCE statements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.statements_id_seq OWNER TO babrovka;

--
-- Name: statements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: babrovka
--

ALTER SEQUENCE statements_id_seq OWNED BY statements.id;


--
-- Name: user_groups; Type: TABLE; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE TABLE user_groups (
    id integer NOT NULL,
    user_id integer,
    group_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.user_groups OWNER TO babrovka;

--
-- Name: user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: babrovka
--

CREATE SEQUENCE user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_groups_id_seq OWNER TO babrovka;

--
-- Name: user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: babrovka
--

ALTER SEQUENCE user_groups_id_seq OWNED BY user_groups.id;


--
-- Name: user_permissions; Type: TABLE; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE TABLE user_permissions (
    id integer NOT NULL,
    user_id integer,
    permission_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.user_permissions OWNER TO babrovka;

--
-- Name: user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: babrovka
--

CREATE SEQUENCE user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_permissions_id_seq OWNER TO babrovka;

--
-- Name: user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: babrovka
--

ALTER SEQUENCE user_permissions_id_seq OWNED BY user_permissions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    phone numeric(11,0),
    "position" character varying(255),
    division character varying(255),
    info text,
    dob character varying(255),
    permit character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    work_status character varying(255),
    organization_id integer,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    avatar_file_name character varying(255),
    avatar_content_type character varying(255),
    avatar_file_size integer,
    avatar_updated_at timestamp without time zone,
    username character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    is_staff boolean,
    is_active boolean,
    is_superuser boolean,
    date_joined timestamp without time zone,
    middle_name character varying(255)
);


ALTER TABLE public.users OWNER TO babrovka;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: babrovka
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO babrovka;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: babrovka
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: babrovka
--

ALTER TABLE ONLY active_admin_comments ALTER COLUMN id SET DEFAULT nextval('active_admin_comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: babrovka
--

ALTER TABLE ONLY admin_users ALTER COLUMN id SET DEFAULT nextval('admin_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: babrovka
--

ALTER TABLE ONLY approve_users ALTER COLUMN id SET DEFAULT nextval('approve_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: babrovka
--

ALTER TABLE ONLY ckeditor_assets ALTER COLUMN id SET DEFAULT nextval('ckeditor_assets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: babrovka
--

ALTER TABLE ONLY delete_notices ALTER COLUMN id SET DEFAULT nextval('delete_notices_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: babrovka
--

ALTER TABLE ONLY document_attachments ALTER COLUMN id SET DEFAULT nextval('document_attachments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: babrovka
--

ALTER TABLE ONLY document_conversations ALTER COLUMN id SET DEFAULT nextval('document_conversations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: babrovka
--

ALTER TABLE ONLY document_relations ALTER COLUMN id SET DEFAULT nextval('document_relations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: babrovka
--

ALTER TABLE ONLY documents ALTER COLUMN id SET DEFAULT nextval('documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: babrovka
--

ALTER TABLE ONLY groups ALTER COLUMN id SET DEFAULT nextval('groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: babrovka
--

ALTER TABLE ONLY open_notices ALTER COLUMN id SET DEFAULT nextval('open_notices_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: babrovka
--

ALTER TABLE ONLY organizations ALTER COLUMN id SET DEFAULT nextval('organizations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: babrovka
--

ALTER TABLE ONLY permission_groups ALTER COLUMN id SET DEFAULT nextval('permission_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: babrovka
--

ALTER TABLE ONLY permissions ALTER COLUMN id SET DEFAULT nextval('permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: babrovka
--

ALTER TABLE ONLY permits ALTER COLUMN id SET DEFAULT nextval('permits_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: babrovka
--

ALTER TABLE ONLY projects ALTER COLUMN id SET DEFAULT nextval('projects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: babrovka
--

ALTER TABLE ONLY responsible_users ALTER COLUMN id SET DEFAULT nextval('responsible_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: babrovka
--

ALTER TABLE ONLY statement_approvers ALTER COLUMN id SET DEFAULT nextval('statement_approvers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: babrovka
--

ALTER TABLE ONLY statements ALTER COLUMN id SET DEFAULT nextval('statements_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: babrovka
--

ALTER TABLE ONLY user_groups ALTER COLUMN id SET DEFAULT nextval('user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: babrovka
--

ALTER TABLE ONLY user_permissions ALTER COLUMN id SET DEFAULT nextval('user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: babrovka
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: active_admin_comments; Type: TABLE DATA; Schema: public; Owner: babrovka
--

COPY active_admin_comments (id, resource_id, resource_type, author_id, author_type, body, created_at, updated_at, namespace) FROM stdin;
\.


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: babrovka
--

SELECT pg_catalog.setval('active_admin_comments_id_seq', 1, false);


--
-- Data for Name: admin_users; Type: TABLE DATA; Schema: public; Owner: babrovka
--

COPY admin_users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at) FROM stdin;
1	admin@example.com	$2a$10$1zvD/brv2VgxZrOZZflgg.N119JZ2VsvLhu85bPogLaL5YFqLmyFO	\N	\N	\N	0	\N	\N	\N	\N	2013-09-10 10:44:26.911748	2013-09-10 10:44:26.911748
\.


--
-- Name: admin_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: babrovka
--

SELECT pg_catalog.setval('admin_users_id_seq', 1, true);


--
-- Data for Name: approve_users; Type: TABLE DATA; Schema: public; Owner: babrovka
--

COPY approve_users (id, document_id, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: approve_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: babrovka
--

SELECT pg_catalog.setval('approve_users_id_seq', 1, false);


--
-- Data for Name: ckeditor_assets; Type: TABLE DATA; Schema: public; Owner: babrovka
--

COPY ckeditor_assets (id, data_file_name, data_content_type, data_file_size, assetable_id, assetable_type, type, width, height, created_at, updated_at) FROM stdin;
\.


--
-- Name: ckeditor_assets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: babrovka
--

SELECT pg_catalog.setval('ckeditor_assets_id_seq', 1, false);


--
-- Data for Name: delete_notices; Type: TABLE DATA; Schema: public; Owner: babrovka
--

COPY delete_notices (id, user_id, document_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: delete_notices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: babrovka
--

SELECT pg_catalog.setval('delete_notices_id_seq', 1, false);


--
-- Data for Name: document_attachments; Type: TABLE DATA; Schema: public; Owner: babrovka
--

COPY document_attachments (id, attachment_file_name, attachment_content_type, attachment_file_size, attachment_updated_at, document_id, created_at, updated_at) FROM stdin;
1	Jcrop.gif	image/gif	329	2013-09-20 08:24:57.918782	6	2013-09-20 08:24:57.922292	2013-09-20 08:24:57.922292
2	barcelona.xlsx	application/vnd.openxmlformats-officedocument.spreadsheetml.sheet	21304	2013-10-02 08:37:18.249889	27	2013-10-02 08:37:18.260375	2013-10-02 08:37:18.260375
\.


--
-- Name: document_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: babrovka
--

SELECT pg_catalog.setval('document_attachments_id_seq', 2, true);


--
-- Data for Name: document_conversations; Type: TABLE DATA; Schema: public; Owner: babrovka
--

COPY document_conversations (id, created_at, updated_at) FROM stdin;
8	2013-10-02 14:20:00.393105	2013-10-02 14:20:00.393105
9	2013-10-03 09:49:47.057731	2013-10-03 09:49:47.057731
10	2013-10-08 10:40:17.482918	2013-10-08 10:40:17.482918
11	2013-10-08 10:40:52.164308	2013-10-08 10:40:52.164308
\.


--
-- Name: document_conversations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: babrovka
--

SELECT pg_catalog.setval('document_conversations_id_seq', 11, true);


--
-- Data for Name: document_relations; Type: TABLE DATA; Schema: public; Owner: babrovka
--

COPY document_relations (id, document_id, relational_document_id) FROM stdin;
\.


--
-- Name: document_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: babrovka
--

SELECT pg_catalog.setval('document_relations_id_seq', 1, true);


--
-- Data for Name: documents; Type: TABLE DATA; Schema: public; Owner: babrovka
--

COPY documents (id, title, user_id, organization_id, deadline, text, file_file_name, file_content_type, file_file_size, file_updated_at, created_at, updated_at, recipient_id, sent, approver_id, approved, opened, for_approve, deleted, archived, callback, prepared, draft, sender_organization_id, document_type, with_comments, executed, for_confirmation, project_id, confidential, executor_id, attachment_file_name, attachment_content_type, attachment_file_size, attachment_updated_at, sn, date, version, document_conversation_id) FROM stdin;
41	cum	116	4	\N	Dolore aut impedit ducimus consectetur distinctio quae a minus ducimus quibusdam consectetur quos est qui et et. Dolorem eaque explicabo ea dolore enim omnis laudantium id et enim ex cupiditate voluptatum voluptatibus. Quis debitis consequatur et quos sint. Qui quos ut et adipisci porro eaque dolore quibusdam esse qui culpa sunt nihil consequatur ipsam quia quos. Ullam quasi ipsam ut quod voluptatum. Eum debitis molestiae corporis id ut qui a alias. Cupiditate consequatur dignissimos suscipit cumque et sint aspernatur et tempora molestiae minima ex ut consectetur ratione ut aut. Sed aut eveniet suscipit voluptas asperiores quo molestiae perspiciatis consectetur minus dolorem accusantium rerum. Eveniet et cum aut quos et occaecati voluptatem asperiores omnis tenetur alias cumque. Ducimus architecto soluta inventore ad sed fuga id ea neque et cupiditate repellat laborum tempore aspernatur rerum provident consectetur. Beatae libero minima deleniti aut quidem et ab. Impedit voluptatum mollitia nobis sed voluptates nesciunt vero in voluptates et placeat et. Sit molestias quidem sed consequatur consequatur aut esse qui ducimus explicabo odit quam. Ea voluptatem eligendi in sit voluptates et. Quis voluptatem dolores tenetur qui voluptatem neque autem. Et et quo non corrupti non nostrum earum. Ut molestiae necessitatibus explicabo a ducimus vero sint doloremque architecto libero voluptas ex voluptatum tenetur. Ullam consectetur totam molestiae labore odio est voluptas consequuntur. Est placeat nulla fugiat et velit vel qui nihil error voluptas ratione temporibus earum. Asperiores et impedit molestias repellat voluptatem earum temporibus dolorem molestiae nihil aperiam officia adipisci. Autem qui eaque veniam quibusdam porro suscipit id aut omnis ducimus quia et eum id. Quo porro impedit nemo reprehenderit rerum deserunt omnis reprehenderit dolorem omnis esse provident pariatur reiciendis. Voluptatem quae vel qui quod vero tenetur et accusantium fugit totam itaque laboriosam officiis. Et quia saepe quasi officiis autem nihil maiores et fuga placeat eum commodi aspernatur et magni et. Nihil totam ut dignissimos enim a voluptate adipisci eos necessitatibus maiores recusandae doloribus maiores illo. Dolorem ratione nobis nemo ullam. Ullam quia culpa numquam et corporis dolores est rerum deserunt porro repellat quisquam itaque nesciunt atque. Deserunt aut ut quidem minima incidunt quisquam est consequatur distinctio iste doloribus eaque vel nemo reprehenderit dicta doloremque. Ullam ipsam deleniti porro rerum id sit. Officia culpa rerum sint ea officiis quibusdam aperiam voluptas qui laudantium quis ea et quasi odio veniam ea qui. Consequatur odit cupiditate est nobis qui pariatur omnis. Laboriosam laborum laboriosam consectetur a aut est suscipit amet voluptate iure magnam magni facilis quia incidunt quidem odio et. Vero maxime nihil dicta velit laborum nisi fugiat provident architecto. Commodi fuga ut vel quas dignissimos architecto nostrum voluptatem earum iure saepe et. Itaque quae dignissimos quo consequatur aut qui rem tempora non id vitae nulla autem quod assumenda et. Saepe magnam temporibus sint expedita eius facilis in ut alias fugit harum. Corrupti error ut inventore recusandae cumque deserunt iusto consequatur perspiciatis debitis sapiente omnis enim non qui at a. Beatae non aut corrupti et assumenda deserunt nostrum sed maiores quo quod pariatur similique. Sunt repellat numquam in rem saepe. Eum labore vel aspernatur facere magnam consequatur necessitatibus magnam ipsum. Dolorum nesciunt necessitatibus amet dolore aut aliquam. Iste sed quod facilis excepturi et qui aliquid reiciendis impedit ullam. Nulla voluptate corporis animi quia expedita nostrum hic optio. Soluta atque ad nisi aliquid et. Omnis ea dignissimos quidem deserunt non esse similique dolorem consequuntur eum autem aliquam culpa tenetur praesentium amet nobis quisquam et. Et atque vel officiis nostrum aliquam qui quas tempora nisi porro	\N	\N	\N	\N	2013-10-08 13:49:59.490249	2013-10-08 13:49:59.490252	\N	\N	115	\N	\N	\N	\N	\N	\N	\N	\N	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
42	distinctio	106	3	\N	Nihil est et soluta veniam laudantium neque numquam culpa ullam architecto. Harum dicta suscipit iure magnam perspiciatis est quo vero magnam id amet cupiditate itaque. Autem nobis dignissimos quo ea dolore explicabo blanditiis omnis nostrum eaque aliquid debitis eligendi impedit repellat. Atque beatae eveniet aliquam voluptatem. Aut facilis quis aspernatur nemo. Accusantium ipsa hic blanditiis nemo accusantium dolores reprehenderit totam aperiam. Fugiat vel veniam voluptatem aliquam et vel molestiae inventore nesciunt omnis magnam tempore voluptate earum harum deleniti atque architecto ullam. Aut consequatur et laborum sunt. Necessitatibus ut id sit assumenda ut. Iste voluptas aut odio odio voluptas aperiam qui sint aliquam non sunt ut debitis veniam quis non sed facilis rem. Praesentium ipsam voluptas omnis adipisci praesentium eveniet impedit et ut ex sunt sed accusantium ab. Ut earum ut nobis quisquam beatae veniam consequatur ut quasi. Aut enim quia excepturi qui et voluptas doloremque atque sint repellendus quia natus delectus sint totam officia animi laudantium. Voluptatem pariatur dolorem sint et modi optio atque laborum qui laudantium. Accusantium et qui est pariatur aspernatur tempora itaque maiores ratione nihil. Voluptatibus laboriosam nihil voluptatem dicta sunt architecto voluptatum iure et. Id corrupti voluptatem aut omnis in fugiat. Cupiditate ea voluptatibus nulla aut rerum et laborum sed nemo aspernatur dicta repellendus aut sit rem mollitia repellendus ullam. Quod id laborum aut at. Explicabo ullam dolor totam similique est ratione sunt fuga voluptatem perspiciatis aliquid. Error repellendus facere sit doloribus id inventore magnam ut possimus ut. Atque laboriosam vero numquam aperiam velit. Veniam praesentium sint eius architecto debitis a quia magni doloribus. Magnam id cum est quibusdam molestiae quaerat quasi voluptatum hic magnam fugiat vero quia. Ut accusamus dolores sunt aspernatur eum non deleniti itaque molestiae accusantium aut architecto nulla quos omnis. Nihil doloremque quos corporis dolorem velit id. Delectus saepe reprehenderit voluptatum et numquam libero mollitia ducimus corporis quia accusantium mollitia. Et quia architecto molestiae quos illo id aperiam voluptatem aperiam dolorem esse. Et beatae deserunt quo veniam pariatur amet cumque sint quae in ut odit ea unde reiciendis eligendi. Maxime beatae voluptatem voluptas eveniet exercitationem et ex reprehenderit quis consequatur ipsa amet numquam unde soluta architecto et ut. Saepe aut officiis et magni harum minus aut possimus est possimus maxime qui consequuntur quos. Non soluta vero rerum vero ullam dolor. Dolor repudiandae qui libero quasi esse corporis eum odio non laboriosam. Nisi quia excepturi sit est voluptatum laborum similique inventore sunt ex deserunt corporis consectetur ut sunt odio eaque aliquam explicabo. Id ipsa minus sunt suscipit at et est voluptatem voluptatem aliquam ad qui rem temporibus fugiat ullam nisi soluta. Harum quia natus repellendus autem sint voluptatem repellat animi iste ut cupiditate qui. Fugit quo molestias laudantium asperiores quae ut dolores dolor qui quia provident illum nulla. Earum inventore velit temporibus et et et in aut quam exercitationem voluptatem. Natus voluptatibus est inventore nesciunt illo recusandae. Quo quod inventore ut aut neque natus. Aut ut quia culpa dolor sunt consectetur dignissimos tempore perspiciatis ipsam similique et perspiciatis accusantium quis voluptatum. Quas architecto sit nemo ducimus quia voluptatibus id voluptas ut explicabo maxime quis possimus ratione autem enim. Officia omnis quo officiis autem sint sed velit sed repellendus corporis quia qui deleniti voluptas. Repudiandae sint natus sint saepe	\N	\N	\N	\N	2013-10-08 13:49:59.896529	2013-10-08 13:49:59.896531	\N	\N	117	\N	\N	\N	\N	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
43	ipsum	106	2	\N	Deserunt enim nulla facere aut maiores occaecati placeat qui. Rem ab itaque debitis ipsam quia et repudiandae dolor. Quidem facere quo excepturi eaque aut eos cupiditate debitis. Nihil voluptates excepturi ea voluptatem recusandae voluptatibus harum debitis alias. Repellendus tempora quis et id molestiae inventore quia consequatur eaque eligendi maxime et facere dolorem tenetur occaecati minus. Dolor nesciunt quo earum quia non quod nobis eum laboriosam quo molestiae aliquid iste fugit. Quos saepe voluptas nobis amet tempora rerum voluptatum aut atque ducimus voluptas modi atque. Facilis iure ullam praesentium aut sed nobis ut odio quae dolorem. Qui sunt numquam non atque sunt. Possimus mollitia rerum temporibus fugiat repudiandae et veniam optio consequatur et voluptates incidunt ducimus minima. Quis et doloremque voluptas ipsam expedita maxime laudantium sit tempore incidunt fugit quaerat laborum voluptatum quas. Modi eum est rerum tempora qui hic non quia consequatur est enim labore consectetur voluptatem ipsam distinctio reprehenderit voluptatem. Molestiae ut voluptatem recusandae est officiis nesciunt enim amet magnam autem alias necessitatibus magnam id. Incidunt corrupti aut quidem ex dolor qui laboriosam quae excepturi dicta qui amet reprehenderit dolores. Sed corrupti et possimus vitae pariatur assumenda cupiditate consequatur explicabo nulla impedit laboriosam qui iste quia laborum voluptatem voluptate in. Harum deserunt iusto qui consequuntur voluptatem ea ut fugiat. Voluptatibus odio harum dolorem alias. Beatae aut nihil itaque voluptatum et quod voluptatem sunt rerum qui veniam sit. Et distinctio nihil dolorum animi dolores id. Minima facere occaecati fugiat vel itaque dolor consequuntur ullam sit distinctio voluptatem voluptas et ipsum ipsam facilis nobis quia. Minus pariatur autem eum adipisci non veritatis recusandae molestiae in sunt minima corrupti in odit eveniet. Et voluptas hic voluptatem quia non delectus et nihil officiis porro illum sed fugiat corporis eius. Commodi blanditiis animi sit quia id modi dignissimos qui velit excepturi libero ut. Sunt omnis molestiae accusamus ex est aut voluptatum modi ut laudantium illo nobis dolor nihil atque sapiente exercitationem quidem ducimus. Labore quia aut et molestiae ea facilis accusantium. Distinctio quasi eos est ut expedita vitae nisi expedita fuga hic earum molestiae temporibus ea exercitationem qui minima sint. Sit ut repellendus dolor et eius dolorum fuga et facilis quibusdam eligendi totam autem voluptates. Esse et velit esse vel quia explicabo ut. Aut dolorum nisi soluta eligendi unde asperiores sequi eos et dolores enim expedita aut asperiores laudantium incidunt voluptatem et. Unde in esse repellendus explicabo velit et amet facere eos iusto sint id ut explicabo expedita corporis aut sed libero. Odit dignissimos aut accusamus iste exercitationem eveniet voluptatem voluptas sed suscipit recusandae. Provident iure consequatur aut accusamus dignissimos eius voluptatem commodi qui. Qui accusantium quasi nemo error quis et. Et amet deserunt sed commodi quas ea dignissimos dicta quia qui illo nesciunt porro sunt distinctio. Illum neque enim aliquid ut consectetur dolores culpa quia in velit placeat. Quisquam facere id libero ut deserunt mollitia quas inventore eum earum exercitationem ea. Sit sed beatae porro doloribus molestiae dolorem atque deserunt dolorem. Corporis illo provident rerum voluptatem aliquid cum aliquam maxime molestiae id aperiam occaecati recusandae inventore totam enim. Nulla minima eum quae commodi nemo voluptatem inventore iste voluptas aut voluptatem tempore iusto ipsa odio commodi. Ratione suscipit dolorem atque culpa nobis porro nesciunt qui laborum tenetur ut eos quia. Veniam provident et numquam voluptas sunt. Repudiandae quia facere et ducimus ea blanditiis consequuntur aut voluptatem. Quaerat et perspiciatis vitae consequatur culpa sit qui reprehenderit libero tenetur. Velit repudiandae veniam id voluptatem inventore vel aut et fuga ut. Cupiditate quae ex eos necessitatibus incidunt et consequuntur placeat aliquam. Beatae inventore quidem nesciunt beatae eos at eligendi cupiditate nisi fuga cumque sed quis ut. Aliquam omnis tenetur quasi et quis dolor cumque nostrum ut a nobis suscipit occaecati molestias reprehenderit cupiditate voluptatem reprehenderit ullam	\N	\N	\N	\N	2013-10-08 13:49:59.901957	2013-10-08 13:49:59.901959	\N	\N	113	\N	\N	\N	\N	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
44	aut	106	4	\N	Numquam sed recusandae a officiis. Aspernatur vel est fuga ea quo non saepe dolorum. Et natus omnis officia et debitis nulla provident perspiciatis earum aut ratione sunt quia delectus quia laboriosam ad. Praesentium incidunt ut sequi culpa labore ut tempora ut officia facere rerum. Nisi et praesentium saepe blanditiis soluta et sit eius ullam ut sit. Similique ipsam molestiae cum animi optio in repudiandae voluptas suscipit fugiat occaecati iste ea libero nulla. Beatae est repellat iste illo aut deserunt odit. Itaque atque sed aut et nesciunt officia nostrum temporibus corrupti a ea expedita sed est est nesciunt consequuntur ea. Rerum qui laudantium labore voluptas id voluptatibus. Blanditiis aut facilis animi rerum consequatur et ad voluptatem nostrum nobis. Necessitatibus delectus sit quia et suscipit rem voluptatibus neque excepturi quaerat. Qui saepe culpa maxime voluptas tempore dolorem voluptatem maxime perferendis porro porro id est. Et ducimus nobis ipsam distinctio corrupti eaque nihil vitae praesentium delectus hic corporis exercitationem. Est aut tempore molestias ut sit et odit consequatur in ab et. Ad sed porro vero repudiandae. Qui molestiae reiciendis sed rerum eius sunt nemo distinctio vitae. Dignissimos id labore similique sequi et sit numquam sapiente saepe et non et. Quis distinctio magnam ut possimus unde eos voluptatem cumque non ut aliquam delectus soluta occaecati voluptas ut qui aspernatur. Maiores occaecati voluptatibus et quas nostrum qui voluptatum nihil sapiente eum. Illum consequatur animi eos temporibus voluptas ut et reprehenderit adipisci alias iusto unde. Et iusto a et aut optio enim et aut totam aut. Et ullam et illum eos itaque numquam. Sequi rerum quia fugiat assumenda ab. Architecto saepe rerum placeat quia consequatur assumenda ullam possimus distinctio tenetur. Est iste et expedita excepturi eaque est eaque. Qui voluptatem sed est et voluptas laudantium hic et sunt. Tempora voluptatibus dolor dolor rem voluptates magni rerum nobis aut sit ipsam ratione quae officia veniam incidunt expedita maiores. Quia molestiae quia asperiores hic repellendus at. Repellat aspernatur dolor sint sit vel odit debitis sapiente. Doloribus nesciunt ut neque ea ab et architecto alias est voluptates facilis inventore saepe voluptatum. Ut ut animi non cupiditate eum blanditiis quod labore consectetur perferendis cumque quis beatae quo ut totam dignissimos qui officiis. Molestiae qui atque et hic qui repellendus exercitationem accusamus. Veniam ut sit est vero et nam eum. Sint nihil et consequuntur a explicabo labore nesciunt. Molestiae sint esse similique dicta sit et accusamus sint deserunt ipsa enim. Soluta sed recusandae pariatur dolore cum porro. Et ipsam qui est sunt aut illo fuga recusandae aut sapiente nulla nihil	\N	\N	\N	\N	2013-10-08 13:49:59.906927	2013-10-08 13:49:59.906928	\N	\N	114	\N	\N	\N	\N	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
45	hic	117	2	\N	In ratione et numquam vel accusamus eos ratione aperiam ut eius. Magni sit eius tempore nam voluptatem. Explicabo ipsam dicta molestiae error voluptate quia cum voluptatem et voluptas libero dolorem. Deserunt odit odit sequi aspernatur tempora culpa incidunt sapiente non blanditiis nostrum qui molestias mollitia consectetur maxime vero vitae. Repudiandae deserunt repellat a pariatur odio impedit blanditiis doloremque et reprehenderit assumenda aut sed deleniti quae voluptatem voluptatem aut. Veniam sunt natus ut autem ullam magni quaerat nihil doloremque eius aut omnis dolorem. Nihil consectetur consequatur atque aperiam exercitationem voluptate sed ex sequi totam neque qui quis esse. Sed quia at sed non eligendi sit vel qui qui voluptates deleniti commodi accusamus consequatur dicta quis quia. Enim ut architecto delectus consequatur non quos vel consequatur culpa dicta illum repellendus id. Quos quos magnam temporibus itaque rem qui quasi repellat et beatae. Eos exercitationem blanditiis quibusdam autem dolorem dolore. In ea perspiciatis cum iusto iusto nobis. Sunt praesentium hic quis tempore et incidunt ab expedita ea fugiat quod possimus laboriosam id. Ipsa commodi iusto neque fugiat non. Quaerat at maiores fuga repellat enim quo porro culpa id laudantium ratione pariatur itaque aut. Enim temporibus aut consectetur et et et iure quia sint dolor ut. Provident dolore esse illum aut suscipit ratione eos pariatur aut similique quia sed totam repudiandae. Velit ut minima non explicabo nihil voluptatibus sapiente itaque. Facilis ipsa aut magni laudantium neque sit eos ratione voluptas vel. Earum nostrum eveniet nihil quo sunt fugit est unde unde provident iusto. Officiis aperiam voluptates deserunt dolorem sed perferendis ratione quidem omnis ut. Recusandae praesentium at dignissimos quidem est sint qui dolorem fugit suscipit impedit commodi enim quas adipisci magnam. Tempore quae libero rerum quis iusto facere alias itaque id sequi quibusdam quia voluptatum aut et nam minus laudantium. Animi est non id sit sit dolorum possimus voluptate magnam reprehenderit molestias. Facilis explicabo magnam soluta facere quis. Suscipit accusantium quos autem accusantium quia mollitia aut ut consequatur neque non rerum expedita odit pariatur id. Ex quos ut voluptatem est accusantium. Iure optio aut et qui ea voluptatem ratione repudiandae. Sit esse quae laboriosam aliquid officiis autem assumenda qui ipsam qui ut aliquid qui rerum numquam enim sed. Ex aut libero ut vitae laudantium cum non ut reiciendis perferendis eveniet et explicabo esse quia ea ratione omnis vel. Et eius sit perferendis voluptates iure sequi quasi ex pariatur dolorum rem qui nobis accusantium incidunt ab deserunt. Voluptas nostrum est qui ducimus est velit nemo sint inventore quo et delectus reprehenderit. Minima qui suscipit cum harum rerum id et aliquam sed quis quibusdam reprehenderit	\N	\N	\N	\N	2013-10-08 13:49:59.911637	2013-10-08 13:49:59.911639	\N	\N	112	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
46	molestiae	106	2	\N	Tempora fugiat fugiat sed voluptates molestiae voluptatibus magni et amet nisi voluptas quis voluptatem minus ipsa. Quibusdam doloribus illo facilis inventore qui quis quas saepe alias saepe vel repudiandae fugiat sint. Blanditiis et quis nihil sed officiis qui non assumenda rerum qui itaque. Voluptatibus fuga reprehenderit voluptatem velit ut eveniet ipsa mollitia nihil architecto accusamus cum. Et eos mollitia et quia id sit. Numquam esse harum incidunt recusandae labore asperiores dolor similique ut nam in in saepe est repellendus. Ullam voluptatibus voluptas beatae et tempora asperiores et qui beatae maxime similique blanditiis nam hic sed sed consequatur. Amet similique ipsam ut qui ipsa iure autem et a adipisci vero. Veniam sed eos ex ea quae voluptatum quae in autem molestiae ipsum et. Ipsa magni ab quod velit sed id a placeat placeat natus explicabo occaecati voluptatibus accusamus laudantium et esse. Aut ut iusto illum qui optio voluptatem rerum sequi quaerat explicabo molestiae. Ad non eveniet odit consequatur rerum deserunt iusto velit hic. Eius tempora sed nostrum eum. Consequatur maxime consequatur omnis praesentium facilis quis. Ab iusto dolore incidunt rerum aliquam. Repudiandae est dicta quibusdam minima in earum provident quod magnam qui expedita est enim nihil tempore. Veritatis est rerum dolores similique fugiat dolorum et. Sunt atque in error nulla vitae sapiente aut. Maxime rerum ut ducimus rerum. Beatae non ex eligendi fuga nemo itaque eligendi omnis molestiae unde quos sit explicabo aperiam dolores molestias eaque. Accusantium consequatur deleniti ea neque repellat accusamus quidem eum ut dignissimos sunt fuga quas et voluptatibus iure. Sint laboriosam esse rerum sequi rerum nam labore aut est tempora ipsam. Ea et sed aut culpa rerum voluptas saepe. Aut aut quidem sit aperiam ab illo eos rerum voluptatum temporibus laboriosam molestiae rem. Incidunt qui voluptatem eligendi beatae dolorem qui voluptatem et consequatur fugit consequatur odit. Cupiditate voluptatem aut consequatur asperiores ut possimus non aliquam voluptatem alias veniam dignissimos officia. Quaerat ullam non omnis id ullam odit et aut laboriosam quaerat a. Ipsam architecto aut iusto quo ut laboriosam dolorum autem consectetur occaecati id aperiam repellendus. Aperiam voluptate quis in magni quibusdam totam temporibus veniam eum aliquid dolores et laborum odio ipsum et est. Iure quo possimus officiis veniam nihil porro aut odio. Sint rem optio corporis dolores rerum possimus occaecati tenetur dolor aperiam sunt aut. Consequatur doloremque iusto hic velit et rerum facilis ut ut molestias perspiciatis. Non vel sequi rerum quia ut vel facilis quasi unde consequatur consequatur voluptas cupiditate ipsa cum eius qui fugiat. Id accusantium dolores ducimus quia ab aut dolor rem eos delectus delectus autem dolor deleniti earum quia. Laborum fuga animi quia aliquid dolorem possimus ea illo recusandae officiis expedita officiis delectus est est quo modi eum. Quasi voluptatum autem nihil fugiat quo. Necessitatibus recusandae nisi vel possimus consequatur occaecati qui ex quia aperiam sit accusantium consequuntur quis. Nobis eum cumque architecto enim est sint. Asperiores fugiat ut magnam est dignissimos sint ea dignissimos non rem. Repudiandae consequuntur voluptatem voluptatum id non eius qui deserunt corporis. Totam dolore at facilis voluptatibus nihil dignissimos impedit asperiores dolores deleniti et vel quam vel nihil ut animi sit. Numquam eum et aspernatur sint repellendus optio quaerat deserunt nam eligendi veritatis deleniti esse placeat id. Vitae magni non nostrum ad quia est cupiditate maiores nihil. Officiis quis reprehenderit aliquid quas accusamus beatae praesentium sit illo qui est tempore cumque nihil quas. Assumenda consequuntur placeat iusto molestiae ab velit quisquam ea dolore ab facere explicabo ab vel et. Sapiente ea provident non dicta temporibus. Assumenda voluptate perferendis repellat reiciendis porro quas architecto dignissimos ex eum qui nobis fuga. Sit qui tenetur voluptatum maxime pariatur ipsum et cum voluptates eum. Itaque non id debitis enim vero sint optio ipsum vel voluptas tempore illum a sunt velit inventore. Dolor veniam consequatur dolores sed accusantium non dignissimos velit	\N	\N	\N	\N	2013-10-08 13:49:59.916414	2013-10-08 13:49:59.916416	\N	\N	115	\N	\N	\N	\N	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
47	corrupti	117	4	\N	Similique rem est qui nobis ut. Eos magnam laudantium et enim velit aut voluptatem dolores sapiente corrupti quibusdam quia. Magni eum id ex dolorem adipisci beatae doloremque consequatur enim est modi quisquam. Et nesciunt dolorem quis sequi est reiciendis enim ipsum sunt modi dolorem ut est neque amet et nam beatae ipsa. Vitae molestiae voluptate id assumenda labore vero sequi odit veniam nam doloribus nihil est necessitatibus iusto molestias molestias suscipit ratione. Dolore quos sit ab neque excepturi distinctio porro ea consequuntur itaque consequuntur corrupti ea reprehenderit ex debitis itaque et corrupti. Perspiciatis aspernatur corrupti nesciunt eius ipsa assumenda ea exercitationem natus sint. Fuga sit dicta molestiae dolorem consequatur corrupti amet laudantium odio sunt et. Ipsum et numquam est excepturi voluptas ad nostrum. Quo voluptatum quibusdam cumque exercitationem ut quaerat culpa et temporibus explicabo similique mollitia sed. Facilis vitae hic error fuga recusandae illum repellat quisquam. Modi qui enim ipsa mollitia omnis. Qui commodi dolore deleniti qui cupiditate maiores accusantium consectetur sapiente esse ratione aut nemo in unde eos. Voluptas ea praesentium tempore molestias enim. Nostrum facere velit explicabo autem quas temporibus tenetur. Voluptatem et possimus ducimus maiores est quis dolor architecto fugiat in repellat eum repellat. Officia voluptatem vero a quia neque voluptatem. Voluptatem maiores molestiae aut dolores placeat a pariatur excepturi in voluptatem et ratione tempora iure eum sed ab. Dolor quam voluptates cum expedita vel totam ullam adipisci quaerat officia repellendus et vitae libero doloribus nulla. Molestiae illum laborum et tenetur. Totam dolorem et velit eligendi sequi omnis eum nihil soluta. Sint repudiandae quia repellendus corporis quos adipisci ex eum aut et non consequatur natus est reiciendis consequuntur laborum. Praesentium aut rem mollitia voluptatem quidem omnis magnam enim deleniti ut impedit. Eos sit nam rerum esse et temporibus ab quaerat natus. Odit quidem odio quam nihil dolor cum placeat est provident labore quis optio eligendi itaque. Ratione non dolore eaque beatae est. Modi corporis sed deserunt ipsa corrupti autem aut saepe ut quia voluptatibus facere. Neque dolor quia in dolorem maiores qui possimus alias enim nostrum tempore explicabo ut dolorem qui facilis porro id. Aut tenetur sint totam facilis nemo corrupti culpa eveniet aut nulla iure corporis. Dolorem ab saepe nemo doloribus tenetur. Aut vero et et cupiditate temporibus accusamus corporis aliquam eveniet et omnis provident illum temporibus. Hic sunt deleniti dolores a reprehenderit atque corrupti. Assumenda voluptatibus assumenda mollitia ut quia inventore quidem sit non accusantium quaerat magni minus non officiis officiis non. Sequi et nihil minima earum nulla ipsum laudantium est ea voluptatem itaque porro dolores atque ut esse maiores quo. Odit unde iure architecto vel. Consequuntur consectetur impedit porro fugit beatae veritatis nostrum qui est doloribus enim. Deleniti rerum natus voluptatem iure laudantium unde. Dolor quo sit tempora et modi illum maiores labore. Aperiam dolorem est accusantium quasi omnis debitis amet non. Excepturi vitae quo ipsum voluptatibus et minima delectus excepturi velit illo omnis consequatur quaerat eveniet quaerat et fugit reprehenderit aliquam	\N	\N	\N	\N	2013-10-08 13:49:59.921381	2013-10-08 13:49:59.921382	\N	\N	109	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
48	et	117	1	\N	Aut autem animi error et illo suscipit odio. Illo maxime minima dolor occaecati expedita aspernatur vero quaerat suscipit architecto est non quia aut aut occaecati quaerat. Magni enim consequatur illum non. Voluptate blanditiis est quam dolores velit debitis sed ut corrupti voluptatem culpa commodi occaecati. Exercitationem deserunt officia quidem qui sunt laudantium ad quia cupiditate maiores ea quo et dolor. Fugit numquam quia illo impedit dignissimos dignissimos rem porro ut voluptates omnis accusantium ullam ab voluptatem aliquid sint neque. Quia earum dolorem omnis numquam similique accusantium nostrum ullam sit nisi aut id est quod. Eaque reprehenderit non aut molestiae nihil voluptatem soluta. Explicabo rem ea corporis dolores. Mollitia omnis voluptatem et quia maiores quia tempore consectetur est dolores sint eligendi odit numquam nam. Quia et excepturi aspernatur nihil qui soluta alias aut consequatur qui occaecati laboriosam eos aperiam nostrum ipsam. Nisi iusto et sequi perferendis tempore quia expedita praesentium et soluta. Beatae rerum ullam omnis ut quidem dignissimos similique possimus suscipit sint. Ea id velit ex deserunt. Aut est cumque voluptas voluptas aut perferendis sunt veritatis non occaecati doloribus et molestias in voluptate rerum qui nisi. Repudiandae perferendis possimus ipsa esse. Et vel assumenda aspernatur asperiores dolor impedit impedit ullam iste tempore cum quisquam. Saepe aliquid et qui nam porro molestiae. Eos excepturi sed neque veritatis. Porro impedit voluptatem ipsam vitae dolorem est eum corporis tenetur itaque voluptatem id hic sit cumque ut consequatur enim incidunt. Fuga explicabo ut quibusdam iste placeat quia voluptate et. Omnis et accusantium non dolorem voluptatem ut deserunt et quia aperiam harum dolorem dolorem illum officiis qui quas. Quam neque doloribus itaque illo cum ex sed vitae dolorum sit voluptatem molestiae possimus esse iusto debitis autem. Saepe aut quod deserunt ut quae mollitia consequatur. Adipisci voluptatem dolore nesciunt magni numquam debitis nostrum dignissimos. Labore sint accusamus dolor non voluptates incidunt consequatur voluptate tenetur illum non dicta libero velit aliquam impedit similique quidem error. Incidunt voluptatum deserunt quis dolorem voluptates rerum dolor sit et et nobis facilis consequatur totam ut. Molestiae et pariatur nam blanditiis adipisci ipsam amet soluta sit. Et ad expedita aut eum natus veritatis ut velit nobis. Iste laudantium et corporis dolores aperiam voluptatibus neque eveniet incidunt unde animi. Cupiditate praesentium vero deserunt eligendi. Dolor facere nostrum earum voluptas illo iste. Commodi soluta voluptatum tempora et sed aperiam et quam ut. Laborum eos porro occaecati dolorum officia et itaque. Voluptatem voluptates fugit laudantium animi quia aspernatur soluta fugit sequi voluptatem et voluptate deleniti. Quae blanditiis distinctio ut sed neque corporis quod magnam explicabo adipisci distinctio est impedit nam officiis aut. Magnam ex a debitis alias assumenda ut fuga distinctio atque. Natus dicta numquam non illo vero corrupti molestiae beatae accusamus	\N	\N	\N	\N	2013-10-08 13:49:59.926263	2013-10-08 13:49:59.926265	\N	\N	112	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
49	est	106	3	\N	Voluptate provident saepe in dolores et et aliquid sunt numquam aut dicta tempora nobis ipsum voluptatem quibusdam. Itaque eos cum amet aliquam laudantium labore quia rerum unde voluptatibus quod ut ipsa. Eius asperiores est accusamus deserunt alias. Fugiat ea accusantium qui dolor autem iste iusto rerum eos magnam. Modi corporis quo nisi natus doloribus et quis. Aperiam nesciunt nihil iusto natus sequi similique sint. Dolores voluptatem omnis provident quia mollitia molestias in sunt commodi. Est qui quis ipsa eum minima minus eius odio sint incidunt in laboriosam voluptatibus. Qui iure dolores in voluptas provident sint ad voluptatem quia rerum velit omnis alias vel incidunt facere id. Possimus magnam eius consequatur illum perspiciatis inventore at deserunt nihil pariatur quia ut fugiat. Et fugiat ratione expedita quae. Quam nobis asperiores autem ut dolorem et vel quo eaque fugit. Officia esse quia possimus dicta placeat pariatur recusandae sit dolor doloremque sit commodi ut. Ex officiis sunt illum voluptatem modi est est labore fuga doloribus odio. Perspiciatis perferendis officia architecto optio illum est et vitae quia suscipit vero vel consequatur sit veritatis ut eum. Magni et voluptas fugiat molestiae molestiae quaerat est. Magnam facilis et quis sed molestias ducimus necessitatibus eius cupiditate et in eius aut voluptatem unde maiores quas soluta ut. Est dolor ipsa officiis enim ut quas et voluptatem quas velit totam id vero deleniti expedita. Similique sed rerum et provident dignissimos. Nesciunt maiores nisi consectetur esse consequuntur et voluptas facilis dolorum maxime sit magni quam. Nesciunt in explicabo neque libero assumenda distinctio. Consequatur qui eos dignissimos voluptas aut molestiae omnis doloremque impedit aut consequuntur dolorum. Velit sed earum illum aut distinctio laborum vitae repellat non. Laudantium assumenda et sed tempora consequatur architecto quas sed et. Ut et et sit debitis blanditiis debitis enim iusto qui perspiciatis voluptas nulla. Voluptatem qui quia sunt velit voluptates rerum aliquam expedita minus dolor quasi tenetur reprehenderit voluptatem. Autem aut qui reiciendis eius ratione aut magni ut eum dolorem natus est dolores odio aut rerum sunt eum. Magnam omnis aut maxime dolores est consequuntur impedit id explicabo quae reprehenderit quo maxime maiores quo voluptatem eos perferendis. Suscipit sint quod optio provident commodi eum atque aliquid quos nesciunt et laborum quo quis recusandae. Similique qui quisquam non eos est natus pariatur est fuga incidunt enim aliquid. Hic autem sunt veritatis excepturi. Id magni sed molestiae debitis ut sunt harum iure officia laudantium deserunt. Ducimus est saepe excepturi iure et iusto vero possimus minima iusto similique. Et praesentium illo illum voluptas quo. Explicabo ut rem quos dolorum natus itaque magni perferendis aut eaque est explicabo. Praesentium at consequatur qui non et sunt veniam modi nulla qui quae tempore quod exercitationem aspernatur ducimus error sunt. Nisi asperiores ea perferendis eligendi aut eveniet repudiandae molestias vel amet ex eveniet et voluptates natus. Qui voluptatibus vel ipsum sequi ut illo rerum nesciunt et id non dignissimos. Consequatur tempore numquam est quasi molestiae voluptate et id accusamus voluptas eaque quaerat nostrum voluptas sunt deleniti rem vel. Explicabo tempore officiis et est ut aspernatur molestias non sint reiciendis veritatis dolor. Enim aliquid est dolorum consequatur et nemo maiores earum et recusandae excepturi eum sed ex sapiente perspiciatis voluptatem quia perspiciatis. Et repudiandae veniam tempora expedita et vel quam accusantium et iure aperiam veritatis et ut voluptatum sequi voluptatum. Provident ratione laudantium quis praesentium aliquid ut sed aperiam. Eos autem sed ea distinctio aut aliquam et architecto aperiam. Enim minus voluptatem nostrum eum est veniam quod unde ut consequatur. Ea quaerat magni culpa a officia quae voluptatem et similique quia commodi ut placeat rerum aut qui ratione error. Et asperiores deleniti distinctio non voluptatum consequatur nesciunt est beatae suscipit. Et et et sequi vero dolores omnis ea eum facilis maxime qui et temporibus suscipit expedita deleniti	\N	\N	\N	\N	2013-10-08 13:49:59.931195	2013-10-08 13:49:59.931197	\N	\N	105	\N	\N	\N	\N	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
50	est	116	1	\N	Nam et tenetur ullam necessitatibus saepe qui explicabo voluptas quo et et dolores voluptatem error aliquid. Quaerat et sed voluptates incidunt exercitationem labore ex recusandae nobis maxime qui ut nulla ipsam qui repellendus et. Excepturi blanditiis pariatur molestiae ipsum aperiam fuga earum laborum ratione fuga amet maiores reprehenderit totam praesentium. Minus et ipsa eveniet qui molestiae aperiam non. Consequuntur sit rem dicta aperiam error laboriosam non qui molestiae voluptas omnis aut nihil dolor saepe debitis fugiat. Doloribus inventore possimus consequuntur officia soluta aliquam sed aut error odit saepe at facere. Quia beatae quis voluptatum inventore deleniti est recusandae. Molestiae ad praesentium qui quis iusto soluta. Non id esse cupiditate deserunt ducimus vero quaerat assumenda et natus. Consequuntur magnam amet blanditiis aut est quibusdam similique amet autem et quaerat quibusdam eaque rem repellendus ea. Aliquam illum quas illum ad quo est esse voluptate. Necessitatibus officia qui et alias maiores nihil assumenda omnis voluptatem cumque ab possimus. Excepturi dignissimos dolorum deserunt cupiditate dolore sint id repellendus corrupti qui ipsa accusamus rerum ullam beatae eveniet pariatur debitis nesciunt. Eaque voluptatem aut sit eos iusto nesciunt. Consequatur labore possimus quia est quia illo ut est. Possimus ipsam ab molestias doloribus autem et illum quod ipsa et eveniet inventore mollitia est voluptas quam non enim. Labore exercitationem tenetur ut eos. Corporis totam et dolor et et voluptatem perspiciatis reiciendis. Est unde unde illo in modi laudantium eveniet natus dolorem itaque. Quia sunt reiciendis commodi ut optio incidunt tempora sed ullam aut repellat provident laborum reiciendis. Ea quos est exercitationem libero sit natus laudantium eaque officia molestiae ipsum dignissimos adipisci veritatis eos. Laborum eaque sapiente reiciendis deleniti qui aut hic modi vel qui autem sint explicabo sunt quam harum dicta officia iste. Et numquam omnis inventore porro corrupti est repudiandae voluptatem cupiditate maiores repellat eos magni possimus perferendis mollitia consectetur nam quo. Aperiam veritatis quas vel aliquam sed nisi adipisci voluptatem atque. Et qui voluptatum deleniti fugiat sit quo culpa pariatur et aut fugit natus temporibus sunt maiores aut et tenetur. Rem dolorem praesentium quaerat quasi sapiente quia blanditiis et ut repellendus enim quis et id tempora perferendis eius. Id aspernatur repudiandae dolor nulla tempore sed quia laborum sapiente voluptas reiciendis voluptas doloremque aut assumenda. Placeat alias consequatur eos sit voluptas voluptas amet et. Sit perferendis est quo sed necessitatibus tempore officia rerum est ut. Rerum quod facilis suscipit fuga odio alias sequi et voluptate vel magni porro sequi est eaque pariatur dolorem id. Cumque officia et sit voluptatem molestias laboriosam velit illum ea ratione et temporibus quos et non. Delectus necessitatibus labore est facere eos molestias nostrum sunt aut similique ad voluptate officiis aut sunt qui velit perspiciatis. Quia ipsum quo laudantium at recusandae in magni officiis atque ut nam rem. Voluptates voluptas sunt ut aliquid et quo nihil molestiae sapiente et facilis inventore. Consequatur et reprehenderit voluptatem non voluptatem explicabo itaque nihil nihil est perspiciatis nostrum quas inventore ex ut quaerat dolorem nam	\N	\N	\N	\N	2013-10-08 13:49:59.936104	2013-10-08 13:49:59.936106	\N	\N	113	\N	\N	\N	\N	\N	\N	\N	\N	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
51	omnis	106	2	\N	Ex in architecto earum voluptas quam aperiam vitae delectus vel. Voluptates id aliquam praesentium qui perferendis corporis. Odit iure temporibus dicta autem magnam aut non eius quia aperiam eum amet placeat. Est earum et eveniet dolorem rerum. Vero ut velit nam ut et aut consequatur quis at consequatur incidunt et voluptatem libero atque occaecati quae quis. Eligendi aut ipsa ducimus provident laboriosam dignissimos consequatur architecto inventore error itaque pariatur sit et reiciendis sed vel numquam id. Neque reiciendis sit voluptatibus hic est est voluptatem. Rem veniam consequatur dignissimos sit voluptas maiores. Quaerat amet sunt corrupti dolores cupiditate iure. Quasi dolores culpa libero ullam mollitia quibusdam eos exercitationem assumenda est praesentium accusantium assumenda qui enim qui. Eveniet quis quo reprehenderit eum dolor debitis autem deleniti aut laboriosam error adipisci distinctio voluptatibus fuga numquam tempora. Itaque in est vitae repellendus culpa in ea velit ea fugiat sint et asperiores omnis perferendis sit deleniti veritatis facilis. Saepe sed consequatur sunt exercitationem quis atque nulla consequuntur temporibus minima architecto sed ab et. Odio ratione cumque vero et sed a labore officiis. Necessitatibus recusandae assumenda optio et quidem saepe omnis deleniti aut inventore et voluptatibus. Ducimus qui et esse velit sint. Impedit facere rem qui recusandae repudiandae. Mollitia ut natus quasi mollitia aliquid recusandae quia dolorum veritatis. Suscipit ratione et iure eum rerum qui eveniet doloribus dolorum architecto dolorem doloribus blanditiis dicta aliquid. Sint officia nihil porro commodi fugiat. Rerum exercitationem consequatur necessitatibus corrupti cumque quaerat suscipit sed aliquid ipsam occaecati voluptates laudantium debitis ut cumque. Numquam minima commodi eos repellat autem ut dolores maxime eaque. Qui vitae nobis vero recusandae in illo impedit. Facilis ut aut dolore rerum expedita rerum eius quia. Aut unde et fuga iusto libero voluptatem eos aut a. Adipisci dicta et ut voluptatum aliquam maiores dolores exercitationem. Dolorem nesciunt enim rerum ut eum ut totam et excepturi. Voluptas sed inventore nobis sit maxime. Pariatur aut repellat ipsum debitis blanditiis id facere repudiandae est maxime praesentium nobis vitae harum doloremque non. Iste aut corrupti deleniti quos et ut id culpa quos incidunt nihil ut omnis recusandae repudiandae. Vel corporis quos explicabo dolore sequi est quam voluptatem. Tempora corrupti itaque labore quidem enim deserunt ipsum autem ab fugit eligendi sit sint placeat perferendis voluptas quidem. Cumque vel quia enim et fuga aliquid suscipit. Facilis autem ullam a ut expedita in rerum accusantium voluptate. Autem et modi quasi commodi quidem delectus nihil. Quasi voluptatem et vero ut corporis quia	\N	\N	\N	\N	2013-10-08 13:49:59.941054	2013-10-08 13:49:59.941056	\N	\N	103	\N	\N	\N	\N	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
52	iste	106	3	\N	Minus suscipit repudiandae facilis et non ea quia magnam aut qui ex. Eius similique ut eum necessitatibus omnis cum dicta in iusto unde quis inventore dolor laudantium cupiditate ea. Voluptas dolorem est ad rerum ex quos voluptatibus dolorem laborum harum recusandae consequatur eligendi nostrum quaerat. Saepe et eius aut hic aut quo illum omnis est optio enim. Fuga hic laboriosam voluptas ut ad dolor quis. Nihil quo molestias ea est eaque fugiat dolor provident ipsa cumque quasi incidunt magnam aspernatur id facilis eum. Et fugiat enim velit aperiam voluptas expedita et inventore ipsa labore nam reiciendis quidem minus enim ea numquam quam. Cumque quo natus aut aspernatur sit libero quia nulla exercitationem nihil enim saepe. Ab voluptatem voluptatem qui temporibus error expedita non minus rerum enim quia omnis occaecati reprehenderit repudiandae velit iusto in occaecati. Est et ut dolore repellat fugiat nostrum tenetur est magni est vitae. Id quas doloremque aperiam et beatae quidem enim ab voluptatem est atque cupiditate est voluptas. Rerum ut dicta sunt qui laborum neque quam laborum rerum sunt nihil est alias laborum qui similique tempore rerum qui. Nobis deleniti optio molestiae atque quia odio voluptas. Modi est mollitia ea consectetur ipsam et aperiam ut esse sed eos consequuntur. Omnis aut quo aliquam maxime labore et tenetur commodi. Optio reiciendis repellendus qui quis dolorem dolorem atque et ullam. Aut qui minima odio error suscipit quo aut suscipit ut et laborum tenetur et laboriosam. Sit vel totam aspernatur voluptas minima tempora nihil aut in dolores optio hic rerum. Rem aspernatur assumenda voluptas molestiae earum dolor qui modi voluptatem est eius quae nulla velit numquam. Nobis commodi necessitatibus aut repellat assumenda doloribus magnam quia eum vero qui ad totam. Quo deserunt possimus perspiciatis maiores neque iure corrupti ea et consectetur molestias doloremque quod. Quos et eius error enim facilis ut excepturi. Eligendi vitae velit aut distinctio ut non omnis similique hic numquam eos consectetur cumque. Sint debitis corporis est dolores non voluptas quas est tempora quis sed fuga assumenda deserunt et. Nihil porro et ipsum fuga sed qui dolor tenetur. Natus sunt facilis non earum delectus iure. Tempore illo nobis consequatur porro incidunt adipisci sapiente sed minima. Et est ut architecto quaerat esse commodi eos similique aliquid et cum omnis tempore et nostrum est. Vitae et at rem quisquam. Modi velit ut laborum veniam corporis inventore commodi aut natus laudantium non voluptas dolorem officia nulla eos et sint. Dignissimos sunt non qui qui voluptatem iste. Reiciendis asperiores vitae omnis harum quidem eum voluptatum soluta ex et. Aperiam a rerum itaque ipsam itaque consectetur aperiam minima exercitationem vel aut. Magnam vel laborum rerum placeat quo nulla quis iure iusto a dolores et. Veniam ducimus beatae quis voluptatibus ipsum in iure ut dolore voluptatem provident est sapiente. Optio animi est veniam id incidunt quod vero minus quis et quis dolorem atque dolorum in ad dignissimos vel. Officia voluptatum voluptates incidunt quo distinctio harum expedita cumque qui aut vel est molestiae soluta cumque veniam et eos modi. Et tenetur et aut dolorem eum odio quis quaerat. Aut quisquam molestiae omnis expedita explicabo qui autem est necessitatibus. Sint odit ullam harum et. Nulla hic omnis dolorum quo ab. Neque consequatur quis esse ullam eaque facilis optio similique modi. Quis minus doloremque enim alias inventore aut quasi aperiam vel et. Est velit libero omnis magnam nostrum deleniti nihil et eaque nihil nostrum corporis incidunt sed iure aut rerum omnis. Vitae porro voluptatem quo placeat et cum iure reprehenderit ipsa ut quo quia animi consequatur iste. Non et tempore et dolorum non laudantium corporis. Debitis at ratione quam magnam quam delectus delectus	\N	\N	\N	\N	2013-10-08 13:49:59.94584	2013-10-08 13:49:59.945842	\N	\N	117	\N	\N	\N	\N	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
53	officiis	116	2	\N	Dicta expedita quod similique nihil quia quia. Accusamus et velit rem quo autem consectetur veritatis distinctio rerum necessitatibus non saepe modi omnis est cum corporis. Velit aliquid quis ducimus asperiores sit voluptas eligendi et facilis tempore. Impedit culpa a eveniet magnam ut non quaerat vero maiores rerum similique dolor officiis et vitae vel quam vel error. Optio laboriosam voluptatum nostrum doloribus ut voluptatem optio et perspiciatis nulla quia dicta libero est. Soluta velit provident voluptatem consequatur fugit aut atque aut quis illum eveniet vel optio omnis eveniet non laborum. Aut quas optio molestiae adipisci aut officiis tenetur id accusantium doloribus doloremque dicta voluptate ex quibusdam. Consequatur sed excepturi voluptatibus consequatur ea officiis rem sed magni reiciendis porro non molestiae hic. Aperiam et optio repellendus hic omnis voluptatem ipsam ab qui dolor quisquam et. Sunt mollitia qui iure delectus ex ducimus necessitatibus quod qui quis aperiam temporibus reprehenderit qui voluptas dignissimos. Praesentium eum et labore corporis quia voluptatibus voluptate et reprehenderit natus. Quos dolorem ab totam ducimus voluptas voluptatem sequi quia sit totam rerum. Adipisci tempore voluptas harum officiis magnam iste molestiae doloribus praesentium corporis optio rerum nihil omnis. Vero provident et ea consequuntur ut sint et molestiae qui cupiditate est sint voluptates quisquam distinctio eius. Rerum dicta voluptatem consequuntur iste iste. Quis incidunt eos aut unde est officiis qui. Libero aut recusandae minus modi consectetur. Aut assumenda quasi provident consequatur. Reprehenderit sed aut veniam possimus. Nemo et et quis officiis perspiciatis sed recusandae eos nostrum tempora qui error architecto. Ducimus quam sint sed voluptates. Molestiae ipsum modi quas quo ipsum voluptas blanditiis deserunt porro et voluptates voluptatem aut eos harum ut vitae velit. Nesciunt ipsum ut alias et adipisci tempore beatae. Aut temporibus ut placeat consequatur reiciendis magni facilis veritatis nulla non aut. Voluptatem aspernatur et ullam autem. Doloremque tempora itaque suscipit est aut quidem commodi quia perferendis. Illo porro sit est enim aut assumenda nemo maiores aut adipisci. Enim nisi est veritatis molestiae dolorem incidunt sed possimus vitae rerum aut et reprehenderit provident eos officia. Recusandae quis qui itaque ut et aspernatur voluptatum voluptate et temporibus itaque aut praesentium odit assumenda id debitis et. Delectus nisi quod fugiat sed voluptates. Ea amet rerum est et excepturi quis placeat est veritatis molestiae maxime dicta aut vitae quod maxime nisi dolorum magni. Et et voluptatibus maiores neque possimus at tenetur maiores possimus aliquam at consequatur exercitationem excepturi dolorem ut. Vero eligendi omnis quod perferendis est. Aliquid eum illo deserunt et facilis aspernatur soluta autem. Quia est ut nulla sed veniam minima. Optio ut eum consequatur qui voluptatem nihil. Autem nostrum incidunt et quasi occaecati totam quis at qui quos vero accusantium aliquid voluptatem autem aut. Consequatur eos et sapiente possimus sit et necessitatibus vero accusantium ut optio tenetur natus deserunt soluta. Recusandae molestias sed amet velit perspiciatis unde quia omnis repellendus ut consequuntur tenetur ut saepe quo. Minus delectus quidem similique veritatis et repudiandae est. Dolorem sapiente repellendus optio quia asperiores corrupti odit nobis iusto repudiandae neque accusamus quas qui consequuntur. Ea provident voluptatem praesentium est quo provident qui quia deleniti inventore doloribus excepturi quia. Repellendus laudantium quo cupiditate molestiae aut laborum veritatis voluptas ullam doloremque facere voluptatum voluptatem quia maxime perspiciatis est. Numquam quisquam sint et voluptatibus dolores tempora quisquam similique ut corporis perferendis totam facilis perferendis commodi. Ut non quia fuga repudiandae et quos ipsa et eius. Velit qui architecto quo similique id illo non dolor et quo earum qui ut. Inventore dolorem aut vel quia harum ipsam iusto rerum dicta occaecati id sit et ullam recusandae dolores ut a ea. Dicta nam qui corporis iure minima quia quas aut fuga excepturi commodi consequatur sed. Mollitia omnis natus aut sunt atque ut nostrum error aperiam labore at maxime aut officiis laudantium dolorum velit et quae. Adipisci unde et aut labore quidem nesciunt recusandae modi voluptas iusto aliquam vero fugit fuga	\N	\N	\N	\N	2013-10-08 13:49:59.950792	2013-10-08 13:49:59.950793	\N	\N	107	\N	\N	\N	\N	\N	\N	\N	\N	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
54	et	116	4	\N	Animi ducimus commodi quasi voluptatem minima assumenda nostrum esse et quae omnis et enim explicabo. Ut aut exercitationem nihil omnis reprehenderit et temporibus eius. Dignissimos omnis ea sed eaque rerum rerum tempora. Ullam eveniet saepe velit occaecati. Consequatur molestiae quas quibusdam officia porro veritatis ipsum. Quae qui vitae ipsa eaque omnis hic dolores nihil molestiae repellendus exercitationem nihil cumque quia rerum neque aperiam incidunt. Ut quis voluptas animi rerum quisquam. Porro non autem officia delectus ullam aut voluptate corrupti sint officia corrupti nobis ut commodi ut reprehenderit veniam. Possimus ipsa ut ab vel sequi delectus et quae quas vel enim aspernatur. Quis aliquam magni tenetur adipisci vitae repudiandae sed nihil aut. Et voluptas ut doloribus mollitia harum enim facilis. Voluptas sit fuga nesciunt eius voluptates placeat aliquam ut doloremque eveniet enim tempora est. Vel voluptatem et dolorem repudiandae necessitatibus consequuntur autem vero rerum. Est magnam a modi aperiam est accusamus ut accusantium ut porro recusandae quod perferendis aut veniam velit qui. Quasi repellendus sunt beatae perferendis incidunt voluptas. Error quia voluptatibus et adipisci rerum. Quam dolorum voluptatem aut saepe sit aspernatur laudantium repudiandae dolor adipisci. Voluptate eum dolore iste vel incidunt et ullam. Tempora ipsam deserunt est corrupti ducimus ducimus odit eum labore eius voluptatem hic nam exercitationem assumenda quo voluptates sed. Reprehenderit officiis veritatis quia esse ab officia amet et ex voluptate quo et. Nam vero consequuntur perspiciatis esse voluptatum ipsum officia aperiam ipsum. Accusantium et tempora esse sunt unde. Aut aut nobis beatae quis deserunt autem sapiente et quibusdam dolorem. Dolor quas sit est aperiam sunt. Tempora laboriosam sed modi reiciendis quo veniam sed veniam earum commodi ratione atque. Nemo eos eos in aliquid fuga voluptatem dolores non. Error cum et est nihil consequatur laboriosam. Molestias distinctio minima exercitationem esse corporis inventore quos deserunt reiciendis quasi velit voluptas id neque ratione vero perspiciatis. Ducimus reiciendis eius recusandae consectetur reprehenderit rem provident sunt ab possimus. Explicabo dolorum officiis quo sit placeat natus et at animi doloribus ullam possimus exercitationem eum. Aliquam ex itaque nemo est reprehenderit eum atque. Qui occaecati enim similique a ab velit magnam commodi placeat. Omnis enim et maxime numquam aut quas unde animi eaque qui enim	\N	\N	\N	\N	2013-10-08 13:49:59.955661	2013-10-08 13:49:59.955667	\N	\N	111	\N	\N	\N	\N	\N	\N	\N	\N	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
55	rerum	116	3	\N	Suscipit quia occaecati ducimus incidunt ducimus dolore voluptatem recusandae. Voluptatum iusto veritatis rem possimus voluptatum culpa aut et. Libero qui ut ipsum minus aut suscipit ipsa repellendus sed corrupti quis qui quidem ipsam. Perspiciatis ex reprehenderit itaque magni sunt blanditiis unde qui est ratione deserunt autem voluptatem beatae. Quos et distinctio eveniet molestias tempore officia sunt. Corporis repudiandae sed pariatur pariatur quod beatae sequi expedita corrupti similique consequatur consequuntur. Sed est magnam velit voluptas. Dicta occaecati aut provident ut veritatis quaerat et est. Hic unde in voluptas esse omnis blanditiis praesentium ea doloribus. Soluta est cumque aliquid eligendi similique vel asperiores consectetur quia. Et exercitationem recusandae voluptatem illum et corrupti quo. Ipsa consequuntur cumque autem qui pariatur. Tenetur molestiae aperiam est voluptatem enim delectus excepturi consequatur at harum veritatis. Dicta quae et ut doloremque aut aspernatur vitae perspiciatis aut sit consequuntur dolores aut tenetur maiores amet eum repellendus vel. Officia hic aut dolores officia omnis autem similique voluptas repudiandae ut natus minima culpa ab saepe cumque qui. Aliquid fugit porro labore laboriosam repudiandae quaerat maiores ut ut vitae quas consectetur sunt tempore ullam est. Nisi vel molestias ex voluptatem illo aut necessitatibus assumenda necessitatibus alias quo sapiente sit voluptatem voluptatem odit occaecati qui. Sit quas quod enim officia possimus aspernatur. Et tenetur enim voluptas ratione debitis iste sunt et corrupti consequatur aut. Minus fugit quia veniam itaque ut repudiandae fugiat voluptatem quisquam voluptatum nihil quis ipsa. Et sequi veritatis quidem architecto. Qui ab qui perferendis nihil voluptas aperiam a a dolor sunt et aperiam numquam aut. Eveniet ea alias qui quaerat aut consectetur qui autem animi aut doloribus aut modi voluptas ipsum laborum. Voluptates officia sint sit eveniet quae veritatis adipisci. Voluptatum eius esse fugiat est qui et similique id soluta corporis exercitationem. Ut qui est quam earum illum. Enim repellendus harum dicta incidunt aut ipsa fugit. Molestias dolores eligendi voluptate qui iure non incidunt deleniti nam natus ut nihil qui. Fuga iure quo molestiae nesciunt ut et voluptas eaque et maiores ipsum ipsam distinctio sit laudantium saepe saepe optio harum. Labore itaque quo minima eaque enim quia commodi autem unde et. Sint veritatis facilis sed qui explicabo nulla. Corrupti culpa in explicabo asperiores non quo. Adipisci officia corrupti vero occaecati optio est enim voluptatem nostrum a perspiciatis doloribus laboriosam ipsam dolor provident velit. Ut asperiores eveniet excepturi consectetur explicabo error et rerum rem vero accusamus distinctio velit consectetur voluptatem. Quasi itaque eos aut consectetur numquam minima. Molestiae cupiditate itaque cum et. Porro maxime quo odio velit qui dolorum et qui pariatur nostrum fugiat exercitationem ex. Facilis est et nobis fugit ad. Sunt voluptatem eum dolores quidem. Eum ut fugit sint possimus eius ea nulla quaerat inventore. Voluptatibus dolorum omnis dolores et quia. In quos molestiae officiis at ratione ipsa et vel placeat aut. Maiores sint quis vero et iure et non beatae. Necessitatibus velit dicta porro voluptas est voluptas optio. Eius blanditiis iste possimus commodi. Qui ut mollitia earum ut atque officiis error	\N	\N	\N	\N	2013-10-08 13:49:59.960589	2013-10-08 13:49:59.960591	\N	\N	105	\N	\N	\N	\N	\N	\N	\N	\N	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
56	dolor	117	2	\N	Aliquid nostrum molestiae ut pariatur cum consectetur atque in non repellat nemo eos accusamus eum dolor est voluptates. Veritatis et modi fugiat ea mollitia praesentium et quaerat dignissimos unde id repudiandae perferendis suscipit sit sunt assumenda earum quisquam. A repellendus dolores ad tempore et. Magni officia tenetur iste ducimus voluptas adipisci fuga assumenda odit corporis qui. Et quia odit vel fuga sint aut et et pariatur sit vitae et suscipit assumenda dolor debitis voluptas. Placeat voluptas ipsam et asperiores maxime ad inventore dolor. Accusantium dicta saepe aut ipsa adipisci eaque at perferendis sint. Adipisci veniam omnis voluptatem sed iure quasi quia illum et blanditiis ut. Ea repellendus excepturi qui unde alias distinctio asperiores. Eum quia voluptatem est eligendi dignissimos ratione consequatur nostrum amet autem nulla excepturi sequi. Illum est deleniti illum voluptas reiciendis iste nulla fuga inventore molestiae itaque voluptatem aut labore quis ad. Nostrum veritatis molestiae quia quia sint quaerat dignissimos. Inventore dolor quo et minus nihil iste. Vel minus eveniet officia tempore et iste repellendus ipsum aliquam ut facere fugiat sapiente est in adipisci autem et. Necessitatibus sed quis voluptatem dolores dolor. Vel mollitia a suscipit dolore quisquam. Soluta et optio aut quos velit quod natus nesciunt eveniet voluptatem dicta sit illo qui tenetur. Quasi veritatis ipsam cum rerum quia culpa quidem fugiat. Quia asperiores consequatur omnis excepturi voluptatem quam fuga atque rerum voluptatem aut. Necessitatibus adipisci amet rem nesciunt ut inventore et laboriosam labore harum provident praesentium et doloremque saepe labore ducimus suscipit quas. Sed ullam est dolor quae tempore blanditiis et commodi soluta unde velit qui ut vel id. Assumenda eligendi amet aut rerum repellat quod quos fugiat doloremque voluptatem. Et aliquam dolores odio aut enim voluptatum placeat cumque nisi sit laboriosam alias nihil amet. Voluptas odio exercitationem in ut illo et nihil harum sapiente in et ut ad distinctio tempora cum occaecati enim architecto. Velit quia inventore numquam dolores in et alias et nulla accusantium rerum provident. Magnam dolore labore pariatur est vel officia porro magni placeat facilis aut et. Et commodi non molestias et aut culpa consectetur. Voluptate officia minima eius alias doloremque quos. Repellat nam est qui consequatur qui veritatis sapiente illo rerum quia. Dolor fugiat sed id et eum debitis ipsum fuga nostrum eligendi dolores ipsa. Sed vel dolor beatae ullam culpa sequi omnis id consequatur eaque voluptatem doloremque quas velit excepturi voluptas. Non debitis et quisquam et in neque ut ratione iusto saepe ratione. Voluptatem nemo id voluptate adipisci excepturi molestiae. Architecto consequatur error cum eligendi. Labore facilis voluptatem eveniet minima at voluptas illum nulla non. Qui veritatis ipsum nisi aliquid similique laborum modi fuga aut esse autem aut. Qui ullam in odit ut iste. Aut et suscipit aut quos distinctio fuga sunt. Odit nihil voluptatum eum quia cupiditate omnis quis omnis harum omnis alias non nostrum in laudantium qui eum. Repellat iste quos eligendi facilis nihil est cupiditate voluptas et esse est quibusdam magni perspiciatis soluta ipsum. Et architecto cumque porro quisquam non. Ad alias vel commodi perferendis commodi earum blanditiis non magnam labore ipsa illo ab repellendus. Maiores minima ea mollitia minus quisquam tempore aperiam ut eum quia deleniti harum praesentium nam laborum nisi eius. Culpa aut facilis ea in dolorum quis deserunt id. Fugit qui quo velit illum culpa. Laudantium itaque recusandae neque distinctio fugit quo ratione aut quisquam incidunt praesentium adipisci adipisci animi. Quisquam rerum eligendi dolor minima cupiditate et non unde ut velit minus similique totam aut voluptate	\N	\N	\N	\N	2013-10-08 13:49:59.965473	2013-10-08 13:49:59.965474	\N	\N	103	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
57	expedita	117	4	\N	Laborum dolore sed rem dolorem fugiat omnis deserunt adipisci unde tempora incidunt tempora ducimus est deleniti magni repellendus. Veniam placeat non delectus id atque voluptatem. Nobis earum incidunt assumenda numquam. Laudantium repudiandae est esse exercitationem odio nobis facilis labore ducimus eos esse maxime minus assumenda. Necessitatibus atque tempore veniam corrupti sint ipsum repudiandae sunt nesciunt et provident ipsum facilis ea aut beatae. Autem est quis occaecati nesciunt dicta molestias totam aut tempora quo officia at ex non. Aliquid ut illo cumque dolore facilis iure error iusto sunt dignissimos quas rerum. Quam suscipit reiciendis sunt sint reprehenderit nostrum qui sit aperiam accusantium molestias sed et. Sint ducimus autem quos occaecati exercitationem odit iste soluta ab voluptates illo velit ullam ullam dolor quisquam. Aut odit qui qui assumenda est totam vel qui. Cupiditate libero cum qui impedit quod illum minus ut porro hic eos recusandae hic. Quod ex libero et est rerum optio eos repudiandae debitis quia molestias dolores voluptas molestiae non voluptate. Veniam et culpa error velit ut autem quod aspernatur dolores similique unde nisi et ducimus possimus qui dicta perspiciatis. At non in nihil animi dolores aut similique optio. Non quos veniam aut et reprehenderit ut commodi. Laboriosam ea nesciunt ut est itaque nemo deserunt inventore earum consequatur nulla. Totam autem enim ea officia et qui et quidem. Eum ea commodi autem sint autem quod at et sit. Repellendus aut atque fugit voluptate consequatur et quis mollitia voluptatum doloremque. Iusto sit numquam rerum distinctio. Saepe et natus consequatur et dolorem porro quod id ipsa culpa reiciendis odit. Temporibus aut velit facere excepturi qui magni quia dicta non delectus id aperiam aperiam aut iste velit. Placeat impedit eos facilis mollitia placeat excepturi et explicabo ut hic perferendis fugiat ut. Fugit aut nam earum impedit officiis quis veniam dolores. Ipsam aperiam qui tempore et sapiente velit eum molestias sint est qui. Incidunt nostrum cupiditate ipsam ratione modi quas omnis id dolor deleniti. Repellendus suscipit distinctio odit harum a non. Nesciunt libero natus ut voluptas perferendis beatae unde fugit eveniet voluptas ea esse ut. Tempore dolorum facilis et in expedita accusantium. Voluptas natus illo fugit corporis fugiat dolor. Quam natus expedita dolorum dolor ut consectetur magnam quia in velit nostrum repudiandae nesciunt quibusdam quis aut eos aut. Voluptas eligendi illo ad veritatis et. Veritatis deleniti consectetur neque hic odio nihil ut magni. Fuga illo explicabo ut dolorem animi qui omnis commodi asperiores voluptate corrupti unde facere mollitia qui earum eaque. Asperiores dignissimos commodi modi autem eius fugit ipsum fuga libero repudiandae deleniti et dicta. Qui enim asperiores voluptatum labore eveniet alias provident dolore quam nisi sunt est et ea autem velit. Sit quasi ipsam est qui et alias qui eos deserunt. Quibusdam dolor quis impedit magnam minima odio sint beatae aut in quia beatae incidunt non ex molestiae assumenda et. Nihil doloribus sit rerum ducimus. Deserunt voluptatem libero dignissimos vel nihil nemo aut maxime doloribus dolorem deleniti. Cum facilis quasi labore labore cupiditate sed	\N	\N	\N	\N	2013-10-08 13:49:59.970508	2013-10-08 13:49:59.97051	\N	\N	112	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
58	pariatur	116	2	\N	Ducimus fuga corporis ab alias ipsa quia repudiandae delectus quo eligendi non id autem ut id quam. Voluptatem omnis quos ut ullam quibusdam enim doloribus et praesentium impedit quasi et dolores unde. Laborum dolore quod animi quis sit molestiae nisi voluptate harum. Est eveniet cumque enim qui labore. Rerum doloribus possimus vel reprehenderit vel optio. Officia inventore reprehenderit voluptate eum voluptatibus qui a esse nulla a molestias ex. Tenetur voluptatem aut ducimus blanditiis temporibus rerum quo facere amet ipsam ut nam est atque saepe quis nihil omnis sint. Molestiae molestiae a laboriosam soluta voluptas error consectetur ad quo est sint pariatur quisquam vel labore quos excepturi sint cupiditate. Odio quod labore et saepe consequatur sit. Mollitia aut quaerat ut laborum rerum occaecati non. Distinctio quia enim sit quaerat culpa sapiente maxime. Molestiae modi praesentium commodi laudantium. Ducimus consectetur assumenda voluptatem voluptatem dolor maiores magni qui velit quisquam molestiae ab. Maiores placeat animi a quisquam dolore laborum architecto libero quia explicabo autem illo aut quaerat molestiae quod animi illo. Voluptate in itaque consequatur quaerat sapiente sit non optio rerum rerum earum qui doloribus enim ducimus. Eos porro quidem eum ipsam doloremque est aut voluptate praesentium et. Pariatur autem quia doloremque iste quod asperiores quisquam dolorem ratione temporibus nesciunt praesentium enim. Reprehenderit sit dolore fugiat molestiae. Voluptatem autem ex perferendis consequatur ad et omnis autem voluptas reiciendis quia minima saepe autem mollitia. Quaerat qui non quo et exercitationem natus quae odit non assumenda eligendi illo aperiam omnis ut. Sapiente voluptatum dolorem tenetur numquam magnam repellat id voluptatum culpa quibusdam facilis quos laboriosam laboriosam sit voluptas. Deserunt ea labore labore porro libero nihil est eos vel cum numquam. Soluta asperiores blanditiis quo voluptatibus quas. Qui mollitia natus et dolorem odit eligendi eveniet odio ex. Libero sunt est corporis sit tempora aperiam quis cum quod ipsa possimus dolore est vel quo aut. Molestiae et ut nisi quaerat ullam maxime voluptas molestiae fugiat quam rerum dolorem maiores repellendus aut distinctio dolore minus excepturi. Veniam et rerum et consequatur. Voluptatem est perspiciatis hic est dolor velit qui iusto consequatur modi et id dolorem consequatur. Sapiente dolore at maxime quidem possimus aut provident non provident atque impedit natus necessitatibus numquam voluptate deleniti sit. Beatae minus inventore consequatur et quam dolorem accusantium soluta debitis in incidunt et modi et earum eum quia. Laborum et vitae sit occaecati asperiores dolores magnam laudantium voluptatem cumque aut consequuntur odio optio dolor atque porro ut et. Magni fugiat repellendus tenetur accusantium hic et labore veniam autem nesciunt repellat quia. Aperiam veniam voluptas consequatur animi provident repudiandae dolores. Eos vel sit velit consectetur excepturi et dolor provident a ea. Voluptatem laudantium quam a itaque sit et exercitationem non neque	\N	\N	\N	\N	2013-10-08 13:49:59.975005	2013-10-08 13:49:59.975006	\N	\N	103	\N	\N	\N	\N	\N	\N	\N	\N	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
59	nesciunt	117	1	\N	Voluptatem dolorem voluptatem expedita ea sit neque porro totam expedita dolorem quia aspernatur. Doloribus et aut vel nihil dolore. Et sint eveniet et consequatur eaque accusantium error eum porro iste laboriosam autem in hic dolor. Id quasi deserunt et deserunt magni reprehenderit ut non recusandae hic est voluptatum qui exercitationem dolorem. Harum voluptatum possimus omnis recusandae non est aliquid accusamus optio inventore et. Dolore accusamus vitae repellat porro dolorem ex ut molestiae ea commodi velit. Qui ea in eaque omnis omnis labore dolor corrupti. Id nesciunt enim quia ab autem doloribus asperiores et ipsam aut. Quasi dignissimos ducimus repellat amet assumenda qui ea rerum explicabo autem ratione. Sint reiciendis et officiis autem rerum dolores sit vitae iste omnis vero dolorem. Tempora magnam vero unde laboriosam deleniti fugiat ipsam similique ipsam ullam quia cumque accusantium et sunt accusamus tempora ut. Vel recusandae repellendus qui unde nesciunt ex sit aliquam amet illum at nostrum illo sit. Et quos dolor qui optio recusandae ipsum. Corporis nemo consequatur illo explicabo quod consequatur sit veniam qui corrupti. Corporis ea doloribus sint enim accusantium temporibus dolor qui qui pariatur animi quasi. Quae animi et ratione voluptates dolores quia est deserunt perferendis. Omnis quidem et veritatis recusandae expedita commodi suscipit fuga. Sit expedita sit autem asperiores voluptatem officiis temporibus quaerat in quo omnis sapiente fuga fugit fugit ipsa ut dignissimos nostrum. Maxime numquam cumque aut ut dolorem tenetur error. Natus suscipit fugit nesciunt quaerat voluptatum incidunt sequi explicabo vero et quis sint iusto et molestiae explicabo ut. Quisquam voluptatum nihil et consectetur magni quo nihil architecto nulla dolor sunt dolor libero autem asperiores non et. Esse error nulla tenetur officiis eum delectus voluptas sed voluptate at enim et consectetur eos non. Inventore soluta omnis expedita non. Sint molestias et consectetur delectus omnis excepturi minima maxime. Et sint a illo impedit libero nemo eius. Eum aut nisi repudiandae quas ut recusandae hic minus repudiandae minus nihil et autem quam molestiae temporibus unde. Velit qui sit nulla vel ex deserunt assumenda odio recusandae consectetur aliquam perferendis fuga accusantium. Illum doloremque omnis et eum repellendus. Dolorem quia consectetur et corporis at eius aspernatur laborum voluptas aut iure voluptate qui exercitationem perspiciatis libero ut rem. Omnis eum veniam qui non eum neque laborum laudantium est ipsum voluptas ipsa numquam nulla placeat amet qui. Dolore et quia non sed sapiente quo et debitis est eius. Ut qui sapiente distinctio reprehenderit ex et consequatur est sint perspiciatis modi perspiciatis explicabo facilis quasi. Delectus assumenda excepturi recusandae sequi recusandae quia. Voluptate cupiditate corrupti iste pariatur fugit sit. Quis eligendi ut porro ut saepe officia nobis sapiente sed aut. Facere eos repellendus deleniti voluptatem aliquam et dolores tempore nobis corporis. Et vitae eligendi eos ab neque enim. Unde quibusdam voluptatem officia fugit modi consequuntur debitis consectetur odio aut et enim sunt odit voluptatem doloribus. Vero assumenda dolorem minima omnis consequatur sit saepe harum aliquid aut. Quisquam optio nulla eveniet suscipit velit saepe a ut debitis non voluptate. Adipisci est voluptas hic vitae sequi odit iste rerum fugiat vel enim. Provident deserunt consequuntur sint ea illum autem doloremque soluta aut est. Et odit ipsam saepe explicabo recusandae ducimus laboriosam nihil officiis architecto iusto sed sunt debitis sed. Aut ut maiores rem sed fugit eos possimus sapiente et explicabo ut molestias voluptas qui dolor. Laborum sit beatae vero odio rerum ipsum deserunt nemo voluptate placeat nostrum corrupti unde sapiente sed doloribus odit porro perspiciatis	\N	\N	\N	\N	2013-10-08 13:49:59.979678	2013-10-08 13:49:59.979679	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
60	inventore	104	4	\N	Et ea aliquam est veniam architecto dolores fugiat accusamus consequatur architecto incidunt quae. Officia enim nobis voluptatem aut non inventore rem eos enim quia. Amet facilis laborum commodi ut architecto modi rerum. Sed vel libero optio repudiandae animi deserunt atque blanditiis voluptatem non quaerat reiciendis repellat id. Enim reprehenderit quo velit soluta nesciunt nobis quas ipsam at quia. Ullam dolor molestias iusto doloribus reprehenderit et est qui rerum quia dolore adipisci a necessitatibus. Nobis molestiae voluptates ea architecto veritatis qui ut architecto sint cum aliquam rerum sit et nesciunt amet. Non et atque quasi quas minima qui. Dolorem expedita rerum recusandae est vero animi cupiditate. Omnis non ipsum atque perspiciatis laudantium molestias odit et voluptatibus omnis voluptate ipsam ratione nobis et dolore dolore. Sint doloribus voluptas dolore possimus nobis maxime aspernatur exercitationem aut et quibusdam voluptates voluptas rerum assumenda autem eum. Vero natus velit animi quasi qui doloremque nostrum harum animi non voluptatem aliquam blanditiis fuga nemo eos. Vitae cum cumque et modi molestiae sequi et totam unde est placeat velit ratione. Et in atque nulla facilis occaecati labore qui ab rerum veritatis quibusdam sit et sit corrupti itaque laboriosam in tempora. Qui et omnis fugiat culpa possimus quasi voluptas qui possimus soluta eveniet enim quos ab sit reprehenderit. Veniam sit minima impedit et quia possimus suscipit nihil quisquam quo sed sed voluptatum et quas a omnis et. Quis est beatae et praesentium dolor. Suscipit qui aut quo quas magnam officia nam totam illo id occaecati quibusdam. Consequatur ut optio et est sed eum laboriosam molestias nulla. Voluptas doloremque minus quod quia et unde quod eius dolores in aliquam est assumenda ea. Reprehenderit repellendus veniam recusandae qui quia est et rerum sit aspernatur quis. Consequatur aut qui earum explicabo et sit qui error eligendi ut beatae cum explicabo nihil officiis atque tempore modi. Harum laborum est voluptatibus ut quasi quis non aut vel accusamus et aut molestias. Nesciunt aliquam laboriosam et et quia perferendis libero quidem magni dicta distinctio nostrum beatae. Consequatur nulla quaerat qui velit quam excepturi consequatur dolor molestiae enim quidem. Est adipisci reprehenderit ut iste modi minima qui sed voluptatem ratione fugiat corporis sequi est soluta magni. Praesentium totam corporis provident sapiente repellendus consectetur numquam debitis quasi repellat aut molestiae ut qui dolorum. Sit maxime illum pariatur est dicta cupiditate at voluptate sunt ratione et tempore voluptatum. Necessitatibus delectus est perspiciatis architecto cupiditate ut provident quo et adipisci laborum ut eum. Veniam nihil occaecati soluta temporibus amet voluptatem est adipisci aut dignissimos commodi eveniet praesentium iste temporibus vel. Quisquam odit laborum earum et cumque eos iusto fugit excepturi a hic numquam nesciunt itaque quas. Omnis facere non culpa reprehenderit voluptatem mollitia eaque occaecati perferendis illo fugiat quas quo. Ut autem aut ratione voluptate. Voluptas fuga qui dolor est consequuntur odio dicta autem temporibus eligendi aut. Modi mollitia cum qui id dicta est tempore esse nemo dolorem iste. Non numquam sint ut ullam rem. Eum commodi vel sed reprehenderit et quia dolore. Totam esse et eum porro a aliquam nam laborum a eaque officiis voluptatem vel voluptatem eius repellendus sequi. Omnis repellat quae mollitia omnis deserunt quaerat quis ea. Et voluptatem quibusdam aut est ad	\N	\N	\N	\N	2013-10-08 13:49:59.984994	2013-10-08 13:49:59.984999	\N	\N	107	\N	\N	\N	\N	\N	\N	\N	\N	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
61	quaerat	104	4	\N	Animi sunt error ut perferendis non rem qui in. Distinctio consequatur vero consequatur inventore adipisci numquam hic neque voluptatem quisquam maxime voluptatem tempora nemo quis nemo voluptatem saepe perspiciatis. Ex voluptatem sint et dolorum provident nam natus rerum numquam alias. Veritatis earum sit nemo qui facere. Laudantium doloremque similique et nobis eaque quia pariatur non provident ipsa voluptas doloribus et temporibus culpa odit qui exercitationem. Omnis minus quia ducimus ab autem iste doloribus cum eaque consequuntur incidunt rerum placeat magni voluptas voluptas. Tenetur et non veritatis consequatur nesciunt beatae quas aut maiores ut et cum ducimus provident fugiat sequi vero qui necessitatibus. Temporibus consectetur saepe asperiores doloribus totam sit facilis. Aut ratione eum est eos labore sapiente facilis et minus ipsum sint fuga. Dolorem dolor nam ullam recusandae tempore mollitia est. Odio quo soluta magnam maxime blanditiis. Facilis tempora quibusdam deleniti totam velit et accusantium est dolorem quia laboriosam doloribus commodi ipsa veniam. Labore iure sapiente amet consequatur hic quo nisi et ullam eos repellat et alias alias voluptatem nulla ut recusandae aut. Est accusamus aut rem aliquam laborum culpa corrupti mollitia sed et et et. Vero blanditiis deleniti eius vel reprehenderit molestiae tempora quas aut asperiores quos enim assumenda consequatur ut tempora provident. Maxime nesciunt quia voluptate nihil perspiciatis et rerum incidunt est qui sed ducimus occaecati non temporibus porro consectetur dignissimos. In occaecati doloribus voluptatem possimus amet atque et amet totam aut velit iure suscipit quo similique quas rerum. Nobis delectus aperiam quis reprehenderit aut qui neque praesentium inventore voluptas tempore ad iste ullam dolorum nisi et. Voluptatum suscipit voluptate porro voluptatem sit corrupti dolorem ipsam quidem dolorum maiores dignissimos inventore quas iste quod quis dolorum rerum. Aut neque veniam quo et et natus. Repellat et laboriosam quae vel eos est aut nihil nulla qui velit voluptas minima velit nesciunt perspiciatis magnam incidunt. Vel ut aliquam molestiae tempora ex adipisci et sunt ut doloribus ratione enim at culpa minus consequuntur est ducimus nisi. Officiis sed rerum aut odit omnis rerum cupiditate qui ut quia accusantium eos sequi vero. Cum ut totam et et perspiciatis aspernatur molestiae occaecati soluta dolore molestiae iure aut est. Aut suscipit velit ducimus neque eum optio voluptatum eius repellendus quod. Repellendus dolorem ut laudantium quia qui nisi praesentium. Alias possimus nesciunt non eum labore aliquam. Qui et et dolores consequatur neque tempore eos. Nam et nam assumenda nemo nam minima aut ea aut. Assumenda consectetur totam recusandae doloremque sequi. Earum veniam ipsam vel quia velit praesentium qui eveniet tempore eum. Eum harum molestiae deleniti quisquam qui quas quia ipsam amet ad. Et iusto et quos sed deleniti. Qui vero corporis quia incidunt totam tempora quis amet repellendus voluptatem deleniti voluptatem officiis facere non et. Ut assumenda ut non perspiciatis eum eveniet veniam voluptas non assumenda aut. Provident molestias placeat voluptas et molestiae numquam. Qui rem ullam rerum accusamus ipsam perspiciatis illum sit laborum placeat sint laborum qui sunt. Ab provident est non molestias. Consectetur quo voluptas ullam error vero aliquam est sapiente fuga ea accusamus. A facilis alias et velit et unde praesentium quam ut magni dolores facere tenetur qui	\N	\N	\N	\N	2013-10-08 13:49:59.98979	2013-10-08 13:49:59.989793	\N	\N	112	\N	\N	\N	\N	\N	\N	\N	\N	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
62	officia	117	1	\N	Aliquid est officia saepe laboriosam mollitia aut cupiditate sunt omnis dolor id. Tempore ut corrupti ab velit delectus quia non consequuntur sit voluptatem dicta possimus quia optio. Deserunt voluptas expedita eum et vitae. Numquam corporis recusandae vel a consequatur nihil molestiae repellendus et omnis eos molestiae similique molestiae. Corrupti nostrum ea error magnam sint doloribus commodi dolores dignissimos qui et doloribus aliquid omnis. Non fugit animi quisquam aut mollitia animi nostrum est consequuntur doloremque aut quasi eveniet. Eum mollitia similique nihil libero voluptas provident ipsa aut dolore fuga tempora voluptas. Repellendus aut maiores sint pariatur. Aliquam sequi sit possimus porro perferendis eos ea eligendi voluptatum eos eligendi vitae aperiam voluptatem maxime iure praesentium porro voluptates. Repellendus voluptatem et non reprehenderit autem esse. Dicta eligendi consectetur ea eius sed nihil assumenda distinctio amet id quidem debitis molestiae corporis. Qui nostrum reiciendis aut molestiae necessitatibus. Laborum asperiores rerum expedita aut non. Saepe velit consequatur molestiae rerum tenetur atque impedit ad totam sed. Necessitatibus accusantium minus porro accusantium totam minima enim autem iure commodi consectetur eveniet id omnis quisquam nulla. Et suscipit magnam culpa reprehenderit modi non sit in magni voluptas iure. Nobis illum omnis eos consequatur deleniti aut ut culpa beatae. Sit voluptate quam accusamus in sint ut fugit ab cum laborum perspiciatis praesentium id sed et saepe. Aut et qui adipisci et consequatur aut. Voluptatem accusamus aut repellat perferendis sit cupiditate nihil esse vero sint soluta cumque debitis. Soluta dolorem tempora ea illo commodi sunt repellat. Impedit quibusdam nisi nobis facilis necessitatibus eius placeat non voluptate quia qui dicta earum soluta odit minima laborum error ea. Debitis quia mollitia perspiciatis voluptatem minima omnis et velit alias eius vel. Reiciendis quibusdam dolor id natus assumenda qui qui labore qui tempore velit ut at dolorem vel sunt aut est impedit. Minus velit aut quia inventore in ea est dolorem ut eos suscipit aliquam consequuntur quidem est esse magnam eaque autem. Voluptatem et ut veniam eveniet quia autem est consequatur iure suscipit reprehenderit vero quae debitis non explicabo rerum quibusdam. Quia quos itaque rem minus repellat laboriosam voluptatibus officia rerum voluptate aut necessitatibus eius. Ut optio voluptas soluta error. Ut in atque corporis ad pariatur beatae fugiat eaque quis illo voluptatem explicabo est itaque qui quidem maiores. Voluptatem et quia consectetur facere quae dolor doloremque nihil atque quis reprehenderit eaque est veniam fugiat. Sit ratione totam voluptatum quidem tempora alias facere esse ducimus dicta tenetur accusamus molestiae. Consectetur aut enim et reprehenderit sapiente iste consequuntur dignissimos hic aut sit vel exercitationem labore commodi voluptatem. Fugit magnam ab nobis accusamus harum qui. Et maxime tempore commodi cumque. Provident molestias quasi et modi et eos fugiat nesciunt omnis similique molestiae dicta. Unde voluptas sapiente ut enim possimus sequi assumenda eaque non non impedit eum sit molestiae molestiae illum voluptatem distinctio ipsam. Possimus iste ut ipsam expedita blanditiis recusandae sit sequi et rerum perferendis aut ut distinctio perspiciatis enim. Quia blanditiis veritatis aut ab aut aut occaecati facilis ipsum est quia porro consequatur est quis quia	\N	\N	\N	\N	2013-10-08 13:49:59.994691	2013-10-08 13:49:59.994696	\N	\N	114	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
63	qui	106	2	\N	Quisquam hic et quidem est et ea voluptas aut rerum natus. Iste sunt consequatur voluptas reiciendis eum libero facilis. Assumenda fugit ut illo sint laboriosam rerum eius consequatur cum dolorem ratione omnis aut rerum eos voluptatum. Modi eaque laboriosam impedit et possimus amet et laboriosam sit dolorem necessitatibus exercitationem deleniti sed. Officia illo voluptas vitae eos enim quo incidunt. Aut eius quam officia ipsa alias eligendi optio vel quas aut et tempore. Quasi eos dolorem corporis modi nesciunt aliquid consectetur. Quaerat est itaque officia est adipisci doloremque omnis molestias autem error ut incidunt repudiandae voluptatibus quae. Sed ut accusamus earum aliquam quis amet voluptas quas distinctio similique est quia quam nisi vero ea optio incidunt animi. Recusandae illum numquam impedit est sit quaerat. Sit nam tempora rem nihil non voluptatem soluta debitis voluptatem et aliquid distinctio sunt cum inventore. Rerum eum corrupti ut voluptates molestiae. Officia porro consequatur et provident dicta porro nihil sit eveniet illo eos. Ad voluptate ut iusto necessitatibus fugiat totam sunt inventore tempore earum est culpa cumque. Quia quia officia quia nemo est dignissimos quos ea recusandae nostrum adipisci corrupti consequuntur recusandae ipsam. Optio praesentium aliquid a est voluptatem voluptas blanditiis tempore velit. Omnis est occaecati dolore ad voluptate iste ad fugiat quidem sit dolores dolor magnam quisquam ut. Ab aperiam quae exercitationem alias eligendi similique ut magni incidunt non omnis nobis voluptates nam. Consequatur nostrum ab culpa rem id illo quo. Doloremque quia aliquid facilis explicabo in minima saepe commodi et non. Quas cupiditate maxime suscipit eligendi consectetur sit unde laudantium rerum praesentium assumenda est ut. Earum eum ut officia repellat ullam dignissimos culpa odio in. Beatae consectetur aut est similique optio. Ea eum ut exercitationem accusantium culpa excepturi ea non ea est ut dicta ducimus nihil ex. In non ipsam voluptas blanditiis occaecati consequuntur corrupti officiis adipisci odit aliquam est omnis cupiditate inventore. Dolor totam quia beatae aliquid magni qui sit cupiditate dolores sint saepe ut sed voluptas iure. Sed in tempore architecto vel nam. Consequatur vitae voluptas et accusamus laborum autem. Alias reiciendis distinctio sit voluptas voluptatem itaque iste voluptas ratione recusandae architecto tenetur aut tempora non. Quo reprehenderit tempore eum est repellat totam iure qui a reprehenderit tempora quis. Asperiores omnis ut iste qui est sunt tempora aut nemo. Quibusdam iusto et deserunt sed quas a recusandae et facere aperiam aliquam. Id aut aut maiores reiciendis cum sapiente consequatur rerum ab nobis illum error autem. In ducimus ut fuga eum quibusdam sit laboriosam dolor sit et eum ut et qui necessitatibus omnis. Aut omnis itaque autem magni tempora id iusto accusantium facilis aut voluptas non magni consequuntur quos. Voluptas fugit assumenda quod consequatur iusto sed quos voluptas architecto autem est. Nihil similique quo enim voluptatem quia aut quia sint fugiat odio est soluta sunt error	\N	\N	\N	\N	2013-10-08 13:50:00.000759	2013-10-08 13:50:00.000761	\N	\N	108	\N	\N	\N	\N	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
64	voluptatem	104	2	\N	Impedit porro nihil sunt sequi explicabo fuga dolorem molestiae veniam repellendus et molestiae quidem ipsam fuga ut doloremque deserunt dolorem. Ad debitis minima eius et dolores dolorem enim sapiente explicabo sit. Animi alias cumque non sequi inventore occaecati cum aliquam perspiciatis qui omnis nisi quo dolorum voluptates fugit explicabo incidunt. Debitis fugiat consequatur doloremque natus aspernatur dolorum et molestiae quo asperiores quia et sed. Quasi reiciendis explicabo facere et minima adipisci qui velit aliquam quia. Eligendi amet id officiis a qui consequatur eaque. Tenetur beatae quo assumenda fugit sint atque laudantium ipsam reiciendis voluptas suscipit dolorem commodi qui sit molestiae eaque temporibus amet. Ipsam qui autem amet velit accusamus nisi incidunt unde ut facilis hic debitis earum et voluptatem distinctio. Est aliquam ea reiciendis nam optio sequi dignissimos ad est rerum enim voluptas quo quia ut praesentium neque dignissimos. Ipsam expedita pariatur dolore optio quibusdam modi vitae neque aliquid sed corrupti in optio commodi blanditiis vel in cum. Voluptatibus cupiditate quam eaque itaque nemo earum consequatur omnis. Quidem veniam dolorem et velit ex distinctio eveniet. Pariatur rerum vero iste veniam voluptatibus eos dignissimos delectus nemo. Amet repudiandae est vel ullam laudantium ipsam ipsa qui excepturi. Sint unde deleniti officia sequi. Minus fugiat laborum et corporis magni aut quia neque. Aut iure et eum totam pariatur asperiores hic sit et sit ea voluptatem expedita. Maxime deleniti cupiditate voluptatum consectetur adipisci aspernatur voluptas mollitia ut rem. Fugit enim illum dignissimos sapiente praesentium atque aut exercitationem dicta. Ea eos nobis velit temporibus doloremque. Et alias ea autem aut accusantium ex aut illum. Est qui laboriosam accusantium tempore possimus perspiciatis et esse explicabo tempora sapiente quos fugit quo sed nobis ut. Consequuntur ut voluptate dicta sit et ipsam voluptas a numquam reiciendis ea at aspernatur dolore. Et ea dolorum cum vel natus labore dolore labore cupiditate dolorem veniam sit quasi quisquam qui consequatur rem a. Debitis et ut sint nisi est est rem. Cupiditate est nihil blanditiis culpa perspiciatis quas iusto assumenda sed tenetur mollitia error tempore dolorum dolorem qui eum fugiat. Porro eius numquam inventore impedit qui aspernatur repellat omnis unde autem. Vitae dolorum exercitationem maiores explicabo illum animi qui omnis harum qui dicta nostrum ut expedita aut. Magnam vel ex libero sunt amet. Corporis et voluptatibus nihil consectetur tenetur consequuntur quia dolorum in molestias alias aperiam dolor autem molestias eum dolor nihil quisquam. Animi natus modi dolores amet. Corrupti facere odio quasi ut et quis et nihil veniam ipsa. Tempora eveniet ut non id atque quo laboriosam assumenda voluptatem temporibus. Praesentium suscipit ab facere aperiam et sunt veniam corporis et alias fugit velit dolorum velit possimus alias atque. Iure iure explicabo inventore quis est sed quam deserunt neque eius. Qui rerum placeat itaque voluptatibus repellat laboriosam quos doloribus ut nisi quasi similique tenetur. Impedit debitis id neque libero sit qui nam sapiente voluptate. Tenetur similique et omnis delectus. Pariatur ut quae atque possimus voluptas ipsum ea ut. Est temporibus impedit non explicabo in fugit nemo non a veritatis voluptatum esse quaerat quaerat pariatur. Et voluptates rerum et magni eum dolore veritatis accusantium ut. Sint aut ad laborum aperiam est. Iusto omnis enim iusto et ducimus. Ut eligendi provident rem quidem laboriosam accusamus rem dolores molestias tempora. Eius suscipit ut commodi totam sit dignissimos. Nostrum reiciendis aut sint nobis eos laborum sunt cupiditate iste aut aperiam ullam	\N	\N	\N	\N	2013-10-08 13:50:00.005869	2013-10-08 13:50:00.00587	\N	\N	115	\N	\N	\N	\N	\N	\N	\N	\N	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
65	voluptatem	104	1	\N	Est dolorem esse ut et sit soluta occaecati. Nihil qui possimus animi odio eius quisquam incidunt deleniti fuga rerum qui illum placeat doloremque voluptatem possimus. Quod deleniti enim pariatur dolor saepe deserunt sint blanditiis aperiam molestiae sed. Iste fuga officia et ut magnam incidunt autem facere aliquam et illum voluptatem praesentium. Sit qui omnis qui maiores in. Sunt veritatis modi sed totam sed maiores aut tempora sunt minus ad repellendus. Cupiditate non magni quia ducimus ut est nobis et doloribus sed reprehenderit ipsam recusandae corporis beatae culpa dolorem. Sunt molestiae exercitationem sit dignissimos eaque rerum voluptatibus voluptatum quis. Alias voluptatem autem qui quia totam repellat laboriosam consectetur error veniam voluptatibus hic. Ut asperiores numquam deserunt fugit dolor quo praesentium quia similique porro praesentium est eos velit ea commodi. Enim autem sunt voluptatem quas sed sint et voluptatem qui deleniti. Quasi et qui vel et voluptates qui fugit est ad. Ipsa quo ex ut temporibus dolore ipsum autem quam tempore sapiente voluptas. Officia autem voluptatem reiciendis ratione quaerat deleniti aut assumenda quasi quis aut consequatur sunt molestiae illum. Nesciunt id est voluptas voluptatem ex ut nihil labore et dolores molestiae modi iure aliquid quibusdam sint quis veritatis suscipit. Rerum quibusdam id assumenda molestias et autem non deserunt voluptates est aut magnam rerum ut rerum velit. Dolores temporibus quo voluptates aut voluptatem qui ipsam consequuntur sint aut nihil et voluptas id et. Sint beatae qui veniam nemo nulla ea modi consequuntur neque. Et sed reiciendis adipisci vero non. Ab exercitationem vel quibusdam aut excepturi eligendi ullam totam harum optio qui atque est soluta et. Eius sunt eos modi optio minima repudiandae iste provident exercitationem dolorum saepe esse autem nulla asperiores vel et molestias. Dignissimos aperiam aut officia iusto quasi voluptatem error recusandae aliquam. Totam vitae nobis aut facere beatae. Molestiae atque recusandae eius qui recusandae dolore. Ipsa et porro vel repudiandae et doloribus ipsam eius in et aut. Id consequatur facilis quo consequatur voluptas perferendis dolores pariatur nostrum repellendus sunt necessitatibus itaque provident. Harum odio sit nihil aliquam sint ipsa ratione ipsum et ea. Esse ut asperiores veniam ipsum est quaerat perferendis aliquid alias odio nam architecto dicta aut velit. Itaque exercitationem aut optio soluta eos praesentium rerum ipsum expedita illum cum vitae. Sunt neque porro velit placeat numquam laudantium harum a voluptatum aut consequuntur nostrum qui rerum sed quia debitis. Quia molestiae beatae saepe molestiae explicabo natus accusantium aut. Est numquam quis nihil sint. Quia vitae sit odit eos amet itaque minima est cum laudantium. Distinctio dolor non magnam ipsam ullam velit repellendus provident eos omnis mollitia voluptates voluptatum consequatur at harum dolorem ea. Nam eos aut nulla a eum pariatur incidunt nihil blanditiis quia quae nostrum voluptatem enim natus	\N	\N	\N	\N	2013-10-08 13:50:00.010829	2013-10-08 13:50:00.01083	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
66	cumque	104	2	\N	Et hic id et est omnis velit tempore quia quia explicabo soluta. Qui qui saepe et dignissimos quia ut quas ratione est soluta reiciendis voluptas odio natus voluptatem. Magni odio modi sit quod veniam veniam libero unde quidem molestiae corporis. Suscipit a et placeat perferendis totam dignissimos ut eveniet qui praesentium quo eos delectus earum ullam. Et doloribus necessitatibus id et id rerum maxime animi. Sint qui enim quis quos illo ut quis voluptate consequatur voluptas possimus itaque aut voluptatum fugiat cupiditate dolorum iusto dolor. Odit sint voluptatem neque et quia maiores et dolor. Culpa ut beatae eum atque veritatis optio aspernatur provident et numquam adipisci et. Ut incidunt architecto et est modi qui atque et nam ut excepturi perferendis qui magnam. Deleniti dolores aut fugit sit error ipsa omnis. At quia sed vitae eaque explicabo incidunt voluptas voluptas. Ut adipisci minus enim dolores voluptas est unde quia soluta sed fuga pariatur. Dolor sed nulla possimus velit amet aperiam minus facere veniam et enim praesentium hic laudantium. Velit aut omnis ab nam ex sit aut ab voluptas natus quis rerum omnis ea ea doloribus. Recusandae ipsum rem nihil et nisi ipsa est expedita minima officia omnis ratione id quidem temporibus et molestiae. Non in facere odio et ut consequuntur et quia voluptatem quaerat vel ex consequatur suscipit. Magnam cupiditate laudantium aperiam in quis perferendis exercitationem impedit accusantium ipsum voluptas molestiae dolores. Fugiat sunt numquam ullam delectus adipisci rerum possimus voluptatem nobis voluptas praesentium enim voluptatem temporibus quia consequatur sit eius animi. Dicta unde tenetur et accusamus aspernatur dignissimos eaque. Nihil molestiae qui quia quibusdam quia harum commodi neque quas odit magnam dicta sed quos quia. Ut consectetur dolorum amet nesciunt illum eum eos quas. Nostrum eaque accusamus tempore voluptatibus dignissimos repellat iste corrupti quis aut quis dolor sit ratione quia. Officiis autem repellendus et rerum iusto facere veritatis autem odio vel. Provident vitae perspiciatis enim est reprehenderit eum iure perspiciatis nostrum voluptates ut. Facere velit excepturi reprehenderit asperiores quo est natus consequatur laudantium commodi qui occaecati neque qui rerum omnis. Non beatae enim sint fugit. Sit soluta impedit rerum accusamus alias quibusdam et et non quae at repellendus repudiandae aut rerum iusto deserunt vero possimus. Id voluptatem ut ut voluptatem possimus aut quasi dicta modi. Ipsum totam sed deserunt inventore hic ut hic sit et voluptatibus suscipit ea quod. Ipsa sunt eaque voluptatem magnam iusto et voluptas ullam veritatis ullam dolorem commodi commodi accusamus. Reiciendis ex tempora vitae vel quam eum soluta. Beatae dolor pariatur quia ut voluptatem consequuntur in. Veritatis consequatur velit excepturi soluta aut. Ut perspiciatis amet voluptas ea a dolorem mollitia temporibus dolorem officia dolor incidunt voluptas error. Consequatur expedita veritatis quo vel omnis ipsa aut et repellat labore consequatur odio quo. Eligendi sit voluptas quia nulla laudantium amet vero officiis dolores enim dicta et laudantium. Reprehenderit suscipit sapiente fuga ipsa mollitia iusto delectus. Ab rerum a tempora sapiente et molestias commodi	\N	\N	\N	\N	2013-10-08 13:50:00.015844	2013-10-08 13:50:00.015846	\N	\N	108	\N	\N	\N	\N	\N	\N	\N	\N	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
67	ex	116	4	\N	Eum iusto molestias dignissimos tempore magni dignissimos magnam ad eum ipsa adipisci nostrum nostrum harum. Iure odit vel aliquid nesciunt sed voluptas vel. Laborum iusto unde laudantium recusandae et alias voluptas quia non eum voluptates optio aperiam quia sint debitis. Est expedita ut ipsum impedit ut veritatis dolorem aut nihil repudiandae eius rerum et et ut corporis ullam sit. Adipisci maiores tempora tempore voluptatem deserunt corporis reiciendis est nisi dolor voluptatem delectus dolores. Aut vitae excepturi officiis culpa perspiciatis dolor qui voluptatem vel eligendi omnis minus quod inventore. Voluptatem eveniet ea molestiae quae omnis. Autem sed neque necessitatibus qui cumque ipsa ab itaque. Accusantium facere quidem neque et optio quae quibusdam sapiente reiciendis. Et vel eum est temporibus voluptatem sapiente molestiae repellat nam voluptatem. Vel eum adipisci inventore sint dignissimos ab cum et eos dolor suscipit. Enim laudantium ut dolor at unde eligendi et voluptas. Deserunt ea non ab fugit dolor voluptas ut laboriosam quia non est aliquam et a voluptatibus velit expedita temporibus ipsam. Id non nesciunt assumenda consequuntur autem eum aut voluptatem eos omnis est omnis magni omnis quaerat veritatis itaque. Est cumque ratione inventore velit dolores sint excepturi. Numquam ut ut consequatur ducimus et voluptas maiores pariatur nostrum libero perferendis. Assumenda accusantium aliquam inventore tempora praesentium quas corrupti beatae recusandae et qui. Consequatur animi tempora cum ea quisquam aperiam distinctio est dolorem aliquid accusantium eum animi et illum. Et dolores non et ab cupiditate numquam. Officia illo nihil dicta qui enim. Molestiae quia quia quia molestiae culpa alias natus consequatur et officia ullam est et dolores non qui consequatur animi culpa. Reprehenderit voluptatibus perferendis accusamus sunt omnis architecto autem corrupti libero rerum odit totam. Maiores necessitatibus tenetur rerum voluptate sit enim adipisci. Distinctio blanditiis sit eum sit nemo sint delectus voluptatem est recusandae praesentium corporis autem laborum optio. Et earum fugit voluptas incidunt ex deleniti ut eos velit nobis non eum provident et magni itaque. Aspernatur perspiciatis voluptatem optio quis animi aut laudantium dolores voluptatum at quam et aspernatur et accusantium quo dignissimos. Repellat quae corrupti quisquam eius sint dolorum eum consectetur id. Odit autem aut esse voluptas ipsum fugiat quia laborum doloribus commodi quia ad veniam dolorum. Ullam quidem et et quos molestiae molestiae fuga illum quas quod quia. Similique autem quia dolore sit. Aut aut pariatur asperiores vel reiciendis maxime tempore voluptas qui sed. Adipisci recusandae et qui ut est animi dolores sed et. Omnis corporis ea assumenda eius est autem aperiam sed aut esse ab hic et. Natus exercitationem eveniet at tenetur odit doloribus quaerat magni officia. Non placeat atque adipisci in quasi ad occaecati. Libero natus quia ut temporibus quod dolor quidem sint ad totam architecto vel vel harum accusantium adipisci. Autem fugiat laudantium delectus at rerum eaque commodi quia incidunt mollitia id aperiam dolore. Et sed nihil et sunt eum officiis. Libero velit excepturi architecto aliquid et	\N	\N	\N	\N	2013-10-08 13:50:00.021328	2013-10-08 13:50:00.02133	\N	\N	108	\N	\N	\N	\N	\N	\N	\N	\N	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
68	minus	117	3	\N	In qui voluptatibus eum ullam consequuntur dolorum ut id possimus. Et aperiam dolorem perspiciatis hic id sequi aliquam velit facilis quia illo nihil sit. Aut ut accusamus minima reprehenderit assumenda ut exercitationem excepturi. Consequatur et aut atque ut aliquam voluptatum. Amet ut explicabo accusamus nostrum quo id non debitis asperiores aspernatur placeat deserunt consequatur et sit repudiandae rem velit commodi. A quo quam delectus numquam sit repellat dolores ut quis. Ipsa tempora quam neque commodi omnis excepturi aut libero quisquam provident quod dolores sit aut perferendis laudantium amet. Libero beatae debitis officia quod ut pariatur nam aut saepe quia facilis possimus quidem a veniam. Vitae aspernatur sed reprehenderit aut est. Quia sed possimus neque excepturi dolorem ut ipsam ut quisquam sapiente voluptas. Consequatur soluta ut rerum voluptates aliquam qui. A modi eaque et aperiam tempora autem suscipit nisi totam consequatur quidem. Cumque cupiditate aut facilis quas rerum rerum commodi iure. Suscipit alias autem a sed et neque debitis consequatur. Qui culpa ipsum atque ea libero delectus iusto est nisi voluptate in. Culpa vero optio sed optio magnam blanditiis. Id veniam velit sint nulla laudantium officiis hic exercitationem reprehenderit illum ad voluptatum soluta cumque expedita. Magnam quo incidunt sapiente rem ut. Architecto recusandae vitae saepe quia commodi aut reiciendis adipisci omnis voluptatum saepe porro. In nam quae tempore rerum explicabo beatae. Sit ipsum vitae numquam sunt voluptas tempora veritatis dolorum eum ducimus. Sint aperiam est nihil nostrum rerum. Ipsam ipsam et sed omnis ut voluptatum vel nulla quas mollitia maxime iste. Saepe neque sunt ut soluta vitae veniam velit recusandae magni et commodi perferendis mollitia accusantium atque atque incidunt. Quos facilis et provident eos est nesciunt saepe eos tempora quam aut aut modi incidunt vitae iste aliquid nulla modi. Et ut odio aut fuga totam voluptas fuga qui et repudiandae dolor omnis. Cupiditate eum culpa in asperiores nisi rem dolores totam libero fuga ut. Sit excepturi et consequatur omnis sunt eum eos quia perferendis quia voluptates perspiciatis repellat. Libero voluptas aut quaerat optio accusantium aliquid porro nihil. Quaerat architecto fugiat accusantium blanditiis incidunt rerum architecto quas cum sequi incidunt aperiam consequatur ullam doloremque repudiandae quis. Quasi rerum rerum quia consequuntur tempore sunt aut consectetur fugiat eum delectus omnis cumque sed rerum. Quae quo officia similique tempore quae quaerat animi magni officiis autem corrupti consequatur doloribus rerum quis facere reprehenderit temporibus. Vitae eaque et commodi odit debitis nemo	\N	\N	\N	\N	2013-10-08 13:50:00.026805	2013-10-08 13:50:00.026807	\N	\N	108	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
69	sint	104	3	\N	Adipisci aspernatur amet a recusandae aut pariatur neque aliquam quia sed velit sed unde dolor ab expedita distinctio. Saepe laborum nihil voluptas error ex exercitationem est. Et fugiat harum id ad aperiam maiores numquam repellat et sit sequi. Sit quaerat aut ratione quis dolor distinctio veritatis deserunt eaque dolorem consequatur vel veritatis aut a labore explicabo. Est perferendis omnis culpa modi repellendus qui nam odit. Officiis earum quam dolorem placeat vitae sit eligendi. Est possimus delectus tempore eligendi doloribus ab aut temporibus aut corrupti eos modi a. Ut sed ut sed odio esse culpa provident ut cumque expedita. Et cumque aut perspiciatis et animi nisi inventore tenetur vel dolor voluptas repellendus. Consequatur sapiente sunt magni eaque occaecati ut sint unde sint veritatis. Soluta qui aut adipisci dolorem magni id tempora omnis doloremque dolor quo nobis sint. Non impedit odio laudantium deleniti placeat debitis iste tenetur. Tempore eos temporibus quo nemo. Eius soluta quia odio magni perspiciatis nulla placeat doloribus dolorem. Est non iusto veritatis aut aperiam velit tempore quo voluptates sed rerum alias cupiditate doloremque rerum mollitia est. Ut voluptatibus quasi asperiores sit non laboriosam vel dolor. Et ad in est magnam voluptas et. Beatae quia dolores et in qui suscipit rerum ratione maiores. Et quidem quae quisquam voluptatem sunt occaecati autem alias laborum dolore non quam cupiditate. Qui amet dolores et qui quia quo harum assumenda ut et totam a cupiditate a. Dolores est tempora reiciendis dolorum neque unde ut expedita fuga aut delectus velit voluptas quis rerum rerum incidunt a dolores. Possimus aperiam cum magnam aliquid quam unde est et qui eius laudantium velit aut nesciunt quod et explicabo. Et magni sunt repellendus consequuntur voluptate quia in dignissimos neque officiis dolores vero ea repellat numquam. Et veritatis vel vel error a quia assumenda cumque. Mollitia sapiente minus autem eum et accusamus et voluptatem aut aut cumque enim dicta non voluptate occaecati quidem reprehenderit. Laboriosam laborum explicabo non qui adipisci provident cumque labore officia voluptate a eos. Omnis quasi non officiis est autem eius. Velit libero labore commodi adipisci. Provident molestias autem temporibus aspernatur exercitationem dicta est voluptas eveniet recusandae. Impedit dolores iste praesentium unde assumenda nemo et ipsam qui magnam qui saepe soluta officiis cum cupiditate mollitia. Ut dolorum quo neque atque non assumenda facilis. Ex molestias sit molestiae non quidem doloremque consequatur quam voluptatem. Error quis incidunt quia et aut totam repellat quo quas	\N	\N	\N	\N	2013-10-08 13:50:00.031647	2013-10-08 13:50:00.031652	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
70	eum	104	2	\N	Qui enim eum et asperiores excepturi laborum minus odit distinctio ut fuga iure consequatur. Sed ut iusto est nemo molestiae cumque ut sit voluptatum quia non eos. Expedita amet est voluptas ipsa est consequuntur vel asperiores repellendus omnis quis quasi non impedit tempore amet quidem rerum eos. Ut repellendus deserunt ut voluptas provident eligendi laboriosam et iure. Earum assumenda soluta odio recusandae quod nam qui quisquam dolore id repellendus odit reprehenderit nobis asperiores quis. Voluptate vel adipisci porro velit quis et voluptatem unde sapiente. Veritatis autem voluptatem perspiciatis praesentium non qui deserunt aperiam atque magni eaque magni praesentium esse est. Qui suscipit quia illo voluptas quaerat qui explicabo velit ipsam provident. Voluptas quisquam velit voluptatum delectus voluptatum impedit dolorum dolor sequi magnam dolores nihil quo et sit vel consectetur. Ea et sit est reiciendis repudiandae. Nihil adipisci quidem saepe impedit quia eum reiciendis ratione adipisci est est placeat laboriosam nihil magni. Maiores delectus iusto illum dolores aut et aliquid. Modi repellendus vitae ipsam consectetur qui nesciunt. Non itaque aspernatur sequi expedita ut maiores est magnam aliquam ab blanditiis recusandae voluptatem enim. Fugiat quis beatae fugiat laudantium porro molestias sequi est. Doloribus voluptas tenetur illum consectetur facere ea delectus fugiat sed temporibus officiis optio. Voluptas architecto qui possimus dolorem quia non sunt temporibus et sequi qui ut ut quasi ut. Sit ducimus molestiae quas esse corporis dolorum ipsa facilis et. Amet itaque aut rerum et odio nulla. Voluptas esse natus ex earum fuga consequatur. Sunt consequatur ut et reprehenderit non minima. Voluptate numquam voluptatum optio est at distinctio laboriosam optio vel. Dolore consequatur in sed qui totam voluptas architecto tempore excepturi. Voluptas qui sint nesciunt enim rerum placeat sint dolor debitis minus eaque explicabo ipsam quis velit. Ea qui ut ratione nihil fuga autem labore dolores. Laborum soluta sint eum occaecati eos omnis exercitationem qui voluptates dicta nesciunt est assumenda. Iusto rerum sed omnis alias eum. Optio qui dolore et et. Et suscipit natus qui molestiae perspiciatis quo tempora necessitatibus. Debitis quasi eum ea ut fugit voluptas molestiae. At iure quisquam saepe non ut. Deleniti ut vero magnam odit voluptatem iste ipsum asperiores aspernatur et et rerum et quibusdam et saepe quia non. Unde quod ut unde architecto minus non debitis dolorem nobis totam omnis omnis eum ea recusandae amet magnam. Provident id sint quo voluptate accusamus voluptatem quaerat qui alias quis quia omnis fugiat. Et voluptatum rerum magni velit quis inventore nostrum tempora autem dolor. Dicta ipsum quo harum qui in neque incidunt qui praesentium rem nobis nobis eum voluptatem enim itaque. Eius iure excepturi et enim nesciunt soluta quibusdam quo ipsam odio aliquid veniam illo sint dolorum. Voluptas neque quis provident neque iure molestias. Dolor quis non ipsa tempora harum occaecati blanditiis cum dolores reiciendis ratione possimus veniam doloremque architecto. Perspiciatis ut sit odio alias doloribus assumenda cupiditate quia eum non libero illum eaque eaque sunt iste. Molestias tempora et doloremque cum sint molestias delectus tenetur dicta aut facere ut in ut eaque velit. Autem repudiandae quibusdam voluptatem nihil molestiae qui architecto magni voluptate placeat. Impedit consectetur et maxime nesciunt nobis eum reiciendis accusamus fugit est at ea et esse nesciunt rerum ipsum. Placeat esse nihil architecto vel fuga laboriosam laudantium voluptatem quibusdam nobis aut odit facilis ex harum earum. Amet consequatur tempore et qui inventore suscipit distinctio sed cum ipsam ex enim quia sapiente assumenda totam facilis dolor. Totam saepe veritatis ipsum expedita. Alias quod dolor ipsa et. Adipisci necessitatibus iure nihil quasi temporibus repellat quia. Sequi excepturi eveniet a exercitationem	\N	\N	\N	\N	2013-10-08 13:50:00.036357	2013-10-08 13:50:00.036359	\N	\N	103	\N	\N	\N	\N	\N	\N	\N	\N	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
71	qui	116	1	\N	Ad culpa eum ea esse voluptatem sapiente voluptatem quas velit est dolor debitis. Voluptate repellendus vel possimus voluptas. Dolorem dolorem est consequatur quam maiores quasi cum et autem pariatur. Ipsum explicabo aut et molestiae. Soluta laborum deserunt sunt et consectetur ut aut temporibus eveniet voluptatem rerum iste neque optio quam quia. Provident veniam repellat modi facilis dolore atque voluptas rerum ut nobis eveniet fuga corporis unde. Ad repellendus at occaecati et doloremque unde accusantium tempore similique officiis suscipit alias dicta delectus distinctio. Qui ut nostrum ea ab enim doloribus aut quod omnis provident inventore. Aut quae totam et cupiditate quis sed et velit. Rerum est tempore voluptate qui possimus aut porro repudiandae ipsam debitis et in placeat ut incidunt eaque et. Modi ea eligendi veniam qui sunt ut sunt ut. Dicta eum ut sit eos perspiciatis qui doloremque debitis ut. Mollitia eligendi voluptas commodi repudiandae doloremque deleniti ratione et suscipit repellendus rerum voluptatem soluta optio soluta voluptas. Sed et qui rerum rem perspiciatis quo et aliquam incidunt sint excepturi temporibus nulla cupiditate exercitationem ipsa. Ea consequatur fugit aut voluptates et ipsum fuga. Blanditiis velit fugiat occaecati sed repellat quaerat. Ut blanditiis eos delectus laudantium qui. Quam ut asperiores molestiae beatae ipsa et velit ad optio. Consequatur delectus et quia quos dicta sapiente voluptatibus labore iusto in officia sit atque incidunt distinctio culpa. Consequatur qui iure corporis rerum quia minima ut ut saepe voluptatum cupiditate necessitatibus voluptates molestias minima molestiae. Quia minus maiores perferendis vitae qui placeat consequatur et numquam cupiditate ipsam sit commodi qui asperiores ipsum itaque ab quaerat. Voluptatem maxime earum blanditiis perferendis corporis maiores itaque dolor quia praesentium earum perspiciatis et. Ea illum quidem libero velit enim quos voluptas doloribus voluptatem aliquid. Asperiores unde repellendus necessitatibus quia similique deleniti voluptas quo excepturi magnam ipsum et repudiandae amet magni. Sed eum consectetur eveniet deserunt nobis fuga ea dolor ab odit dolores sit libero beatae incidunt sed rerum et sit. Quo quis tempore deleniti eveniet dolores sit sint sequi doloribus reprehenderit consequatur repudiandae quo maxime quis ab cupiditate ad. Corporis beatae fugit autem nulla deleniti ea rerum rerum expedita est unde omnis vitae pariatur. Dolorem sunt aspernatur neque voluptas voluptatum rem quidem illo quia perferendis quisquam officiis aliquam. Error aut mollitia fugiat rerum non culpa enim repellat exercitationem id et aut quaerat officia illum odit sequi nam. Unde cum veritatis aut natus. Expedita illo ullam aspernatur sequi voluptatem neque eveniet esse. At repellat assumenda sunt similique. Soluta molestiae quibusdam esse quod. Magni saepe eum enim ipsum culpa eum veritatis dicta assumenda qui et odio nam iure aperiam perferendis fugit dolore totam. Tempore et praesentium laboriosam non quidem libero dolorem sed odio eaque qui deleniti nesciunt et dolorem qui. Iste inventore ut est maiores et quidem ut est ut quos consequatur ut ut in fuga tempore rerum facilis. Est doloribus rerum et quo qui enim ea dolore fugit quas earum id quidem molestiae sequi asperiores. Eveniet sit totam dolorum nostrum soluta natus ullam animi quia ea sunt eveniet. Assumenda culpa quis voluptate inventore aspernatur at quibusdam veniam repudiandae eligendi laborum molestias ab. Dolor sit provident culpa ipsam magni sint et commodi earum aperiam sunt expedita magni modi hic vero aperiam. Numquam quod doloribus sint deleniti aliquam. Iusto et tempora provident voluptatem nemo nisi dolore non qui	\N	\N	\N	\N	2013-10-08 13:50:00.041101	2013-10-08 13:50:00.041103	\N	\N	109	\N	\N	\N	\N	\N	\N	\N	\N	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
72	qui	104	4	\N	Voluptatem aspernatur vel voluptatibus cupiditate illo quam beatae commodi veritatis est id dolore rerum. Accusantium dolorum earum ipsam nulla dolorem rem distinctio. Nulla quos culpa suscipit voluptate ad molestiae sunt ut. Sed illo distinctio architecto eum necessitatibus omnis molestiae odio eius assumenda. Ab aut excepturi iste sit odio aut rerum qui dolor neque et numquam minima voluptas. Laudantium rerum non debitis nemo. Dolor ut dolorem ea nulla aliquid id. Illum laboriosam eaque doloribus voluptas cupiditate. Beatae maiores quis eaque officia exercitationem incidunt laborum distinctio expedita corrupti consequatur quis impedit nisi est esse eum. Nemo et repudiandae et libero sint qui ea sint cum minus sunt. Eos doloribus accusantium aut voluptas vel sint in autem et maiores maxime qui facilis. Quis dolor culpa eligendi deleniti et ipsam laborum quas enim voluptas corporis eos nostrum. Nihil enim corrupti culpa est maiores assumenda neque omnis suscipit molestiae fuga explicabo voluptatem fugit fugit deserunt atque cum officia. Qui soluta id labore aut quas nostrum tempore qui ipsa dolorem officia id fugiat. Quae a culpa tenetur qui dolores. Quasi qui iusto et inventore veniam perferendis iste id. Ut occaecati vel harum esse eum et esse iure ut. Ea voluptas temporibus sint voluptas quisquam omnis qui ut consequatur. Nulla eum nihil tempore debitis nam quia. Et temporibus facere et est. Exercitationem aut consequuntur similique repudiandae velit ea voluptatem voluptate et sed vitae fugit voluptatem. Ea odio deserunt dignissimos sint voluptas excepturi sit exercitationem. Harum quia vitae suscipit deserunt labore corrupti. Assumenda consequatur vel libero qui necessitatibus. Aut recusandae reprehenderit esse facilis qui accusantium earum corrupti incidunt neque voluptatem aut libero libero aspernatur qui dolores pariatur eligendi. Voluptate velit omnis perferendis aperiam sunt est maiores consectetur qui maiores voluptatem ea. Alias molestiae soluta aperiam rerum nam itaque est impedit. Ea eius possimus dolor et ut sed. Qui nemo in vitae distinctio. Voluptatem sint inventore alias eaque maiores esse dolor accusamus voluptatem alias pariatur. Et quia vitae occaecati provident esse nisi ab ut aut ut. Ut voluptas quaerat ullam tempore porro sed sed qui. Nisi voluptates nihil et aut. Iure sed unde dignissimos voluptatem sequi qui atque magnam pariatur aut inventore voluptatem qui iure qui suscipit placeat. Minus ratione ipsa officia doloribus qui autem. Minima eos aut iusto eum dolore assumenda incidunt quasi veritatis unde ut sed minima. Magni vel voluptatem laudantium pariatur corporis illo aut porro architecto. Eaque soluta est optio delectus explicabo dolorem	\N	\N	\N	\N	2013-10-08 13:50:00.045824	2013-10-08 13:50:00.045826	\N	\N	113	\N	\N	\N	\N	\N	\N	\N	\N	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
73	similique	106	3	\N	Ullam iusto autem iusto libero quibusdam est corporis aut. Et incidunt labore tempora eos officia quos impedit ut iusto sunt placeat laborum numquam saepe magnam modi. Qui quo dolorem praesentium aut molestias harum aut cum numquam consequatur maiores. Labore ullam exercitationem atque corporis neque animi ad perferendis quas distinctio voluptas optio maxime animi atque similique qui rerum sunt. Culpa id similique debitis vitae nulla incidunt unde et voluptatum vel impedit porro non rem natus porro unde ipsa. Natus quia amet facilis voluptatibus sunt deserunt ut dolores vero harum qui tempore aperiam ducimus. Aut voluptatum expedita officia eos. Velit porro quas eaque et voluptates vel quia architecto nulla dicta. Eius quis et ad velit et animi eius tenetur doloremque quia illum placeat iusto reiciendis et quis. Laudantium corporis deleniti perspiciatis vitae reprehenderit sequi dolores possimus maiores et quae id aut aliquam voluptatem eos aut ad. Dolorum cum laudantium voluptatum corrupti mollitia omnis ut eveniet doloribus sapiente soluta omnis et at facilis nihil vitae consequuntur beatae. Quod ducimus facere sequi facere non autem sapiente eius ut aut debitis commodi adipisci suscipit aliquid hic. Provident itaque tempore nostrum repellat quia qui quo vero repudiandae odio fugiat sunt aliquid ea voluptas. Nulla sapiente blanditiis molestiae nulla quis ipsam odit facilis minus in provident itaque architecto est natus qui. Eos temporibus sit aspernatur quod quo velit voluptas vero explicabo ratione incidunt omnis. Non minus non sint ea ut dolore ipsa deserunt magni doloremque corrupti eveniet laudantium autem. Et aut sit quaerat dolore corrupti quisquam aut quos sint sequi nihil doloremque. Ut enim excepturi voluptatem culpa aliquam laboriosam non veniam repellat quia nam id in veniam dolores. Velit qui corrupti dolore vero ea molestias dolore nihil quis perspiciatis adipisci similique est minima optio pariatur in et. Aut ab aut quam et expedita omnis ut illo est sunt quos commodi saepe consectetur quis consequatur repellendus. Qui sunt quia necessitatibus assumenda aliquid molestiae repudiandae nostrum laboriosam. Nulla assumenda quidem fugit cum architecto nemo aperiam ipsum praesentium soluta rem. Sit autem eos laboriosam voluptatibus deleniti voluptas illo et unde voluptatibus neque dolorem eveniet voluptatibus reprehenderit. Nisi est qui qui sunt dolore temporibus quisquam qui ad. Et culpa magni totam autem dolorum qui reprehenderit nam suscipit est qui esse praesentium ab eum eos ut magnam quia. Omnis exercitationem est maxime cupiditate ut. Officia sit quae officia nobis aut numquam eos atque doloribus omnis sunt vel in tenetur ut voluptatem nobis ipsum cupiditate. Id molestiae commodi quasi quia earum veniam voluptas qui error dicta veniam natus itaque molestiae sed qui eius vero. Tempora at voluptatem officia nam doloremque ipsam eligendi asperiores et consequuntur praesentium odit aut. Nihil doloremque aut sit atque sint iste hic rerum aut esse magnam occaecati dolor. Porro et nemo voluptates vitae iusto est excepturi. Nulla eligendi itaque voluptate quo quam neque consequatur eius. Suscipit doloribus nisi illum aut sed et quisquam praesentium beatae tenetur sed dolore. Delectus non neque rerum adipisci molestiae et inventore quas quam dolores amet adipisci error deserunt eaque beatae quas repellendus id. Sunt pariatur iste voluptatum et facilis sint et deserunt et voluptatum hic et quaerat id. Sunt nihil similique et harum eum ad officia odio libero repellendus quia quae itaque libero qui et quidem qui minima. Voluptate iusto eius iure fugiat. Dolor delectus commodi et veniam nesciunt et possimus nihil dolorem earum. Culpa ut ut esse dolorem similique et debitis quibusdam rerum beatae quia hic molestiae quia animi soluta. Natus consectetur et consectetur quae dolor perspiciatis maxime officia eius optio dolorem neque. Eos debitis impedit similique perferendis velit recusandae. Accusantium sunt adipisci veritatis et assumenda aliquam sit modi tempore ut ad. Earum facere quos est magni. Necessitatibus aliquam illo ut officia sint commodi aut illum dolores quisquam itaque modi maiores consequuntur omnis. Rerum velit ut dolorum vero ut. Optio eos rerum possimus dignissimos quis quae in ullam minima porro reiciendis porro quis cupiditate consequatur deleniti nisi architecto ut. Illo ut non necessitatibus accusamus labore quaerat qui quia ad delectus a aut ut et aut quia voluptatum et eum. Labore hic et consequatur explicabo et veniam necessitatibus quo id quod. Vitae pariatur non ratione ut eum quaerat ducimus maxime velit eligendi numquam laudantium voluptatem repellat maxime libero in delectus ut. Nemo et minima minima et eius sunt quo laudantium officiis aliquid qui consequatur nostrum nostrum debitis	\N	\N	\N	\N	2013-10-08 13:50:00.050737	2013-10-08 13:50:00.050739	\N	\N	112	\N	\N	\N	\N	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
74	voluptas	106	4	\N	Repellat voluptatem qui cum voluptatem error quod totam repudiandae distinctio voluptatem qui laboriosam soluta aut quisquam sit ratione voluptatem. Optio voluptatem molestias consequatur facilis ratione placeat iste sunt quisquam. Aliquid molestias rerum est non possimus atque soluta voluptate laboriosam dolore hic. Sit dignissimos sint expedita quasi iusto quo reprehenderit vel recusandae assumenda et iste quas rem qui eos. Dolores laborum tenetur a voluptas repellat maiores occaecati non dolor. Tempore corrupti excepturi voluptatem similique voluptatem hic et tempora veniam est consequatur esse perferendis nobis maiores recusandae qui eos commodi. Dicta molestiae voluptas nisi fugiat molestias in omnis quas nihil facilis ullam ut ut numquam esse quis sunt dolore. Perferendis perspiciatis illo eos officia. Iure qui odio soluta deleniti aut incidunt voluptatem commodi aperiam quis voluptas dicta fuga magni cum. Sint cum amet minus quae ratione cumque provident nisi deserunt ut repellat inventore. Eveniet sit quisquam consequatur illo cum aliquid quibusdam necessitatibus aut molestias saepe reiciendis sed rem sint. Consequuntur perferendis quo non neque cumque laudantium ut neque sit consectetur et fugiat qui harum id quibusdam incidunt nemo. Laboriosam molestiae aut temporibus dolorum tempora porro quia totam est dolor possimus aut aut ducimus at quae ab quaerat quae. Quia accusamus sit et fuga distinctio et quis pariatur error deserunt dolorem eaque velit suscipit et in iusto omnis iure. Quam tempore ipsa laborum beatae voluptatem exercitationem sunt quisquam enim rem qui sit alias. Id asperiores atque rerum expedita autem soluta adipisci distinctio similique placeat dolor et. Voluptatum neque quae suscipit veritatis ut voluptas fugit nihil ipsam quidem iure aliquam laboriosam. Nihil nostrum in magni natus est minus et ad sunt quisquam similique ducimus tempora quasi quasi labore. Eius quia blanditiis cum aut praesentium id fugiat quibusdam a repudiandae fugiat. Omnis voluptatem illum et voluptatem soluta ducimus pariatur. Aspernatur possimus laudantium tenetur et molestias ipsa voluptatem animi quo dicta voluptatem qui id ut aspernatur numquam reprehenderit. Qui veritatis facilis doloremque vero voluptatem inventore neque id non voluptatem consequatur est officiis consequatur. Veniam itaque ut quae quia modi quia corporis dolor natus molestias iste voluptates delectus quibusdam quaerat debitis. Et modi tempora molestiae excepturi iure dolorem amet quia libero magnam voluptatibus provident assumenda qui ut nobis. Autem fuga qui doloremque molestiae optio voluptatem ut voluptatem consequatur qui est veritatis in occaecati asperiores pariatur architecto molestiae. Adipisci facere occaecati quos voluptatem nostrum nobis dolor eaque dignissimos. Facere sed repellendus aspernatur dolores error. Totam id et vel iste omnis corrupti sit eos ex labore sunt itaque voluptate atque aut praesentium. Modi similique nisi occaecati saepe animi delectus accusamus neque est exercitationem reiciendis sint culpa earum illo labore vero maxime. Fugiat molestias qui non consequatur qui sit nobis non. Aut nam maxime officiis rem. Ut architecto minima libero mollitia qui pariatur impedit nam mollitia. Accusantium autem quam libero distinctio ipsa cupiditate assumenda neque iste deleniti quidem rerum quas omnis at neque nesciunt. Nihil et vero sit mollitia quaerat nam perspiciatis rerum quia ut. Repellat impedit facilis voluptas quia in inventore. Voluptas nostrum dignissimos earum vel autem perferendis ad omnis voluptatem non occaecati omnis optio quia non vitae quia numquam. Qui temporibus reprehenderit voluptatem ut ea aperiam voluptatibus. Ut quo delectus cum sunt incidunt. Et illum sit rerum explicabo quibusdam et	\N	\N	\N	\N	2013-10-08 13:50:00.055944	2013-10-08 13:50:00.055946	\N	\N	106	\N	\N	\N	\N	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
75	autem	116	2	\N	Sed soluta veniam quibusdam vero harum delectus rerum laborum voluptates. Aut sit autem enim mollitia eum sint et assumenda illum quia numquam eius dignissimos saepe. Explicabo dolorem et quo non ut temporibus sed laudantium earum est laudantium modi officia quibusdam expedita blanditiis saepe. Aspernatur laboriosam quis aut odit commodi aut at necessitatibus. Ex officia labore molestiae fugit eaque sequi accusamus explicabo impedit veniam. Consequatur accusamus commodi dolorem non. Dolores expedita voluptatum sed et voluptate. Vitae animi alias sunt et hic eaque et est nostrum ut similique vero eveniet. Sapiente possimus quis animi odio nesciunt commodi ut est nam. Assumenda laborum in sequi sed rerum eum esse perspiciatis illum modi atque et mollitia. Non fuga dolores et nulla maxime asperiores ipsum aliquid id consequatur molestiae laboriosam sit hic aut quo. Error et qui fugiat dolorem accusamus dolor exercitationem incidunt voluptatem qui cum voluptatem temporibus eum molestiae aliquam. Ut error tempore corporis harum tempora atque incidunt praesentium ipsa occaecati dolor corporis porro voluptatum ut. Distinctio nemo numquam iure reiciendis praesentium occaecati consequatur reprehenderit. Placeat adipisci quo neque aliquid laboriosam rem saepe natus ex nisi iste consequatur tempora culpa optio vel sit vel. Vel velit quasi distinctio iure neque exercitationem fuga architecto sit et a quasi qui expedita quisquam. Non architecto rerum non vitae. Perspiciatis officiis temporibus eos natus et non molestiae et est expedita qui eos dolor recusandae et omnis. Autem laborum praesentium itaque rem enim velit nam reiciendis autem ut quia architecto consequatur voluptatem vero quia. Aperiam quod quia cum architecto in harum cum ad est ab nisi molestiae soluta aliquid sit non quia. Pariatur aliquam et reprehenderit sed quis et autem eius necessitatibus dolorem corrupti. Vitae eos asperiores ut officia ea eos sunt eligendi. Voluptatum in optio id excepturi quia beatae et. A minima qui nostrum recusandae aut et ea doloremque repellendus laboriosam sequi at sint commodi maxime omnis soluta. Sint quo sunt quo reiciendis et dolorem ut nisi ut illo delectus non rerum corrupti error odit. Et eum totam aut blanditiis nihil incidunt quas repellat non deserunt saepe harum libero eum sed tempore maxime. Quis fugit vero sed eum ipsum voluptatem laborum dolorem quia. Saepe et et ipsa voluptas ut rerum omnis error deserunt totam. Quis cupiditate at adipisci delectus sit et maxime laudantium nesciunt ut dolor aut qui ut vel ut voluptates. Aspernatur quis facere qui veritatis maxime sint omnis nostrum qui aliquid corporis officiis sapiente illum fugiat ut quidem libero corrupti. Laudantium totam ipsa ducimus facere aliquid. Fuga voluptas eos repellendus dolore maiores et illum quia nulla animi dolorum illum voluptas vel repellendus mollitia distinctio animi eius. Et recusandae natus veniam alias recusandae sint voluptatibus praesentium vel nostrum et ea officiis expedita. Blanditiis officiis corporis eius dolores odit repellat quas quas animi ut. Aut perspiciatis molestiae hic voluptatibus omnis est quaerat accusantium quae. Autem consectetur eos consectetur est maxime ea eius beatae	\N	\N	\N	\N	2013-10-08 13:50:00.060859	2013-10-08 13:50:00.060861	\N	\N	105	\N	\N	\N	\N	\N	\N	\N	\N	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
76	dolorem	116	3	\N	Repellat tempore deleniti dicta aliquid illo totam. Temporibus nobis fuga perferendis modi reiciendis distinctio qui aut quis corrupti temporibus illo vero non velit et numquam autem. Eius quia error ut iste voluptatibus cum saepe illo et nostrum rerum omnis repellat. Odit eos qui expedita eius placeat dolor occaecati voluptas sint. Unde facilis deleniti quidem ipsa possimus facilis. Illo praesentium quia dolorum dolor mollitia occaecati modi fuga minima. Voluptas libero aut unde quod. Debitis aut ut fuga placeat numquam. Debitis tenetur aut et occaecati illum ut atque sequi cum in animi modi. Et ut vel soluta reiciendis quos repellat pariatur odio iure itaque sit assumenda. Placeat excepturi similique suscipit esse aut in. Ea aut quod ad est qui velit ratione id eaque expedita et tempora. Vel vitae accusantium quas rerum qui non facere recusandae quaerat voluptatem quos quas adipisci ut eos ipsa nihil. Velit recusandae quia velit esse numquam est nulla a tempore aliquam eligendi assumenda facilis quidem. Aut assumenda consequatur ipsum nobis excepturi ad nobis modi delectus eius dicta explicabo inventore qui blanditiis autem id ad. Reprehenderit animi numquam nam earum hic cupiditate ex. Sint rerum sequi sint quis autem dolorem ea accusantium laboriosam molestias eum consequatur rerum nesciunt. Qui officiis laborum velit delectus voluptatem cupiditate delectus consequatur perferendis eius ea nobis. Mollitia inventore fuga in ut dolore aspernatur iusto exercitationem sed. Ab quo dolores quas natus repudiandae ipsa facilis consequatur nemo veniam blanditiis unde doloribus quidem vel. Omnis ducimus reiciendis quis recusandae. Veritatis nisi nemo et molestiae nam perferendis iste quis debitis. Mollitia reiciendis sed provident voluptatem facere earum natus autem impedit beatae quaerat sed quo. Et fuga est ut et repudiandae asperiores aspernatur. Dolorem nihil et molestiae ipsam cumque aut esse ullam ea ut distinctio esse ut et et quia odio adipisci. Similique repellendus est voluptatem quam non blanditiis pariatur incidunt est. Laudantium dolore amet et et ab sint atque sit atque et dolores sed hic ea nostrum vero. Omnis rem deserunt accusamus at dolores quo qui doloribus et veniam molestiae repudiandae eum mollitia aliquid ex qui similique. Esse nihil iure perferendis et corporis aut quas quibusdam repellat adipisci eius recusandae deserunt esse. Occaecati odit et laudantium iste cumque nobis saepe distinctio reprehenderit alias. Molestias rerum veniam explicabo et mollitia autem autem. Consectetur ratione reiciendis dicta est non et expedita eum culpa alias dolores sed aliquam eos eaque ullam eum. Qui cum omnis quis ducimus dolore fugit voluptates vero et cupiditate cupiditate. Architecto quos animi id unde unde qui quibusdam et ullam optio velit voluptatem. Qui placeat vel voluptatem odit suscipit odit molestiae fugit doloribus ipsa tenetur sapiente necessitatibus nam sint magni qui occaecati. Et incidunt ut reiciendis officia voluptate dolorem placeat ut. Occaecati ut dolorem nam aperiam et qui. Aliquam quisquam aut culpa in laboriosam qui et necessitatibus dolore blanditiis vel	\N	\N	\N	\N	2013-10-08 13:50:00.066123	2013-10-08 13:50:00.066125	\N	\N	116	\N	\N	\N	\N	\N	\N	\N	\N	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
77	suscipit	106	3	\N	Est neque eius quo reiciendis facere quis. Consequatur eius omnis soluta voluptas vero cupiditate adipisci officia et. Similique nostrum sunt dolor cum facere blanditiis tenetur eius. Atque similique similique fugit labore aut autem accusantium rem accusantium placeat sed aperiam repellendus dolores quia. Officia autem accusantium est nihil. Aliquid accusamus consequuntur fugiat unde a blanditiis. Et eveniet non aliquam labore qui quia molestiae enim fugiat aperiam debitis non saepe vero non quasi. Sunt illum dolore fuga qui. Fuga porro qui velit repellat. Ad rerum et et deleniti nisi qui. Id excepturi velit perspiciatis commodi magni consequuntur. Accusamus sequi veritatis corrupti beatae amet enim architecto modi hic. Aut repellendus quas vero sed quia eos inventore ex quas vel inventore ea odio voluptatem sunt ea sint hic. Est error consequatur distinctio voluptatibus culpa laudantium asperiores tempore vero ut. In nulla libero officiis error quas exercitationem quasi perferendis quasi commodi quia eum dolor perspiciatis dolores voluptates ducimus eius non. Beatae officiis atque et impedit voluptatem aut quasi officia sapiente. Quod magni est consequatur quo aut nemo minus consequatur similique adipisci quod magni minus sit rerum. Quasi rerum ipsum qui dolor eligendi et facilis tempore eveniet nemo fuga. Quos quis quos incidunt reiciendis expedita illo ullam consequuntur voluptas quibusdam sint dolor molestias. Perferendis repellat autem ducimus aperiam enim. In et rerum perspiciatis amet. Quod veniam culpa optio aliquid quo eaque aut cum nam cumque omnis eius deleniti. Repellendus aut quis tenetur dolores facere corrupti eos tempore quia perferendis voluptas est est aut ut eum modi in. Et nemo id omnis totam harum id adipisci. Adipisci est minus qui necessitatibus inventore exercitationem possimus et placeat. Sint id eligendi libero doloremque ea laborum minima nulla sed et nihil iure qui sit ipsa accusamus tenetur. Aut nihil esse dolorem nemo quasi eos qui enim veritatis modi voluptas corporis magni unde odit. Eveniet atque aspernatur voluptatibus aspernatur est quidem neque iure. Odio quos vel est id possimus sint quos officia possimus occaecati. Unde repellat maiores exercitationem quasi quidem facilis inventore praesentium corrupti vitae voluptatibus voluptatibus vel totam minima maxime odio saepe nobis. Laboriosam perferendis pariatur saepe ut qui quo enim est ipsa. Est atque explicabo dolorem similique temporibus deleniti doloremque consectetur et nisi molestiae et. Necessitatibus dolor velit dolor velit nam accusamus debitis in temporibus repellendus molestias dignissimos est eos. Sed voluptas corporis quaerat sequi enim qui qui vero non est quo blanditiis totam aliquam illum tenetur neque ducimus doloribus. Quo maiores consequatur rerum earum sequi. Nostrum delectus inventore amet nobis ut deserunt commodi voluptatem minus reiciendis repudiandae doloremque. Aut ipsam ex quia totam aliquam est	\N	\N	\N	\N	2013-10-08 13:50:00.070926	2013-10-08 13:50:00.070928	\N	\N	108	\N	\N	\N	\N	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
78	magni	106	4	\N	Soluta ad dolorem sint asperiores magnam recusandae dolor voluptas aut aut sint eveniet quo voluptatem quibusdam velit pariatur. Non molestiae molestiae accusamus voluptatem repudiandae. Nihil sunt nulla animi voluptas aut repellat magni doloremque. Eaque dolor adipisci et est et consequuntur. Iusto possimus explicabo temporibus harum optio esse quis reprehenderit quae eligendi mollitia itaque voluptatem deserunt voluptas. Deleniti magnam perferendis cum vero expedita. Laudantium quae numquam itaque id sed in rerum. Qui et sed magni ipsam occaecati amet. Voluptas omnis nesciunt quia itaque fugiat iste ipsum. Quaerat ut asperiores quo ab aspernatur inventore aut reprehenderit quis quia. Est cumque qui consectetur ut dignissimos eius distinctio vero amet. Est mollitia pariatur mollitia inventore voluptatem tenetur optio enim modi harum a rerum dolorem accusamus aperiam distinctio laudantium molestiae. Quod occaecati error minima aut sed ut pariatur veniam quia iusto non nisi accusantium velit. Culpa quia assumenda omnis dolores voluptas accusamus aut voluptates ipsum nemo ut numquam laudantium temporibus nisi magni eveniet voluptas. Eum eos repudiandae iure quisquam ut et tenetur suscipit numquam recusandae et. Natus voluptatem veniam sit aut officia et. Sint dolorem aspernatur totam distinctio eos rerum qui eos soluta recusandae quia exercitationem repellat molestiae. Et aliquid ut enim atque quaerat autem doloremque et. Aut earum aut blanditiis recusandae itaque voluptatem aut quo non in a et consequatur. Maiores repudiandae rerum nihil quod sunt consequatur non ut et ipsam est voluptate placeat iste dolorem omnis. Non natus consequatur a sint rerum ut. Cumque incidunt ut asperiores eveniet quas magni velit. Cum fugit iusto id ut voluptas voluptatem autem sint ut dolorem expedita aut fugiat at facilis in non. Animi quia voluptatem alias hic harum officiis id est deserunt. Iure unde labore rerum sed est repellendus sed quam officiis consectetur et rerum assumenda officiis ratione nemo vero. Rem at dicta ratione et dolore itaque molestiae nulla recusandae hic ut a consequatur quas et. Accusamus voluptatem est atque sint repellendus ut explicabo officia praesentium rerum iste reiciendis delectus explicabo vero cupiditate facere perferendis quo. Iusto delectus est cupiditate tempore iste iure tempora sint aut eveniet exercitationem ut expedita quidem culpa quisquam. Eos facere quasi inventore in. Repudiandae dolorem blanditiis id quo aliquam doloribus et perferendis excepturi qui ratione ducimus modi eligendi. Numquam fugit commodi itaque quo et autem et perferendis sed. Odit maiores tempora laborum repellendus delectus labore et voluptatem beatae laborum voluptatum nihil aperiam aliquam autem unde dolore sunt. Qui excepturi ea vitae rerum architecto culpa quas dolore repellat et magnam dolorum dolorem porro rerum quis error inventore sunt. Omnis est commodi ratione est. Quasi tenetur omnis est possimus praesentium. Qui ab aperiam cumque vero repudiandae nostrum voluptates qui laborum quis dolor quas aspernatur consequatur repellendus. Perferendis eum illo labore consequatur nulla quos ad in sit cupiditate. Unde non quasi rerum dolorem nobis quia ut vel nobis quidem optio beatae maiores. Ut et temporibus laudantium commodi doloremque totam facilis delectus minima esse id velit ipsa nesciunt omnis cupiditate et. Eligendi sed laboriosam enim minima aut beatae tempore voluptatem nihil rerum. Vel dolor voluptas sint dolorem et placeat vel commodi facilis tempora in. Consequuntur cum est quidem ducimus voluptatum quasi assumenda quaerat voluptas quo quasi vitae quasi enim repellat nulla quos sunt. A eveniet enim velit dolorum possimus amet nisi molestiae quia incidunt aspernatur eum accusantium incidunt quibusdam	\N	\N	\N	\N	2013-10-08 13:50:00.075549	2013-10-08 13:50:00.075551	\N	\N	117	\N	\N	\N	\N	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
79	dolore	106	1	\N	Quis doloremque harum laboriosam accusamus doloremque qui quos veritatis ex vel nobis dolorem fuga. Cum veritatis voluptas inventore quis et id ipsum ducimus unde consequatur cupiditate ea ea sint dolore et et consequuntur. Et voluptates omnis animi et quod accusantium iure alias modi at saepe fugiat perferendis possimus vitae velit est est est. Qui libero dolorem ullam quidem sit sunt harum. Necessitatibus et alias quibusdam omnis sit eum suscipit vero fugiat non ad consequuntur quod inventore facere sunt facere. Omnis hic veniam qui unde natus ratione ipsum vitae et. Voluptates placeat delectus autem ut ullam vel laboriosam nobis omnis recusandae dolorem occaecati sed culpa sint et. Hic maxime dolore voluptatem explicabo numquam laboriosam amet libero unde libero nostrum ut eum non aut vel pariatur. Qui sed enim dolorem consequatur blanditiis. Repudiandae neque deserunt velit veniam quo quia libero perferendis ad aut consectetur est blanditiis porro autem quas assumenda consequatur. Nulla aut deserunt deserunt et accusantium at consequatur aut blanditiis molestiae similique dicta cupiditate. Consequatur vero quo ea qui ea ut maxime blanditiis modi ratione dolor temporibus itaque nihil hic et vel perspiciatis aliquid. Vel voluptatem hic aut sunt modi doloribus. Modi provident aut similique dolor ad ipsa accusamus ratione nobis ea reprehenderit et molestiae. Iure soluta repellendus eligendi illum molestiae incidunt et vero. Voluptas quam quia rerum ad fuga doloribus optio est accusantium. Eligendi repudiandae labore iure reiciendis totam aspernatur omnis id consequatur nulla. Ut cupiditate ut molestias tempore veritatis omnis et ipsa quos velit. Et rerum quas eius minima nobis voluptatem aut nam voluptatem voluptas deserunt hic quos laudantium quis eius. Quia ducimus omnis eos totam aut ratione ut voluptate laborum et est nobis quos. Ut modi architecto fuga qui nulla deserunt mollitia expedita nihil necessitatibus reiciendis corporis provident laudantium temporibus. Maxime quod molestiae dolorem magnam ut voluptate ut earum enim repellat quia natus veniam quae minima non. Dolores molestiae id cupiditate ad debitis id. Et sunt quo nam quis quam. Autem adipisci provident labore molestiae nesciunt enim. Quas neque cum eos dolore sunt laborum distinctio illo reprehenderit asperiores autem eveniet culpa. Praesentium ex aperiam pariatur nobis dolor voluptatem laborum est explicabo voluptatem velit voluptatem in est debitis dolor quidem. Consequatur est voluptatem praesentium quasi sit sunt ipsum beatae nesciunt pariatur qui consectetur exercitationem itaque et totam praesentium laudantium laudantium. Fugiat voluptatem delectus impedit rerum tempora et velit delectus incidunt quia. Tempora delectus porro occaecati ipsum atque ad. Quia fuga impedit voluptates voluptates sit et sunt animi quibusdam aut iusto ut illo debitis. Aliquam itaque ea ex molestias eligendi maiores quaerat eaque. Occaecati eaque aliquam doloribus minus autem quia possimus in consequuntur error repellendus et id. Quia id eveniet nihil cum est et fugit ut molestiae et enim molestiae ipsum blanditiis at cupiditate. Doloribus et aut eaque ad nihil vero assumenda aspernatur error voluptatibus explicabo sit. Recusandae qui exercitationem doloribus rerum nobis omnis molestiae totam rem. Voluptas perferendis sunt error ducimus molestiae ut quia accusamus eveniet aut voluptate ex facere. Iure commodi pariatur adipisci explicabo et vitae. Corrupti doloribus ut enim labore et maxime ipsam expedita aspernatur animi saepe est dolorum ut illum sint officiis aut fuga. Consectetur est numquam reprehenderit qui qui ex placeat ipsum quia non voluptatem consectetur et reprehenderit minus	\N	\N	\N	\N	2013-10-08 13:50:00.080334	2013-10-08 13:50:00.080336	\N	\N	107	\N	\N	\N	\N	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
80	voluptas	117	4	\N	Repudiandae et quia commodi voluptatem earum corporis sit vel quos inventore velit maiores et id. Quidem quae excepturi sint dolores maxime. Exercitationem maiores ipsam dolor id reprehenderit accusantium et ad mollitia voluptatum. Voluptatem qui molestiae esse quo. Assumenda eum itaque alias necessitatibus beatae quis et accusamus doloribus omnis incidunt voluptatem nihil ut. Et eos nihil unde in ut. Accusantium sit facere qui quia et accusantium. Eligendi velit et quia similique recusandae ut assumenda sit culpa voluptas est nam aliquid. Distinctio inventore est sequi non officiis distinctio aspernatur qui. Est voluptatibus rerum nesciunt optio facere dolorem soluta modi est quod ad. Autem in repellendus quia et dolore. Et ipsum delectus molestiae sed ipsa dolorem commodi. Eum fugit maxime ut quia iure. Aut ab eveniet in consectetur beatae delectus adipisci voluptate aspernatur autem harum saepe quidem ad modi id et. Nihil officiis doloremque consequatur eligendi distinctio aperiam repudiandae vero animi ab voluptatibus dolores nemo excepturi sint dolor veritatis. Aut totam eius hic deleniti vel sapiente hic ut temporibus repellendus labore perferendis distinctio magnam distinctio et sunt. Perspiciatis et illum qui ut blanditiis explicabo. Eligendi quo cumque qui ut quam optio amet omnis rerum odit tempore nihil. Laudantium reprehenderit ut impedit eum ipsum officiis quas consequuntur qui quisquam inventore et dolorum. Assumenda ut voluptatibus nam blanditiis quo. Perspiciatis nihil autem eius porro ut dolores aut ea iusto a veritatis. Velit facilis et eos magni. Possimus consequatur nesciunt tenetur voluptatem suscipit et totam ab cum ducimus voluptas a placeat. Explicabo aliquid qui maiores omnis consequuntur. Laboriosam maxime voluptatem earum laudantium unde ut aut blanditiis tempora dolores qui sed est facilis ipsum. Laboriosam animi et deleniti eos eaque quisquam ex consequatur et. Alias deleniti placeat beatae voluptatem aspernatur consequatur. Sed id corporis asperiores asperiores atque ut ut tempore autem. Molestiae eaque molestias eaque quo rerum omnis perspiciatis consequatur velit. Consequatur ut facilis aut sequi sit error tempora repellendus ea aut et quisquam nobis eos incidunt. Et ut tempore nulla qui rerum sed quia consectetur sit aut laborum ratione deserunt at qui et. Assumenda qui error dolores quis veniam similique dolorum dolore aut. Cupiditate perspiciatis atque ut accusantium tempore asperiores est impedit reprehenderit repellat vero. Beatae aliquid culpa iure quam. Consequatur sed natus sed alias et ratione voluptatum voluptatem soluta unde consectetur tempore atque dolore officiis adipisci tempore consequatur	\N	\N	\N	\N	2013-10-08 13:50:00.085394	2013-10-08 13:50:00.085395	\N	\N	117	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Name: documents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: babrovka
--

SELECT pg_catalog.setval('documents_id_seq', 80, true);


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: babrovka
--

COPY groups (id, title, created_at, updated_at) FROM stdin;
1	Администратор САКЭ	2013-09-10 11:10:42.519143	2013-09-10 11:10:42.519143
2	Создавать заявку на пропуск	2013-09-10 11:38:01.378789	2013-09-10 11:38:01.378789
3	Утверждать пропуска	2013-09-10 14:17:48.897351	2013-09-10 14:17:48.897351
4	Выпускать пропуска	2013-09-10 14:17:55.740287	2013-09-10 14:17:55.740287
5	Выдавать пропуска	2013-09-10 14:18:02.329128	2013-09-10 14:18:02.329128
6	Согласовывать письма	2013-09-18 14:35:03.898833	2013-09-18 14:35:03.898833
\.


--
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: babrovka
--

SELECT pg_catalog.setval('groups_id_seq', 6, true);


--
-- Data for Name: open_notices; Type: TABLE DATA; Schema: public; Owner: babrovka
--

COPY open_notices (id, document_id, user_id, created_at, updated_at) FROM stdin;
1	38	4	2013-10-03 10:22:50.200293	2013-10-03 10:22:50.200293
2	38	2	2013-10-03 10:22:50.204758	2013-10-03 10:22:50.204758
3	38	5	2013-10-03 10:22:50.207153	2013-10-03 10:22:50.207153
\.


--
-- Name: open_notices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: babrovka
--

SELECT pg_catalog.setval('open_notices_id_seq', 3, true);


--
-- Data for Name: organizations; Type: TABLE DATA; Schema: public; Owner: babrovka
--

COPY organizations (id, title, parent_id, lft, rgt, created_at, updated_at, logo_file_name, logo_content_type, logo_file_size, logo_updated_at, address, phone, mail, director_id) FROM stdin;
1	eum	\N	\N	\N	2013-10-08 13:29:33.070906	2013-10-08 13:29:33.652029	Blain.jpg	image/jpeg	67990	2013-10-08 13:29:33.52769	quo	88123361453	esther_runte@yahoo.com	88
2	ut	\N	\N	\N	2013-10-08 13:29:33.452397	2013-10-08 13:29:33.792603	Simon2.jpg	image/jpeg	10848	2013-10-08 13:29:33.669325	saepe	88123361442	rhea@yahoo.com	101
3	at	\N	\N	\N	2013-10-08 13:29:33.455005	2013-10-08 13:29:33.923528	cdwharton-avatar.jpg	image/jpeg	30430	2013-10-08 13:29:33.804575	aut	88123361848	shakira@hotmail.com	97
4	non	\N	\N	\N	2013-10-08 13:29:33.457301	2013-10-08 13:29:34.127755	Jack.jpg	image/jpeg	44562	2013-10-08 13:29:33.935838	ea	88123361765	gerry.bahringer@gmail.com	87
\.


--
-- Name: organizations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: babrovka
--

SELECT pg_catalog.setval('organizations_id_seq', 4, true);


--
-- Data for Name: permission_groups; Type: TABLE DATA; Schema: public; Owner: babrovka
--

COPY permission_groups (id, permission_id, group_id, created_at, updated_at) FROM stdin;
1	3	1	2013-09-10 11:10:42.531696	2013-09-10 11:10:42.531696
2	6	2	2013-09-10 11:38:01.389584	2013-09-10 11:38:01.389584
3	7	3	2013-09-10 14:17:48.912303	2013-09-10 14:17:48.912303
4	8	4	2013-09-10 14:17:55.742546	2013-09-10 14:17:55.742546
5	9	5	2013-09-10 14:18:02.330959	2013-09-10 14:18:02.330959
6	1	6	2013-09-18 14:35:03.909374	2013-09-18 14:35:03.909374
\.


--
-- Name: permission_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: babrovka
--

SELECT pg_catalog.setval('permission_groups_id_seq', 6, true);


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: babrovka
--

COPY permissions (id, title, description, created_at, updated_at) FROM stdin;
1	Согласовывать письма	Предоставляет пользователю возможность согласовывать письма	2013-10-08 12:17:25.669746	2013-10-08 12:17:25.669746
2	Одобрять акты	Предоставляет пользователю возможность одобрять-принимать акты	2013-10-08 12:17:25.675162	2013-10-08 12:17:25.675162
3	Административная панель	Предоставляет пользователю доступ в административную панель	2013-10-08 12:17:25.678893	2013-10-08 12:17:25.678893
4	Cоздавать пользователей	Предоставляет пользователю возможность создавать учетные записи	2013-10-08 12:17:25.682122	2013-10-08 12:17:25.682122
5	Просмотр конфиденциальной корреспонденции	Предоставляет пользователю возможность просматривать конфиденциальную корреспонденцию	2013-10-08 12:17:25.684499	2013-10-08 12:17:25.684499
6	Создавать заявку на пропуск	Предоставляет пользователю возможность создавать заявку на пропуск	2013-10-08 12:17:25.686567	2013-10-08 12:17:25.686567
7	Утверждать пропуска	Предоставляет пользователю возможность утверждать/аннулировать пропуска	2013-10-08 12:17:25.68864	2013-10-08 12:17:25.68864
8	Выпускать пропуска	Предоставляет пользователю возможность выспуска пропуска	2013-10-08 12:17:25.690616	2013-10-08 12:17:25.690616
9	Выдавать пропуска	Предоставляет пользователю возможность выдачи пропуска	2013-10-08 12:17:25.692968	2013-10-08 12:17:25.692968
\.


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: babrovka
--

SELECT pg_catalog.setval('permissions_id_seq', 9, true);


--
-- Data for Name: permits; Type: TABLE DATA; Schema: public; Owner: babrovka
--

COPY permits (id, number, user_id, purpose, start_date, expiration_date, requested_duration, granted_area, granted_object, permit_type, agreed, canceled, released, issued, created_at, updated_at, rejected) FROM stdin;
5	111	3	Штаб	2013-09-25	2013-09-02	1 месяц	Штаб	Штаб	permanent	t	t	t	t	2013-09-12 09:04:47.695356	2013-09-12 09:05:06.611724	f
6	6765	3	Штаб	2013-09-10	2013-09-25	1 месяц	Штаб	Штаб	permanent	t	t	t	t	2013-09-12 09:05:21.576561	2013-09-12 09:07:07.963375	f
\.


--
-- Name: permits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: babrovka
--

SELECT pg_catalog.setval('permits_id_seq', 6, true);


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: babrovka
--

COPY projects (id, title, created_at, updated_at) FROM stdin;
\.


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: babrovka
--

SELECT pg_catalog.setval('projects_id_seq', 1, false);


--
-- Data for Name: responsible_users; Type: TABLE DATA; Schema: public; Owner: babrovka
--

COPY responsible_users (id, document_id, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: responsible_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: babrovka
--

SELECT pg_catalog.setval('responsible_users_id_seq', 1, false);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: babrovka
--

COPY schema_migrations (version) FROM stdin;
20130618131021
20130618151256
20130618163937
20130618164728
20130619101705
20130628133606
20130628133644
20130628142416
20130628142505
20130629141450
20130704204555
20130704204729
20130704204753
20130705082045
20130705162801
20130710155945
20130710180516
20130710180517
20130711063816
20130715081805
20130716124701
20130716134859
20130717110716
20130724134503
20130724142522
20130724151607
20130725150018
20130730143842
20130730144222
20130805065730
20130806135003
20130807140316
20130807140625
20130808052041
20130808114708
20130811185443
20130811185453
20130811185454
20130812084327
20130814084837
20130816142610
20130819103006
20130819133227
20130826120214
20130910104448
20130912084011
20130919110220
20130919121601
20130919130617
20130919133212
20130925121318
20131002130600
20131002131414
\.


--
-- Data for Name: statement_approvers; Type: TABLE DATA; Schema: public; Owner: babrovka
--

COPY statement_approvers (id, user_id, statement_id, accepted, created_at, updated_at) FROM stdin;
\.


--
-- Name: statement_approvers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: babrovka
--

SELECT pg_catalog.setval('statement_approvers_id_seq', 1, false);


--
-- Data for Name: statements; Type: TABLE DATA; Schema: public; Owner: babrovka
--

COPY statements (id, title, user_id, sender_organization_id, organization_id, document_id, text, file_file_name, file_content_type, file_file_size, file_updated_at, draft, prepared, opened, accepted, not_accepted, sent, deleted, created_at, updated_at) FROM stdin;
\.


--
-- Name: statements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: babrovka
--

SELECT pg_catalog.setval('statements_id_seq', 1, false);


--
-- Data for Name: user_groups; Type: TABLE DATA; Schema: public; Owner: babrovka
--

COPY user_groups (id, user_id, group_id, created_at, updated_at) FROM stdin;
77	5	1	2013-09-20 11:17:15.147282	2013-09-20 11:17:15.147282
78	5	2	2013-09-20 11:17:15.149492	2013-09-20 11:17:15.149492
79	5	3	2013-09-20 11:17:15.150981	2013-09-20 11:17:15.150981
80	5	4	2013-09-20 11:17:15.152204	2013-09-20 11:17:15.152204
81	5	5	2013-09-20 11:17:15.153682	2013-09-20 11:17:15.153682
82	5	6	2013-09-20 11:17:15.155079	2013-09-20 11:17:15.155079
83	2	1	2013-09-23 07:54:41.533821	2013-09-23 07:54:41.533821
84	2	6	2013-09-23 07:54:41.53652	2013-09-23 07:54:41.53652
85	6	6	2013-10-03 10:22:37.403934	2013-10-03 10:22:37.403934
49	3	1	2013-09-18 15:56:31.491349	2013-09-18 15:56:31.491349
50	3	6	2013-09-18 15:56:31.493382	2013-09-18 15:56:31.493382
\.


--
-- Name: user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: babrovka
--

SELECT pg_catalog.setval('user_groups_id_seq', 85, true);


--
-- Data for Name: user_permissions; Type: TABLE DATA; Schema: public; Owner: babrovka
--

COPY user_permissions (id, user_id, permission_id, created_at, updated_at) FROM stdin;
4	1	3	2013-09-10 11:14:35.16755	2013-09-10 11:14:35.16755
5	1	3	2013-09-10 11:14:35.637116	2013-09-10 11:14:35.637116
77	5	3	2013-09-20 11:17:15.186416	2013-09-20 11:17:15.186416
78	5	6	2013-09-20 11:17:15.189577	2013-09-20 11:17:15.189577
79	5	7	2013-09-20 11:17:15.191342	2013-09-20 11:17:15.191342
80	5	8	2013-09-20 11:17:15.192758	2013-09-20 11:17:15.192758
81	5	9	2013-09-20 11:17:15.194134	2013-09-20 11:17:15.194134
82	5	1	2013-09-20 11:17:15.195513	2013-09-20 11:17:15.195513
83	2	3	2013-09-23 07:54:41.551384	2013-09-23 07:54:41.551384
84	2	1	2013-09-23 07:54:41.553877	2013-09-23 07:54:41.553877
85	6	1	2013-10-03 10:22:37.433201	2013-10-03 10:22:37.433201
86	101	1	2013-10-08 12:17:55.683013	2013-10-08 12:17:55.683013
87	101	2	2013-10-08 12:17:55.72949	2013-10-08 12:17:55.72949
88	101	3	2013-10-08 12:17:55.731514	2013-10-08 12:17:55.731514
89	101	4	2013-10-08 12:17:55.733152	2013-10-08 12:17:55.733152
90	101	5	2013-10-08 12:17:55.734813	2013-10-08 12:17:55.734813
91	101	6	2013-10-08 12:17:55.736431	2013-10-08 12:17:55.736431
92	101	7	2013-10-08 12:17:55.738057	2013-10-08 12:17:55.738057
93	101	8	2013-10-08 12:17:55.740476	2013-10-08 12:17:55.740476
94	101	9	2013-10-08 12:17:55.742588	2013-10-08 12:17:55.742588
54	3	3	2013-09-18 15:56:31.516164	2013-09-18 15:56:31.516164
55	3	1	2013-09-18 15:56:31.518195	2013-09-18 15:56:31.518195
\.


--
-- Name: user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: babrovka
--

SELECT pg_catalog.setval('user_permissions_id_seq', 94, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: babrovka
--

COPY users (id, phone, "position", division, info, dob, permit, created_at, updated_at, work_status, organization_id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, avatar_file_name, avatar_content_type, avatar_file_size, avatar_updated_at, username, first_name, last_name, is_staff, is_active, is_superuser, date_joined, middle_name) FROM stdin;
117	7777777	tester	НТР	НЕТ	1998	\N	2013-10-08 13:45:14.124486	2013-10-08 13:50:06.981821	at_work	2	babrovka@gmail.com	$2a$10$F2F5waTZ/kclEgQywkcBMOp5VgHQUlE03Ww6ndc8gLo0IEvPKqEy6	\N	\N	\N	1	2013-10-08 13:50:06.980486	2013-10-08 13:50:06.980486	127.0.0.1	127.0.0.1	Richy.png	image/png	44579	2013-10-08 13:45:14.484614	tester	tester	tester	\N	\N	\N	\N	tester
116	88123361708	repudiandae	eos	Dolore molestias minima quis qui soluta qui iste velit facilis iusto	2010-09-30 20:47:21.936751	826	2013-10-08 13:45:13.936107	2013-10-08 13:45:14.470116	at_work	3	minnie@yahoo.com	$2a$10$4.2wNkAsLYdq28dl89MkUu7AUW9ELmFcZGz0R8HZe/RB.3u0Lxcx6	\N	\N	\N	\N	\N	\N	\N	\N	Tomek.jpg	image/jpeg	24470	2013-10-08 13:45:14.131259	king	Michele	Streich	\N	\N	\N	\N	Koch
102	88123361684	dolores	ea	Quam placeat quam est id omnis inventore omnis aut voluptas et architecto expedita rerum sint atque aliquam. Dolorem iste eveniet aut maiores eaque doloremque qui libero eligendi. Illum laudantium minus quia blanditiis saepe omnis doloribus accusamus ut iure earum natus	2009-10-18 19:02:58.747076	994	2013-10-08 13:45:12.382873	2013-10-08 13:45:15.140739	at_work	3	nedra_wintheiser@yahoo.com	$2a$10$1fAL.r4dcq6tEKlt5s8mcuMATrh9e/R/NZgF4WlR2M8Piv.UnbhbW	\N	\N	\N	\N	\N	\N	\N	\N	Rob.jpg	image/jpeg	12132	2013-10-08 13:45:14.796918	fatima	Monte	Kiehn	\N	\N	\N	\N	Deckow
103	88123361904	aut	ex	Tempora expedita aut mollitia cum reiciendis quia possimus dolores eum tempore natus expedita dicta accusamus quia impedit. Sunt deleniti repellendus repudiandae atque doloremque et odit qui et quia suscipit tenetur fuga	1995-05-22 07:44:05.840519	801	2013-10-08 13:45:12.839852	2013-10-08 13:45:15.414376	ooo	2	noble_collier@gmail.com	$2a$10$vJ1Iwm45zwg1ZulaQ7fyQ.1a.LJEtbW.j0K/oTYVJIuSt9VgA6CgC	\N	\N	\N	\N	\N	\N	\N	\N	Tomek.jpg	image/jpeg	24470	2013-10-08 13:45:15.153725	ashlee	Santina	Feeney	\N	\N	\N	\N	Breitenberg
104	88123361703	consequatur	repellendus	Consectetur quia ea qui ut sed amet eius esse quis aperiam	2008-11-06 15:53:43.926167	990	2013-10-08 13:45:12.925478	2013-10-08 13:45:15.670305	at_work	4	gregory@hotmail.com	$2a$10$DOJKKhilYWGGMVSAtfMbKeKoTBSgL2XCXrd.oY94ZLNcDyU9u4uC.	\N	\N	\N	\N	\N	\N	\N	\N	Robert.jpg	image/jpeg	18135	2013-10-08 13:45:15.429734	jayce_stoltenberg	Jovani	Tromp	\N	\N	\N	\N	Russel
105	88123361545	inventore	assumenda	Ut rerum unde est in id rerum occaecati necessitatibus libero tempora minima ullam cumque	2011-11-25 12:24:40.007951	991	2013-10-08 13:45:13.006937	2013-10-08 13:45:15.986076	ooo	3	rosalind.kerluke@yahoo.com	$2a$10$Pft/1PPmbX9J/.KrbXLqYuIjWIsYUJmCBTKDXr0Gc0y35u9Q2j9v.	\N	\N	\N	\N	\N	\N	\N	\N	Jimmy.jpg	image/jpeg	36177	2013-10-08 13:45:15.684332	lucio	Hermina	Graham	\N	\N	\N	\N	O'Conner
106	88123361959	et	pariatur	Sequi maiores in soluta aut vitae. Quidem et velit ut est voluptatem et pariatur itaque modi non fugit laboriosam possimus aliquam ut	2005-09-30 12:33:52.089057	986	2013-10-08 13:45:13.088346	2013-10-08 13:45:16.270998	ooo	1	oren.deckow@yahoo.com	$2a$10$ccZnjd9JMz6XvQZwxoE/dejFpse8Uwo9CCr/ceI9VG9FrZz4NHrde	\N	\N	\N	\N	\N	\N	\N	\N	Jack.jpg	image/jpeg	44562	2013-10-08 13:45:16.000079	dax_gerhold	Antone	Gaylord	\N	\N	\N	\N	Brakus
107	88123361731	rerum	molestiae	Ipsa sunt quae qui assumenda quo rerum reprehenderit. Sed inventore sit in veritatis porro occaecati cum reprehenderit explicabo autem cumque	2009-03-26 13:06:22.175650	769	2013-10-08 13:45:13.17441	2013-10-08 13:45:16.602231	ooo	2	holly_hamill@hotmail.com	$2a$10$ueIa5d2WwDbuZYmjl2pO/.q2TXIsrZcMtzmAZfuq3XDxwyAfqHMd6	\N	\N	\N	\N	\N	\N	\N	\N	FullCreamMIlk.png	image/png	22525	2013-10-08 13:45:16.286645	lawson_renner	Janet	Boyer	\N	\N	\N	\N	Block
108	88123361562	aut	quis	Qui dolores nisi est et totam exercitationem mollitia tempora porro maiores nihil magnam repellat qui. Earum beatae eligendi perspiciatis quasi sit provident qui est similique rerum architecto sit et officiis debitis omnis porro accusamus. Quam quo reiciendis aut velit nam voluptas sunt et alias sint	2005-11-06 03:13:26.257630	997	2013-10-08 13:45:13.256878	2013-10-08 13:45:16.867562	at_work	3	jason@gmail.com	$2a$10$3uU6Gkj4/FflZUerSTyz9.nHVuP5CIPwpYIKyuJ3.QFTxhASYxbPO	\N	\N	\N	\N	\N	\N	\N	\N	Andrew.jpg	image/jpeg	6583	2013-10-08 13:45:16.618432	georgiana.macejkovic	Dwight	Weber	\N	\N	\N	\N	Wunsch
109	88123361177	voluptatum	non	Eos iste eos qui accusamus consequuntur et et suscipit. A ut officia quaerat tempore	2007-08-07 23:35:26.343260	971	2013-10-08 13:45:13.342072	2013-10-08 13:45:17.138303	at_work	2	mekhi@yahoo.com	$2a$10$7cVYb87kvDbizzfX8J/odOdsn5k/EeB/sOdnw5fRf.IUzX2yZx71i	\N	\N	\N	\N	\N	\N	\N	\N	Adam.jpg	image/jpeg	78293	2013-10-08 13:45:16.880928	columbus_paucek	Marlen	Mante	\N	\N	\N	\N	Wilderman
110	88123361116	accusamus	soluta	Repudiandae ea nesciunt ut necessitatibus et voluptatem ducimus sint corrupti eos nihil minima nostrum dolor omnis rerum alias cum. Quisquam earum dolorem qui non voluptatum illo rerum corrupti ad adipisci molestias quis omnis beatae atque. Possimus accusamus aliquid nisi harum repellendus aut voluptatem porro alias est	2005-05-07 12:15:20.427992	860	2013-10-08 13:45:13.427077	2013-10-08 13:45:17.520721	at_work	2	izaiah@gmail.com	$2a$10$BHbkebb2u71aYCeXS/c./eEpdr9Xukivm0wEKYkJeThTvxckQffSO	\N	\N	\N	\N	\N	\N	\N	\N	banekoma.png	image/png	72036	2013-10-08 13:45:17.212956	etha_kshlerin	Mireya	Lynch	\N	\N	\N	\N	Hilll
111	88123361698	beatae	totam	Asperiores cumque fuga aut laboriosam et quia ex nihil unde temporibus dolore et fuga autem totam. Quis ex dolorem asperiores eum et voluptatum suscipit	2005-06-25 15:12:47.512503	843	2013-10-08 13:45:13.511847	2013-10-08 13:45:17.839527	at_work	2	dolly_murazik@yahoo.com	$2a$10$73uRtW/FvabiXz2af8SAEuqeAw8DOQGCalGerA4zlSTYMGMT41Lce	\N	\N	\N	\N	\N	\N	\N	\N	alex.jpg	image/jpeg	47456	2013-10-08 13:45:17.544213	lavinia	Nathanael	Powlowski	\N	\N	\N	\N	Volkman
112	88123361109	sunt	unde	Sed expedita dicta dolorum exercitationem et quis qui corrupti voluptatem culpa ratione. Provident voluptas vel perferendis vero omnis sit ut dolores veritatis ad dicta	2010-02-03 04:23:00.597183	862	2013-10-08 13:45:13.596021	2013-10-08 13:45:18.164121	ooo	4	kelli@gmail.com	$2a$10$hsbegIganMseTrKCDAkv.emVPV39Z/Nh1ZIiLv8wDRaDnH9MAApgi	\N	\N	\N	\N	\N	\N	\N	\N	Jonic.jpg	image/jpeg	30654	2013-10-08 13:45:17.855607	soledad_howell	Dannie	Bahringer	\N	\N	\N	\N	Will
113	88123361150	repellendus	eligendi	Et quae animi odit qui aliquam distinctio labore doloribus corporis enim aut illo deleniti aut. Non rerum et ut hic modi iste debitis voluptatem qui aspernatur sapiente odit quo ea voluptas est	1994-07-05 18:56:29.682599	772	2013-10-08 13:45:13.681363	2013-10-08 13:45:18.451293	ooo	3	jayden@gmail.com	$2a$10$05vVH6GUDKhSHOcFqmEvm.AptDJkSLo7Zsi5LRO9aSBnOmZ2k2aWe	\N	\N	\N	\N	\N	\N	\N	\N	Adrian2.png	image/png	91567	2013-10-08 13:45:18.180284	bo.hahn	Alec	Cruickshank	\N	\N	\N	\N	Conn
114	88123361726	eveniet	at	Hic pariatur qui reprehenderit nam iusto fugit quia. At rem qui fugit eos iure quia voluptate quo temporibus iure incidunt quam et fugit minus suscipit sunt voluptatem	1994-08-12 23:48:43.768045	815	2013-10-08 13:45:13.767255	2013-10-08 13:45:18.81071	ooo	4	ardith_mcdermott@hotmail.com	$2a$10$wUmcZFmTxHCTOAdgBMqSueEVJBLzUIJV3zJYv7RI5AfKDlOaSBhyO	\N	\N	\N	\N	\N	\N	\N	\N	Duncan.jpg	image/jpeg	49054	2013-10-08 13:45:18.466689	kennedy	Lisette	Predovic	\N	\N	\N	\N	Konopelski
115	88123361944	voluptas	magnam	Officia optio voluptas asperiores fugiat ut dignissimos nam et aut qui voluptatibus. Soluta molestiae corrupti officiis eaque libero minima id exercitationem minima cupiditate sit	2012-04-12 13:50:30.852482	887	2013-10-08 13:45:13.851819	2013-10-08 13:45:19.081972	ooo	3	sunny_casper@gmail.com	$2a$10$KEodAjC6GERih3F4v7mToevFfjd6fNjFjoWRL43xYm0Rk/C7BQPb.	\N	\N	\N	\N	\N	\N	\N	\N	Paul.jpg	image/jpeg	15737	2013-10-08 13:45:18.826181	nestor	Norma	Little	\N	\N	\N	\N	Jaskolski
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: babrovka
--

SELECT pg_catalog.setval('users_id_seq', 117, true);


--
-- Name: admin_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: babrovka; Tablespace: 
--

ALTER TABLE ONLY active_admin_comments
    ADD CONSTRAINT admin_notes_pkey PRIMARY KEY (id);


--
-- Name: admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: babrovka; Tablespace: 
--

ALTER TABLE ONLY admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: approve_users_pkey; Type: CONSTRAINT; Schema: public; Owner: babrovka; Tablespace: 
--

ALTER TABLE ONLY approve_users
    ADD CONSTRAINT approve_users_pkey PRIMARY KEY (id);


--
-- Name: ckeditor_assets_pkey; Type: CONSTRAINT; Schema: public; Owner: babrovka; Tablespace: 
--

ALTER TABLE ONLY ckeditor_assets
    ADD CONSTRAINT ckeditor_assets_pkey PRIMARY KEY (id);


--
-- Name: delete_notices_pkey; Type: CONSTRAINT; Schema: public; Owner: babrovka; Tablespace: 
--

ALTER TABLE ONLY delete_notices
    ADD CONSTRAINT delete_notices_pkey PRIMARY KEY (id);


--
-- Name: document_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: babrovka; Tablespace: 
--

ALTER TABLE ONLY document_attachments
    ADD CONSTRAINT document_attachments_pkey PRIMARY KEY (id);


--
-- Name: document_conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: babrovka; Tablespace: 
--

ALTER TABLE ONLY document_conversations
    ADD CONSTRAINT document_conversations_pkey PRIMARY KEY (id);


--
-- Name: document_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: babrovka; Tablespace: 
--

ALTER TABLE ONLY document_relations
    ADD CONSTRAINT document_relations_pkey PRIMARY KEY (id);


--
-- Name: documents_pkey; Type: CONSTRAINT; Schema: public; Owner: babrovka; Tablespace: 
--

ALTER TABLE ONLY documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: groups_pkey; Type: CONSTRAINT; Schema: public; Owner: babrovka; Tablespace: 
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: open_notices_pkey; Type: CONSTRAINT; Schema: public; Owner: babrovka; Tablespace: 
--

ALTER TABLE ONLY open_notices
    ADD CONSTRAINT open_notices_pkey PRIMARY KEY (id);


--
-- Name: organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: babrovka; Tablespace: 
--

ALTER TABLE ONLY organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: permission_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: babrovka; Tablespace: 
--

ALTER TABLE ONLY permission_groups
    ADD CONSTRAINT permission_groups_pkey PRIMARY KEY (id);


--
-- Name: permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: babrovka; Tablespace: 
--

ALTER TABLE ONLY permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: permits_pkey; Type: CONSTRAINT; Schema: public; Owner: babrovka; Tablespace: 
--

ALTER TABLE ONLY permits
    ADD CONSTRAINT permits_pkey PRIMARY KEY (id);


--
-- Name: projects_pkey; Type: CONSTRAINT; Schema: public; Owner: babrovka; Tablespace: 
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: responsible_users_pkey; Type: CONSTRAINT; Schema: public; Owner: babrovka; Tablespace: 
--

ALTER TABLE ONLY responsible_users
    ADD CONSTRAINT responsible_users_pkey PRIMARY KEY (id);


--
-- Name: statement_approvers_pkey; Type: CONSTRAINT; Schema: public; Owner: babrovka; Tablespace: 
--

ALTER TABLE ONLY statement_approvers
    ADD CONSTRAINT statement_approvers_pkey PRIMARY KEY (id);


--
-- Name: statements_pkey; Type: CONSTRAINT; Schema: public; Owner: babrovka; Tablespace: 
--

ALTER TABLE ONLY statements
    ADD CONSTRAINT statements_pkey PRIMARY KEY (id);


--
-- Name: user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: babrovka; Tablespace: 
--

ALTER TABLE ONLY user_groups
    ADD CONSTRAINT user_groups_pkey PRIMARY KEY (id);


--
-- Name: user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: babrovka; Tablespace: 
--

ALTER TABLE ONLY user_permissions
    ADD CONSTRAINT user_permissions_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: babrovka; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_ckeditor_assetable; Type: INDEX; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE INDEX idx_ckeditor_assetable ON ckeditor_assets USING btree (assetable_type, assetable_id);


--
-- Name: idx_ckeditor_assetable_type; Type: INDEX; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE INDEX idx_ckeditor_assetable_type ON ckeditor_assets USING btree (assetable_type, type, assetable_id);


--
-- Name: index_active_admin_comments_on_author_type_and_author_id; Type: INDEX; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE INDEX index_active_admin_comments_on_author_type_and_author_id ON active_admin_comments USING btree (author_type, author_id);


--
-- Name: index_active_admin_comments_on_namespace; Type: INDEX; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE INDEX index_active_admin_comments_on_namespace ON active_admin_comments USING btree (namespace);


--
-- Name: index_admin_notes_on_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE INDEX index_admin_notes_on_resource_type_and_resource_id ON active_admin_comments USING btree (resource_type, resource_id);


--
-- Name: index_admin_users_on_email; Type: INDEX; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE UNIQUE INDEX index_admin_users_on_email ON admin_users USING btree (email);


--
-- Name: index_admin_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE UNIQUE INDEX index_admin_users_on_reset_password_token ON admin_users USING btree (reset_password_token);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: babrovka; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: public; Type: ACL; Schema: -; Owner: babrovka
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM babrovka;
GRANT ALL ON SCHEMA public TO babrovka;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

