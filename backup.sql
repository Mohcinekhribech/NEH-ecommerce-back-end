--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

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
-- Name: app_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.app_user (
    dtype character varying(31) NOT NULL,
    id uuid NOT NULL,
    date_of_birth date,
    email character varying(255),
    full_name character varying(255),
    password character varying(255),
    profile_pic character varying(255),
    role character varying(255),
    registration_date date,
    age_range character varying(255),
    address character varying(255),
    city character varying(255),
    country character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    phone character varying(255),
    zip_code character varying(255),
    date_of_creation timestamp(6) without time zone,
    CONSTRAINT app_user_age_range_check CHECK (((age_range)::text = ANY ((ARRAY['AGE_18_24'::character varying, 'AGE_25_34'::character varying, 'AGE_35_44'::character varying, 'AGE_45_54'::character varying, 'AGE_55_64'::character varying, 'AGE_65_OLDER'::character varying])::text[]))),
    CONSTRAINT app_user_role_check CHECK (((role)::text = ANY ((ARRAY['Client'::character varying, 'Admin'::character varying])::text[])))
);


ALTER TABLE public.app_user OWNER TO postgres;

--
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category (
    id uuid NOT NULL,
    description character varying(255),
    image character varying(255),
    name character varying(255)
);


ALTER TABLE public.category OWNER TO postgres;

--
-- Name: ordered_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ordered_product (
    quantity integer,
    total_price double precision,
    unit_price double precision,
    order_id uuid NOT NULL,
    product_id uuid NOT NULL
);


ALTER TABLE public.ordered_product OWNER TO postgres;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id uuid NOT NULL,
    address character varying(255),
    city character varying(255),
    country character varying(255),
    created_at timestamp(6) without time zone NOT NULL,
    delivered boolean,
    email character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    payment_method character varying(255),
    payment_status character varying(255),
    phone character varying(255),
    status character varying(255),
    total_price double precision,
    zip_code character varying(255),
    client_id uuid,
    CONSTRAINT orders_payment_method_check CHECK (((payment_method)::text = ANY ((ARRAY['CREDIT_CARD'::character varying, 'DEBIT_CARD'::character varying, 'PAYPAL'::character varying, 'COD'::character varying, 'BANK_TRANSFER'::character varying, 'MOBILE_PAYMENT'::character varying])::text[]))),
    CONSTRAINT orders_payment_status_check CHECK (((payment_status)::text = ANY ((ARRAY['PENDING'::character varying, 'PAID'::character varying, 'PAYMENT_FAILED'::character varying, 'REFUND_INITIATED'::character varying, 'REFUNDED'::character varying, 'COD_PENDING'::character varying, 'COD_COLLECTED'::character varying, 'COD_FAILED'::character varying])::text[]))),
    CONSTRAINT orders_status_check CHECK (((status)::text = ANY ((ARRAY['PENDING'::character varying, 'CONFIRMED'::character varying, 'PROCESSING'::character varying, 'SHIPPED'::character varying, 'OUT_FOR_DELIVERY'::character varying, 'DELIVERED'::character varying, 'CANCELLED'::character varying, 'RETURNED'::character varying, 'REFUNDED'::character varying, 'PAYMENT_FAILED'::character varying, 'REFUSED_BY_CLIENT'::character varying, 'REFUSED_BY_SELLER'::character varying])::text[])))
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    id uuid NOT NULL,
    description character varying(255),
    final_price double precision,
    name character varying(255),
    purchase_price double precision,
    quantity integer,
    weight double precision,
    category_id uuid,
    benefits character varying(1000),
    how_to_use character varying(255)
);


ALTER TABLE public.product OWNER TO postgres;

--
-- Name: product_media; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_media (
    id uuid NOT NULL,
    media_name character varying(255),
    product_id uuid
);


ALTER TABLE public.product_media OWNER TO postgres;

--
-- Name: product_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_tags (
    tag_id uuid NOT NULL,
    product_id uuid NOT NULL
);


ALTER TABLE public.product_tags OWNER TO postgres;

--
-- Name: tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tag (
    id uuid NOT NULL,
    name character varying(255)
);


ALTER TABLE public.tag OWNER TO postgres;

--
-- Name: token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.token (
    id integer NOT NULL,
    expired boolean NOT NULL,
    revoked boolean NOT NULL,
    token character varying(255),
    token_type character varying(255),
    user_id uuid,
    CONSTRAINT token_token_type_check CHECK (((token_type)::text = 'BEARER'::text))
);


ALTER TABLE public.token OWNER TO postgres;

--
-- Name: token_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.token ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.token_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: app_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.app_user (dtype, id, date_of_birth, email, full_name, password, profile_pic, role, registration_date, age_range, address, city, country, first_name, last_name, phone, zip_code, date_of_creation) FROM stdin;
Admin	40139aca-18bb-4abf-98c5-17a905ab5bf5	2024-11-21	admin@gmail.com	admin	$2a$10$CC3pGYEQk.XP2rTIFqRtJuiGP41WLwzwu65G/VhN5zGrNkHgvVtVO	string	Admin	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
Client	16910ff3-5ce9-4e6a-bbb9-fafe1f328411	\N	m@gmail.com	Mohcine Khribech	$2a$10$7u.0/QMNSRZFolAckoQPBOc6pwqFtosafg0DgZT4elNW1cMXC6.eO	3f88116c-4997-44e7-80c0-bfa5aa4fdd50.jpeg	Client	2025-02-12	AGE_18_24	Elhouda , pré de lycee ajdir	Agadir	Morocco	Mohcine	Khribech	0631560367	80000	2025-02-25 12:58:40
Client	5ee6da15-9409-4c0a-a3e5-1e06e57227e7	\N	mK@gmail.com	\N	$2a$10$IIo0f4dxCj/bAx7OKRJDdeUMJtuYgh5MzB/CID0M/u3MS66IdpsLS	90f81095-b5d2-4f4c-9c99-d2681c1b3384.jpg	Client	\N	AGE_18_24	Elhouda , pré de lycee ajdir	Agadir	Morocco	Mohcine	Khribech	0631560367	80000	2025-02-26 14:25:33.344978
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category (id, description, image, name) FROM stdin;
e9bce0e7-ca8a-46f5-a352-9d2fedca74b6	Lorem, ipsum dolor sit amet consectetur adipisicing elit. Numquam perferendis fuga iusto corrupti repellendus assumenda ducimus ad dolores\n	82257e3d-e199-4d4d-86ce-8fe95a235585.png	test
041a4b64-0762-497d-94a1-2f58fc3dca39	Lorem, ipsum dolor sit amet consectetur adipisicing elit. Numquam perferendis fuga iusto corrupti repellendus assumenda ducimus ad dolores	82257e3d-e199-4d4d-86ce-8fe95a235585.png	Mask
\.


--
-- Data for Name: ordered_product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ordered_product (quantity, total_price, unit_price, order_id, product_id) FROM stdin;
2	600	300	bb146d72-c10d-4ade-afef-8c5f850a1a50	44ba4932-e9d7-4261-91f1-316c3af622c5
2	600	300	27597f84-42a6-4557-b7c3-bd3a80d84677	44ba4932-e9d7-4261-91f1-316c3af622c5
1	300	300	ba7ea7e9-4918-45d6-b5d6-6ab2fb407230	44ba4932-e9d7-4261-91f1-316c3af622c5
1	300	300	fa74ac84-c22d-4b74-9d87-0bc9b67f5502	44ba4932-e9d7-4261-91f1-316c3af622c5
1	300	300	f7003c8b-2feb-4817-acf1-4bf67c1e9c8b	44ba4932-e9d7-4261-91f1-316c3af622c5
1	300	300	08ef5bc5-5552-40df-8c93-d727381136e5	44ba4932-e9d7-4261-91f1-316c3af622c5
1	300	300	3d09be91-e0cf-443d-affd-1bfe9884e2a3	44ba4932-e9d7-4261-91f1-316c3af622c5
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, address, city, country, created_at, delivered, email, first_name, last_name, payment_method, payment_status, phone, status, total_price, zip_code, client_id) FROM stdin;
c2216c6e-a2ae-4d04-adf7-e1ea9660efd3	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:44.320246	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
e123872e-bc12-4838-8e3e-6ef6eba5144f	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:44.567917	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
17085659-93fa-4a13-9645-ae0ba4690503	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-25 13:22:34.476253	\N	m@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	DELIVERED	700	80000	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
8ceed63d-f753-4726-9e0e-e309a5a1cba2	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-25 13:22:23.026805	\N	m@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	DELIVERED	1000	80000	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
7e2fa2bb-4445-434e-9900-ec0cdc1b6d64	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-25 13:22:22.526386	\N	m@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	DELIVERED	1000	80000	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
55a90d46-b0e8-480e-afff-edddcb569d6b	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-25 13:22:32.729236	\N	m@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	DELIVERED	700	80000	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
bb146d72-c10d-4ade-afef-8c5f850a1a50	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-25 13:22:10.520291	\N	m@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	DELIVERED	1600	80000	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
27597f84-42a6-4557-b7c3-bd3a80d84677	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-25 13:22:11.408307	\N	m@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	DELIVERED	1600	80000	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
ba7ea7e9-4918-45d6-b5d6-6ab2fb407230	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-25 13:27:50.054086	\N	m@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	DELIVERED	2510	80000	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
0880dee8-ea9b-4f6e-9c01-5050b2b261fb	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:39:42.490921	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
b7d67ca0-7503-4fc5-b760-7cf10ca9816e	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:40.649364	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
58bb2144-1cc4-4055-bfcb-5122e9ec1273	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:41.069442	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
87c8702b-6255-4804-9dfc-1f3f862d6445	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:41.380039	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
9b017ff1-e0a9-4ef9-8eca-74a518919a81	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:41.666559	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
dd99dca3-bba8-43d8-9f76-78656e7cec43	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:41.965264	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
94cabe4b-a842-4f74-8efb-6019b8315d6b	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:42.209777	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
f3d56188-f580-49cb-bac7-5fdb0f629cf7	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:42.463821	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
4adc53ef-fce4-4ebd-b700-1a764feb10f7	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:42.670291	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
a13e9811-5d66-4c22-b4d8-34813eef1232	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:42.965509	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
73df9c32-3ca8-4d4a-b36f-9350b8d088fc	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:43.187739	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
fe88cd93-9fe2-4be5-a563-39ae6b78788d	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:43.397864	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
91c6e3dd-1293-4545-98bb-876b8982e9c7	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:43.808483	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
0f03b5f7-439a-4a2e-9f37-a05a34208def	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:45.021755	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
374b79f5-a754-4041-a6cb-0777f0669cc9	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:45.208415	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
5954b955-9606-4bbe-8bd2-fa58b5442acd	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:45.446889	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
898cd76d-7fb3-47aa-a75d-da67ef3c28ec	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:45.669204	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
bbb286d8-a547-4bc7-824a-2c86b3315e7e	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:45.870624	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
8c5b7437-fb16-4611-8307-410292f36505	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:46.048454	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
cd9f8bfe-b78a-461a-9dfd-6a31c6260e2c	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:46.297111	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
1fb48d30-3585-4124-b75d-51731045a8a1	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:46.547764	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
eb93a0a7-4c88-48a7-9757-50ef3aac4d0f	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:47.197558	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
0daed512-85b4-4bb5-ad48-929fca5dbef2	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:47.330638	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
970992da-d086-464e-8cc6-6af326afbd6a	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:47.505035	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
98168cde-fa80-47dc-a702-062d60addcd7	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:47.64987	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
fa33256a-0fbd-45cc-b90a-b3cbdf49c766	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:48.102207	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
f7003c8b-2feb-4817-acf1-4bf67c1e9c8b	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:36:51.942157	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	OUT_FOR_DELIVERY	1300	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
f777ca02-ce14-4349-b1a4-c28bacf7ce29	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:44.780106	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	DELIVERED	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
d26140bc-14c0-4da2-9a4a-b9a61e3ccf6b	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:44.07831	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	DELIVERED	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
c961ad38-ce53-465d-8f43-8ddfb7bfd9a0	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:48.234012	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
614b8d22-3853-4a2e-84d6-1e94d9ee7614	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:49.51291	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
a00a6572-d410-4de5-82d4-ee0a2e0465d8	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:50.155847	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
4d6c9ec8-0b30-4311-a75e-953fcdd064d3	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:51.179469	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
b225ea2a-46df-46a8-bbb2-36b298c88971	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:51.816699	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
e281aa48-8069-40ec-816d-cf1196ccd4ec	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:52.800268	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
343430fa-5cf9-402c-9a72-4573472c0e68	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:53.607329	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
830b76f8-ef2e-4e4f-ab75-7bd0f243e216	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:54.638927	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
7f038ca3-038b-4468-8e24-0e27aded13f1	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:48.398018	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
0f274c1a-1fc9-440b-8707-20b8f2094fb0	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:49.022185	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
7d9bcf12-2de2-4187-9606-db7b0bd026e7	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:49.201281	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
1b0fa420-15d3-43ec-866a-925e594b439f	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:49.679198	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
2c026c26-dd7f-4199-a2bf-309fe06214ef	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:50.005584	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
9f4f917b-f457-4fb2-8511-e64489117fed	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:50.325362	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
fd902471-b519-40a2-acc9-f08ec504d61c	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:50.680731	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
c611c6cc-e79e-4324-b3c9-380a46557f42	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:50.833946	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
9a180e99-c848-4309-9f95-abb2a8436672	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:51.338505	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
c2eb56c3-fe13-42c0-aeae-7dac2ef36c67	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:51.662302	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
16785941-dd44-4b32-853f-f9829a863aad	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:51.96562	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
4e3957bc-6593-43ca-a4d3-af4322eafd1a	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:52.307464	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
68ce24ce-aa78-4479-bee3-fc2b4ff222f3	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:52.481861	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
48002886-2968-4206-b715-21199e812ee5	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:52.981297	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
a706aad7-92fa-4fb3-907a-2aac371d059e	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:53.424245	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
1fedddd5-f6f5-42ff-9256-24ac87283faa	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:53.781416	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
5664c3a3-66e4-4d98-b13b-7697989632fa	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:54.105554	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
a39db70f-5919-4f55-a2a7-fa60c666507f	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:54.285771	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
3f7d061d-fdbd-414f-8fea-5604e3369b90	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:54.793644	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
b4918a63-d082-4c56-980d-9b407e1d2028	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:48.549798	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
741c0590-564b-4251-9c97-259d4eba4929	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:49.350792	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
9d34bec7-5537-448c-b7b3-63690c924da2	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:49.82561	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
527645f7-1f37-48cb-aced-de6aa140a6b3	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:50.506999	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
75fe0327-4eed-47dd-bf8e-3e9ec1bc3168	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:50.999476	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
05c35da2-0b49-44f2-845a-f9654b275667	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:51.518411	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
12bc7bde-8db7-455d-a264-a2395d56ec41	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:52.135029	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
6ad0abbd-8241-4f01-a16b-274f42378f99	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:52.631703	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
fcb3f656-5da9-4b82-a8e8-340e548ee22d	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:53.116482	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
df902934-4829-4253-8690-11233e5c06dc	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:53.923517	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
57c262df-99c7-42d2-914e-181227ed5fcc	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:54.45026	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
579bac4b-f66e-4387-800a-7b7339797d11	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:55.191076	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
8120a4f8-33b4-4dff-80d2-81334e762a62	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:55.370462	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
4294d98c-0395-438d-b7ec-c3421e4fda11	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:55.54381	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
d0f88075-1fd1-4443-a400-a48dbd2775e2	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:55.716723	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
15d9623c-67e3-4efc-93d9-5e732d5e56a4	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:55.905867	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
6934f079-6af1-4b95-93b2-c1fb560477a1	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:56.08052	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
6067147b-acd3-478b-bf70-e3e89de8caf3	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:56.261162	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
bdd6b371-d35c-459e-b1fd-16ee7296d741	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:56.443979	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
68872024-53d8-4974-a465-c4296d9d4bd2	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:56.613349	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
d173562f-faa3-4eac-81a8-020450ae8c8f	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:56.802908	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
917ac3ae-1286-4d22-be38-01b425a305fb	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:57.007735	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
e99ade17-6577-470b-a589-85c932ae7dc4	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:57.168074	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
4bcbe63f-7d83-40a6-b067-33934eaa2066	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:57.367671	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
c8da7803-03fd-4c1c-9bb0-b57fb470639e	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:57.561574	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
da7295a8-cf64-4b5e-a8eb-c73d76be884c	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:57.714856	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
fb0b4b70-b0bb-45a4-9aed-d29f28897a46	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:57.911646	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
092d5a9d-a385-4cf9-903a-73e7b7f05eb8	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:58.048447	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
da22527e-add8-4e6f-87c9-ac536d81c467	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:58.224875	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
55358ff5-09d8-401b-97b4-66ac7ff138cd	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:58.404069	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
88d4b42b-404c-4e3b-878c-41186a52396d	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:58.591782	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
3a0e2f23-5fdd-457e-a28e-12a17cb96653	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:58.778566	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
d5e4315f-8420-4cbb-b556-33ec590ca85a	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:58.961888	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
531decd0-6c7c-491f-af91-51ae4c69aedb	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:59.150051	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
872de6cd-5013-47a3-84a1-de5c5c177937	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:59.321362	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
07b7f3b6-e98b-41b9-b59a-9b9e207f61a3	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:59.53232	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
10488254-a769-4fe3-9336-1dedf9326b69	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:59.698016	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
a3cb6aa1-0961-4d96-aa58-abc718f3a508	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:40:59.89326	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
ef78bf84-a155-4269-8a07-f1a78dd31b7f	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:00.047669	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
938de532-5618-4a4d-ac16-bc17a77db73a	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:00.206784	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
58e8d419-fb4e-49bf-94f6-3d63d2e29cd2	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:00.371017	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
12ed81de-359a-4366-b7b3-fa79f74cd3f9	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:00.702743	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
895ae975-144d-4911-a565-beddcdfe6730	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:00.889509	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
2b65c86d-d22c-4f3b-aa21-e76a47ad45dd	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:01.211459	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
368d2ff1-2192-42df-b376-b65d34a1f6e4	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:01.370029	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
5ac04dcd-92a6-4293-b75d-6eea05d232d2	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:01.951339	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
8129dc60-e012-4056-a0ad-07fc27e5b0bb	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:02.325039	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
5f4fc323-89a4-4f12-961d-7ce0ff9f4761	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:02.719319	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
0ede1637-5c3a-4202-a316-6eceb790bda4	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:03.202011	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
e27af69b-0535-483d-a144-e396bbe85bcb	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:03.793352	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
22bb8ee3-8436-44c4-a052-7fc272f01ce4	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:04.168794	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
13c9b08a-41cc-436b-a4cc-e53475358cd9	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:04.57964	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
a0c310fe-a84a-4857-a86a-6d0a56cfe02a	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:04.982841	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
51bbd4b5-4505-44f0-98cf-81e596015caa	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:05.151788	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
9f96b765-43e6-41fc-b4ce-657ff30f09f3	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:05.719352	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
6db19e00-f9ac-49e8-8340-3128d25feeaf	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:05.984137	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
183fb8f7-a9b6-47bf-ad40-17d5f14cc3e7	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:06.272833	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
f18e8890-4f00-4059-b70e-7dfeaef8af24	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:06.676418	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
a407fabb-568c-43b5-a812-c74f3e4ee5f2	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:06.893433	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
699d179a-ad9d-4288-abc8-ea889cb7cf4e	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:07.334312	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
3d4ba56b-b782-48b7-b253-156c8206599c	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:07.660347	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
198ba4e5-b82f-4cdb-9a03-94297264d994	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:07.961862	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
4ea42d5b-e4ea-4764-804f-311a2cb026fd	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:08.302707	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
209bc99f-fcd2-41dd-899c-ab17007aaa15	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:08.477682	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
718e6ef0-abd2-4582-8be9-b90c163672a4	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:08.977329	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
4793cc57-1a6a-41b9-b757-aa2e2ab2d47c	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:09.336852	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
5b259c3e-ae45-4cba-ba2c-f2996c88ebac	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:09.660846	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
f13460e0-ee9d-4d63-8da2-c092de76dc02	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:09.99239	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
fe0c5a87-0164-471e-ae94-0b26252926bd	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:10.172871	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
abc37b10-3670-41fc-911e-83c7e62aa391	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:10.751312	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
19675bac-977e-42f2-ac9b-4f53a8461c0a	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:14.966486	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
79de8f51-3ae2-447f-9f36-23c26165801e	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:15.258531	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
895855ea-ea30-41ab-8a27-3a0318ca249c	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:15.402483	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
79bdee03-1823-4b55-a52b-ce7abaa11066	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:15.802994	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
e3356816-cd96-4061-9659-e730368d2f20	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:16.058303	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
fdd03e76-c088-4132-ac0a-1aaa88e967e5	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:16.355812	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
43b9d4ed-1da5-40b1-b3ac-020bf53e255c	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:16.616299	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
5e11f6d0-f5f7-447f-aec6-79fb8a03a7f3	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:16.759173	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
079aadf7-1f4f-43d4-95c5-11ea97c67e16	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:17.211195	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
5f32982f-8aa0-4501-b43d-2087661eca4b	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:17.519103	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
b59a063b-6ecd-4123-a6cf-18047f330c0c	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:00.533335	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
5005262c-0e25-436f-9042-b4e43224e2d2	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:01.043085	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
edd1289e-e0fc-44f7-b949-839b927a30d3	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:01.573866	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
ddb717a7-ed49-4d8d-a729-c186e7698d00	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:02.126655	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
770c784c-66bb-45de-8269-22f3639f5dd5	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:02.986544	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
7cab774d-8d90-4529-922a-828815d91064	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:03.380194	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
415cab77-37bc-4d93-82b2-0595cf9a58dc	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:03.961501	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
40f7b596-12a6-40e3-a6d5-c90992414993	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:04.802193	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
fd19793e-22ab-476c-a625-a1b2b0356d41	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:05.399781	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
b7915dcd-6b57-442b-a3b9-8c5bda78ed12	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:06.505414	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
2ecfbc89-f964-46f0-a0fa-ba67bb03a8f3	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:07.02661	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
e8f9816d-08c1-47bf-97a1-88a64fece56d	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:07.487682	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
faf4f093-de8e-410a-b763-d76176d115d8	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:08.130221	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
fcaea9fe-ec0c-4acb-94bb-9fb6d4f729fa	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:08.680768	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
5394be72-4952-4c0d-8161-da24c64a0c91	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:09.146953	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
ab4e3229-054a-46ff-8a8a-aafb6debf5f8	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:09.797424	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
896a8da0-8129-4ee5-bc87-90b925e174c3	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:10.373584	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
e4ceb3b5-b3bc-45c2-aeff-2638fbca6e57	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:15.124957	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
c2b8cb62-9443-478b-a729-df6dc7ed2a92	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:15.533265	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
2179f50e-132f-40a5-afad-d6e670327ad5	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:15.931614	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
2d97ef91-e59a-4b00-ab64-147979e49713	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:16.466708	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
faf70a99-0009-4f8c-801a-a1636d63197b	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:16.902566	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
746fabf6-14c7-4549-86d7-15e987675b37	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:17.339252	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
a4e81e10-11cd-40f4-8b78-233fd38a4dcf	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:17.961157	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
8084249d-06ca-4663-8198-9126f59d43b7	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:18.357455	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
8028334c-9d3f-4230-81d5-6ac79a928638	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:18.798383	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
1ef74510-e744-4647-beed-11dda1d586df	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:19.628199	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
67dca310-aba0-485b-88c1-202173f276d9	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:20.09327	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
34ecd8ff-6a4d-4696-b998-972ea2804f89	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:20.735058	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
6606ebc5-257f-4681-9cf7-04d6d202d064	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:21.203769	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
faab11f9-fa8f-4d70-8c84-ba113cf7d470	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:21.71296	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
adb62e05-2724-4bb2-8d0d-9146de32c237	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:22.363638	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
b5ed0b27-beae-4846-bd25-a95f42444fbb	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:22.842639	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
90515329-a8d4-469d-8815-2cc0a111f6e5	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:23.181043	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
a39a54af-cdeb-4476-9866-2b2bb0046a39	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:23.83492	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
2187fbec-92bb-4598-aa21-18102008c805	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:24.701549	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
b399c44f-2561-4493-a644-502faaa91f0c	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:25.418605	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
e1808134-bbe6-4cc0-89b8-9c8b9073536d	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:25.938142	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
5ecb0173-6bfa-468d-bde7-e4933456d6db	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:26.496241	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
3dd61214-edc5-44c8-a99a-3dee53ba1f3e	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:27.186711	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
96af3679-7c12-4d92-bdda-369f3aeab5a9	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:01.776178	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
f544d703-28f0-465d-a29c-7f8a4fc049b6	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:02.548791	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
9f5bbe27-d235-4c67-9795-bcebcb3f7fc6	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:03.60901	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
587eb10e-a4ec-4d44-843e-e53fc03c5186	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:04.39651	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
e1c7efb3-a762-4d60-96ae-5979ceb01818	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:05.578069	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
3d06b049-e98b-405f-afef-d166d99e7b41	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:06.082676	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
49933edf-1a4a-421b-9949-0fd33540e4ae	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:07.180354	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
43505d48-4c4d-4291-a75e-d8046fe51e62	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:07.810845	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
c8c70d1f-eb86-4935-be66-6e9f533f7bca	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:08.816759	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
e9a7b7a7-f069-465a-9dbe-6d18a96c143a	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:09.49811	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
5d8117da-47dc-4dc1-b378-2b7fadca73a2	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:10.5434	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
91c0d165-f586-456e-bd7f-4cf9742c2c3d	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:14.268733	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
188e671e-6a1c-4697-8cc7-e3256af87d94	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:15.665737	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
67f840ee-43f1-4b0f-baf7-4506e52f76f3	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:16.196435	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
02fc2cd8-7538-43b8-bef1-c9d30fa0cffa	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:17.046984	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
595764b4-6854-490d-8e96-5467031d995f	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:17.683658	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
765f61eb-623c-4c67-a700-d97a445ca92d	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:18.488478	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
e749659f-ab41-40be-91ee-c686f996936d	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:19.057196	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
70f4b42d-668d-414f-8acc-54b782b749be	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:19.797143	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
a7d9205a-8621-4d10-b1bd-c81b0edda66a	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:20.398875	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
ce81b000-c4ed-4c27-9821-7c80ff74d390	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:21.348941	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
db1c096e-91d1-4ad4-9a4e-1fb6c3d9a31e	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:22.03882	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
28882867-3280-434a-a7bb-979b2f3242c1	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:23.008786	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
b61b6c2b-ec41-4968-8f53-33a561fafb29	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:23.512216	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
1a1001b7-cce6-4eff-bbee-09a13cd9c123	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:24.382472	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
1cbd4258-94bc-438c-b2e0-31b29305fa20	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:25.043071	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
043af79b-7920-4260-8954-84cb9be8a8cc	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:26.162808	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
0d979fa2-23a3-48c5-b24e-0382cbd238a9	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:26.839417	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
183870d4-81c3-4942-96da-425329b05124	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:27.895164	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
c151534b-4735-4040-95a6-d64ec195b8dd	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:28.558495	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
8b37823d-771d-4fe5-8893-95299a4c2229	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:30.039473	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
809ee95a-de26-47f7-aef7-855fc12d2b53	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:31.102296	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
281fbd53-8ea3-4d00-9831-71d8b943dc1c	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:31.769083	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
a7642943-225a-4589-acda-505c2f0cc4aa	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:32.769278	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
065294c5-1d6a-415f-a564-a883a1f7e6ae	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:33.296703	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
89ae1f88-dc72-44ef-bb15-66343ea8146d	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:34.417271	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
b6946552-3302-41f1-bc3d-f3307a670def	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:34.991036	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
d69ee926-a509-43eb-b66b-7ab1d02b5adc	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:36.08517	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
5492bce2-e4a0-447e-afaa-91e727f7a55c	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:36.76363	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
0abf9528-b29d-4a13-9c3c-e925b4621311	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:37.824765	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
289983d0-ca23-4339-8c1c-24d07c1558fe	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:17.806239	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
f8fb50ad-e6c1-4b0f-a247-c5cc094f0e21	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:18.084048	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
aa65be2a-d69e-45cc-9b77-3fcabd209684	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:18.207604	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
4e67990f-0760-4195-8541-46be697f4e15	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:18.648438	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
c4b4ae6d-95fc-4c6e-834f-d683da6058c3	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:18.927847	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
184f9804-64bf-4c45-9996-02b69359ed60	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:19.21975	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
bc16c1de-44d9-43b6-bd13-2bbd29f1ee9b	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:19.343106	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
70490021-0971-4878-9e84-688103a4d6c7	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:19.494602	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
b726ea62-3510-43ca-9975-70f22baf7245	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:19.968238	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
30925558-f558-488f-a6be-9b5c812f2123	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:20.233457	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
e9fcd678-5b3a-4e85-9c06-3fa15c32c39e	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:20.553052	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
f6569be5-abcf-408c-9ccf-24d40a1cdc31	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:20.87344	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
d8081de7-1d60-4794-88c7-0b1e02acfaab	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:21.052472	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
f3373312-8532-4887-9887-8283b8ae2566	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:21.542489	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
0677e2f7-71b6-494b-9c37-53f8494d1f43	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:21.863665	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
a42de087-4660-4cb2-a77e-b24564eb53dd	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:22.209994	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
3f19cba0-1f40-48b6-a7d6-449f1eda7af1	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:22.532178	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
d93af777-15fc-4cad-83d0-5abbf94cc916	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:22.675322	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
ed915f7a-cb71-417d-8c1a-937fdb432164	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:23.34154	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
1df37eb1-a0a4-4c44-8715-bc03d0282f30	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:23.653525	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
aac27d58-9368-418d-bb81-03431ff30e98	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:24.018363	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
a27cc135-5e7c-4915-930c-dface2aa2f12	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:24.209914	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
951aec6e-c289-4729-b681-2837826fb0f6	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:24.536551	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
225af81e-2469-4671-8bd5-77caa27618a7	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:24.890316	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
44b791af-5833-4265-9260-db649882504d	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:25.225968	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
23af5b5a-58b8-459e-acaa-c7c440aa43c0	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:25.570771	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
f83c0d02-af4d-444e-bb8e-482e390779c9	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:25.763602	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
edb520e7-e58f-44f2-a1a3-d41256058aba	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:26.322175	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
2f0678dd-0c5d-4658-80b6-9bee24af886e	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:26.653232	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
0654b23f-d0f8-44e6-b668-fcc5624767b4	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:27.022668	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
3f68e9fb-a543-49e4-a31f-7d7ab18c23c5	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:27.354925	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
5efadcbd-3702-4637-a957-cc2c453f8baf	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:27.539196	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
fca05330-c581-409f-af1e-d73643b27678	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:28.04284	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
00cbde14-a623-4da0-84a5-6d651aa481a3	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:28.380049	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
9b746340-3d75-4c30-b30c-3da2e0d42dbe	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:28.702153	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
83e91ff5-f1ac-49df-a50c-67ddbb57d42a	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:29.031349	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
bfafbabf-6d41-4357-8fc4-0fb9a846f56c	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:29.228608	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
489f1df9-55e4-43e5-bc96-31a8a9a0bb1c	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:29.540641	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
fd594585-5131-489e-bd36-3f2776ec6e8f	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:29.882026	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
4738153a-2d2a-4bcc-8658-0d50a0c11808	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:30.228294	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
74bab91a-6ac3-4a41-b385-e1a35de0fc1f	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:27.709367	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
48b27ec0-45de-4ae6-b1b5-f37642f64a49	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:28.221529	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
a5a48975-aeee-471f-9cf1-bb2478c057a5	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:28.911823	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
b58c5ac2-b16c-49d2-b808-9926b2f7838a	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:29.36975	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
7d5791da-aefc-46ac-930a-4e608af7a800	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:29.708705	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
0bf103ef-e51b-493f-a146-6bada4f0e68f	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:30.411186	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
d9cc8b95-e1f0-4ce6-8038-a880febc5d2e	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:30.930631	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
ac13ba49-263b-48ac-be6a-159411a62908	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:31.464136	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
035d2f36-a20e-423c-b9d1-f2d559c2fcf9	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:32.09829	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
e2ff2e91-5521-4182-bcca-410d5e68a21f	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:32.595737	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
c78c0978-ee10-40b1-8da1-154ef373df61	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:33.102863	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
8282be61-b8e6-403f-82ca-55ce854cac88	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:33.674919	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
694e5b91-b94c-432a-b2ca-fb251fcb8ec2	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:34.261585	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
fff81183-3987-411f-a78f-b9a3e50fb647	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:34.610743	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
79f38870-4e84-47bc-9f90-5b083e451406	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:35.37217	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
4f0d04f9-cb36-474e-b458-06ddf859ff03	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:35.911013	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
1fe2bb78-deec-42a0-923c-0b6f0cc00a83	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:36.418853	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
71b60444-d34f-417d-959e-a3c9c21546b8	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:37.121122	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
16b596d9-e0f2-489a-b3e2-4f807bc28c9b	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:37.650138	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
fe23e610-1a92-46df-bdff-0912cfe0b7c0	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:38.167004	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
73d3e4ba-d731-4813-8a97-5de30d4ed99d	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:38.861129	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
9e499569-1ab1-4f16-8b46-6370e447213c	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:39.458172	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
cce25f7f-cb98-4dba-be06-f2ba2f1520c5	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:39.896032	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
bc98fcd2-b1f6-43c4-8036-35a3495f6a4f	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:40.693616	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
e616daf7-1b7f-4e28-a05c-2589a36bcabe	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:41.304033	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
c5c70279-0490-4cc0-976c-a24332b92f93	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:41.938439	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
0b4955e4-684f-4cd3-996a-9375715b9204	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:42.647253	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
56bd274c-fb9d-4a87-8d21-40a302f2f775	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:43.625912	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
2e38d5ee-45f4-48df-ad22-6d10ce60e146	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:44.398076	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
0d9f0e96-bd57-47cf-81cd-a2c256c306e0	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:44.777965	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
c4a70923-56b6-4a6e-bef5-d7ab3140ce09	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:45.329277	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
bdaf0587-94f5-43b1-8be8-9e915a109736	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:45.991803	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
674c717f-5eb9-4d33-81d3-50943b28fced	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:46.485648	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
8b39f6b3-99c0-4555-8f8f-8bbed75501b7	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:47.01516	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
9ca97e35-0341-490a-88bd-005141ea45d6	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:47.728775	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
4a72ad51-08f4-44ee-a012-5293cb42922e	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:48.278496	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
54c0f413-1c60-42fd-89cd-e3b9dae14998	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:48.841502	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
a30306ff-1f7d-47f0-8b24-e521d035acea	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:49.549669	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
ae38fd47-8470-4b08-aca9-c5ffd7bbe348	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:49.935802	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
58984702-794c-4fc0-be78-eb5cbb9d9739	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:50.491825	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
a33ab7ee-dfc2-472b-8b8e-7a91e2b4ee3c	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:30.584483	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
3bc5bf86-f9c2-4967-b0fe-efdb06459371	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:30.772367	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
d3758327-30aa-44d8-a846-c20279336f0d	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:31.273189	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
37cdd5eb-1e84-49c2-82c8-22212bf25e6e	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:31.617752	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
9cf519e1-ce54-4787-a20a-64c6c1c23293	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:31.928583	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
95d4eacf-632c-4386-8f44-68fdda08e67f	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:32.261213	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
dd1e783c-cc21-4461-af0f-09260f9da2a6	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:32.415666	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
a50548b9-32a4-4581-8f0b-a03d98471436	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:32.928397	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
e3b0b168-bbed-482a-a806-24df305bf8b0	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:33.497811	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
732c15c1-ccd2-4b61-9917-c3e66c805cb7	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:33.889347	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
c999d68a-9844-4b49-84f9-4db4775b785f	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:34.064582	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
05102ea4-0734-4a5d-a458-e9a19847a682	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:34.810949	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
b63aae06-88e6-45eb-b9a6-610fd1bf4ced	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:35.185971	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
de216d8c-7290-41cc-b95a-92fb5ab6b57e	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:35.555316	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
446e9896-0224-44d6-8c87-23e3f63e36c6	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:35.752285	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
9ccd8f83-a2bb-4024-ab32-8c7866f745a6	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:36.244026	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
3ed4d55d-d6ac-4b15-b090-7a9cc5647274	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:36.587398	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
4f44d1c9-cd4a-4dd8-9c5a-a3560c96893c	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:36.952738	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
fb29f268-168f-453b-9601-116d202c7b62	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:37.294179	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
8d74e962-6fd1-462c-a531-e16ff99130f2	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:37.477744	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
cb47cc07-b7a1-4ab3-8f6b-df7379f528b5	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:37.989686	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
a08100e5-2a31-4271-92ec-7f4d0b4a574d	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:38.328455	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
410f9429-0363-42bc-888b-7bcf8a2d39b9	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:38.706785	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
5deda694-dbfe-4ad8-af9b-a2ebe3c69371	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:39.03362	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
5b2355c6-c528-4d87-bda4-3a606078419f	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:39.208294	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
a3fb422f-cea7-4d1f-a209-7da119b136eb	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:39.674579	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
485e9948-1066-43c6-bbb6-75672ac59197	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:40.099751	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
363b40d4-fe83-4a0e-8600-1e2d931596ca	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:40.488589	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
bae97291-e9c8-4409-a59a-b939b0f709c2	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:40.917998	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
155b853a-9b7f-49f9-b066-fc94f460de01	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:41.124625	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
703e3835-ab69-4ce5-ac24-749fa7df2e61	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:41.761213	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
ce6ae51b-7218-494c-b2e9-8f01d2a36a4f	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:42.144853	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
53ade52f-dd87-414b-aa00-58e666a86df9	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:42.504281	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
2d1428a9-d499-4091-a028-a4bd8022b6dd	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:42.821899	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
ef0747e1-a168-4803-84e0-3e1449490e54	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:43.00181	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
9088c7ad-e53f-4133-b8cc-82efd6ac8539	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:43.420729	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
60446daa-a81b-41ff-a561-802326a6f002	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:43.818051	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
0d44596e-7b06-4e9b-a2ce-7d73441f2128	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:44.212783	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
83750e97-90f6-44da-ad78-9e33f501312d	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:44.614221	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
bf70b2e7-a445-4e33-8caf-2feda9ded968	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:45.175399	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
d5cfde93-3d62-47cc-a27a-d58cc87ac465	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:38.509765	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
7febcc7e-0c42-4590-a6c7-043c49e396ec	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:40.31147	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
0275a3d6-f1b3-4799-a76a-246666376a14	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:41.488446	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
a2465f08-f344-4338-beb6-300966651b15	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:42.312975	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
8a59a502-6b9f-4bb2-bca3-d18f3d60e71b	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:43.194362	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
829820a5-4287-4719-8131-d7069c61fc0b	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:44.006023	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
f4413977-fb6b-4837-916c-34e3ae02b740	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:44.980674	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
10c30afa-1afb-4cee-bb2a-311b164a6e91	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:45.663594	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
ec9f9c19-664a-4477-b690-2603c44cdc4b	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:46.65817	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
e8e23dce-341c-4017-8361-ca94f0c2f22a	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:47.37267	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
f63bee7d-53fd-4cdc-ab96-818ccd9ca776	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:48.479171	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
28b0d55d-ba74-4629-b1f4-f579e19f8ec0	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:49.191924	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
517a411f-9bc4-4c08-b5a3-806feff69fc5	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:50.131498	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
69f55eaf-23e2-47c4-95a4-97ddf5589fa6	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:45.475635	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
759e740f-6b50-403d-b2bf-bc03b2a4f2ea	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:45.82961	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
4dbdbfc9-72ad-47c5-828d-ea8e61b0b078	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:46.169796	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
c2238038-22b9-4f85-b5aa-754451bf30de	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:46.330144	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
989f106d-cf04-42e6-b7a9-bc4e1c525305	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:46.822216	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
f06c9399-cb37-4113-8608-588ac07433c0	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:47.179153	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
6d7f714d-819b-4f4e-833c-0d49ebd62755	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:47.549334	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
1dc84cf3-f70d-4e75-8b31-526ac9ef6422	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:47.942666	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
796789b4-b3a6-4dc1-bf61-5cfb4c02a22a	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:48.103621	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
87d2713a-9d5a-4eaf-b594-c7546ee58299	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:48.654753	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
892d0b42-26e9-4b4d-b76b-dd96af3ff5ea	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:49.008497	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
314565c6-783d-46cc-85b1-8d27ab0378a0	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:49.376638	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
b0cf17b9-a52c-45a6-9331-333f89cc1d0d	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:49.76964	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
5f6652b5-1971-4962-acdb-36ebdcb5f921	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 14:41:50.309623	\N	mK@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	5100	80000	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
fa74ac84-c22d-4b74-9d87-0bc9b67f5502	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-25 13:27:53.448882	\N	m@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	SHIPPED	2510	80000	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
08ef5bc5-5552-40df-8c93-d727381136e5	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 17:33:57.074034	\N	m@gmail.com	Mohcine	Khribech	PAYPAL	PENDING	0631560367	PENDING	1300	80000	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
3d09be91-e0cf-443d-affd-1bfe9884e2a3	Elhouda , pré de lycee ajdir	Agadir	Morocco	2025-02-26 17:34:22.279896	\N	m@gmail.com	Mohcine	Khribech	COD	PENDING	0631560367	PENDING	1300	80000	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product (id, description, final_price, name, purchase_price, quantity, weight, category_id, benefits, how_to_use) FROM stdin;
44ba4932-e9d7-4261-91f1-316c3af622c5	L'huile d'argan est un produit naturel complet qui peut être intégré à ta routine beauté pour une peau et des cheveux nourris, réparés et protégés au quotidien.	300	Argan Oil	100	100	60	e9bce0e7-ca8a-46f5-a352-9d2fedca74b6	Hydratation profonde : Grâce à sa richesse en acides gras essentiels, elle pénètre rapidement dans la peau pour une hydratation longue durée. Propriétés anti-âge : Les antioxydants et la vitamine E qu'elle contient aident à lutter contre les radicaux libres, réduisant ainsi les signes de vieillissement prématuré. Apaisante et réparatrice : Elle est idéale pour calmer les irritations cutanées et nourrir les peaux sèches ou abîmées. Renforcement capillaire : Elle nourrit le cuir chevelu et les cheveux, les rendant plus brillants, doux et moins cassants. Facilite la réparation des ongles : Elle aide à renforcer les ongles, prévenir leur cassure et réparer les cuticules abîmées.	Utilisation modérée : Quelques gouttes suffisent pour chaque application, car l'huile d'argan est très concentrée. Choisir une huile pure et de qualité : Opte pour de l'huile d'argan biologique et pressée à froid pour profiter pleinement de ses bienfaits.
\.


--
-- Data for Name: product_media; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_media (id, media_name, product_id) FROM stdin;
3d13d4c4-67a3-4e98-b879-5abdb2c6f800	fb970d3b-6b81-43a3-8c12-638c96742d15.jpeg	44ba4932-e9d7-4261-91f1-316c3af622c5
5bd9ff44-c88d-46df-bf19-a2eeb87cad2f	b8524b59-6861-413b-a0e1-2f0a054a2706.jpeg	44ba4932-e9d7-4261-91f1-316c3af622c5
f3742f25-f17e-4aa7-a6d4-d2b69ce6e51a	2a5ddf39-cff6-47c2-a159-0d88057cc7e8.jpeg	44ba4932-e9d7-4261-91f1-316c3af622c5
411098dd-c8ea-4ca2-b0a3-1572deb85a63	9cb6f6c0-cda4-40b3-869b-e216ab6daefd.jpeg	44ba4932-e9d7-4261-91f1-316c3af622c5
\.


--
-- Data for Name: product_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_tags (tag_id, product_id) FROM stdin;
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tag (id, name) FROM stdin;
c92d3833-fbcf-4933-9465-6a10ee68a3a9	test
\.


--
-- Data for Name: token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.token (id, expired, revoked, token, token_type, user_id) FROM stdin;
25	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTczOTM3NDA2NiwiZXhwIjoxNzM5Mzc0MjEwfQ.dbIsfjxegdTkbeXavC0XjT_RE0A7627hccRSafHv6Gc	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
26	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTczOTM3NDMzMSwiZXhwIjoxNzM5Mzc0NDc1fQ.86ivTDbRg3SW77DUAkvSPqfqskw9TXgtZD_5YEWXpx8	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
27	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTczOTM3NDU5MywiZXhwIjoxNzM5Mzc0NzM3fQ.mn-CbyslmtHXsKxQDO6KyHzxDj7BjzYRRftM567F8fg	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
28	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTczOTM3NTE5MCwiZXhwIjoxNzM5Mzc1MzM0fQ.4PgT2WXKfRqcNj_A3iJ6zu7FcZ_eW9OIa2odcJnLXV0	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
21	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbkBnbWFpbC5jb20iLCJpYXQiOjE3MzIzODI5NzYsImV4cCI6MTczMjM4MzEyMH0.cYJLcuaDL_bJL-BTBZEeYxQgpn4bKa-fgBcHMzZRj3o	BEARER	40139aca-18bb-4abf-98c5-17a905ab5bf5
22	f	f	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbkBnbWFpbC5jb20iLCJpYXQiOjE3Mzc5ODA3MjEsImV4cCI6MTczNzk4MDg2NX0.1t8HPRFN7C61uW8SeDFX7lXrADASJG7LoVUiyTq52Eo	BEARER	40139aca-18bb-4abf-98c5-17a905ab5bf5
23	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTczOTM3MjMwMCwiZXhwIjoxNzM5MzcyNDQ0fQ.CuLTnmcQd9DGWtrcGkWxVmBr85JULoRRHESGqHwDh1o	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
24	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTczOTM3MzE3MiwiZXhwIjoxNzM5MzczMzE2fQ.0Mb9ySj6yss9d7nbdyDMJaMm7IVeXxHoTznT4IkqQdA	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
29	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTczOTU3OTcyMiwiZXhwIjoxNzM5NTc5ODY2fQ._ceJQL5WwNSv2en5pdLylKNGhIMQ7_ns7X3JRKRrMEU	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
30	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTczOTU3OTg5NCwiZXhwIjoxNzM5NTgwMDM4fQ.ivCvhi8IEtgr1DvJ0s2KCV8tw106RP9RTXXwdoWLkwo	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
31	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTczOTU4MDEwNSwiZXhwIjoxNzM5NTgwMjQ5fQ.RiKkTIELh2kmXJxzN7L64SfV7Kju8nQSycVn96FjCh8	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
32	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTczOTY0Mzk5OCwiZXhwIjoxNzM5NjQ0MTQyfQ.aJ8uZXx0rmJPI_35afPN1cgyzhnX37tmUh_yJXlaFmo	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
33	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTczOTc5Nzg1MCwiZXhwIjoxNzM5Nzk3OTk0fQ.NpMo4mG2j2kF1jsG3fQhKojW4jMN5-ORdL0-M39Fr40	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
34	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTczOTgwNzE1MSwiZXhwIjoxNzM5ODA3Mjk1fQ.AQaZa_wj8WWe4X8iYtdY_bza7VZsqD7sq5l48z7GfQM	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
35	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTczOTgwNzQxMiwiZXhwIjoxNzM5ODA3NTU2fQ.gRFdS4J_FW6g62TkPUhC147RYbMSetUeeY1B_6CPPts	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
36	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTczOTgwODMwMSwiZXhwIjoxNzM5ODA4NDQ1fQ.q9oYjM2-Bu5S-M3-B-hWp6g7aGIQxfGxcoSXJmfqv34	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
37	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTczOTgxMTcxMiwiZXhwIjoxNzM5ODExODU2fQ.A5XoDHVNRuBHtrqAJYKP8MIh-Qj6lxUfFX4Bpoe0o7s	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
38	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTczOTkwMjE0MywiZXhwIjoxNzM5OTAyMjg3fQ.jyGKUsi-n9qSDTS32bsuuKshiPjUlMSr5eM1O62V6P0	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
39	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTczOTkwMzA1NywiZXhwIjoxNzM5OTAzMjAxfQ.7ESj5wA_nYYFGYKrJmqfoG0cKmn01oNIxypG9UhVVo4	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
40	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTczOTkwMzQxNywiZXhwIjoxNzM5OTAzNTYxfQ.kXYFMJ77A_ZCipfgbOfu-zikhQCCxABNer1vk9WWpRU	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
41	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTczOTkyMzIxNywiZXhwIjoxNzM5OTIzMzYxfQ.tbaV6xq9nqoDhnqlayufOLHrcYIiDn6LCNEDiw9Lw3A	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
42	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTczOTkyNTEzMiwiZXhwIjoxNzM5OTI1Mjc2fQ.DmGiyxTCCror__LdH1GxO3Y2NEiETY7LIzmFXmWFMMY	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
43	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTczOTk3NzQxMywiZXhwIjoxNzM5OTc3NTU3fQ.1nMlvO_oZjeS5_eSkvonSkzo5Gi6WM14WArq4OP2sf4	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
44	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTczOTk4ODc2NSwiZXhwIjoxNzM5OTg4OTA5fQ.98R0aG6d4SW_JZTn84dFkKZWjk4zcF7ZqE420KYaEt0	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
45	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTczOTk5MDE3NCwiZXhwIjoxNzM5OTkwMzE4fQ.nuKerdqW7O2bozhAgx95Zwq__BfPJHD2o20Llg8v0vM	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
46	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTczOTk5MzE3NCwiZXhwIjoxNzM5OTkzMzE4fQ.mxsNsbhCsJU3HxH-HYskhOMLkemAYmIHeKHNsPqO5sQ	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
47	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTc0MDAwNzc1MywiZXhwIjoxNzQwMDA3ODk3fQ.CDM-sSPHC90QJflWipwVS4UHy5dOmhopTh8Ned0GzSs	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
48	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTc0MDAwODAzNywiZXhwIjoxNzQwMDA4MTgxfQ.YqsChfB_Cyr3T-y2bHsMwVsm1kvbPKZ4F8-g36ztOaI	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
49	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTc0MDAwODExMSwiZXhwIjoxNzQwMDA4MjU1fQ.0aS7z2VwP6Wn9u0btwRuzzVUzEOKfsk1jpaBNmvrwyk	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
50	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTc0MDAwODMzNiwiZXhwIjoxNzQwMDA4NDgwfQ.IGXyJ9MgDnnA8jEJ2h7UvmjeiWVjVufbmZwpOmJ7hfo	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
51	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTc0MDAwOTgzNCwiZXhwIjoxNzQwMDA5OTc4fQ.KcrfV_RTLH4f6FtBL-1qunworcuFKDJqKXZOIhnvb7E	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
52	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTc0MDA1NjE1MCwiZXhwIjoxNzQwMDU2Mjk0fQ.TMi3GKxB46jWlVgyDQdGUTdekei9sRZNAB3orpoD_tc	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
53	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTc0MDA1NzQ1MSwiZXhwIjoxNzQwMDU3NTk1fQ.j8y8EaZxy8SQoi8-aktPNmMWDz6LTmMx_ldgTx4eDwU	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
54	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTc0MDA1NzYzOSwiZXhwIjoxNzQwMDU3NzgzfQ.sS0LHoz8aBCTEe-RshqvuxTNwwMKDhOOa5UkpOkv9sI	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
55	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTc0MDA1Nzc0NiwiZXhwIjoxNzQwMDU3ODkwfQ.At6OHbionI1gv9RrX9y2ABygxJqmPiBLRJVYiAFfdZU	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
56	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTc0MDA1ODAyMSwiZXhwIjoxNzQwMDU4MTY1fQ.JOUx83hf-vs6gnQngBjTUf4xL0bVB4fgoqE9wXzEE_c	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
57	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTc0MDA2NDQ4OCwiZXhwIjoxNzQwMDY0NjMyfQ.yMPjLapuydVOro4gi4RnoAbUbT3LVBM6IJdZfvA8XSQ	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
58	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTc0MDA2NDcyMiwiZXhwIjoxNzQwMDY0ODY2fQ.udChQbApIKaEAMLqUW9Itz4AS7PX4tvfQ33aJ473m2k	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
59	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTc0MDA2NzAyNCwiZXhwIjoxNzQwMDY3MTY4fQ.1NSrD4mpxg36YsUQKzNAXVvMn5nkowmcWWAX85rOpLE	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
60	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTc0MDA2NzE2NywiZXhwIjoxNzQwMDY3MzExfQ.4yY0Y95d8en6IhGjW1w7Etzvf0bY8j2Ks5UedxoDick	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
61	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTc0MDIzMTYxOCwiZXhwIjoxNzQwMjMxNzYyfQ._FBjhGyUx5PZs27eg3i7fYzlPe_hvC3y4j8MYmL18pI	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
62	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTc0MDI0Nzg4NSwiZXhwIjoxNzQwMjQ4MDI5fQ.pLHYQzNWhwV7X-mWzOowU88spxF5xGR0GxgLxX5ucAs	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
63	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTc0MDI0Nzg4NiwiZXhwIjoxNzQwMjQ4MDMwfQ.t8Xmgyeizxc1tjNkQxzz1I8iOktp4zDiDyUZuFU5jKA	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
64	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTc0MDI2MTY1MiwiZXhwIjoxNzQwMjYxNzk2fQ.24XYBTSTv5XmNKuZSj4vZwgZVYu8iFdorbp5nZcSpnU	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
65	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTc0MDI2Mzc0OSwiZXhwIjoxNzQwMjYzODkzfQ.YWFKSLAO_LwbhmWVTckUQlj180SOJuFeDfLLQS5cWuE	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
66	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTc0MDM1ODkyMiwiZXhwIjoxNzQwMzU5MDY2fQ.o5F61KjNqdqj7iiUawj6tjTJJmQpYzWtnwmv1m8PtLc	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
67	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTc0MDQxMTY5NCwiZXhwIjoxNzQwNDExODM4fQ.0fqXgh11qXLZUsyMXp4IR1TOxMDgipFn5g8ktdHbPKo	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
68	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTc0MDQxNTY3OCwiZXhwIjoxNzQwNDE1ODIyfQ.vX_1Hmi7mkmakIBz4y94s-kq1tPgLy_yteGNRnDEkGs	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
69	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTc0MDQ4ODQxMiwiZXhwIjoxNzQwNDg4NTU2fQ.BW29U4gtJtYKIlKJfuBdpFBkF_8Exz2Qy98ZQhd92Go	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
70	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTc0MDQ4OTcxOSwiZXhwIjoxNzQwNDg5ODYzfQ.qPNpx9H95t3HUzuDNLt7VeK3rinuK1PVp2aA0jB_b6o	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
71	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTc0MDQ5MDA2NCwiZXhwIjoxNzQwNDkwMjA4fQ.QP4hPTe--D53p4wnApL_02pQ37DVc5Yb-VSdp308c0s	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
72	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTc0MDQ5MjU0MSwiZXhwIjoxNzQwNDkyNjg1fQ.jXCfLbj7Ay5JaAKDxp-7TxgnC76a5Uwss_rVJ5tGeyw	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
74	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtS0BnbWFpbC5jb20iLCJpYXQiOjE3NDA1Nzk5MzMsImV4cCI6MTc0MDU4MDA3N30.Lh7EQGHtDqY1t2HboKcAwB0M1bFiEEnqZV3uM6j1nBs	BEARER	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
75	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtS0BnbWFpbC5jb20iLCJpYXQiOjE3NDA1ODA1OTgsImV4cCI6MTc0MDU4MDc0Mn0.1E2mFQPM-O__dGUX9RQsHxzHIDsPxhkZEcyuVIqGZ1Y	BEARER	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
76	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtS0BnbWFpbC5jb20iLCJpYXQiOjE3NDA1ODA3NzYsImV4cCI6MTc0MDU4MDkyMH0.qulcX38caOm_1MEeySJQ2ViRQtRjXR3KJsfpyp0trFM	BEARER	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
77	f	f	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtS0BnbWFpbC5jb20iLCJpYXQiOjE3NDA1ODA4MzQsImV4cCI6MTc0MDU4MDk3OH0.tU9djbmlQ6V5fgvQ3UWP2ZDroovTzUyzgmzNIW3HF7g	BEARER	5ee6da15-9409-4c0a-a3e5-1e06e57227e7
73	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTc0MDU3ODcwOCwiZXhwIjoxNzQwNTc4ODUyfQ.jPRjN1VZqokaOMDohOONFqrMiuYAxAuD6vf1KSgQa4M	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
78	t	t	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTc0MDU5MTE5NCwiZXhwIjoxNzQwNTkxMzM4fQ.x9xNi1zTg2yLVtS3bbn1LFRVo26mDBdHc6XkZAFXqQI	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
79	f	f	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtQGdtYWlsLmNvbSIsImlhdCI6MTc0MDY2MjU0NCwiZXhwIjoxNzQwNjYyNjg4fQ.gPX5VXTeqg441vt2BufHMuO7WpGqba81mb64i0vnWcY	BEARER	16910ff3-5ce9-4e6a-bbb9-fafe1f328411
\.


--
-- Name: token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.token_id_seq', 79, true);


--
-- Name: app_user app_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_pkey PRIMARY KEY (id);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- Name: ordered_product ordered_product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordered_product
    ADD CONSTRAINT ordered_product_pkey PRIMARY KEY (order_id, product_id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: product_media product_media_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_media
    ADD CONSTRAINT product_media_pkey PRIMARY KEY (id);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- Name: token token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token
    ADD CONSTRAINT token_pkey PRIMARY KEY (id);


--
-- Name: app_user uk1j9d9a06i600gd43uu3km82jw; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT uk1j9d9a06i600gd43uu3km82jw UNIQUE (email);


--
-- Name: token ukpddrhgwxnms2aceeku9s2ewy5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token
    ADD CONSTRAINT ukpddrhgwxnms2aceeku9s2ewy5 UNIQUE (token);


--
-- Name: product fk1mtsbur82frn64de7balymq9s; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT fk1mtsbur82frn64de7balymq9s FOREIGN KEY (category_id) REFERENCES public.category(id);


--
-- Name: ordered_product fk2nijit240cv1lx2ak4x5cakm8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordered_product
    ADD CONSTRAINT fk2nijit240cv1lx2ak4x5cakm8 FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: product_tags fk8gmf959fnpxtkagtk56mbaj0e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_tags
    ADD CONSTRAINT fk8gmf959fnpxtkagtk56mbaj0e FOREIGN KEY (product_id) REFERENCES public.product(id);


--
-- Name: orders fkbxrxsll049g1dgbdv3dvwis7f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fkbxrxsll049g1dgbdv3dvwis7f FOREIGN KEY (client_id) REFERENCES public.app_user(id);


--
-- Name: ordered_product fkcbk8xvg3o4s3ard6hv25p4jqc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordered_product
    ADD CONSTRAINT fkcbk8xvg3o4s3ard6hv25p4jqc FOREIGN KEY (product_id) REFERENCES public.product(id);


--
-- Name: token fkebe1hlldfjpivnyt2tlydy4vl; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token
    ADD CONSTRAINT fkebe1hlldfjpivnyt2tlydy4vl FOREIGN KEY (user_id) REFERENCES public.app_user(id);


--
-- Name: product_media fkish5xtvhdauc3njtkj6j5eyjp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_media
    ADD CONSTRAINT fkish5xtvhdauc3njtkj6j5eyjp FOREIGN KEY (product_id) REFERENCES public.product(id);


--
-- Name: product_tags fkm946f9wup0ybm58h3eoh2f7sh; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_tags
    ADD CONSTRAINT fkm946f9wup0ybm58h3eoh2f7sh FOREIGN KEY (tag_id) REFERENCES public.tag(id);


--
-- PostgreSQL database dump complete
--

