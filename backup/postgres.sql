--
-- PostgreSQL database dump
--

\restrict 4uAJkOsdumnaCpopIWiIVvQ1t7GB6AaLOvqeODg0Y0tNDp9srW580UGPbifDxcR

-- Dumped from database version 16.13
-- Dumped by pg_dump version 16.13

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
-- Name: alerts; Type: TABLE; Schema: public; Owner: dashauto
--

CREATE TABLE public.alerts (
    id integer NOT NULL,
    type character varying(50) NOT NULL,
    message text NOT NULL,
    severity character varying(20) DEFAULT 'info'::character varying NOT NULL,
    status character varying(20) DEFAULT 'open'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    resolved_at timestamp without time zone
);


ALTER TABLE public.alerts OWNER TO dashauto;

--
-- Name: alerts_id_seq; Type: SEQUENCE; Schema: public; Owner: dashauto
--

CREATE SEQUENCE public.alerts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.alerts_id_seq OWNER TO dashauto;

--
-- Name: alerts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dashauto
--

ALTER SEQUENCE public.alerts_id_seq OWNED BY public.alerts.id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: dashauto
--

CREATE TABLE public.order_items (
    id integer NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    unit_price numeric(12,2) NOT NULL
);


ALTER TABLE public.order_items OWNER TO dashauto;

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: dashauto
--

CREATE SEQUENCE public.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_seq OWNER TO dashauto;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dashauto
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: dashauto
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    order_code character varying(50) NOT NULL,
    customer_name character varying(200),
    total_amount numeric(14,2) DEFAULT 0 NOT NULL,
    status character varying(20) DEFAULT 'pending'::character varying NOT NULL,
    region character varying(100),
    employee_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.orders OWNER TO dashauto;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: dashauto
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO dashauto;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dashauto
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: dashauto
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    sku character varying(50),
    price numeric(12,2) DEFAULT 0 NOT NULL,
    category character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.products OWNER TO dashauto;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: dashauto
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO dashauto;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dashauto
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: reports; Type: TABLE; Schema: public; Owner: dashauto
--

CREATE TABLE public.reports (
    id integer NOT NULL,
    title character varying(200) NOT NULL,
    type character varying(50) NOT NULL,
    content text,
    file_url character varying(500),
    email_status character varying(20) DEFAULT 'pending'::character varying,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.reports OWNER TO dashauto;

--
-- Name: reports_id_seq; Type: SEQUENCE; Schema: public; Owner: dashauto
--

CREATE SEQUENCE public.reports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reports_id_seq OWNER TO dashauto;

--
-- Name: reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dashauto
--

ALTER SEQUENCE public.reports_id_seq OWNED BY public.reports.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: dashauto
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    role character varying(20) DEFAULT 'viewer'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users OWNER TO dashauto;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: dashauto
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO dashauto;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dashauto
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: workflow_logs; Type: TABLE; Schema: public; Owner: dashauto
--

CREATE TABLE public.workflow_logs (
    id integer NOT NULL,
    workflow_name character varying(200) NOT NULL,
    status character varying(20) NOT NULL,
    message text,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.workflow_logs OWNER TO dashauto;

--
-- Name: workflow_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: dashauto
--

CREATE SEQUENCE public.workflow_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.workflow_logs_id_seq OWNER TO dashauto;

--
-- Name: workflow_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dashauto
--

ALTER SEQUENCE public.workflow_logs_id_seq OWNED BY public.workflow_logs.id;


--
-- Name: alerts id; Type: DEFAULT; Schema: public; Owner: dashauto
--

ALTER TABLE ONLY public.alerts ALTER COLUMN id SET DEFAULT nextval('public.alerts_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: dashauto
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: dashauto
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: dashauto
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: reports id; Type: DEFAULT; Schema: public; Owner: dashauto
--

ALTER TABLE ONLY public.reports ALTER COLUMN id SET DEFAULT nextval('public.reports_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: dashauto
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: workflow_logs id; Type: DEFAULT; Schema: public; Owner: dashauto
--

ALTER TABLE ONLY public.workflow_logs ALTER COLUMN id SET DEFAULT nextval('public.workflow_logs_id_seq'::regclass);


--
-- Data for Name: alerts; Type: TABLE DATA; Schema: public; Owner: dashauto
--

COPY public.alerts (id, type, message, severity, status, created_at, resolved_at) FROM stdin;
2	high_return_rate	Canh bao mau so 2	info	open	2026-04-16 05:38:00.371	\N
3	workflow_error	Canh bao mau so 3	info	resolved	2026-04-16 19:38:00.374	\N
4	low_revenue	Canh bao mau so 4	info	open	2026-04-13 06:38:00.378	\N
5	high_return_rate	Canh bao mau so 5	info	resolved	2026-04-15 02:38:00.38	\N
6	low_revenue	Canh bao mau so 6	info	resolved	2026-04-13 04:38:00.383	\N
7	low_revenue	Canh bao mau so 7	warning	resolved	2026-04-12 18:38:00.386	\N
8	low_revenue	Canh bao mau so 8	warning	resolved	2026-04-11 23:38:00.389	\N
1	workflow_error	Canh bao mau so 1	critical	resolved	2026-04-16 20:38:00.367	2026-04-16 16:05:06.556809
9	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:07:10.764097	\N
10	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:10:19.840932	\N
11	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:10:57.050016	\N
12	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:11:02.291386	\N
13	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:11:57.052635	\N
14	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:12:57.04808	\N
15	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:13:57.028835	\N
16	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:14:57.048799	\N
17	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:15:57.040886	\N
18	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:16:57.052259	\N
19	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:17:57.058425	\N
20	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:18:57.031755	\N
21	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:19:57.044143	\N
22	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:20:57.031933	\N
23	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:21:57.032501	\N
24	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:22:57.056816	\N
25	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:23:57.043493	\N
26	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:24:57.059019	\N
27	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:25:57.029209	\N
28	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:26:57.039922	\N
29	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:27:57.039055	\N
30	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:28:57.055997	\N
31	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:29:57.050379	\N
32	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:30:57.046483	\N
33	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:31:57.051376	\N
34	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:32:57.057781	\N
35	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:33:57.050109	\N
36	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:34:57.045659	\N
37	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:35:57.042335	\N
38	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:36:57.037701	\N
39	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:37:57.046075	\N
40	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:38:57.017105	\N
41	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:39:57.028183	\N
42	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:40:57.022668	\N
43	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:41:57.025205	\N
44	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:42:57.023139	\N
45	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:43:57.02914	\N
46	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:44:57.020292	\N
47	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:45:57.040733	\N
48	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:46:57.027355	\N
49	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:47:57.022943	\N
50	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:48:57.033284	\N
51	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:49:57.024677	\N
52	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:50:57.024748	\N
53	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:51:57.016017	\N
54	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:52:57.018723	\N
55	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:53:57.024815	\N
56	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:54:57.027248	\N
57	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:55:57.024001	\N
58	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:56:57.020511	\N
59	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:57:57.024326	\N
60	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:58:57.021486	\N
61	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 16:59:57.027843	\N
62	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:00:57.02117	\N
63	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:01:57.025955	\N
64	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:02:57.026748	\N
65	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:03:57.030812	\N
66	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:04:57.030675	\N
67	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:05:57.020758	\N
68	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:06:57.024595	\N
69	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:07:57.027462	\N
70	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:08:57.018658	\N
71	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:09:57.023036	\N
72	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:10:57.02941	\N
73	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:11:57.017468	\N
74	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:12:57.030054	\N
75	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:13:57.022453	\N
76	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:14:57.025899	\N
77	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:15:57.018279	\N
78	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:16:57.030979	\N
79	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:17:57.022277	\N
80	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:18:57.017974	\N
81	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:19:57.018326	\N
82	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:20:57.018527	\N
83	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:21:57.019441	\N
84	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:22:57.02133	\N
85	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:23:57.027846	\N
86	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:24:57.019144	\N
87	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:25:57.023067	\N
88	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:26:57.040184	\N
89	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:27:57.027285	\N
90	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:28:57.021593	\N
91	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:29:57.016076	\N
92	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:30:57.020895	\N
93	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:31:57.026784	\N
94	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:32:57.014328	\N
95	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:33:57.025472	\N
96	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:34:57.021718	\N
97	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:35:57.022291	\N
98	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:36:57.020614	\N
99	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:37:57.018139	\N
100	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:38:57.018023	\N
101	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:39:57.028246	\N
102	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:40:57.025633	\N
103	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:41:57.027407	\N
104	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:42:57.015497	\N
105	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:43:57.025215	\N
106	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:44:57.028311	\N
107	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:45:57.016252	\N
108	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:46:57.029756	\N
109	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:47:57.029735	\N
110	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:48:57.024017	\N
111	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:49:57.031566	\N
112	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:50:57.026177	\N
113	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:51:57.023283	\N
114	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:52:57.024185	\N
115	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:53:57.028113	\N
116	low_order_rate	Khong co don hang trong 1 gio qua - phat hien boi n8n	warning	open	2026-04-17 17:54:57.029196	\N
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: dashauto
--

COPY public.order_items (id, order_id, product_id, quantity, unit_price) FROM stdin;
1	1	5	1	2500000.00
2	1	3	1	22000000.00
3	1	5	3	2500000.00
4	2	1	1	25000000.00
5	3	6	2	45000000.00
6	4	1	3	25000000.00
7	4	2	1	28000000.00
8	5	2	1	28000000.00
9	5	4	2	6000000.00
10	6	1	1	25000000.00
11	6	5	1	2500000.00
12	6	3	2	22000000.00
13	7	5	1	2500000.00
14	7	4	3	6000000.00
15	8	1	1	25000000.00
16	9	4	1	6000000.00
17	10	1	1	25000000.00
18	10	3	3	22000000.00
19	10	3	3	22000000.00
20	11	4	1	6000000.00
21	12	2	2	28000000.00
22	12	5	2	2500000.00
23	13	5	3	2500000.00
24	14	3	1	22000000.00
25	15	3	1	22000000.00
26	15	2	2	28000000.00
27	16	5	2	2500000.00
28	16	3	2	22000000.00
29	16	5	2	2500000.00
30	17	5	3	2500000.00
31	17	1	3	25000000.00
32	17	4	2	6000000.00
33	18	2	1	28000000.00
34	18	6	3	45000000.00
35	19	5	3	2500000.00
36	20	6	1	45000000.00
37	20	6	3	45000000.00
38	21	2	1	28000000.00
39	21	4	1	6000000.00
40	22	1	2	25000000.00
41	23	4	3	6000000.00
42	23	6	1	45000000.00
43	23	4	2	6000000.00
44	24	4	1	6000000.00
45	25	3	3	22000000.00
46	25	4	3	6000000.00
47	25	3	1	22000000.00
48	26	5	3	2500000.00
49	26	2	1	28000000.00
50	27	2	1	28000000.00
51	28	6	3	45000000.00
52	28	1	2	25000000.00
53	29	6	2	45000000.00
54	29	2	2	28000000.00
55	29	6	1	45000000.00
56	30	6	1	45000000.00
57	30	2	2	28000000.00
58	31	2	2	28000000.00
59	31	1	2	25000000.00
60	31	6	2	45000000.00
61	32	3	1	22000000.00
62	32	1	3	25000000.00
63	32	1	2	25000000.00
64	33	1	1	25000000.00
65	33	2	1	28000000.00
66	33	6	1	45000000.00
67	34	2	1	28000000.00
68	34	5	2	2500000.00
69	35	5	1	2500000.00
70	35	5	2	2500000.00
71	35	4	1	6000000.00
72	36	1	2	25000000.00
73	37	4	3	6000000.00
74	37	3	2	22000000.00
75	37	6	1	45000000.00
76	38	3	2	22000000.00
77	38	3	2	22000000.00
78	39	5	1	2500000.00
79	39	5	1	2500000.00
80	39	2	1	28000000.00
81	40	1	2	25000000.00
82	40	3	2	22000000.00
83	40	1	2	25000000.00
84	41	2	3	28000000.00
85	41	5	1	2500000.00
86	41	6	1	45000000.00
87	42	3	1	22000000.00
88	42	6	1	45000000.00
89	43	6	1	45000000.00
90	44	4	3	6000000.00
91	44	6	2	45000000.00
92	44	3	2	22000000.00
93	45	5	2	2500000.00
94	45	6	2	45000000.00
95	46	5	3	2500000.00
96	46	6	2	45000000.00
97	46	2	1	28000000.00
98	47	6	2	45000000.00
99	47	3	1	22000000.00
100	48	4	3	6000000.00
101	48	2	3	28000000.00
102	49	4	3	6000000.00
103	49	2	1	28000000.00
104	49	1	1	25000000.00
105	50	5	3	2500000.00
106	50	5	1	2500000.00
107	51	4	3	6000000.00
108	51	2	2	28000000.00
109	51	4	2	6000000.00
110	52	5	3	2500000.00
111	52	3	2	22000000.00
112	53	2	1	28000000.00
113	53	3	2	22000000.00
114	54	5	2	2500000.00
115	55	6	1	45000000.00
116	56	4	3	6000000.00
117	56	1	1	25000000.00
118	57	3	2	22000000.00
119	57	2	3	28000000.00
120	58	4	1	6000000.00
121	58	6	3	45000000.00
122	59	1	1	25000000.00
123	59	4	1	6000000.00
124	60	3	3	22000000.00
125	60	1	2	25000000.00
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: dashauto
--

COPY public.orders (id, order_code, customer_name, total_amount, status, region, employee_id, created_at) FROM stdin;
1	ORD-0001	Khach hang 1	32000000.00	completed	Hai Phong	1	2026-04-08 09:37:59.784
2	ORD-0002	Khach hang 2	25000000.00	pending	Da Nang	1	2026-04-06 22:37:59.798
3	ORD-0003	Khach hang 3	90000000.00	pending	Ha Noi	1	2026-04-13 23:37:59.804
4	ORD-0004	Khach hang 4	103000000.00	cancelled	Ha Noi	1	2026-04-10 02:37:59.809
5	ORD-0005	Khach hang 5	40000000.00	completed	Hai Phong	1	2026-03-30 04:37:59.817
6	ORD-0006	Khach hang 6	71500000.00	completed	Ha Noi	1	2026-04-06 13:37:59.823
7	ORD-0007	Khach hang 7	20500000.00	pending	Hai Phong	1	2026-04-12 10:37:59.834
8	ORD-0008	Khach hang 8	25000000.00	cancelled	Da Nang	1	2026-04-10 08:37:59.841
9	ORD-0009	Khach hang 9	6000000.00	cancelled	Ha Noi	1	2026-03-31 08:37:59.846
10	ORD-0010	Khach hang 10	157000000.00	pending	Ha Noi	1	2026-03-29 21:37:59.851
11	ORD-0011	Khach hang 11	6000000.00	completed	Ho Chi Minh	1	2026-03-31 14:37:59.861
12	ORD-0012	Khach hang 12	61000000.00	completed	Da Nang	1	2026-03-18 09:37:59.866
13	ORD-0013	Khach hang 13	7500000.00	completed	Da Nang	1	2026-04-03 01:37:59.872
14	ORD-0014	Khach hang 14	22000000.00	cancelled	Da Nang	1	2026-04-05 11:37:59.876
15	ORD-0015	Khach hang 15	78000000.00	completed	Hai Phong	1	2026-03-19 13:37:59.879
16	ORD-0016	Khach hang 16	54000000.00	completed	Hai Phong	1	2026-03-28 07:37:59.885
17	ORD-0017	Khach hang 17	94500000.00	pending	Da Nang	1	2026-03-31 00:37:59.892
18	ORD-0018	Khach hang 18	163000000.00	completed	Da Nang	1	2026-03-19 13:37:59.899
19	ORD-0019	Khach hang 19	7500000.00	completed	Da Nang	1	2026-04-16 21:37:59.905
20	ORD-0020	Khach hang 20	180000000.00	completed	Hai Phong	1	2026-04-11 09:37:59.909
21	ORD-0021	Khach hang 21	34000000.00	completed	Da Nang	1	2026-04-11 17:37:59.915
22	ORD-0022	Khach hang 22	50000000.00	completed	Hai Phong	1	2026-04-13 00:37:59.921
23	ORD-0023	Khach hang 23	75000000.00	cancelled	Da Nang	1	2026-04-10 02:37:59.925
24	ORD-0024	Khach hang 24	6000000.00	completed	Hai Phong	1	2026-04-04 15:37:59.932
25	ORD-0025	Khach hang 25	106000000.00	cancelled	Hai Phong	1	2026-04-16 09:37:59.937
26	ORD-0026	Khach hang 26	35500000.00	pending	Ho Chi Minh	1	2026-03-20 05:37:59.945
27	ORD-0027	Khach hang 27	28000000.00	cancelled	Hai Phong	1	2026-03-18 00:37:59.951
28	ORD-0028	Khach hang 28	185000000.00	pending	Ha Noi	1	2026-03-30 15:37:59.955
29	ORD-0029	Khach hang 29	191000000.00	cancelled	Ha Noi	1	2026-04-08 17:37:59.96
30	ORD-0030	Khach hang 30	101000000.00	pending	Ho Chi Minh	1	2026-03-23 07:37:59.968
31	ORD-0031	Khach hang 31	196000000.00	completed	Ha Noi	1	2026-03-23 07:37:59.975
32	ORD-0032	Khach hang 32	147000000.00	completed	Da Nang	1	2026-03-30 22:37:59.986
33	ORD-0033	Khach hang 33	98000000.00	completed	Ha Noi	1	2026-03-29 22:37:59.995
34	ORD-0034	Khach hang 34	33000000.00	completed	Ho Chi Minh	1	2026-03-29 12:38:00.009
35	ORD-0035	Khach hang 35	13500000.00	completed	Da Nang	1	2026-04-13 08:38:00.021
36	ORD-0036	Khach hang 36	50000000.00	pending	Ha Noi	1	2026-04-14 23:38:00.034
37	ORD-0037	Khach hang 37	107000000.00	cancelled	Hai Phong	1	2026-03-25 05:38:00.041
38	ORD-0038	Khach hang 38	88000000.00	completed	Ha Noi	1	2026-03-22 03:38:00.056
39	ORD-0039	Khach hang 39	33000000.00	pending	Ha Noi	1	2026-04-04 00:38:00.067
40	ORD-0040	Khach hang 40	144000000.00	completed	Da Nang	1	2026-03-26 03:38:00.083
41	ORD-0041	Khach hang 41	131500000.00	completed	Ha Noi	1	2026-04-03 11:38:00.101
42	ORD-0042	Khach hang 42	67000000.00	completed	Ha Noi	1	2026-03-27 21:38:00.117
43	ORD-0043	Khach hang 43	45000000.00	pending	Ho Chi Minh	1	2026-03-23 10:38:00.13
44	ORD-0044	Khach hang 44	152000000.00	completed	Da Nang	1	2026-03-23 14:38:00.138
45	ORD-0045	Khach hang 45	95000000.00	completed	Hai Phong	1	2026-04-10 10:38:00.154
46	ORD-0046	Khach hang 46	125500000.00	completed	Ho Chi Minh	1	2026-03-24 03:38:00.166
47	ORD-0047	Khach hang 47	112000000.00	completed	Hai Phong	1	2026-04-07 16:38:00.182
48	ORD-0048	Khach hang 48	102000000.00	completed	Hai Phong	1	2026-04-04 12:38:00.194
49	ORD-0049	Khach hang 49	71000000.00	pending	Da Nang	1	2026-04-13 11:38:00.202
50	ORD-0050	Khach hang 50	10000000.00	completed	Da Nang	1	2026-04-05 01:38:00.213
51	ORD-0051	Khach hang 51	86000000.00	pending	Ho Chi Minh	1	2026-04-08 23:38:00.221
52	ORD-0052	Khach hang 52	51500000.00	completed	Ha Noi	1	2026-03-21 06:38:00.232
53	ORD-0053	Khach hang 53	72000000.00	completed	Da Nang	1	2026-04-07 22:38:00.243
54	ORD-0054	Khach hang 54	5000000.00	completed	Ha Noi	1	2026-03-29 22:38:00.254
55	ORD-0055	Khach hang 55	45000000.00	completed	Hai Phong	1	2026-04-04 20:38:00.265
56	ORD-0056	Khach hang 56	43000000.00	cancelled	Hai Phong	1	2026-04-03 01:38:00.274
57	ORD-0057	Khach hang 57	128000000.00	cancelled	Hai Phong	1	2026-03-19 15:38:00.286
58	ORD-0058	Khach hang 58	141000000.00	cancelled	Ha Noi	1	2026-04-11 13:38:00.299
59	ORD-0059	Khach hang 59	31000000.00	completed	Da Nang	1	2026-03-21 08:38:00.311
60	ORD-0060	Khach hang 60	116000000.00	pending	Hai Phong	1	2026-04-15 20:38:00.323
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: dashauto
--

COPY public.products (id, name, sku, price, category, created_at) FROM stdin;
1	Laptop Dell XPS 13	DELL-XPS13	25000000.00	Laptop	2026-04-16 15:37:59.768703
2	iPhone 15 Pro	IP15-PRO	28000000.00	Phone	2026-04-16 15:37:59.779563
3	Samsung Galaxy S24	SS-S24	22000000.00	Phone	2026-04-16 15:37:59.783157
4	AirPods Pro 2	APP-2	6000000.00	Accessory	2026-04-16 15:37:59.7863
5	Magic Mouse	MM-1	2500000.00	Accessory	2026-04-16 15:37:59.789562
6	MacBook Pro 14	MBP-14	45000000.00	Laptop	2026-04-16 15:37:59.792677
\.


--
-- Data for Name: reports; Type: TABLE DATA; Schema: public; Owner: dashauto
--

COPY public.reports (id, title, type, content, file_url, email_status, created_by, created_at) FROM stdin;
1	Bao cao 1	daily	Noi dung tom tat bao cao so 1	\N	success	1	2026-04-03 15:38:00.336
2	Bao cao 2	monthly	Noi dung tom tat bao cao so 2	\N	success	1	2026-04-07 02:38:00.341
3	Bao cao 3	monthly	Noi dung tom tat bao cao so 3	\N	success	1	2026-04-15 15:38:00.344
4	Bao cao 4	weekly	Noi dung tom tat bao cao so 4	\N	success	1	2026-04-15 02:38:00.347
5	Bao cao 5	daily	Noi dung tom tat bao cao so 5	\N	failed	1	2026-04-06 04:38:00.35
6	Bao cao 6	monthly	Noi dung tom tat bao cao so 6	\N	success	1	2026-04-15 01:38:00.352
7	Bao cao 7	monthly	Noi dung tom tat bao cao so 7	\N	failed	1	2026-04-08 22:38:00.355
8	Bao cao 8	monthly	Noi dung tom tat bao cao so 8	\N	success	1	2026-04-12 06:38:00.358
9	Bao cao 9	daily	Noi dung tom tat bao cao so 9	\N	failed	1	2026-04-15 01:38:00.36
10	Bao cao 10	daily	Noi dung tom tat bao cao so 10	\N	failed	1	2026-04-10 10:38:00.363
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: dashauto
--

COPY public.users (id, username, password, role, created_at) FROM stdin;
1	admin	$2b$10$gN9Cdy9Y73h6A3gA334xh.HpmPbjIeCyknUfiE9AIwk5rI.Wi2G52	admin	2026-04-16 15:19:30.72389
2	admin1	$2b$10$TpNFYs0frqp1YMzCwSMI4.hYkiVPWp4DHrbTTGiucLt6C4LaOK9Si	viewer	2026-04-16 15:32:48.364156
\.


--
-- Data for Name: workflow_logs; Type: TABLE DATA; Schema: public; Owner: dashauto
--

COPY public.workflow_logs (id, workflow_name, status, message, executed_at) FROM stdin;
1	daily_report	failed	Execution 1	2026-04-14 01:38:00.392
2	sync_orders	success	Execution 2	2026-04-12 11:38:00.396
3	daily_report	success	Execution 3	2026-04-15 23:38:00.399
4	daily_report	success	Execution 4	2026-04-11 16:38:00.402
5	backup_db	success	Execution 5	2026-04-12 17:38:00.404
6	sync_orders	success	Execution 6	2026-04-12 20:38:00.407
7	send_alert_email	failed	Execution 7	2026-04-13 06:38:00.41
8	sync_orders	success	Execution 8	2026-04-12 22:38:00.412
9	sync_orders	success	Execution 9	2026-04-13 04:38:00.415
10	sync_orders	success	Execution 10	2026-04-15 10:38:00.417
11	daily_report	success	Execution 11	2026-04-14 18:38:00.419
12	backup_db	success	Execution 12	2026-04-16 19:38:00.422
13	send_alert_email	success	Execution 13	2026-04-14 12:38:00.424
14	backup_db	failed	Execution 14	2026-04-14 12:38:00.427
15	backup_db	success	Execution 15	2026-04-15 11:38:00.429
16	send_alert_email	success	Execution 16	2026-04-10 08:38:00.431
17	sync_orders	success	Execution 17	2026-04-13 17:38:00.434
18	daily_report	success	Execution 18	2026-04-12 09:38:00.437
19	sync_orders	failed	Execution 19	2026-04-10 02:38:00.439
20	send_alert_email	success	Execution 20	2026-04-11 13:38:00.441
21	test_from_n8n	success	Chay thu tu n8n luc 2026-04-17 15:47:17.705542+00	2026-04-17 15:47:17.705542
22	cron_heartbeat	success	Cron chay luc 2026-04-17 15:54:49.966121+00	2026-04-17 15:54:49.966121
23	cron_heartbeat	success	Cron chay luc 2026-04-17 15:55:51.053713+00	2026-04-17 15:55:51.053713
24	cron_heartbeat	success	Cron chay luc 2026-04-17 15:56:51.074324+00	2026-04-17 15:56:51.074324
25	cron_heartbeat	success	Cron chay luc 2026-04-17 15:57:51.055233+00	2026-04-17 15:57:51.055233
26	cron_heartbeat	success	Cron chay luc 2026-04-17 15:58:51.051402+00	2026-04-17 15:58:51.051402
27	cron_heartbeat	success	Cron chay luc 2026-04-17 15:59:51.072216+00	2026-04-17 15:59:51.072216
28	cron_heartbeat	success	Cron chay luc 2026-04-17 16:00:51.0682+00	2026-04-17 16:00:51.0682
29	cron_heartbeat	success	Cron chay luc 2026-04-17 16:01:51.061222+00	2026-04-17 16:01:51.061222
30	cron_heartbeat	success	Cron chay luc 2026-04-17 16:02:51.05546+00	2026-04-17 16:02:51.05546
31	cron_heartbeat	success	Cron chay luc 2026-04-17 16:03:51.030393+00	2026-04-17 16:03:51.030393
32	cron_heartbeat	success	Cron chay luc 2026-04-17 16:04:51.044791+00	2026-04-17 16:04:51.044791
33	cron_heartbeat	success	Cron chay luc 2026-04-17 16:05:51.043274+00	2026-04-17 16:05:51.043274
34	cron_heartbeat	success	Cron chay luc 2026-04-17 16:06:51.059475+00	2026-04-17 16:06:51.059475
35	cron_heartbeat	success	Cron chay luc 2026-04-17 16:07:51.067779+00	2026-04-17 16:07:51.067779
36	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:08:24.969421
37	cron_heartbeat	success	Cron chay luc 2026-04-17 16:08:51.024447+00	2026-04-17 16:08:51.024447
38	cron_heartbeat	success	Cron chay luc 2026-04-17 16:09:51.034092+00	2026-04-17 16:09:51.034092
39	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:10:19.850291
40	cron_heartbeat	success	Cron chay luc 2026-04-17 16:10:51.031245+00	2026-04-17 16:10:51.031245
41	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:10:57.054942
42	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:11:02.300048
43	cron_heartbeat	success	Cron chay luc 2026-04-17 16:11:51.039219+00	2026-04-17 16:11:51.039219
44	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:11:57.058502
45	cron_heartbeat	success	Cron chay luc 2026-04-17 16:12:51.032488+00	2026-04-17 16:12:51.032488
46	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:12:57.052006
47	cron_heartbeat	success	Cron chay luc 2026-04-17 16:13:51.044337+00	2026-04-17 16:13:51.044337
48	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:13:57.032574
49	cron_heartbeat	success	Cron chay luc 2026-04-17 16:14:51.036564+00	2026-04-17 16:14:51.036564
50	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:14:57.05351
51	cron_heartbeat	success	Cron chay luc 2026-04-17 16:15:51.034726+00	2026-04-17 16:15:51.034726
52	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:15:57.04478
53	cron_heartbeat	success	Cron chay luc 2026-04-17 16:16:51.031799+00	2026-04-17 16:16:51.031799
54	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:16:57.058163
55	cron_heartbeat	success	Cron chay luc 2026-04-17 16:17:51.029175+00	2026-04-17 16:17:51.029175
56	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:17:57.063266
57	cron_heartbeat	success	Cron chay luc 2026-04-17 16:18:51.038318+00	2026-04-17 16:18:51.038318
58	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:18:57.035924
59	cron_heartbeat	success	Cron chay luc 2026-04-17 16:19:51.03687+00	2026-04-17 16:19:51.03687
60	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:19:57.047676
61	cron_heartbeat	success	Cron chay luc 2026-04-17 16:20:51.032552+00	2026-04-17 16:20:51.032552
62	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:20:57.036915
63	cron_heartbeat	success	Cron chay luc 2026-04-17 16:21:51.033223+00	2026-04-17 16:21:51.033223
64	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:21:57.036102
65	cron_heartbeat	success	Cron chay luc 2026-04-17 16:22:51.036394+00	2026-04-17 16:22:51.036394
66	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:22:57.062978
67	cron_heartbeat	success	Cron chay luc 2026-04-17 16:23:51.038485+00	2026-04-17 16:23:51.038485
68	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:23:57.047365
69	cron_heartbeat	success	Cron chay luc 2026-04-17 16:24:51.040329+00	2026-04-17 16:24:51.040329
70	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:24:57.064946
71	cron_heartbeat	success	Cron chay luc 2026-04-17 16:25:51.030315+00	2026-04-17 16:25:51.030315
72	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:25:57.033097
73	cron_heartbeat	success	Cron chay luc 2026-04-17 16:26:51.045034+00	2026-04-17 16:26:51.045034
74	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:26:57.044109
75	cron_heartbeat	success	Cron chay luc 2026-04-17 16:27:51.033335+00	2026-04-17 16:27:51.033335
76	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:27:57.043053
77	cron_heartbeat	success	Cron chay luc 2026-04-17 16:28:51.040039+00	2026-04-17 16:28:51.040039
78	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:28:57.060613
79	cron_heartbeat	success	Cron chay luc 2026-04-17 16:29:51.04099+00	2026-04-17 16:29:51.04099
80	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:29:57.055538
81	cron_heartbeat	success	Cron chay luc 2026-04-17 16:30:51.039024+00	2026-04-17 16:30:51.039024
82	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:30:57.050249
83	cron_heartbeat	success	Cron chay luc 2026-04-17 16:31:51.036832+00	2026-04-17 16:31:51.036832
84	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:31:57.056208
85	cron_heartbeat	success	Cron chay luc 2026-04-17 16:32:51.036737+00	2026-04-17 16:32:51.036737
86	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:32:57.062699
87	cron_heartbeat	success	Cron chay luc 2026-04-17 16:33:51.045955+00	2026-04-17 16:33:51.045955
88	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:33:57.055297
89	cron_heartbeat	success	Cron chay luc 2026-04-17 16:34:51.047371+00	2026-04-17 16:34:51.047371
90	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:34:57.050627
91	cron_heartbeat	success	Cron chay luc 2026-04-17 16:35:51.053529+00	2026-04-17 16:35:51.053529
92	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:35:57.047188
93	cron_heartbeat	success	Cron chay luc 2026-04-17 16:36:51.050843+00	2026-04-17 16:36:51.050843
94	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:36:57.041693
95	cron_heartbeat	success	Cron chay luc 2026-04-17 16:37:51.05923+00	2026-04-17 16:37:51.05923
96	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:37:57.051748
97	cron_heartbeat	success	Cron chay luc 2026-04-17 16:38:51.03537+00	2026-04-17 16:38:51.03537
98	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:38:57.019092
99	cron_heartbeat	success	Cron chay luc 2026-04-17 16:39:51.026453+00	2026-04-17 16:39:51.026453
100	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:39:57.030511
101	cron_heartbeat	success	Cron chay luc 2026-04-17 16:40:51.036677+00	2026-04-17 16:40:51.036677
102	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:40:57.025869
103	cron_heartbeat	success	Cron chay luc 2026-04-17 16:41:51.031621+00	2026-04-17 16:41:51.031621
104	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:41:57.028586
105	cron_heartbeat	success	Cron chay luc 2026-04-17 16:42:51.028374+00	2026-04-17 16:42:51.028374
106	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:42:57.025741
107	cron_heartbeat	success	Cron chay luc 2026-04-17 16:43:51.029271+00	2026-04-17 16:43:51.029271
108	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:43:57.03256
109	cron_heartbeat	success	Cron chay luc 2026-04-17 16:44:51.0337+00	2026-04-17 16:44:51.0337
110	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:44:57.022593
111	cron_heartbeat	success	Cron chay luc 2026-04-17 16:45:51.029036+00	2026-04-17 16:45:51.029036
112	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:45:57.043836
113	cron_heartbeat	success	Cron chay luc 2026-04-17 16:46:51.026162+00	2026-04-17 16:46:51.026162
114	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:46:57.030396
115	cron_heartbeat	success	Cron chay luc 2026-04-17 16:47:51.022781+00	2026-04-17 16:47:51.022781
116	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:47:57.025099
117	cron_heartbeat	success	Cron chay luc 2026-04-17 16:48:51.028286+00	2026-04-17 16:48:51.028286
118	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:48:57.041567
119	cron_heartbeat	success	Cron chay luc 2026-04-17 16:49:51.032197+00	2026-04-17 16:49:51.032197
120	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:49:57.026836
121	cron_heartbeat	success	Cron chay luc 2026-04-17 16:50:51.017207+00	2026-04-17 16:50:51.017207
122	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:50:57.026898
123	cron_heartbeat	success	Cron chay luc 2026-04-17 16:51:51.020207+00	2026-04-17 16:51:51.020207
124	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:51:57.018035
125	cron_heartbeat	success	Cron chay luc 2026-04-17 16:52:51.017564+00	2026-04-17 16:52:51.017564
126	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:52:57.020659
127	cron_heartbeat	success	Cron chay luc 2026-04-17 16:53:51.021949+00	2026-04-17 16:53:51.021949
128	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:53:57.0274
129	cron_heartbeat	success	Cron chay luc 2026-04-17 16:54:51.020214+00	2026-04-17 16:54:51.020214
130	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:54:57.030032
131	cron_heartbeat	success	Cron chay luc 2026-04-17 16:55:51.020352+00	2026-04-17 16:55:51.020352
132	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:55:57.026129
133	cron_heartbeat	success	Cron chay luc 2026-04-17 16:56:51.015858+00	2026-04-17 16:56:51.015858
134	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:56:57.022882
135	cron_heartbeat	success	Cron chay luc 2026-04-17 16:57:51.025137+00	2026-04-17 16:57:51.025137
136	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:57:57.026693
137	cron_heartbeat	success	Cron chay luc 2026-04-17 16:58:51.018504+00	2026-04-17 16:58:51.018504
138	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:58:57.023663
139	cron_heartbeat	success	Cron chay luc 2026-04-17 16:59:51.020634+00	2026-04-17 16:59:51.020634
140	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 16:59:57.029973
141	cron_heartbeat	success	Cron chay luc 2026-04-17 17:00:51.022752+00	2026-04-17 17:00:51.022752
142	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:00:57.023855
143	cron_heartbeat	success	Cron chay luc 2026-04-17 17:01:51.019517+00	2026-04-17 17:01:51.019517
144	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:01:57.028438
145	cron_heartbeat	success	Cron chay luc 2026-04-17 17:02:51.017963+00	2026-04-17 17:02:51.017963
146	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:02:57.028638
147	cron_heartbeat	success	Cron chay luc 2026-04-17 17:03:51.017125+00	2026-04-17 17:03:51.017125
148	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:03:57.033144
149	cron_heartbeat	success	Cron chay luc 2026-04-17 17:04:51.018675+00	2026-04-17 17:04:51.018675
150	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:04:57.033463
151	cron_heartbeat	success	Cron chay luc 2026-04-17 17:05:51.016641+00	2026-04-17 17:05:51.016641
152	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:05:57.023706
153	cron_heartbeat	success	Cron chay luc 2026-04-17 17:06:51.026754+00	2026-04-17 17:06:51.026754
154	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:06:57.02833
155	cron_heartbeat	success	Cron chay luc 2026-04-17 17:07:51.020789+00	2026-04-17 17:07:51.020789
156	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:07:57.029314
157	cron_heartbeat	success	Cron chay luc 2026-04-17 17:08:51.034728+00	2026-04-17 17:08:51.034728
158	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:08:57.022939
159	cron_heartbeat	success	Cron chay luc 2026-04-17 17:09:51.018956+00	2026-04-17 17:09:51.018956
160	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:09:57.025317
161	cron_heartbeat	success	Cron chay luc 2026-04-17 17:10:51.03213+00	2026-04-17 17:10:51.03213
162	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:10:57.031462
163	cron_heartbeat	success	Cron chay luc 2026-04-17 17:11:51.025054+00	2026-04-17 17:11:51.025054
164	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:11:57.019514
165	cron_heartbeat	success	Cron chay luc 2026-04-17 17:12:51.023609+00	2026-04-17 17:12:51.023609
166	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:12:57.036475
167	cron_heartbeat	success	Cron chay luc 2026-04-17 17:13:51.027725+00	2026-04-17 17:13:51.027725
168	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:13:57.025151
169	cron_heartbeat	success	Cron chay luc 2026-04-17 17:14:51.034379+00	2026-04-17 17:14:51.034379
170	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:14:57.028589
171	cron_heartbeat	success	Cron chay luc 2026-04-17 17:15:51.041139+00	2026-04-17 17:15:51.041139
172	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:15:57.021081
173	cron_heartbeat	success	Cron chay luc 2026-04-17 17:16:51.026734+00	2026-04-17 17:16:51.026734
174	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:16:57.034651
175	cron_heartbeat	success	Cron chay luc 2026-04-17 17:17:51.020232+00	2026-04-17 17:17:51.020232
176	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:17:57.025105
177	cron_heartbeat	success	Cron chay luc 2026-04-17 17:18:51.023538+00	2026-04-17 17:18:51.023538
178	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:18:57.020729
179	cron_heartbeat	success	Cron chay luc 2026-04-17 17:19:51.023419+00	2026-04-17 17:19:51.023419
180	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:19:57.020689
181	cron_heartbeat	success	Cron chay luc 2026-04-17 17:20:51.052649+00	2026-04-17 17:20:51.052649
182	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:20:57.020873
183	cron_heartbeat	success	Cron chay luc 2026-04-17 17:21:51.020849+00	2026-04-17 17:21:51.020849
184	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:21:57.021842
185	cron_heartbeat	success	Cron chay luc 2026-04-17 17:22:51.025974+00	2026-04-17 17:22:51.025974
186	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:22:57.027962
187	cron_heartbeat	success	Cron chay luc 2026-04-17 17:23:51.017879+00	2026-04-17 17:23:51.017879
188	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:23:57.029979
189	cron_heartbeat	success	Cron chay luc 2026-04-17 17:24:51.022953+00	2026-04-17 17:24:51.022953
190	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:24:57.024351
191	cron_heartbeat	success	Cron chay luc 2026-04-17 17:25:51.027055+00	2026-04-17 17:25:51.027055
192	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:25:57.025291
193	cron_heartbeat	success	Cron chay luc 2026-04-17 17:26:51.017154+00	2026-04-17 17:26:51.017154
194	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:26:57.043803
195	cron_heartbeat	success	Cron chay luc 2026-04-17 17:27:51.025257+00	2026-04-17 17:27:51.025257
196	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:27:57.03024
197	cron_heartbeat	success	Cron chay luc 2026-04-17 17:28:51.025312+00	2026-04-17 17:28:51.025312
198	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:28:57.025963
199	cron_heartbeat	success	Cron chay luc 2026-04-17 17:29:51.022565+00	2026-04-17 17:29:51.022565
200	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:29:57.018249
201	cron_heartbeat	success	Cron chay luc 2026-04-17 17:30:51.020252+00	2026-04-17 17:30:51.020252
202	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:30:57.023862
203	cron_heartbeat	success	Cron chay luc 2026-04-17 17:31:51.017896+00	2026-04-17 17:31:51.017896
204	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:31:57.029092
205	cron_heartbeat	success	Cron chay luc 2026-04-17 17:32:51.018394+00	2026-04-17 17:32:51.018394
206	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:32:57.016749
207	cron_heartbeat	success	Cron chay luc 2026-04-17 17:33:51.027974+00	2026-04-17 17:33:51.027974
208	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:33:57.027491
209	cron_heartbeat	success	Cron chay luc 2026-04-17 17:34:51.026753+00	2026-04-17 17:34:51.026753
210	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:34:57.024118
211	cron_heartbeat	success	Cron chay luc 2026-04-17 17:35:51.018511+00	2026-04-17 17:35:51.018511
212	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:35:57.024978
213	cron_heartbeat	success	Cron chay luc 2026-04-17 17:36:51.022755+00	2026-04-17 17:36:51.022755
214	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:36:57.02256
215	cron_heartbeat	success	Cron chay luc 2026-04-17 17:37:51.025677+00	2026-04-17 17:37:51.025677
216	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:37:57.02087
217	cron_heartbeat	success	Cron chay luc 2026-04-17 17:38:51.020564+00	2026-04-17 17:38:51.020564
218	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:38:57.020062
219	cron_heartbeat	success	Cron chay luc 2026-04-17 17:39:51.022125+00	2026-04-17 17:39:51.022125
220	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:39:57.030957
221	cron_heartbeat	success	Cron chay luc 2026-04-17 17:40:51.021836+00	2026-04-17 17:40:51.021836
222	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:40:57.028043
223	cron_heartbeat	success	Cron chay luc 2026-04-17 17:41:51.028109+00	2026-04-17 17:41:51.028109
224	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:41:57.029359
225	cron_heartbeat	success	Cron chay luc 2026-04-17 17:42:51.022777+00	2026-04-17 17:42:51.022777
226	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:42:57.017433
227	cron_heartbeat	success	Cron chay luc 2026-04-17 17:43:51.028364+00	2026-04-17 17:43:51.028364
228	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:43:57.027724
229	cron_heartbeat	success	Cron chay luc 2026-04-17 17:44:51.026885+00	2026-04-17 17:44:51.026885
230	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:44:57.033263
231	cron_heartbeat	success	Cron chay luc 2026-04-17 17:45:51.026366+00	2026-04-17 17:45:51.026366
232	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:45:57.018649
233	cron_heartbeat	success	Cron chay luc 2026-04-17 17:46:51.034611+00	2026-04-17 17:46:51.034611
234	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:46:57.031937
235	cron_heartbeat	success	Cron chay luc 2026-04-17 17:47:51.028058+00	2026-04-17 17:47:51.028058
236	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:47:57.033339
237	cron_heartbeat	success	Cron chay luc 2026-04-17 17:48:51.026754+00	2026-04-17 17:48:51.026754
238	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:48:57.02613
239	cron_heartbeat	success	Cron chay luc 2026-04-17 17:49:51.031726+00	2026-04-17 17:49:51.031726
240	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:49:57.034153
241	cron_heartbeat	success	Cron chay luc 2026-04-17 17:50:51.02835+00	2026-04-17 17:50:51.02835
242	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:50:57.028537
243	cron_heartbeat	success	Cron chay luc 2026-04-17 17:51:51.030927+00	2026-04-17 17:51:51.030927
244	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:51:57.025671
245	cron_heartbeat	success	Cron chay luc 2026-04-17 17:52:51.019077+00	2026-04-17 17:52:51.019077
246	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:52:57.027279
247	cron_heartbeat	success	Cron chay luc 2026-04-17 17:53:51.02381+00	2026-04-17 17:53:51.02381
248	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:53:57.031741
249	cron_heartbeat	success	Cron chay luc 2026-04-17 17:54:51.022337+00	2026-04-17 17:54:51.022337
250	hourly_orders_check	failed	Khong co don trong 1h qua - da tao alert	2026-04-17 17:54:57.031395
251	cron_heartbeat	success	Cron chay luc 2026-04-17 17:55:51.015582+00	2026-04-17 17:55:51.015582
\.


--
-- Name: alerts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dashauto
--

SELECT pg_catalog.setval('public.alerts_id_seq', 116, true);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dashauto
--

SELECT pg_catalog.setval('public.order_items_id_seq', 125, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dashauto
--

SELECT pg_catalog.setval('public.orders_id_seq', 60, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dashauto
--

SELECT pg_catalog.setval('public.products_id_seq', 6, true);


--
-- Name: reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dashauto
--

SELECT pg_catalog.setval('public.reports_id_seq', 10, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dashauto
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: workflow_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dashauto
--

SELECT pg_catalog.setval('public.workflow_logs_id_seq', 251, true);


--
-- Name: alerts alerts_pkey; Type: CONSTRAINT; Schema: public; Owner: dashauto
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT alerts_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: dashauto
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_order_code_key; Type: CONSTRAINT; Schema: public; Owner: dashauto
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_order_code_key UNIQUE (order_code);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: dashauto
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: dashauto
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: products products_sku_key; Type: CONSTRAINT; Schema: public; Owner: dashauto
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_sku_key UNIQUE (sku);


--
-- Name: reports reports_pkey; Type: CONSTRAINT; Schema: public; Owner: dashauto
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: dashauto
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: dashauto
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: workflow_logs workflow_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: dashauto
--

ALTER TABLE ONLY public.workflow_logs
    ADD CONSTRAINT workflow_logs_pkey PRIMARY KEY (id);


--
-- Name: idx_alerts_status; Type: INDEX; Schema: public; Owner: dashauto
--

CREATE INDEX idx_alerts_status ON public.alerts USING btree (status);


--
-- Name: idx_orders_created_at; Type: INDEX; Schema: public; Owner: dashauto
--

CREATE INDEX idx_orders_created_at ON public.orders USING btree (created_at);


--
-- Name: idx_orders_status; Type: INDEX; Schema: public; Owner: dashauto
--

CREATE INDEX idx_orders_status ON public.orders USING btree (status);


--
-- Name: idx_workflow_logs_executed_at; Type: INDEX; Schema: public; Owner: dashauto
--

CREATE INDEX idx_workflow_logs_executed_at ON public.workflow_logs USING btree (executed_at);


--
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dashauto
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: order_items order_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dashauto
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: orders orders_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dashauto
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.users(id);


--
-- Name: reports reports_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dashauto
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

\unrestrict 4uAJkOsdumnaCpopIWiIVvQ1t7GB6AaLOvqeODg0Y0tNDp9srW580UGPbifDxcR

