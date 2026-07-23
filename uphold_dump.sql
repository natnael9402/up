--
-- PostgreSQL database dump
--

\restrict PhCJ2eAfuRmfMGVahj4E7zDV1xvcZknfOnRLU0L2Xm3JfnmJmcSqyXhVSW1tkgC

-- Dumped from database version 16.11
-- Dumped by pg_dump version 16.11

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
-- Name: arbitrage_hostings_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.arbitrage_hostings_status AS ENUM (
    'running',
    'ended',
    'cancelled'
);


ALTER TYPE public.arbitrage_hostings_status OWNER TO postgres;

--
-- Name: deposits_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.deposits_status AS ENUM (
    'pending',
    'approved',
    'rejected'
);


ALTER TYPE public.deposits_status OWNER TO postgres;

--
-- Name: kyc_submissions_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.kyc_submissions_status AS ENUM (
    'pending',
    'approved',
    'rejected'
);


ALTER TYPE public.kyc_submissions_status OWNER TO postgres;

--
-- Name: loan_repayments_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.loan_repayments_status AS ENUM (
    'pending',
    'approved',
    'rejected'
);


ALTER TYPE public.loan_repayments_status OWNER TO postgres;

--
-- Name: loans_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.loans_status AS ENUM (
    'pending',
    'approved',
    'rejected',
    'repaid',
    'overdue'
);


ALTER TYPE public.loans_status OWNER TO postgres;

--
-- Name: mining_hostings_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.mining_hostings_status AS ENUM (
    'running',
    'ended',
    'cancelled'
);


ALTER TYPE public.mining_hostings_status OWNER TO postgres;

--
-- Name: profiles_kyc_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.profiles_kyc_status AS ENUM (
    'unverified',
    'pending',
    'verified',
    'rejected'
);


ALTER TYPE public.profiles_kyc_status OWNER TO postgres;

--
-- Name: profiles_trade_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.profiles_trade_status AS ENUM (
    'win',
    'loss',
    'normal'
);


ALTER TYPE public.profiles_trade_status OWNER TO postgres;

--
-- Name: support_tickets_priority; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.support_tickets_priority AS ENUM (
    'low',
    'medium',
    'high',
    'urgent'
);


ALTER TYPE public.support_tickets_priority OWNER TO postgres;

--
-- Name: support_tickets_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.support_tickets_status AS ENUM (
    'open',
    'in_progress',
    'awaiting_user',
    'closed'
);


ALTER TYPE public.support_tickets_status OWNER TO postgres;

--
-- Name: users_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.users_role AS ENUM (
    'admin',
    'user'
);


ALTER TYPE public.users_role OWNER TO postgres;

--
-- Name: users_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.users_status AS ENUM (
    'active',
    'inactive',
    'suspended',
    'banned'
);


ALTER TYPE public.users_status OWNER TO postgres;

--
-- Name: withdrawals_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.withdrawals_status AS ENUM (
    'pending',
    'approved',
    'rejected'
);


ALTER TYPE public.withdrawals_status OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- Name: arbitrage_hostings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.arbitrage_hostings (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    product_id bigint NOT NULL,
    amount numeric(14,2) NOT NULL,
    status public.arbitrage_hostings_status DEFAULT 'running'::public.arbitrage_hostings_status NOT NULL,
    currency character varying(255) DEFAULT 'USDT'::character varying NOT NULL,
    start_date timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    end_date timestamp(0) without time zone,
    last_profit_date timestamp(0) without time zone,
    total_earned numeric(14,2) DEFAULT 0.00 NOT NULL,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.arbitrage_hostings OWNER TO postgres;

--
-- Name: arbitrage_hostings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.arbitrage_hostings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.arbitrage_hostings_id_seq OWNER TO postgres;

--
-- Name: arbitrage_hostings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.arbitrage_hostings_id_seq OWNED BY public.arbitrage_hostings.id;


--
-- Name: arbitrage_products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.arbitrage_products (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    days integer NOT NULL,
    daily_rate numeric(10,2) NOT NULL,
    min_amount numeric(14,2) NOT NULL,
    max_amount numeric(14,2) NOT NULL,
    image character varying(255),
    is_active boolean DEFAULT true NOT NULL,
    supported_currencies text,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.arbitrage_products OWNER TO postgres;

--
-- Name: arbitrage_products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.arbitrage_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.arbitrage_products_id_seq OWNER TO postgres;

--
-- Name: arbitrage_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.arbitrage_products_id_seq OWNED BY public.arbitrage_products.id;


--
-- Name: assets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.assets (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    symbol character varying(20) NOT NULL,
    name character varying(100),
    amount numeric(20,8) NOT NULL,
    current_price numeric(20,8),
    current_value numeric(20,2),
    avg_purchase_price numeric(20,8),
    last_updated_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.assets OWNER TO postgres;

--
-- Name: assets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.assets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.assets_id_seq OWNER TO postgres;

--
-- Name: assets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.assets_id_seq OWNED BY public.assets.id;


--
-- Name: cache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache OWNER TO postgres;

--
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO postgres;

--
-- Name: crypto_addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.crypto_addresses (
    id bigint NOT NULL,
    currency character varying(10) NOT NULL,
    network character varying(20) NOT NULL,
    address character varying(255) NOT NULL,
    qr_code text,
    is_active boolean DEFAULT true NOT NULL,
    notes text,
    created_by bigint,
    updated_by bigint,
    last_updated timestamp(0) without time zone,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.crypto_addresses OWNER TO postgres;

--
-- Name: crypto_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.crypto_addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.crypto_addresses_id_seq OWNER TO postgres;

--
-- Name: crypto_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.crypto_addresses_id_seq OWNED BY public.crypto_addresses.id;


--
-- Name: deposits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deposits (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    currency character varying(255) DEFAULT 'USDT'::character varying NOT NULL,
    amount numeric(15,2) NOT NULL,
    transaction_id character varying(255),
    payment_method character varying(255) NOT NULL,
    payment_details character varying(255),
    description text,
    proof_image character varying(255),
    status public.deposits_status DEFAULT 'pending'::public.deposits_status NOT NULL,
    rejection_reason text,
    processed_by bigint,
    processed_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.deposits OWNER TO postgres;

--
-- Name: deposits_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.deposits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.deposits_id_seq OWNER TO postgres;

--
-- Name: deposits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.deposits_id_seq OWNED BY public.deposits.id;


--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO postgres;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.failed_jobs_id_seq OWNER TO postgres;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: job_batches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


ALTER TABLE public.job_batches OWNER TO postgres;

--
-- Name: jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.jobs OWNER TO postgres;

--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jobs_id_seq OWNER TO postgres;

--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: kyc_submissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kyc_submissions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    document_type character varying(255) NOT NULL,
    document_number character varying(255),
    front_image_url character varying(255),
    back_image_url character varying(255),
    selfie_image_url character varying(255),
    status public.kyc_submissions_status DEFAULT 'pending'::public.kyc_submissions_status NOT NULL,
    rejection_reason text,
    approved_at timestamp(0) without time zone,
    rejected_at timestamp(0) without time zone,
    processed_by bigint,
    processed_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.kyc_submissions OWNER TO postgres;

--
-- Name: kyc_submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kyc_submissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.kyc_submissions_id_seq OWNER TO postgres;

--
-- Name: kyc_submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kyc_submissions_id_seq OWNED BY public.kyc_submissions.id;


--
-- Name: loan_repayments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.loan_repayments (
    id bigint NOT NULL,
    loan_id bigint NOT NULL,
    amount numeric(15,2) NOT NULL,
    proof_image character varying(255) NOT NULL,
    status public.loan_repayments_status DEFAULT 'pending'::public.loan_repayments_status NOT NULL,
    rejection_reason text,
    processed_by bigint,
    processed_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.loan_repayments OWNER TO postgres;

--
-- Name: loan_repayments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.loan_repayments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.loan_repayments_id_seq OWNER TO postgres;

--
-- Name: loan_repayments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.loan_repayments_id_seq OWNED BY public.loan_repayments.id;


--
-- Name: loans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.loans (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    amount numeric(15,2) NOT NULL,
    currency character varying(255) DEFAULT 'USDT'::character varying NOT NULL,
    status public.loans_status DEFAULT 'pending'::public.loans_status NOT NULL,
    rejection_reason text,
    duration integer DEFAULT 30 NOT NULL,
    interest_rate numeric(5,2) DEFAULT 0.00 NOT NULL,
    total_payable numeric(15,2) DEFAULT 0.00 NOT NULL,
    accumulated_interest numeric(15,2) DEFAULT 0.00 NOT NULL,
    last_interest_date timestamp(0) without time zone,
    due_date timestamp(0) without time zone,
    approved_at timestamp(0) without time zone,
    repaid_at timestamp(0) without time zone,
    processed_by bigint,
    processed_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(0) without time zone,
    back_image character varying(255),
    document_type character varying(255),
    front_image character varying(255)
);


ALTER TABLE public.loans OWNER TO postgres;

--
-- Name: loans_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.loans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.loans_id_seq OWNER TO postgres;

--
-- Name: loans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.loans_id_seq OWNED BY public.loans.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: mining_hostings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mining_hostings (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    product_id bigint NOT NULL,
    amount numeric(14,2) NOT NULL,
    status public.mining_hostings_status DEFAULT 'running'::public.mining_hostings_status NOT NULL,
    currency character varying(255) DEFAULT 'USDT'::character varying NOT NULL,
    start_date timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    end_date timestamp(0) without time zone,
    last_profit_date timestamp(0) without time zone,
    total_earned numeric(14,2) DEFAULT 0.00 NOT NULL,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.mining_hostings OWNER TO postgres;

--
-- Name: mining_hostings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mining_hostings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mining_hostings_id_seq OWNER TO postgres;

--
-- Name: mining_hostings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mining_hostings_id_seq OWNED BY public.mining_hostings.id;


--
-- Name: mining_products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mining_products (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    days integer NOT NULL,
    daily_rate numeric(10,2) NOT NULL,
    min_amount numeric(14,2) NOT NULL,
    max_amount numeric(14,2) NOT NULL,
    limit_times integer NOT NULL,
    hashrate character varying(255) NOT NULL,
    power character varying(255) NOT NULL,
    network_type character varying(255) NOT NULL,
    manufacturer character varying(255),
    size character varying(255),
    weight character varying(255),
    temperature character varying(255),
    humidity character varying(255),
    image character varying(255),
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.mining_products OWNER TO postgres;

--
-- Name: mining_products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mining_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mining_products_id_seq OWNER TO postgres;

--
-- Name: mining_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mining_products_id_seq OWNED BY public.mining_products.id;


--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.password_reset_tokens OWNER TO postgres;

--
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.personal_access_tokens OWNER TO postgres;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.personal_access_tokens_id_seq OWNER TO postgres;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- Name: profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profiles (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    uuid character(36) NOT NULL,
    kyc_status public.profiles_kyc_status DEFAULT 'unverified'::public.profiles_kyc_status NOT NULL,
    level smallint DEFAULT 1 NOT NULL,
    kyc_documents text,
    bank_account character varying(255),
    blockchain_addresses text,
    google_auth_enabled boolean DEFAULT false NOT NULL,
    google_auth_secret character varying(255),
    withdrawal_password_enabled boolean DEFAULT false NOT NULL,
    withdrawal_password character varying(255),
    trade_status public.profiles_trade_status,
    total_assets numeric(20,8) DEFAULT 0.00000000 NOT NULL,
    preferred_language character varying(255) DEFAULT 'en'::character varying NOT NULL,
    notification_settings text,
    sim_trade_enabled boolean DEFAULT false NOT NULL,
    invite_code character varying(255),
    referral_count integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.profiles OWNER TO postgres;

--
-- Name: profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.profiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.profiles_id_seq OWNER TO postgres;

--
-- Name: profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.profiles_id_seq OWNED BY public.profiles.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- Name: support_ticket_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.support_ticket_messages (
    id bigint NOT NULL,
    ticket_id bigint NOT NULL,
    user_id bigint,
    admin_id bigint,
    message text NOT NULL,
    is_read boolean DEFAULT false NOT NULL,
    attachments text,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.support_ticket_messages OWNER TO postgres;

--
-- Name: support_ticket_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.support_ticket_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.support_ticket_messages_id_seq OWNER TO postgres;

--
-- Name: support_ticket_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.support_ticket_messages_id_seq OWNED BY public.support_ticket_messages.id;


--
-- Name: support_tickets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.support_tickets (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    subject character varying(255) NOT NULL,
    status public.support_tickets_status DEFAULT 'open'::public.support_tickets_status NOT NULL,
    priority public.support_tickets_priority DEFAULT 'medium'::public.support_tickets_priority NOT NULL,
    category character varying(255) NOT NULL,
    last_reply_at timestamp(0) without time zone,
    closed_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.support_tickets OWNER TO postgres;

--
-- Name: support_tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.support_tickets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.support_tickets_id_seq OWNER TO postgres;

--
-- Name: support_tickets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.support_tickets_id_seq OWNED BY public.support_tickets.id;


--
-- Name: trade_contracts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trade_contracts (
    id bigint NOT NULL,
    trade_id bigint NOT NULL,
    quantity numeric(15,8) NOT NULL,
    leverage integer NOT NULL,
    liquidation_price numeric(15,8) NOT NULL,
    take_profit numeric(15,8),
    stop_loss numeric(15,8),
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.trade_contracts OWNER TO postgres;

--
-- Name: trade_contracts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.trade_contracts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.trade_contracts_id_seq OWNER TO postgres;

--
-- Name: trade_contracts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.trade_contracts_id_seq OWNED BY public.trade_contracts.id;


--
-- Name: trade_options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trade_options (
    id bigint NOT NULL,
    trade_id bigint NOT NULL,
    duration integer NOT NULL,
    return_rate numeric(5,2) NOT NULL,
    expected_return numeric(15,2) NOT NULL,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.trade_options OWNER TO postgres;

--
-- Name: trade_options_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.trade_options_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.trade_options_id_seq OWNER TO postgres;

--
-- Name: trade_options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.trade_options_id_seq OWNED BY public.trade_options.id;


--
-- Name: trade_spots; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trade_spots (
    id bigint NOT NULL,
    trade_id bigint NOT NULL,
    quantity numeric(15,8) NOT NULL,
    market_price numeric(15,8) NOT NULL,
    exchange_rate numeric(20,12),
    from_coin character varying(10),
    to_coin character varying(10),
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.trade_spots OWNER TO postgres;

--
-- Name: trade_spots_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.trade_spots_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.trade_spots_id_seq OWNER TO postgres;

--
-- Name: trade_spots_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.trade_spots_id_seq OWNED BY public.trade_spots.id;


--
-- Name: trades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trades (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    symbol character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    direction character varying(255) NOT NULL,
    amount numeric(15,2) NOT NULL,
    entry_price numeric(15,8) NOT NULL,
    exit_price numeric(15,8),
    exchange_rate numeric(18,8),
    from_coin character varying(20),
    to_coin character varying(20),
    status character varying(255) DEFAULT 'open'::character varying NOT NULL,
    result character varying(255),
    pnl numeric(15,2) DEFAULT 0.00 NOT NULL,
    fee numeric(15,2) DEFAULT 0.00 NOT NULL,
    opened_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    closed_at timestamp(0) without time zone,
    closed_by bigint,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.trades OWNER TO postgres;

--
-- Name: trades_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.trades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.trades_id_seq OWNER TO postgres;

--
-- Name: trades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.trades_id_seq OWNED BY public.trades.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    trade_id bigint,
    type character varying(255) NOT NULL,
    amount numeric(15,2) NOT NULL,
    currency character varying(255) DEFAULT 'USDT'::character varying NOT NULL,
    balance numeric(15,2) NOT NULL,
    description text,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transactions_id_seq OWNER TO postgres;

--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255),
    phone character varying(255),
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    role public.users_role DEFAULT 'user'::public.users_role NOT NULL,
    status public.users_status DEFAULT 'active'::public.users_status NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(0) without time zone,
    balance numeric(15,2) DEFAULT 0.00 NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: withdrawals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.withdrawals (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    currency character varying(255) DEFAULT 'USDT'::character varying NOT NULL,
    amount numeric(15,2) NOT NULL,
    fee numeric(15,8) DEFAULT 0.00000000 NOT NULL,
    transaction_id character varying(255),
    wallet_address character varying(255),
    network character varying(20) DEFAULT 'TRC20'::character varying NOT NULL,
    bank_details character varying(255),
    description text,
    status public.withdrawals_status DEFAULT 'pending'::public.withdrawals_status NOT NULL,
    rejection_reason text,
    processed_by bigint,
    processed_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.withdrawals OWNER TO postgres;

--
-- Name: withdrawals_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.withdrawals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.withdrawals_id_seq OWNER TO postgres;

--
-- Name: withdrawals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.withdrawals_id_seq OWNED BY public.withdrawals.id;


--
-- Name: arbitrage_hostings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arbitrage_hostings ALTER COLUMN id SET DEFAULT nextval('public.arbitrage_hostings_id_seq'::regclass);


--
-- Name: arbitrage_products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arbitrage_products ALTER COLUMN id SET DEFAULT nextval('public.arbitrage_products_id_seq'::regclass);


--
-- Name: assets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assets ALTER COLUMN id SET DEFAULT nextval('public.assets_id_seq'::regclass);


--
-- Name: crypto_addresses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crypto_addresses ALTER COLUMN id SET DEFAULT nextval('public.crypto_addresses_id_seq'::regclass);


--
-- Name: deposits id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deposits ALTER COLUMN id SET DEFAULT nextval('public.deposits_id_seq'::regclass);


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: kyc_submissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kyc_submissions ALTER COLUMN id SET DEFAULT nextval('public.kyc_submissions_id_seq'::regclass);


--
-- Name: loan_repayments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loan_repayments ALTER COLUMN id SET DEFAULT nextval('public.loan_repayments_id_seq'::regclass);


--
-- Name: loans id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loans ALTER COLUMN id SET DEFAULT nextval('public.loans_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: mining_hostings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mining_hostings ALTER COLUMN id SET DEFAULT nextval('public.mining_hostings_id_seq'::regclass);


--
-- Name: mining_products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mining_products ALTER COLUMN id SET DEFAULT nextval('public.mining_products_id_seq'::regclass);


--
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- Name: profiles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles ALTER COLUMN id SET DEFAULT nextval('public.profiles_id_seq'::regclass);


--
-- Name: support_ticket_messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.support_ticket_messages ALTER COLUMN id SET DEFAULT nextval('public.support_ticket_messages_id_seq'::regclass);


--
-- Name: support_tickets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.support_tickets ALTER COLUMN id SET DEFAULT nextval('public.support_tickets_id_seq'::regclass);


--
-- Name: trade_contracts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trade_contracts ALTER COLUMN id SET DEFAULT nextval('public.trade_contracts_id_seq'::regclass);


--
-- Name: trade_options id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trade_options ALTER COLUMN id SET DEFAULT nextval('public.trade_options_id_seq'::regclass);


--
-- Name: trade_spots id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trade_spots ALTER COLUMN id SET DEFAULT nextval('public.trade_spots_id_seq'::regclass);


--
-- Name: trades id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trades ALTER COLUMN id SET DEFAULT nextval('public.trades_id_seq'::regclass);


--
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: withdrawals id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.withdrawals ALTER COLUMN id SET DEFAULT nextval('public.withdrawals_id_seq'::regclass);


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
4a20e0b0-0899-4774-8fd2-2a62ed4d4126	c9291d4425bce60ea90df17a140b01f317bc1e80389b8c3cf0672e971db403bb	2025-12-06 14:22:18.553265+00	20251110075957_init	\N	\N	2025-12-06 14:22:17.149434+00	1
c50f9601-5191-4252-9822-9a030423089e	8129c89c9680e263aae1a6c4e36b88736a638f8c761a8d9c60ca7f26c577ad15	2026-01-05 11:55:39.640448+00	20260103162056_add_loan_interest_fields	\N	\N	2026-01-05 11:55:39.442631+00	1
65ea80bf-2ee3-4390-841a-814f7709a855	ee2c3c085455db933f69457943c7b897bf0197d8c775d849d21243ec59181a6d	2026-01-05 11:55:39.742237+00	20260104072157_add_loan_repayments	\N	\N	2026-01-05 11:55:39.641594+00	1
d6458f8c-2e9e-46ca-9729-8d74c7ee4079	d1d5e513496bca9464b753a6110fb327be713377504db14d9e9418f9f9f6501c	2026-01-05 11:55:39.749079+00	20260104084729_update_loan_documents	\N	\N	2026-01-05 11:55:39.743182+00	1
01038f29-d60d-413d-bd8f-fb8df1247a00	334cfe9108c27e66478902a2fdc184e6d31977c310ef7695bbbf6c04e22ae985	2026-01-05 11:55:39.846857+00	20260104165615_add_default_timestamp	\N	\N	2026-01-05 11:55:39.750405+00	1
\.


--
-- Data for Name: arbitrage_hostings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.arbitrage_hostings (id, user_id, product_id, amount, status, currency, start_date, end_date, last_profit_date, total_earned, created_at, updated_at) FROM stdin;
1	12	1	1500.00	ended	USDT	2025-12-09 02:28:29	2025-12-10 02:28:29	2025-12-10 02:28:29	7.50	2025-12-09 02:28:29	2025-12-10 02:28:29
3	4	1	2999.00	ended	USDT	2026-01-02 21:35:36	2026-01-03 21:35:36	2026-01-03 21:35:36	15.00	2026-01-02 21:35:36	2026-01-03 21:35:36
4	12	1	2500.00	cancelled	USDT	2026-01-06 16:53:51	2026-01-06 16:54:07	\N	0.00	2026-01-06 16:53:51	2026-01-06 16:54:07
2	12	6	150000.00	cancelled	USDT	2025-12-09 02:29:03	2026-01-06 16:54:12	\N	0.00	2025-12-09 02:29:03	2026-01-06 16:54:12
5	24	1	2999.00	cancelled	USDT	2026-01-08 05:46:39	2026-01-08 05:48:12	\N	0.00	2026-01-08 05:46:39	2026-01-08 05:48:12
6	31	5	50000.00	cancelled	USDT	2026-01-15 20:37:13	2026-01-15 20:37:41	\N	0.00	2026-01-15 20:37:13	2026-01-15 20:37:41
7	78	2	7999.00	ended	BTC	2026-05-02 13:31:01	2026-05-05 13:31:01	2026-05-05 13:31:01	208.77	2026-05-02 13:31:01	2026-05-05 13:31:01
8	78	1	2999.00	ended	BTC	2026-05-08 01:37:48	2026-05-09 01:37:48	2026-05-09 01:37:48	15.00	2026-05-08 01:37:48	2026-05-09 01:37:48
9	78	1	2999.00	ended	BTC	2026-05-08 18:01:24	2026-05-09 18:01:24	2026-05-09 18:01:24	15.00	2026-05-08 18:01:24	2026-05-09 18:01:25
10	78	2	7999.00	ended	BTC	2026-05-12 10:29:21	2026-05-15 10:29:21	2026-05-15 10:29:21	208.77	2026-05-12 10:29:21	2026-05-15 10:29:21
11	78	3	19999.00	ended	BTC	2026-05-26 02:22:04	2026-06-02 02:22:04	2026-06-02 02:22:04	1385.93	2026-05-26 02:22:04	2026-06-02 02:22:04
12	78	4	50001.00	ended	BTC	2026-05-30 01:10:28	2026-06-06 01:10:28	2026-06-06 01:10:28	4200.08	2026-05-30 01:10:28	2026-06-06 01:10:29
15	78	2	7999.00	ended	BTC	2026-06-17 22:40:41	2026-06-20 22:40:41	2026-06-20 22:40:41	208.77	2026-06-17 22:40:41	2026-06-20 22:40:42
13	78	5	99999.00	ended	BTC	2026-06-07 00:46:11	2026-06-21 00:46:11	2026-06-21 00:46:11	19739.80	2026-06-07 00:46:11	2026-06-21 00:46:12
14	78	4	50001.00	ended	BTC	2026-06-14 02:12:53	2026-06-21 02:12:53	2026-06-21 02:12:53	4200.08	2026-06-14 02:12:53	2026-06-21 02:12:53
\.


--
-- Data for Name: arbitrage_products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.arbitrage_products (id, name, days, daily_rate, min_amount, max_amount, image, is_active, supported_currencies, created_at, updated_at) FROM stdin;
1	A100	1	0.50	1000.00	2999.00	/avatar.jpg	t	["USDT","BTC","ETH"]	2025-12-06 14:22:36	2025-12-06 14:22:36
2	H200	3	0.87	3000.00	7999.00	/avatar.jpg	t	["USDT","BTC","ETH"]	2025-12-06 14:22:36	2025-12-06 14:22:36
3	GH350	7	0.99	8000.00	19999.00	/avatar.jpg	t	["USDT","BTC","ETH"]	2025-12-06 14:22:36	2025-12-06 14:22:36
4	V1	7	1.20	20000.00	50001.00	/avatar.jpg	t	["USDT","BTC","ETH"]	2025-12-06 14:22:36	2025-12-06 14:22:36
5	V8	14	1.41	50000.00	99999.00	/avatar.jpg	t	["USDT","BTC","ETH"]	2025-12-06 14:22:36	2025-12-06 14:22:36
6	V12	15	1.56	100000.00	200000.00	/avatar.jpg	t	["USDT","BTC","ETH"]	2025-12-06 14:22:36	2025-12-06 14:22:36
7	V16	20	1.62	200000.00	300000.00	/avatar.jpg	t	["USDT","BTC","ETH"]	2025-12-06 14:22:36	2025-12-06 14:22:36
8	A360	20	1.76	300000.00	500000.00	/avatar.jpg	t	["USDT","BTC","ETH"]	2025-12-06 14:22:36	2025-12-06 14:22:36
9	A3487	26	1.86	500000.00	999999.00	/avatar.jpg	t	["USDT","BTC","ETH"]	2025-12-06 14:22:36	2025-12-06 14:22:36
10	A3679	35	3.10	1000000.00	3000000.00	/avatar.jpg	t	["USDT","BTC","ETH"]	2025-12-06 14:22:36	2025-12-06 14:22:36
\.


--
-- Data for Name: assets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.assets (id, user_id, symbol, name, amount, current_price, current_value, avg_purchase_price, last_updated_at, created_at, updated_at) FROM stdin;
1	12	ETH	ETH	1.59903802	2072.83000000	3314.53	3127.44000000	2026-03-26 20:17:03	2025-12-08 06:14:39	2026-03-26 20:17:03
\.


--
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache (key, value, expiration) FROM stdin;
\.


--
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- Data for Name: crypto_addresses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.crypto_addresses (id, currency, network, address, qr_code, is_active, notes, created_by, updated_by, last_updated, created_at, updated_at) FROM stdin;
13	ETH	ETH	0xe7800295778578a72Ef10a4fB07FC6CCC1b03f5E	\N	t		2	67	2026-05-12 13:04:32	2025-12-31 14:36:12	2026-05-12 13:04:32
14	BTC	BTC	bc1qt7vy7689jzgqvkgu5jkg47f2an5hvyprudp6yy	\N	t		3	67	2026-06-15 05:04:50	2026-01-20 17:32:18	2026-06-15 05:04:50
\.


--
-- Data for Name: deposits; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deposits (id, user_id, currency, amount, transaction_id, payment_method, payment_details, description, proof_image, status, rejection_reason, processed_by, processed_at, created_at, updated_at) FROM stdin;
2	12	USDT	199990.00	\N	crypto	\N	\N	https://i.ibb.co/prJpTbc1/134086269334785706.jpg	approved	\N	3	2025-12-08 06:35:40	2025-12-08 06:34:53	2025-12-08 06:35:40
1	12	USDT	199990.00	\N	crypto	\N	\N	https://i.ibb.co/TxvGw8Jp/134095163709256301.jpg	approved	\N	3	2025-12-08 06:35:45	2025-12-08 06:34:35	2025-12-08 06:35:45
3	12	BTC	50000.00	\N	crypto	\N	\N	https://i.ibb.co/TxvGw8Jp/134095163709256301.jpg	approved	\N	3	2025-12-08 06:36:16	2025-12-08 06:35:58	2025-12-08 06:36:16
4	31	ETH	16.00	\N	crypto	\N	\N	https://i.ibb.co/JjKJFYzv/Screenshot-2026-01-16-01-08-10-95-40deb401b9ffe8e1df2f1cc5ba480b12.jpg	approved	\N	3	2026-01-15 20:24:36	2026-01-15 20:23:31	2026-01-15 20:24:36
5	31	ETH	50000.00	\N	crypto	\N	\N	https://i.ibb.co/JjKJFYzv/Screenshot-2026-01-16-01-08-10-95-40deb401b9ffe8e1df2f1cc5ba480b12.jpg	approved	\N	3	2026-01-15 20:25:59	2026-01-15 20:25:36	2026-01-15 20:25:59
6	31	ETH	150000.00	\N	crypto	\N	\N	https://i.ibb.co/JjKJFYzv/Screenshot-2026-01-16-01-08-10-95-40deb401b9ffe8e1df2f1cc5ba480b12.jpg	approved	\N	3	2026-01-15 20:29:56	2026-01-15 20:29:46	2026-01-15 20:29:56
7	31	ETH	150000.00	\N	crypto	\N	\N	https://i.ibb.co/JjKJFYzv/Screenshot-2026-01-16-01-08-10-95-40deb401b9ffe8e1df2f1cc5ba480b12.jpg	approved	\N	3	2026-01-15 20:30:48	2026-01-15 20:30:35	2026-01-15 20:30:48
8	33	ETH	10.00	\N	crypto	\N	\N	https://i.ibb.co/7Jsz8Ncg/IMG-4490.png	approved	\N	3	2026-01-17 05:39:18	2026-01-16 22:14:41	2026-01-17 05:39:18
9	38	BTC	10.00	\N	crypto	\N	\N	https://i.ibb.co/WN6DPx52/IMG-2634.png	approved	\N	3	2026-01-28 14:32:38	2026-01-27 23:23:51	2026-01-28 14:32:38
10	33	ETH	10.00	\N	crypto	\N	\N	https://i.ibb.co/Sw6v0680/IMG-4955.jpg	approved	\N	3	2026-02-04 23:31:31	2026-02-04 23:25:32	2026-02-04 23:31:31
12	38	ETH	10.00	\N	crypto	\N	\N	https://i.ibb.co/Gf905ZR8/IMG-2806.png	pending	\N	\N	\N	2026-02-10 20:50:58	2026-02-10 20:50:58
13	38	ETH	10.00	\N	crypto	\N	\N	https://i.ibb.co/Gf905ZR8/IMG-2806.png	pending	\N	\N	\N	2026-02-10 20:51:53	2026-02-10 20:51:53
11	38	ETH	10.00	\N	crypto	\N	\N	https://i.ibb.co/hF1tztKr/IMG-2803.png	approved	\N	3	2026-02-10 21:43:56	2026-02-10 20:49:41	2026-02-10 21:43:56
14	47	ETH	10.00	\N	crypto	\N	\N	https://i.ibb.co/zTDM2mCf/IMG-4623.png	rejected	Deposit request rejected due to verification issues	3	2026-02-11 16:28:41	2026-02-11 13:33:53	2026-02-11 16:28:41
17	38	ETH	10.00	\N	crypto	\N	\N	https://i.ibb.co/cPxNqNV/IMG-2824.png	pending	\N	\N	\N	2026-02-18 21:27:11	2026-02-18 21:27:11
16	38	ETH	10.00	\N	crypto	\N	\N	https://i.ibb.co/6RPMxxk4/IMG-2825.png	approved	\N	3	2026-02-18 21:51:19	2026-02-18 21:27:01	2026-02-18 21:51:19
18	23	BTC	2000.00	\N	crypto	\N	\N	https://i.ibb.co/zVXBXXHD/IMG-2107.png	pending	\N	\N	\N	2026-02-19 16:19:22	2026-02-19 16:19:22
19	23	BTC	2000.00	\N	crypto	\N	\N	https://i.ibb.co/3mv9gHg8/IMG-2106.png	approved	\N	3	2026-02-20 17:44:17	2026-02-19 16:21:15	2026-02-20 17:44:17
20	38	ETH	10.00	\N	crypto	\N	\N	https://i.ibb.co/Xr9P3Hqb/IMG-2829.png	pending	\N	\N	\N	2026-02-21 00:21:58	2026-02-21 00:21:58
21	38	ETH	10.00	\N	crypto	\N	\N	https://i.ibb.co/Xr9P3Hqb/IMG-2829.png	pending	\N	\N	\N	2026-02-21 00:22:09	2026-02-21 00:22:09
22	38	ETH	10.00	\N	crypto	\N	\N	https://i.ibb.co/ym4SLW1L/IMG-2829.png	pending	\N	\N	\N	2026-02-21 00:28:32	2026-02-21 00:28:32
23	38	ETH	10.00	\N	crypto	\N	\N	https://i.ibb.co/SDFJwhj1/IMG-2832.png	pending	\N	\N	\N	2026-02-21 00:30:18	2026-02-21 00:30:18
24	42	ETH	10.00	\N	crypto	\N	\N	https://i.ibb.co/d4FcbHFC/IMG-9457.png	pending	\N	\N	\N	2026-02-23 00:57:59	2026-02-23 00:57:59
25	23	BTC	10.00	\N	crypto	\N	\N	https://i.ibb.co/7m5q9GV/IMG-2208.png	pending	\N	\N	\N	2026-02-23 19:25:16	2026-02-23 19:25:16
26	23	BTC	10.00	\N	crypto	\N	\N	https://i.ibb.co/7m5q9GV/IMG-2208.png	pending	\N	\N	\N	2026-02-23 19:25:44	2026-02-23 19:25:44
27	23	BTC	10.00	\N	crypto	\N	\N	https://i.ibb.co/5gryHtzT/IMG-2385.png	pending	\N	\N	\N	2026-03-01 04:00:53	2026-03-01 04:00:53
28	23	BTC	10.00	\N	crypto	\N	\N	https://i.ibb.co/fz4PqGQM/IMG-2386.png	pending	\N	\N	\N	2026-03-01 04:01:18	2026-03-01 04:01:18
29	23	BTC	10.00	\N	crypto	\N	\N	https://i.ibb.co/PvRDLpK8/IMG-2384.png	pending	\N	\N	\N	2026-03-01 04:01:34	2026-03-01 04:01:34
30	23	BTC	10.00	\N	crypto	\N	\N	https://i.ibb.co/Y7gWW9tb/IMG-2383.png	pending	\N	\N	\N	2026-03-01 04:01:51	2026-03-01 04:01:51
31	23	BTC	10.00	\N	crypto	\N	\N	https://i.ibb.co/HDT04CdB/IMG-2382.png	pending	\N	\N	\N	2026-03-01 04:02:04	2026-03-01 04:02:04
32	23	BTC	10.00	\N	crypto	\N	\N	https://i.ibb.co/G48pL6vw/IMG-2402.png	pending	\N	\N	\N	2026-03-02 03:23:11	2026-03-02 03:23:11
33	23	BTC	10.00	\N	crypto	\N	\N	https://i.ibb.co/G48pL6vw/IMG-2402.png	pending	\N	\N	\N	2026-03-02 03:24:51	2026-03-02 03:24:51
34	64	ETH	10.00	\N	crypto	\N	\N	https://i.ibb.co/Q7DGSQHy/IMG-1645.png	pending	\N	\N	\N	2026-03-10 20:20:54	2026-03-10 20:20:54
35	38	ETH	10.00	\N	crypto	\N	\N	https://i.ibb.co/FkptW6f3/IMG-2891.png	pending	\N	\N	\N	2026-03-12 21:27:13	2026-03-12 21:27:13
36	38	ETH	10.00	\N	crypto	\N	\N	https://i.ibb.co/vrLCv2j/IMG-2890.png	pending	\N	\N	\N	2026-03-12 21:27:22	2026-03-12 21:27:22
37	38	ETH	10.00	\N	crypto	\N	\N	https://i.ibb.co/xtFQrDhm/IMG-2891.png	pending	\N	\N	\N	2026-03-13 00:30:31	2026-03-13 00:30:31
38	38	ETH	10.00	\N	crypto	\N	\N	https://i.ibb.co/Y46SfXkj/IMG-2892.png	pending	\N	\N	\N	2026-03-13 20:04:11	2026-03-13 20:04:11
39	38	ETH	10.00	\N	crypto	\N	\N	https://i.ibb.co/Y46SfXkj/IMG-2892.png	pending	\N	\N	\N	2026-03-13 20:04:58	2026-03-13 20:04:58
40	77	ETH	9800.00	\N	crypto	\N	\N	https://i.ibb.co/jvL3GC97/image.jpg	pending	\N	\N	\N	2026-03-26 15:02:52	2026-03-26 15:02:52
41	76	ETH	10.00	\N	crypto	\N	\N	https://i.ibb.co/236N5N8D/image.jpg	pending	\N	\N	\N	2026-04-06 20:20:36	2026-04-06 20:20:36
42	78	BTC	10.00	\N	crypto	\N	\N	https://i.ibb.co/B2sXY6x4/IMG-4965.png	pending	\N	\N	\N	2026-04-14 00:38:57	2026-04-14 00:38:57
43	38	ETH	10.00	\N	crypto	\N	\N	https://i.ibb.co/BVbZGfyg/IMG-2928.png	pending	\N	\N	\N	2026-04-29 17:37:28	2026-04-29 17:37:28
44	38	ETH	10.00	\N	crypto	\N	\N	https://i.ibb.co/dwmCMM38/IMG-2929.png	pending	\N	\N	\N	2026-04-29 17:38:10	2026-04-29 17:38:10
45	38	ETH	10.00	\N	crypto	\N	\N	https://i.ibb.co/HTvGHKhL/IMG-2930.png	pending	\N	\N	\N	2026-04-29 17:42:32	2026-04-29 17:42:32
46	38	ETH	10.00	\N	crypto	\N	\N	https://i.ibb.co/HTvGHKhL/IMG-2930.png	pending	\N	\N	\N	2026-04-29 17:47:48	2026-04-29 17:47:48
47	38	ETH	10.00	\N	crypto	\N	\N	https://i.ibb.co/HTvGHKhL/IMG-2930.png	pending	\N	\N	\N	2026-04-29 18:14:12	2026-04-29 18:14:12
48	38	ETH	10.00	\N	crypto	\N	\N	https://i.ibb.co/BKy6bqfF/IMG-3138.png	pending	\N	\N	\N	2026-06-18 01:11:17	2026-06-18 01:11:17
49	38	ETH	10.00	\N	crypto	\N	\N	https://i.ibb.co/Xf4dwLhW/IMG-3139.png	pending	\N	\N	\N	2026-06-18 01:13:10	2026-06-18 01:13:10
\.


--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
\.


--
-- Data for Name: kyc_submissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kyc_submissions (id, user_id, document_type, document_number, front_image_url, back_image_url, selfie_image_url, status, rejection_reason, approved_at, rejected_at, processed_by, processed_at, created_at, updated_at) FROM stdin;
1	7	passport	ES0111416	https://i.ibb.co/1f4xNFNG/1000049094.jpg	https://i.ibb.co/xq1tVzyy/1000049095.jpg	https://i.ibb.co/QvPqCDpN/1000049096.jpg	approved	\N	2025-12-06 21:43:52	\N	3	2025-12-06 21:43:52	2025-12-06 21:43:09	2025-12-06 21:43:52
2	9	driving_license	056242629	https://i.ibb.co/5WndRqmW/1000019230.jpg	https://i.ibb.co/Tq0F9T3D/1000019231.jpg	https://i.ibb.co/5WndRqmW/1000019230.jpg	approved	\N	2025-12-07 00:36:31	\N	3	2025-12-07 00:36:31	2025-12-07 00:35:41	2025-12-07 00:36:31
3	5	driving_license	4584	https://i.ibb.co/VWR21K6D/134095163709256301.jpg	https://i.ibb.co/TMyWp8X3/134086269334785706.jpg	https://i.ibb.co/TMyWp8X3/134086269334785706.jpg	approved	\N	2025-12-07 00:52:52	\N	3	2025-12-07 00:52:52	2025-12-07 00:51:36	2025-12-07 00:52:52
4	4	driving_license	ETH123	https://i.ibb.co/F4kFPXg4/IMG-20251121-WA0056.jpg	https://i.ibb.co/F4kFPXg4/IMG-20251121-WA0056.jpg	https://i.ibb.co/F4kFPXg4/IMG-20251121-WA0056.jpg	approved	\N	2025-12-07 06:30:04	\N	2	2025-12-07 06:30:04	2025-12-07 06:29:48	2025-12-07 06:30:04
6	16	driving_license	1234	https://i.ibb.co/sv3t0QqB/1000005470.jpg	https://i.ibb.co/sv3t0QqB/1000005470.jpg	https://i.ibb.co/sv3t0QqB/1000005470.jpg	approved	\N	2025-12-17 00:36:14	\N	3	2025-12-17 00:36:14	2025-12-17 00:35:41	2025-12-17 00:36:14
7	17	driving_license	J188435XH62	https://i.ibb.co/kVvZ9NDn/Driving-lic-front.jpg	https://i.ibb.co/d0gdgphp/Driving-lic-back.jpg	https://i.ibb.co/zVTB5B9W/Selfie-with-doc.jpg	approved	\N	2025-12-17 20:26:40	\N	3	2025-12-17 20:26:40	2025-12-17 19:00:45	2025-12-17 20:26:40
8	18	driving_license	5611102236	https://i.ibb.co/Ng2DVS8R/image.jpg	https://i.ibb.co/pvTtrmFN/image.jpg	https://i.ibb.co/vCHR5KH5/image.jpg	approved	\N	2025-12-18 00:14:30	\N	3	2025-12-18 00:14:30	2025-12-17 20:53:32	2025-12-18 00:14:30
9	20	driving_license	051340897	https://i.ibb.co/6c96dLK8/1000042619.jpg	https://i.ibb.co/7N6hb3sL/1000042618.jpg	https://i.ibb.co/s9fstGHm/1000040797.jpg	approved	\N	2025-12-19 17:43:56	\N	2	2025-12-19 17:43:56	2025-12-19 04:15:49	2025-12-19 17:43:56
10	22	national_id	1127020182	https://i.ibb.co/rKHkXnpn/image.jpg	https://i.ibb.co/zh082JR8/image.jpg	https://i.ibb.co/tPMVDDYM/image.jpg	approved	\N	2025-12-25 09:17:41	\N	3	2025-12-25 09:17:41	2025-12-25 09:11:56	2025-12-25 09:17:41
11	32	driving_license	M10275118998	https://i.ibb.co/7x9PmXD1/image.jpg	https://i.ibb.co/vx8GvcV0/image.jpg	https://i.ibb.co/C5XpYhY9/image.jpg	approved	\N	2026-01-15 16:25:46	\N	3	2026-01-15 16:25:46	2026-01-15 16:19:24	2026-01-15 16:25:46
12	33	national_id	IU4PB1JD1	https://i.ibb.co/SXyzpWVj/IMG-4450.jpg	https://i.ibb.co/1ftPz04P/IMG-4451.jpg	https://i.ibb.co/4g0Vvq1V/IMG-4452.jpg	approved	\N	2026-01-16 19:29:53	\N	3	2026-01-16 19:29:53	2026-01-16 19:25:34	2026-01-16 19:29:53
13	38	passport	653375009	https://i.ibb.co/SXdTBXqV/image.jpg	https://i.ibb.co/PZVxXzw5/image.jpg	https://i.ibb.co/j9bFcPf7/image.jpg	approved	\N	2026-01-22 16:09:46	\N	3	2026-01-22 16:09:46	2026-01-21 23:06:31	2026-01-22 16:09:46
14	44	driving_license	D904037845613	https://i.ibb.co/9knxz3xT/image.jpg	https://i.ibb.co/jkGHtx1y/image.jpg	https://i.ibb.co/svrYqPtD/image.jpg	approved	\N	2026-01-28 20:24:22	\N	3	2026-01-28 20:24:22	2026-01-28 20:22:56	2026-01-28 20:24:22
15	47	national_id	LCH87NJ0P	https://i.ibb.co/RTQJ5snj/image.jpg	https://i.ibb.co/TMqvGfgn/image.jpg	https://i.ibb.co/BKQJRHcL/image.jpg	approved	\N	2026-02-03 19:08:15	\N	3	2026-02-03 19:08:15	2026-02-03 19:07:03	2026-02-03 19:08:15
16	49	driving_license	36716416	https://i.ibb.co/Z6JXBgkz/1000009827.jpg	https://i.ibb.co/svTZtNFh/1000009828.jpg	https://i.ibb.co/Z6JXBgkz/1000009827.jpg	approved	\N	2026-02-04 21:52:39	\N	3	2026-02-04 21:52:39	2026-02-04 21:51:32	2026-02-04 21:52:39
17	50	driving_license	WDL48S83F8SB	https://i.ibb.co/7d308dkP/1000078492.jpg	https://i.ibb.co/7xL9WY6y/1000078493.jpg	https://i.ibb.co/ZpGmY0K4/1000078497.jpg	approved	\N	2026-02-07 03:57:49	\N	3	2026-02-07 03:57:49	2026-02-07 03:26:01	2026-02-07 03:57:49
18	51	driving_license	2000015528	https://i.ibb.co/JW0zmGKm/1000007758.jpg	https://i.ibb.co/N2dHjkFT/1000007759.jpg	https://i.ibb.co/xKcJtJzy/1000007760.jpg	approved	\N	2026-02-07 06:54:24	\N	3	2026-02-07 06:54:24	2026-02-07 06:35:19	2026-02-07 06:54:24
19	46	driving_license	088711342	https://i.ibb.co/DHJPwNnC/1000078527.jpg	https://i.ibb.co/yFtKgfmh/1000078569.jpg	https://i.ibb.co/m5HrLKL8/1000078545.jpg	approved	\N	2026-02-11 03:42:01	\N	3	2026-02-11 03:42:01	2026-02-11 02:57:19	2026-02-11 03:42:01
20	53	driving_license	095326913	https://i.ibb.co/Y4D2yDhp/image.jpg	https://i.ibb.co/7Jmp8WGL/image.jpg	https://i.ibb.co/j1nNG66/image.jpg	approved	\N	2026-02-13 15:29:43	\N	3	2026-02-13 15:29:43	2026-02-13 04:54:39	2026-02-13 15:29:43
21	57	driving_license	TESFA756014RE9NF 23	https://i.ibb.co/yBpgmVQn/image.jpg	https://i.ibb.co/MDMdQZZ5/image.jpg	https://i.ibb.co/RTfr8dH5/image.jpg	approved	\N	2026-02-23 21:18:55	\N	3	2026-02-23 21:18:55	2026-02-23 21:17:07	2026-02-23 21:18:55
22	58	passport	133216902	https://i.ibb.co/FqXpbVN1/1000025706.jpg	https://i.ibb.co/whxpNQ7j/1000025707.jpg	https://i.ibb.co/TDk43Qwk/1000025708.jpg	approved	\N	2026-02-24 00:46:06	\N	3	2026-02-24 00:46:06	2026-02-24 00:42:28	2026-02-24 00:46:06
23	62	driving_license	B60096044	https://i.ibb.co/Y7b6kt18/image.jpg	https://i.ibb.co/xtf53c2g/image.jpg	https://i.ibb.co/CpyJh8t1/IMG-7839.jpg	approved	\N	2026-02-27 20:36:05	\N	3	2026-02-27 20:36:05	2026-02-27 20:32:48	2026-02-27 20:36:05
24	65	driving_license	A61476715	https://i.ibb.co/wrJBCtgf/storage-emulated-0-DCIM-Camera-20230406-170703.jpg	https://i.ibb.co/Xk7rDXr6/storage-emulated-0-DCIM-Camera-20230406-170714.jpg	https://i.ibb.co/fzjPhYfv/image.jpg	approved	\N	2026-03-01 22:24:48	\N	3	2026-03-01 22:24:48	2026-03-01 17:49:30	2026-03-01 22:24:48
25	68	driving_license	2063802744	https://i.ibb.co/1GwvcKRR/image.jpg	https://i.ibb.co/qLjJs6JY/image.jpg	https://i.ibb.co/jmPXH8r/image.jpg	approved	\N	2026-03-13 19:14:28	\N	3	2026-03-13 19:14:28	2026-03-08 08:09:50	2026-03-13 19:14:28
26	74	driving_license	688510	https://i.ibb.co/2Dn16qr/IMG-1435.jpg	https://i.ibb.co/Q351JPqy/IMG-1709.jpg	https://i.ibb.co/xt4bGzKd/19d0dfb9-e3ad-48b7-b515-43b66e15d06d.jpg	rejected	Documents not valid or unclear	\N	2026-03-15 21:38:50	2	2026-03-15 21:38:50	2026-03-15 21:22:42	2026-03-15 21:38:50
27	76	driving_license	GE-BR-EF-T062BA	https://i.ibb.co/2YMxC7pK/image.jpg	https://i.ibb.co/Dg1HzD2n/image.jpg	https://i.ibb.co/2Y5qcSv3/image.jpg	approved	\N	2026-03-16 18:49:40	\N	3	2026-03-16 18:49:40	2026-03-16 18:40:32	2026-03-16 18:49:40
28	77	national_id	L5MZ831GJ	https://i.ibb.co/8gPsk47C/image.jpg	https://i.ibb.co/GQsXNKYM/image.jpg	https://i.ibb.co/PZ81HZjV/image.jpg	approved	\N	2026-03-25 22:17:04	\N	3	2026-03-25 22:17:04	2026-03-23 15:25:33	2026-03-25 22:17:04
29	80	national_id	iUR61RKH6	https://i.ibb.co/08S6g3X/IMG-0269.jpg	https://i.ibb.co/kg0Zy6Pb/IMG-0270.jpg	https://i.ibb.co/W4PnsCXL/image.jpg	approved	\N	2026-04-02 15:16:08	\N	2	2026-04-02 15:16:08	2026-03-29 18:21:02	2026-04-02 15:16:08
30	94	driving_license	613 6006810	https://i.ibb.co/ccBT9xqm/Temp-fe99c45d-60f1-4260-8eeb-5963ee56c577-jpg.jpg	https://i.ibb.co/My1tfjf4/Temp-640aabec-b286-4842-9468-fa288b87e23f-jpg.jpg	https://i.ibb.co/HDvgKdvT/Temp-46586ca1-c59f-4d6f-bd03-2e71be7088b8-jpg.jpg	approved	\N	2026-07-03 02:32:35	\N	3	2026-07-03 02:32:35	2026-07-03 02:24:27	2026-07-03 02:32:35
31	96	driving_license	2122	https://i.ibb.co/RpZbDgN9/IMG-0534.jpg	https://i.ibb.co/C5Krj9G2/IMG-0535.jpg	https://i.ibb.co/BHf02Dyq/IMG-0534.jpg	pending	\N	\N	\N	\N	\N	2026-07-15 03:31:51	2026-07-15 03:31:51
\.


--
-- Data for Name: loan_repayments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.loan_repayments (id, loan_id, amount, proof_image, status, rejection_reason, processed_by, processed_at, created_at, updated_at) FROM stdin;
1	1	100.00	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/87f04cfd-cb92-40b8-aefb-f261c4612b1a-1767801950374-893ec6cfcf7a.jpg	approved	\N	2	2026-01-07 16:06:21	2026-01-07 16:05:51	2026-01-07 16:06:21
2	3	10000.00	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/3611e0fd-8b65-4fda-bcce-23e50204a2dd-1768404160580-ccb086de6b62.png	approved	\N	3	2026-01-14 15:23:30	2026-01-14 15:22:42	2026-01-14 15:23:30
3	4	500.00	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/d31d373a-66ba-4e8a-b8ed-e32d060ae5ac-1768405582135-ce97071f5da5.png	rejected	You have to pay the rest 	3	2026-01-14 15:47:21	2026-01-14 15:46:23	2026-01-14 15:47:21
4	4	60000.00	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/d5ff2bde-b82d-45f3-bbaa-04cb5ee43051-1768407331340-d40afae175df.png	rejected	jdjdjd	3	2026-01-18 01:35:48	2026-01-14 16:15:32	2026-01-18 01:35:48
5	2	7000.00	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/d200405d-270b-49e0-9ea6-219e2c0111b7-1768618176766-e01033d762d5.jfif	approved	\N	3	2026-01-18 01:36:12	2026-01-17 02:49:38	2026-01-18 01:36:12
6	15	10000.00	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/d76af91d-d621-41ec-a3b2-dd26ef4d8de7-1769008615489-94a576bb6a50.jfif	approved	\N	3	2026-01-21 15:17:10	2026-01-21 15:16:56	2026-01-21 15:17:10
8	14	10000.00	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/b6c2bc2f-daf5-4d66-8768-f9fced6d2852-1769456049997-141d7432ce25.png	approved	\N	3	2026-01-26 19:34:50	2026-01-26 19:34:11	2026-01-26 19:34:50
9	14	5005.00	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/ddc2de50-35a6-4960-9cc9-afb98630ae30-1769456133829-719b6a6beed7.png	approved	\N	3	2026-01-26 19:35:49	2026-01-26 19:35:35	2026-01-26 19:35:49
10	16	10000.00	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/2436f3fe-2bd2-4863-bff0-39fa1300c3b9-1769456732018-962a149f2322.jfif	approved	\N	3	2026-01-26 19:46:38	2026-01-26 19:45:33	2026-01-26 19:46:38
11	8	10000.00	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/34b9fb29-4808-43af-b5ef-36ab85b76a7c-1769468711270-c3156838eb2d.jfif	approved	\N	3	2026-01-26 23:05:35	2026-01-26 23:05:12	2026-01-26 23:05:35
12	7	10000.00	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/c8d9fca3-412d-4985-9697-1500aa6d4217-1769468960988-c06bca363535.jfif	approved	\N	3	2026-01-26 23:09:34	2026-01-26 23:09:22	2026-01-26 23:09:34
7	9	10000.00	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/6f2c94c0-f948-479d-8bf0-1f22e2cbe15e-1769451116360-44cf63ec2501.jpg	approved	\N	3	2026-01-26 23:37:22	2026-01-26 18:11:58	2026-01-26 23:37:22
13	9	23812.00	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/21d2ac93-86e1-4e9d-8fd6-c4391ecd7d7f-1769470881796-5ef6a3e8c11e.jpg	approved	\N	3	2026-01-26 23:43:12	2026-01-26 23:41:23	2026-01-26 23:43:12
14	9	23833.37	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/4147f946-a4ee-4c4b-8dd3-aad64517d7ac-1769553333745-235af08260f3.jpg	approved	\N	3	2026-01-27 22:36:05	2026-01-27 22:35:35	2026-01-27 22:36:05
15	9	11348.18	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/f9f9d601-8217-4cf9-b4c7-81f4f47bcd95-1769801815364-9eaa8e408140.jpg	approved	\N	3	2026-01-30 20:17:50	2026-01-30 19:36:57	2026-01-30 20:17:50
16	9	7603.12	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/f8c1348e-071b-44fa-ae3d-5a7856e859d3-1770086049773-fc39afcdce41.jpg	approved	\N	3	2026-02-03 13:27:14	2026-02-03 02:34:11	2026-02-03 13:27:14
17	19	35707.96	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/bf11a211-f778-4056-b680-4ea0fb85cb9b-1770828768578-dff11cb600e1.jpg	approved	\N	3	2026-02-11 17:03:16	2026-02-11 16:52:49	2026-02-11 17:03:16
18	19	17397.00	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/dacab345-75dc-44b8-b74a-61be83703702-1771353040058-48bb3da942c1.jpg	approved	\N	3	2026-02-17 18:37:10	2026-02-17 18:30:42	2026-02-17 18:37:10
19	19	12361.23	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/27b40d5d-f188-453e-aae5-e6d983a7c7e8-1772460192863-6cd4d5163776.jpg	approved	\N	3	2026-03-02 17:29:12	2026-03-02 14:03:14	2026-03-02 17:29:12
20	19	19115.54	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/eab90f56-db74-4627-951c-8f9822e1c2a4-1772558853823-8b7ef60c412c.jpg	approved	\N	3	2026-03-03 23:21:09	2026-03-03 17:27:35	2026-03-03 23:21:09
21	19	23821.45	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/9a1251b2-f3b6-4eba-87e6-69c24a2d50ba-1772830862468-7e406be9e2f2.jpg	approved	\N	3	2026-03-06 21:14:25	2026-03-06 21:01:03	2026-03-06 21:14:25
22	19	6239.84	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/30ddae4c-d876-4fc0-83ec-eb53d52d477d-1773441926166-d9dac69cb85d.jpg	approved	\N	2	2026-03-14 02:48:05	2026-03-13 22:45:27	2026-03-14 02:48:05
23	19	3090.00	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/b9571d98-32a9-48ee-8d89-ecc2cf53aa6f-1773458897440-47e6eb83cb67.jpg	approved	\N	2	2026-03-14 03:28:45	2026-03-14 03:28:18	2026-03-14 03:28:45
24	19	5024.52	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/13b0cc59-f850-48dd-a775-7a41d0cf2044-1773874907778-41370122c698.jpg	approved	\N	2	2026-03-18 23:55:27	2026-03-18 23:01:49	2026-03-18 23:55:27
25	19	1436.00	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/089ada3e-67a8-4be1-88b6-d1ff7c86755d-1773967118106-7fa1e9b9ac93.jpg	approved	\N	2	2026-03-20 03:03:05	2026-03-20 00:38:39	2026-03-20 03:03:05
\.


--
-- Data for Name: loans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.loans (id, user_id, amount, currency, status, rejection_reason, duration, interest_rate, total_payable, accumulated_interest, last_interest_date, due_date, approved_at, repaid_at, processed_by, processed_at, created_at, updated_at, back_image, document_type, front_image) FROM stdin;
1	12	10000.00	USDT	repaid	\N	30	0.01	10000.00	0.00	2026-01-07 16:04:17	2026-02-06 16:04:17	2026-01-07 16:04:17	2026-01-07 16:06:21	2	2026-01-07 16:04:17	2026-01-07 16:02:05	2026-01-07 16:06:21	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/548f75c0-958f-4885-9e5e-fddc6ad21389-1767801722644-507a91769ed4.jpg	passport	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/f8a095ae-0ac2-4f2f-8ffb-01b213a9e887-1767801721141-3ea27746b484.jpg
3	10	80000.00	USDT	repaid	\N	30	0.01	80000.00	0.00	2026-01-14 15:01:17	2026-02-13 15:01:17	2026-01-14 15:01:17	2026-01-14 15:23:30	3	2026-01-14 15:01:17	2026-01-14 14:45:08	2026-01-14 15:23:30	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/6c2c8cdf-1113-4c9d-affd-ca93a4fc428c-1768401907767-60b21d54174d.png	national_id	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/d2a3216a-5bb9-4f8c-8b22-10852e3b96a3-1768401906747-c9030d81fdfa.png
12	4	15000.00	USDT	pending	\N	30	0.01	15000.00	0.00	\N	\N	\N	\N	\N	\N	2026-01-20 18:02:16	2026-01-20 18:02:16	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/6d99c458-cb2b-4ef6-803a-2bd0bca15eb5-1768932135174-1842050dcb4f.jpg	national_id	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/29b44edb-273b-4376-aacf-574493589d81-1768932133647-9d812237b08f.jpg
5	12	80000.00	USDT	approved	\N	30	0.01	458350.78	378350.78	2026-07-20 00:00:00	2026-02-16 05:40:57	2026-01-17 05:40:57	\N	3	2026-01-17 05:40:57	2026-01-16 19:52:21	2026-07-20 00:00:00	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/8322344b-2ecb-4337-9377-7abd6d13cc01-1768593139888-1065b4f11ecf.jfif	national_id	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/20fbc024-7898-410d-806f-dbc781964c14-1768593138237-33e5bc1a29ee.jfif
2	12	50000.00	USDT	repaid	\N	30	0.01	52500.00	2500.00	2026-01-18 00:00:01	2026-02-12 16:58:41	2026-01-13 16:58:41	2026-01-18 01:36:13	3	2026-01-13 16:58:41	2026-01-13 16:58:23	2026-01-18 01:36:13	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/bb3a1f65-b896-4f1a-ae57-c05fa61fa672-1768323502825-d417dc0b419c.jfif	national_id	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/587e0829-519e-42e3-9f59-357a65460b0c-1768323501528-28df09c5b0de.jfif
6	12	60000.00	USDT	pending	\N	30	0.01	60000.00	0.00	\N	\N	\N	\N	\N	\N	2026-01-18 01:40:39	2026-01-18 01:40:39	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/3d77ddeb-d59f-4e0b-8172-c630329eefc3-1768700438233-2739c248dd81.jfif	passport	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/985e9e85-8973-45b3-a471-e9727c744b5b-1768700437031-3d8a55ccf8f5.jfif
8	34	80000.00	USDT	approved	\N	30	0.01	407042.76	337042.76	2026-07-20 00:00:00	2026-02-17 14:44:33	2026-01-18 14:44:33	\N	3	2026-01-18 14:44:33	2026-01-18 14:43:53	2026-07-20 00:00:00	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/c6bb4282-1155-467d-b8ce-c61631355d0d-1768747431464-1b702b929bdc.jfif	national_id	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/756386bc-27b5-4b2b-a9dd-ddd6be29b019-1768747430038-29f642071b99.jfif
4	10	60000.00	USDT	approved	\N	30	0.01	357920.47	297920.47	2026-07-20 00:00:00	2026-02-13 15:45:13	2026-01-14 15:45:13	\N	3	2026-01-14 15:45:13	2026-01-14 15:44:48	2026-07-20 00:00:00	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/3e23c46c-d527-40b4-9666-b8dd46487ab6-1768405486598-21c434748825.png	passport	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/bef1ca1a-e0e5-46c5-86e8-966c72c7132d-1768405485479-bab3c663cc68.png
13	34	50000.00	USDT	approved	\N	30	0.01	282144.46	232144.46	2026-07-20 00:00:00	2026-02-19 18:44:32	2026-01-20 18:44:32	\N	3	2026-01-20 18:44:32	2026-01-20 18:42:17	2026-07-20 00:00:00	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/5afe3f10-6a4c-471e-91b4-72109007a551-1768934535813-237254c8926a.jfif	national_id	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/95c949cb-ac83-4d40-b68c-7965b845ac00-1768934534842-37c460d884dc.jfif
15	34	10000.00	USDT	repaid	\N	30	0.01	10000.00	0.00	2026-01-21 15:15:18	2026-02-20 15:15:18	2026-01-21 15:15:18	2026-01-21 15:17:10	3	2026-01-21 15:15:18	2026-01-21 15:15:06	2026-01-21 15:17:10	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/638f68ce-71b1-4770-b2cc-678596bd378b-1769008504122-378a1efdd778.jfif	national_id	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/8a7bb39a-8446-480a-8b36-dce7596981fd-1769008503074-0b8bff5278b8.jfif
7	34	70000.00	USDT	approved	\N	30	0.01	349889.08	289889.08	2026-07-20 00:00:00	2026-02-17 01:47:09	2026-01-18 01:47:09	\N	3	2026-01-18 01:47:09	2026-01-18 01:46:31	2026-07-20 00:00:00	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/6ddf4aca-6142-4885-a3c7-d42920815480-1768700789478-7ab6c51da52b.jfif	national_id	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/6656550b-63e1-411f-b619-9c5c5265c6e3-1768700788499-57aeebcbccd1.jfif
11	34	50000.00	USDT	approved	\N	30	0.01	282144.46	232144.46	2026-07-20 00:00:00	2026-02-19 16:45:13	2026-01-20 16:45:13	\N	3	2026-01-20 16:45:13	2026-01-20 16:45:02	2026-07-20 00:00:00	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/9da113f6-71ad-4121-bb10-6c6e64f7634b-1768927500568-a81d87194888.jfif	national_id	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/cfa3a7d7-0dda-4f80-8296-913e9708604a-1768927498870-f9da0dc09bb1.jfif
9	9	70000.00	USDT	repaid	\N	30	0.01	0.00	6596.67	2026-02-03 00:00:01	2026-02-20 15:17:58	2026-01-21 15:17:58	2026-02-03 13:27:14	3	2026-01-21 15:17:58	2026-01-18 17:17:38	2026-02-03 13:27:14	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/8fc414d8-f55a-447e-bd5f-cee3bfee1fcd-1768756657529-d4a6f614cbd5.jpg	national_id	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/bea4a083-1b51-4f4f-a6d3-dd101cab1cb5-1768756656169-ea0d721e84d1.jpg
14	4	15000.00	USDT	repaid	\N	30	0.01	0.00	0.00	2026-01-26 19:33:27	2026-02-25 19:33:27	2026-01-26 19:33:27	2026-01-26 19:35:49	3	2026-01-26 19:33:27	2026-01-21 15:06:16	2026-01-26 19:35:49	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/b482871f-4b10-4ed9-aaa2-03355c1a7239-1769007974643-01987a220141.png	passport	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/9261677a-9585-466d-b0f6-7f7b4f04e1b9-1769007973346-97148a6f50ba.png
17	10	20000.00	USDT	pending	\N	30	0.01	20000.00	0.00	\N	\N	\N	\N	\N	\N	2026-01-29 05:23:02	2026-01-29 05:23:02	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/a3838dd3-9aeb-43d5-9f1c-e8a11b6483b9-1769664180900-77b701f7bf3b.jpeg	national_id	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/4995cc7f-e0e1-4f1a-9574-655a8b43727c-1769664179450-d9e701e7949f.jpeg
16	34	50000.00	USDT	approved	\N	30	0.01	220218.79	180218.79	2026-07-20 00:00:00	2026-02-25 19:45:07	2026-01-26 19:45:07	\N	3	2026-01-26 19:45:07	2026-01-26 19:44:38	2026-07-20 00:00:00	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/acd9fb75-823f-4ce6-90dd-d05f24276350-1769456676761-d7f375ffa982.jfif	national_id	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/7c8a3248-b61b-4d17-b21c-565383cd4788-1769456675353-48f5a54418cb.jfif
18	12	20000.00	USDT	approved	\N	30	0.01	21442.70	1442.70	2026-07-20 00:00:00	2026-08-12 17:13:38	2026-07-13 17:13:38	\N	3	2026-07-13 17:13:38	2026-01-29 14:24:13	2026-07-20 00:00:00	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/6d0e936d-e78f-4cf3-8338-5f5d375dc888-1769696652673-b7bbb1c96d44.jfif	national_id	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/d112b7a4-a6d2-46b8-9679-db6f9607c58a-1769696651809-5a3695853497.jfif
10	34	39999.00	USDT	approved	\N	30	0.01	225709.98	185710.98	2026-07-20 00:00:00	2026-02-19 16:42:48	2026-01-20 16:42:48	\N	3	2026-01-20 16:42:48	2026-01-20 16:42:37	2026-07-20 00:00:00	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/8f7f9736-836d-4326-a389-46c82cb7a6ca-1768927356139-1abd8897e703.jfif	national_id	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/485273c3-f50f-4b99-a8d5-aa2dd3b614e8-1768927353357-30c693de7f2e.jfif
19	9	100000.00	USDT	repaid	\N	30	0.01	0.00	24118.95	2026-03-20 00:00:01	2026-03-05 15:44:27	2026-02-03 15:44:27	2026-03-20 03:03:06	3	2026-02-03 15:44:27	2026-02-03 15:42:49	2026-03-20 03:03:06	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/9967133b-2174-4da2-8325-6bd380e1c2e0-1770133368029-59b4678e5ca1.jpg	driving_license	https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/uploads/eeaa5f63-be8a-4349-b9fb-5c49afd68a23-1770133367208-0946eb067a71.jpg
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, migration, batch) FROM stdin;
\.


--
-- Data for Name: mining_hostings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mining_hostings (id, user_id, product_id, amount, status, currency, start_date, end_date, last_profit_date, total_earned, created_at, updated_at) FROM stdin;
2	12	1	50000.00	cancelled	USDT	2026-02-16 02:27:41	2026-02-16 02:27:53	\N	0.00	2026-02-16 02:27:41	2026-02-16 02:27:53
1	12	1	51000.00	cancelled	USDT	2026-01-06 16:55:54	2026-02-16 02:27:59	2026-02-05 16:55:54	28764.00	2026-01-06 16:55:54	2026-02-16 02:27:59
6	10	1	50000.00	cancelled	USDT	2026-03-10 02:29:09	2026-03-10 02:29:23	\N	0.00	2026-03-10 02:29:09	2026-03-10 02:29:23
9	12	2	400000.00	cancelled	USDT	2026-03-11 01:43:30	2026-03-25 22:11:05	2026-03-25 22:11:05	106400.00	2026-03-11 01:43:30	2026-03-25 22:11:05
3	12	1	100000.00	cancelled	USDT	2026-03-10 01:24:51	2026-03-25 22:11:14	2026-03-25 22:11:14	28200.00	2026-03-10 01:24:51	2026-03-25 22:11:14
5	10	1	50000.00	ended	USDT	2026-03-10 02:28:28	2026-04-09 02:28:28	2026-04-09 02:28:28	28200.00	2026-03-10 02:28:28	2026-04-09 02:28:29
4	10	2	400000.00	ended	USDT	2026-03-10 01:53:02	2026-04-19 01:53:02	2026-04-19 01:53:02	304000.00	2026-03-10 01:53:02	2026-04-19 01:53:02
7	10	2	400000.00	ended	USDT	2026-03-10 02:43:37	2026-04-19 02:43:37	2026-04-19 02:43:37	304000.00	2026-03-10 02:43:37	2026-04-19 02:43:38
8	9	2	400000.00	ended	USDT	2026-03-11 01:35:44	2026-04-20 01:35:44	2026-04-20 01:35:44	304000.00	2026-03-11 01:35:44	2026-04-20 01:35:45
10	12	2	200000.00	ended	USDT	2026-03-25 22:08:30	2026-05-04 22:08:30	2026-05-04 22:08:30	152000.00	2026-03-25 22:08:30	2026-05-04 22:08:32
11	10	3	1813754.39	cancelled	USDT	2026-05-29 03:55:27	2026-06-02 01:51:42	2026-06-02 01:51:42	108825.26	2026-05-29 03:55:27	2026-06-02 01:51:42
\.


--
-- Data for Name: mining_products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mining_products (id, name, days, daily_rate, min_amount, max_amount, limit_times, hashrate, power, network_type, manufacturer, size, weight, temperature, humidity, image, is_active, created_at, updated_at) FROM stdin;
1	S3	30	1.88	50000.00	100001.00	3	850W+12%	210W	ETH	Intel	360x125x155mm	8.2KG	0~45C	-20~75	/s3.jpg	t	2025-12-06 14:22:36	2025-12-06 14:22:36
2	MS3	40	1.90	200000.00	400000.00	3	8300+/-10%	3188+/-10%	ETH	Intel	570x316x430mm	1700kg	0~45C	3%RH-115%RH	/ms3.jpg	t	2025-12-06 14:22:36	2025-12-06 14:22:36
3	460S	45	2.00	1000000.00	3000000.00	1	500TH/S +/-5%	34000W +/-10%	ETH	Bitmain	550x320x200mm	14.5KG	0~40C	5%RH~95%RH	/460s.jpg	t	2025-12-06 14:22:36	2025-12-06 14:22:36
\.


--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
natamelanie410@gmail.com	563704d2c114cf12ba86cb69014002b055f6376b8ec4b039cd34ae9b9f76762b	2025-12-25 03:18:46
tigistkumsia12@gmail.com	01b9fa1ead3a6a3c6e45455315d402de0b1192f882be67ac60246c82f2020bf6	2026-05-29 11:14:51
babure880@gmail.com	cfc0e1965b3a3d5fefd886bfab50fb8f610c4cc74ccb13da0b8ce5ca69c936e5	2026-06-22 20:24:44
Tokentradesnet@gmail.com	c460d1c0b148b44bab1bb399bb0fae1481e8e66ae4ee23a77172e8876f423a63	2026-01-17 18:34:22
yeabsirayirdaw12@gmail.com	ec2a30c830117712a9bc006fb4665e17603fb9a3439cd29ec3afed195fe5239a	2026-02-14 04:26:43
\.


--
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personal_access_tokens (id, tokenable_type, tokenable_id, name, token, abilities, last_used_at, expires_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profiles (id, user_id, uuid, kyc_status, level, kyc_documents, bank_account, blockchain_addresses, google_auth_enabled, google_auth_secret, withdrawal_password_enabled, withdrawal_password, trade_status, total_assets, preferred_language, notification_settings, sim_trade_enabled, invite_code, referral_count, created_at, updated_at) FROM stdin;
33	36	ba67b8d5-c99d-4113-9e76-0efeebe092e7	verified	1	{"verified_at":"2026-01-19T14:54:16.919Z"}	\N	\N	f	\N	f	\N	loss	361870.64000000	en	\N	f	\N	0	2026-01-19 14:49:45	2026-06-11 16:01:10
19	22	0c20f1e8-a19d-44e4-b1e3-8d1a6ecb68cb	verified	1	\N	\N	\N	f	\N	f	\N	loss	16163.13000000	en	\N	f	\N	0	\N	2025-12-26 09:21:03
16	19	2fb664f1-ba4c-4f79-8bba-fb4f50cdff0c	unverified	1	\N	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	\N	\N
18	21	1f04a492-8250-4e77-b837-7ddcbf893d56	verified	3	{"verified_at":"2025-12-23T00:48:49.408Z"}	\N	\N	f	\N	t	$2b$10$3pSdf1RwwvylyU3M/FdTAeaiG0iYWev9GwIODju3TNEARd0ZRWbna	loss	4167.00000000	en	\N	f	\N	0	\N	2026-01-06 16:43:50
37	40	f7d3d8e7-0a83-4b26-81ff-7ff9b0e0aa31	unverified	1	\N	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	2026-01-22 08:14:10	2026-01-22 08:14:10
13	16	57ec2e63-b40c-485f-8b06-7efbf58988b8	verified	1	\N	\N	\N	f	\N	t	$2b$10$sW7GnWPbhriTyQ7Wiks7f.x7gUqeLAFUQ1mEy66Nm0/J02gSkUg9.	\N	45628.00000000	en	\N	f	\N	0	\N	2025-12-27 19:12:11
10	13	653881df-86b8-4b17-b606-c55cc0b43402	unverified	1	\N	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	\N	\N
11	14	82419b52-5c88-493a-9b7b-d8e5322e2b8c	unverified	1	\N	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	\N	\N
48	51	4b7708cd-c0d9-4c80-bec7-a6aa8b9e3d5a	verified	1	\N	\N	\N	f	\N	f	\N	loss	2275.00000000	en	\N	f	\N	0	2026-02-07 06:19:32	2026-05-24 21:46:51
17	20	d504e8d8-c175-4165-9e10-d97645e064fa	verified	1	{"verified_at":"2025-12-19T17:43:40.110Z"}	\N	\N	f	\N	t	$2b$10$l.lP0EVCrUaYbhLvR8dg4e11IudrA7WcRBISbfYvJ0/LILgC6vl76	loss	6289.25000000	en	\N	f	\N	0	\N	2026-01-29 01:05:26
47	50	3d1cde64-71cd-4e0f-a280-0ba9ff35b84f	verified	1	\N	\N	\N	f	\N	t	$2b$10$wauMng1yd25Y.pSilKd3aesgceOwOvVOaOeFL0gCJghZa/nqNJa9.	loss	5654.00000000	en	\N	f	\N	0	2026-02-07 02:47:53	2026-04-17 04:32:24
14	17	f687dfa0-582a-43c9-9564-bca004b4ab47	verified	1	\N	\N	\N	f	\N	t	$2b$10$sQZPpuxAt5wIgXTf/2keL.1Uyf.WUF8v26/4A/g4tGWBVNr1hGC3G	loss	16763.00000000	en	\N	f	\N	0	\N	2026-03-21 16:48:01
23	26	bcdf12c2-8c69-45ed-9ca2-ad06bcbb171b	unverified	1	\N	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	2026-01-12 12:51:42	2026-01-12 12:51:42
4	7	9729550a-15eb-41a4-bcf1-b591fc403175	verified	1	\N	\N	\N	f	\N	f	\N	loss	4640.00000000	en	\N	f	\N	0	\N	2025-12-09 16:27:11
2	5	d342acb0-e942-4cd3-9ea6-a1e76bfc92c0	verified	1	\N	\N	\N	f	\N	t	$2b$10$8AY7MGSW3B5yI.OwnqR49.TMYsqB1XydNxpaTy6fEbjBCGVZoJ/Wi	loss	133484.00000000	en	\N	f	\N	0	\N	2026-01-07 03:59:42
44	47	69a5acda-08df-4f6a-90eb-613fc8e9262d	verified	1	\N	\N	\N	f	\N	t	$2b$10$A4HJRAAfcLuw05xwhl1n.uheQiGAWFuNPY/zkTyu2vg6Nw5vNNGGi	loss	210358.00000000	en	\N	f	\N	0	2026-02-03 18:49:49	2026-06-06 13:42:49
12	15	9a2c3aa6-3254-4702-a666-763b25fa2164	unverified	1	\N	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	\N	\N
24	27	15519394-5e72-409d-9507-ddbdf006c5f0	unverified	1	\N	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	2026-01-12 21:17:55	2026-01-12 21:17:55
26	29	224978c7-9f16-46ca-8fe6-3e2d49509835	unverified	1	\N	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	2026-01-14 10:36:38	2026-01-14 10:36:38
31	34	38443024-5071-464a-9295-0b397b8af2fd	unverified	1	\N	\N	\N	f	\N	f	\N	\N	299999.00000000	en	\N	f	\N	0	2026-01-17 18:33:55	2026-01-21 17:16:06
9	12	ff0684aa-2e4c-41bd-8053-fd25a71ec3cd	verified	3	{"verified_at":"2025-12-08T06:05:42.471Z"}	\N	\N	f	\N	t	$2b$10$kAn78FRfMqyWkYeF.rgwQuK9h7RTjHtzyIGsBVOeY6pvoJaKt3Aea	win	2010223.29000000	en	\N	f	\N	0	\N	2026-06-12 12:40:44
45	48	560c4536-e47d-47bd-b5db-3ac1ac0ee8e6	unverified	1	\N	\N	\N	f	\N	f	\N	win	268598.00000000	en	\N	f	\N	0	2026-02-03 19:28:33	2026-03-06 22:52:04
27	30	eeecce2a-fe91-472a-9ff8-c28fbf15a671	unverified	1	\N	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	2026-01-14 16:05:23	2026-01-14 16:05:23
21	24	5e31c534-15db-4cb3-9694-2bbfc0cbeea5	verified	1	{"verified_at":"2025-12-31T15:23:16.223Z"}	\N	\N	f	\N	t	$2b$10$h2kTGapAbz3ojn.NoJ9Z8uGF5rJimphOP5ZOneZIIxO.QFVP1a1.y	\N	98451.00000000	en	\N	f	\N	0	\N	2026-02-11 19:01:38
38	41	470f1495-0c81-4c2f-9ed8-4e272ad9767d	unverified	1	\N	\N	\N	f	\N	f	\N	win	692500.40000000	en	\N	f	\N	0	2026-01-23 21:09:05	2026-07-14 15:41:50
34	37	003526c8-41df-4a97-a469-082b6d2aa0e1	unverified	1	\N	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	2026-01-19 17:44:26	2026-01-19 17:44:26
30	33	283397ec-a733-4b9a-be9f-2d59b5a74def	verified	1	\N	\N	\N	f	\N	t	$2b$10$l3ku8z1gr8X3N10r3jvuQeSPArs3aoK/zojLf0igjR8GEWQoQAgZ6	\N	17051.00000000	en	\N	f	\N	0	2026-01-16 18:52:16	2026-02-04 23:35:47
36	39	abee7587-b857-4190-b609-4a99d7a12a6c	verified	1	{"verified_at":"2026-01-22T02:20:41.299Z"}	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	2026-01-22 02:13:40	2026-01-22 02:20:41
29	32	e5643c6e-273c-446b-91b3-020227a34576	verified	1	\N	\N	\N	f	\N	t	$2b$10$E4vVNJfChgxSicPWvuFCOeQQsJzBNbW7zPQ4SD.MJSnZ1HezgNA/q	loss	14407.00000000	en	\N	f	\N	0	2026-01-15 16:04:39	2026-01-31 17:52:06
41	44	acb88b87-2009-4ece-ad42-3f5c763ae0c6	verified	1	\N	\N	\N	f	\N	t	$2b$10$Df4UMPaFqJJwJsgDSntmre6RZjyfzNa3tWz0mi80KMHSaehR34vk.	loss	3563.00000000	en	\N	f	\N	0	2026-01-28 17:50:03	2026-02-07 22:20:39
15	18	47ec45ac-7f10-4fd6-9f90-89b8fd4f5929	verified	1	{"verified_at":"2025-12-17T21:08:21.121Z"}	\N	\N	f	\N	f	\N	loss	60.00000000	en	\N	f	\N	0	\N	2026-06-11 16:01:42
42	45	02c0d50a-fe60-4e20-9dda-caf8565c0011	unverified	1	\N	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	2026-01-29 02:38:10	2026-01-29 02:38:10
40	43	293a7a15-c5fd-4d08-9d5b-0569d49be273	unverified	1	\N	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	2026-01-26 09:10:59	2026-01-26 09:10:59
25	28	25eea384-1fd2-4a2c-90cf-b17b4c3e53f4	verified	1	{"verified_at":"2026-01-14T04:47:00.844Z"}	\N	\N	f	\N	f	\N	loss	636.00000000	en	\N	f	\N	0	2026-01-14 04:46:13	2026-03-16 19:29:07
6	9	c10179f1-30ed-4276-8bcc-9e59a8a85f5f	verified	3	\N	\N	\N	f	\N	t	$2b$10$1pWAI0/DBx2GG03b80f/G.b7mqjPZlV5/LM4.eLjZxDVXwz41AIX6	loss	993097.20000000	en	\N	f	\N	0	\N	2026-04-21 21:49:50
35	38	1839e7a1-dfc0-4464-9ae3-75a1318d9e59	verified	1	{"verified_at":"2026-01-21T23:11:41.641Z"}	\N	\N	f	\N	t	$2b$10$zCPhFn4xztzjsTqJxh5oDerVnba0hk6rDOAHSBIiFA7HAwSRjYNR6	loss	1852.00000000	en	\N	f	\N	0	2026-01-21 22:56:35	2026-06-19 18:26:31
39	42	739278a4-f33a-496f-b397-3d1756d3a20d	verified	1	{"verified_at":"2026-01-25T18:35:50.837Z"}	\N	\N	f	\N	f	\N	loss	406.00000000	en	\N	f	\N	0	2026-01-25 18:33:31	2026-01-26 03:53:59
28	31	baa80db1-8f65-4832-af79-deb8408c9c16	verified	3	{"verified_at":"2026-01-15T02:50:14.771Z"}	\N	\N	f	\N	t	$2b$10$B94biOgKaoW7JzIXcccG4uMIft9rgITydGytRnhzM0eBvR0H8rDNC	win	279614.48000000	en	\N	f	\N	0	2026-01-15 02:48:09	2026-07-14 03:38:58
32	35	0d2bd461-a9e6-4dad-9061-6c69b222b312	verified	1	{"verified_at":"2026-01-18T21:24:28.877Z"}	\N	\N	f	\N	f	\N	loss	90.20000000	en	\N	f	\N	0	2026-01-18 21:24:18	2026-02-11 03:25:04
43	46	5b65327e-4a40-48d6-adb8-64e3b6974bfc	verified	1	\N	\N	\N	f	\N	f	\N	loss	0.00000000	en	\N	f	\N	0	2026-02-03 04:01:47	2026-05-12 16:03:48
46	49	6f454431-dd87-43ab-ac7b-844a6c89b24b	verified	1	\N	\N	\N	f	\N	f	\N	loss	1212.00000000	en	\N	f	\N	0	2026-02-04 21:37:38	2026-02-05 18:32:13
1	4	d9dbba87-8d91-487f-9582-5fce441022b4	verified	1	\N	\N	\N	f	\N	t	$2b$10$pod7UQVhhpt2J0CnDggRZuuCtvwvg/aP9CLwf0JyBWBnch6SjOJLG	\N	114039.50000000	en	\N	f	\N	0	\N	2026-07-11 04:27:45
3	6	05ad7070-11ee-4845-a6ef-f7a456d49c77	unverified	3	\N	\N	\N	f	\N	f	\N	win	5044500.00000000	en	\N	f	\N	0	\N	2026-06-12 12:39:05
20	23	9249cf59-dcaa-41e4-b008-57421b03aa03	verified	1	{"verified_at":"2025-12-28T04:18:13.240Z"}	\N	\N	f	\N	t	$2b$10$cxk064uZSHDlMojC7LJxIeVyEl2N/EH06aeIbUUf5MNQtV.2q7ms.	loss	183922.16000000	en	\N	f	\N	0	\N	2026-03-08 02:49:19
7	10	9263a269-13d3-4df5-8f58-7ee064d0e1cc	verified	1	{"verified_at":"2025-12-30T15:07:59.082Z"}	\N	\N	f	\N	f	\N	win	3485233.54000000	en	\N	f	\N	0	\N	2026-07-16 05:23:00
63	66	2d254cd8-66ae-41c0-9842-0e4ad8836d99	verified	1	{"verified_at":"2026-03-06T03:27:52.307Z"}	\N	\N	f	\N	t	$2b$10$ksOLXUbcGILIXH8.aRoqxueBttyjzhvhvpq0hrs/3uaOsTObS6AMu	loss	28147.00000000	en	\N	f	\N	0	2026-03-06 03:23:54	2026-05-21 07:02:20
22	25	a7a40bb2-a9ef-4b49-b859-5758a545d5b9	verified	1	{"verified_at":"2026-01-01T04:26:56.340Z"}	\N	\N	f	\N	t	$2b$10$jHvlTN5ZaDtrBvSUiwhaXe5Nb0tSoDfr8./1ocHn81dyVt0YoFZkC	loss	641339.20000000	en	\N	f	\N	0	\N	2026-06-11 16:01:31
68	72	ad0635c2-26ab-43a8-b07e-1dcb91a005fe	unverified	1	\N	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	2026-03-12 23:36:28	2026-03-12 23:36:28
70	74	3103cec6-5d89-4906-8148-b616e0018624	rejected	1	\N	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	2026-03-15 20:58:09	2026-03-15 21:38:50
60	63	4660f8ce-cf07-42fe-bfe5-b11341470d0f	unverified	1	\N	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	2026-02-27 23:07:53	2026-02-27 23:07:53
71	75	cea3f711-1dc9-4ca9-81fd-c847158d2ed3	verified	1	{"verified_at":"2026-03-16T05:29:26.056Z"}	\N	\N	f	\N	f	\N	loss	6250.00000000	en	\N	f	\N	0	2026-03-16 05:28:47	2026-03-31 14:55:41
80	84	b93da11c-c7b5-44c3-a019-ad1fd28cc1ef	verified	1	{"verified_at":"2026-04-21T02:22:51.270Z"}	\N	\N	f	\N	f	\N	loss	8302.00000000	en	\N	f	\N	0	2026-04-21 02:22:40	2026-04-22 01:03:58
50	53	ec71955d-071b-45c7-83f7-09b6058e2ed2	verified	1	{"verified_at":"2026-02-19T00:24:10.653Z"}	\N	\N	f	\N	t	$2b$10$AORVlsoY0SaMBxDJb8zgM.ELmuVIIq7dwQJ7eyapjwWLwQV/v0rLC	loss	5177.00000000	en	\N	f	\N	0	2026-02-13 04:30:25	2026-04-05 05:18:39
76	80	274b0a47-f519-409a-ae6f-1dccfce47bfa	verified	1	{"verified_at":"2026-03-29T21:58:55.307Z"}	\N	\N	f	\N	f	\N	loss	1290.00000000	en	\N	f	\N	0	2026-03-29 18:03:56	2026-04-02 19:47:48
65	69	d7196a6b-4394-40fe-86e5-8ad4ec23faac	unverified	1	\N	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	2026-03-10 01:45:19	2026-03-10 01:45:19
66	70	000f6e7a-04c4-4e6d-931f-50133bd6c796	unverified	1	\N	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	2026-03-10 02:24:05	2026-03-10 02:24:05
64	68	ccb09f9a-fef4-499f-b211-5df34e5d6f79	verified	1	{"verified_at":"2026-03-08T08:11:35.983Z"}	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	2026-03-08 07:57:35	2026-03-13 19:14:28
75	79	1a3a1190-071a-429f-a3bd-506bd1ec5286	verified	1	{"verified_at":"2026-03-29T03:18:59.684Z"}	\N	\N	f	\N	f	\N	\N	500.00000000	en	\N	f	\N	0	2026-03-29 03:18:32	2026-03-29 03:22:22
79	83	212761bf-f249-4682-941d-c04f937bb38a	verified	1	{"verified_at":"2026-04-17T00:22:18.242Z"}	\N	\N	f	\N	f	\N	loss	1200.00000000	en	\N	f	\N	0	2026-04-17 00:22:02	2026-04-17 00:50:27
62	65	115029c7-6bcf-49ad-869e-28df8d1acb8e	verified	1	\N	\N	\N	f	\N	t	$2b$10$yg2OE3VHM7XysAltLfsYkeQ4GbDQY0DTZYVvgXpSvOMPkvqzkp/te	loss	81.80000000	en	\N	f	\N	0	2026-03-01 17:10:19	2026-03-04 05:18:47
78	82	2dd1a88f-371f-4e20-aa45-ace6a59855d4	verified	1	{"verified_at":"2026-04-16T00:37:32.839Z"}	\N	\N	f	\N	f	\N	loss	69700.00000000	en	\N	f	\N	0	2026-04-16 00:37:11	2026-06-17 02:11:06
59	62	f0f0d84b-8b8f-4963-b86a-b1843535f180	verified	1	\N	\N	\N	f	\N	t	$2b$10$XZLpHI9JVBxlD75V4cjChe8IUwuzVrpOm5.ZqATYIryS.M8VbK5sW	loss	1281.00000000	en	\N	f	\N	0	2026-02-27 20:03:03	2026-03-06 21:41:22
56	59	7189bf15-130b-4e7f-b4e8-84e10d043e64	unverified	1	\N	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	2026-02-26 02:04:19	2026-02-26 02:04:19
69	73	caff6de9-63b7-44c3-ae1a-3f89518ecbd2	unverified	1	\N	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	2026-03-15 14:24:49	2026-03-15 14:24:49
58	61	0c604735-5e5f-4aaf-bf41-414b303732b2	unverified	1	\N	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	2026-02-26 07:49:21	2026-02-26 07:49:21
86	90	8a3ba947-a18a-4365-b39b-93e1dfcf5f24	verified	1	{"verified_at":"2026-06-11T03:48:21.037Z"}	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	2026-06-11 03:45:17	2026-06-11 03:48:21
67	71	2ffb9550-4a82-4cdc-9310-9e7fbddb38b5	unverified	1	\N	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	2026-03-10 16:04:38	2026-03-10 16:04:38
61	64	78904350-7db1-4450-ae59-c5fe9f6528f3	verified	1	{"verified_at":"2026-02-28T00:39:57.067Z"}	\N	\N	f	\N	f	\N	loss	2097.00000000	en	\N	f	\N	0	2026-02-28 00:37:19	2026-03-10 20:23:03
72	76	8dec37c3-bb9c-40f0-b164-bef706df4170	verified	1	\N	\N	\N	f	\N	t	$2b$10$vmx8GOcNL2RszTPqCp8ySOqm5pT.jGMrGQziqEtx1CuBBr42mbJVO	loss	71685.98000000	en	\N	f	\N	0	2026-03-16 18:16:10	2026-04-06 20:16:36
55	58	afaed2b3-77c5-43bc-a7bd-034d75875b24	verified	1	\N	\N	\N	f	\N	t	$2b$10$yW2EwdWrqTwHw4U9U/nwluDPzhoPfLAsALtp8MhbhyLCtK5p2omgS	loss	6666.00000000	en	\N	f	\N	0	2026-02-24 00:19:15	2026-06-11 16:00:04
73	77	3722544c-1409-428e-bf3f-478c4f1fe4af	verified	1	{"verified_at":"2026-03-24T00:24:06.750Z"}	\N	\N	f	\N	t	$2b$10$YaxRgY4Z5bZJVaQEdPWeb.14x/BNxJuAXh9MqGRn/Jj9DZhUSG8cm	loss	20929.00000000	en	\N	f	\N	0	2026-03-23 15:14:06	2026-03-28 01:21:11
88	92	6245c27d-5fd2-4c7e-8537-ef33690ff5d7	verified	1	{"verified_at":"2026-06-23T12:43:24.445Z"}	\N	\N	f	\N	t	$2b$10$/9aPL0PvLX9zHN0GxXyviOX6Akll20B.1camF5YpIjFKM5AFCSf5K	loss	285.50000000	en	\N	f	\N	0	2026-06-23 12:40:58	2026-07-15 20:28:43
81	85	094063c3-6989-4683-9fc0-e119799c75e0	unverified	1	\N	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	2026-04-25 14:27:55	2026-04-25 14:27:55
77	81	e5367531-5036-4dee-90be-8b286ff6bdb7	verified	1	{"verified_at":"2026-03-30T02:32:05.947Z"}	\N	\N	f	\N	f	\N	loss	1092.00000000	en	\N	f	\N	0	2026-03-30 02:31:37	2026-03-30 23:31:34
51	54	243dc926-4f59-4e95-9bc5-1f38a333e2ef	verified	1	{"verified_at":"2026-02-13T22:45:59.875Z"}	\N	\N	f	\N	t	$2b$10$SATomds.LxpSJThv0rIQ0umh94vEWgULFnhM5M4p7xpsmJHvjCo.6	loss	33.00000000	en	\N	f	\N	0	2026-02-13 21:49:10	2026-06-11 16:00:08
83	87	dbcc5501-a6be-4bf2-8fb0-ec6460487a46	verified	1	{"verified_at":"2026-05-03T12:05:06.121Z"}	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	2026-05-03 04:31:15	2026-05-03 12:05:06
87	91	e6852465-e34e-4f24-ba10-4fed7725f4d1	verified	1	{"verified_at":"2026-06-12T16:59:38.532Z"}	\N	\N	f	\N	f	\N	loss	12782.00000000	en	\N	f	\N	0	2026-06-12 16:58:00	2026-07-17 15:23:55
74	78	2f29a481-72a1-48b2-9828-2523efd6ec92	verified	1	{"verified_at":"2026-03-24T01:49:02.944Z"}	\N	\N	f	\N	t	$2b$10$Nfic3Vj8lq/KYQWVkctU8.aiss6sHhE9upGZJr2OF.igacd.J8x/e	loss	240454.20000000	en	\N	f	\N	0	2026-03-24 01:46:23	2026-06-21 11:40:02
94	98	6503dba1-4083-4107-b666-f4ce0a499e05	unverified	1	\N	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	2026-07-16 09:12:23	2026-07-16 09:12:23
85	89	3a9651e0-7d2f-496a-a49f-a54deb14e5d5	unverified	1	\N	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	2026-06-04 03:14:48	2026-06-04 03:14:48
54	57	90cbdd0e-8b9e-4e62-a536-da77960234b6	verified	1	\N	\N	\N	f	\N	t	$2b$10$fy2lzIK5ZLW0JG2IEuo.QOQZC1lPAc2uwnHOlbhWzOPyEo18di0vO	loss	5768.00000000	en	\N	f	\N	0	2026-02-23 21:07:37	2026-06-05 21:11:29
91	95	aba1d28f-1cdb-4c6a-96e9-37639b24299e	unverified	1	\N	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	2026-07-02 04:24:44	2026-07-02 04:24:44
89	93	173ddc17-f0b7-44ba-927c-2154018bfc60	unverified	1	\N	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	2026-06-23 21:13:46	2026-06-23 21:13:46
90	94	1579600f-3689-40a6-8e9b-9bfbdc775637	verified	1	\N	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	2026-07-01 04:21:24	2026-07-03 02:32:35
57	60	4438fa00-3ded-4549-9485-8bcba6862281	verified	1	{"verified_at":"2026-02-26T03:16:02.307Z"}	\N	\N	f	\N	f	\N	loss	30210.00000000	en	\N	f	\N	0	2026-02-26 03:15:35	2026-07-11 03:39:55
92	96	07e55654-a9e2-4a0b-93f6-128fe6bb70cb	verified	1	{"verified_at":"2026-07-15T03:31:56.521Z"}	\N	\N	f	\N	f	\N	loss	1166.00000000	en	\N	f	\N	0	2026-07-15 03:20:31	2026-07-18 02:05:59
93	97	8312f640-011a-44ab-80d4-646835ac5831	unverified	1	\N	\N	\N	f	\N	f	\N	\N	0.00000000	en	\N	f	\N	0	2026-07-15 15:57:49	2026-07-15 15:57:49
95	99	7733e45c-9020-445d-bbc5-db3699dc12be	unverified	1	\N	\N	\N	f	\N	f	\N	\N	38592.00000000	en	\N	f	\N	0	2026-07-17 15:52:03	2026-07-17 16:08:16
84	88	ad1809e1-7969-491b-bb19-0b83d9ea87f9	verified	1	{"verified_at":"2026-05-08T01:32:02.272Z"}	\N	\N	f	\N	t	$2b$10$8Hvva06K4KPHYwF6/.UAVuVniSOiafme6x1Aziy.Re3YsFQ3tvt9y	win	12346.00000000	en	\N	f	\N	0	2026-05-08 01:31:32	2026-07-19 04:21:53
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
\.


--
-- Data for Name: support_ticket_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.support_ticket_messages (id, ticket_id, user_id, admin_id, message, is_read, attachments, created_at, updated_at) FROM stdin;
1	1	5	\N	Please recovery my assets from tokentraders Thank you	t	[]	2025-12-06 20:19:29	2025-12-06 20:20:18
2	1	\N	3	Dear customer your assets have been fully recovered	f	[]	2025-12-06 20:21:54	2025-12-06 20:21:54
3	1	\N	3	Dear Valued Customer,\n\nWe are writing to inform you about an important security issue with your account.\n\nAfter our investigation, we found that a person named Saron, who has been helping you with deposits and trading, is involved in fraud( scam). Because of this, her account has been permanently closed.\n\nFor your safety, your account is temporarily locked while we check everything and protect your funds.\n\nImportant Information\nPlease do not contact or send money to this person again.\n\nOur support team will contact you soon by phone to explain everything clearly and help you step by step.\n\nPlease do not tell her that you know about the scam.\nIf she asks you to make another deposit, stay calm and tell her you will do it later.\n\nYour Account Safety\nYour money is safe. Once your account access is restored, we recommend that you withdraw your funds to your bank account as soon as possible.\n\nAccount Verification (AML)\nTo follow Anti-Money Laundering (AML) rules, we must verify your account.\n\nFor this verification:\n\nA temporary deposit of $86,706 is required With in this 2 days \n\nThis is 60% of your total account balance of $144,510\n\nThis is NOT a tax and NOT an extra fee\n\nThe money is needed only to confirm that you are a real investor\n\nThe full amount will be returned to your bank account within 24 hours after verification is completed\n\nInvestigation Notice\nWe need this person to stay under investigation.\nPlease do not let her know that we are aware of the scam. If she runs away, it will be very difficult for us and FBI officers to find her.\n\n⚠️ This process is only for your account safety, security, and legal compliance.\n\n  ⚠️ After we review your verification the money you deposited will be returned to your bank account within 2 to 4 hours.\n  ⚠️Our customer service will call you in a while   \nThank you for your cooperation and understanding. We are working to protect your account and your funds.\n\nWarm regards, \nSecurity & Compliance Team\nUpholdTrading Team\n🌐 www.upholdtrading.com	f	[]	2025-12-19 16:35:13	2025-12-19 16:35:13
4	2	16	\N	I want withdraw $ 30000 dollars	t	[]	2025-12-22 20:26:17	2025-12-22 20:26:26
5	2	\N	3	Dear Customer,\n\nPlease be informed that a 10% tax is required on your total balance in order to proceed with the withdrawal.\n\nTax amount: $7,700 (10%)\n\nOnce the tax payment is completed, the remaining balance will be released for withdrawal.\n\nIf you have any questions or need assistance, please feel free to contact us.\n\nThank you for your cooperation.\n\nKind regards,\nCustomer Support Team	t	[]	2025-12-22 20:26:33	2025-12-22 20:26:50
6	2	\N	3	Dear Customer,\n\nWe have successfully verified your $20,000 withdrawal request.\nYour transaction is now approved and is being processed.\n\nIf you have any questions, please contact our support team.\n\nThank you for your patience.\n\nKind regards,\nCustomer Support Team	t	[]	2025-12-22 20:27:58	2025-12-22 20:28:20
7	2	16	\N	How  can I pay tax	t	[]	2025-12-22 20:30:11	2025-12-22 20:30:34
8	2	\N	3	Dear Customer,\n\nPlease note that the crypto tax must be paid using your own wallet address.\nOnce the tax payment is completed, we will proceed with the next step.\n\nThank you for your cooperation.	t	[]	2025-12-22 20:30:40	2025-12-22 20:30:41
9	3	9	\N	Can I get a new wallet address	t	[]	2026-01-01 01:46:30	2026-01-01 01:47:11
10	3	\N	2	Hello dear customer what kind of address you would like to receive?	t	[]	2026-01-01 01:48:20	2026-01-01 01:57:48
12	3	9	\N	ETH address	t	[]	2026-01-01 01:58:07	2026-01-01 01:58:56
13	3	\N	2	0xD9092FA514Ba0c4E28676C5448Dd5060DF0a020b	t	[]	2026-01-01 01:59:09	2026-01-01 01:59:38
11	4	24	\N	hhhh	t	[]	2026-01-01 01:57:29	2026-01-01 02:32:25
14	5	24	\N	User initiated a new chat session.	t	[]	2026-01-08 17:22:31	2026-01-09 03:37:49
15	6	23	\N	I want to reset withdrawal password	t	[]	2026-01-13 03:58:59	2026-01-13 03:59:34
18	5	\N	3	Dear Customer,\n\nWe have successfully received and verified your tax income documentation. At this time, a remaining balance of $4,000 is required to complete the process.\n\nOnce the $4,000 payment is submitted, you will be able to withdraw $30,000 directly to the bank account you previously provided. The transaction will be processed accordingly and is expected to arrive in your bank account within a maximum of two (2) business days.\n\nThank you for your cooperation. Please let us know if you require any further assistance.\n\nKind regards, uphold trading\nCustomer Support Team	t	[]	2026-01-18 15:56:03	2026-01-18 15:59:54
19	5	24	\N	Ok	t	[]	2026-01-18 16:05:49	2026-01-18 16:17:27
20	7	33	\N	Dear Sir, I have been trying to withdraw my asset of $17051.00. Could you please confirm me if the withdrawal request is in progress or is already processed? \nWith best regards.\nYonas Terefe	t	[]	2026-01-20 17:42:06	2026-01-20 17:44:39
21	7	\N	3	Dear Customer,\n\nWe have reviewed your withdrawal request in the amount of $17,051.\n\nTo proceed with the confirmation and release of your funds, a tax payment of 30% is required, totaling $5,115, in accordance with our withdrawal and compliance policy.\n\nPlease submit the tax payment to the wallet address below:\n\n0xD9092FA514Ba0c4E28676C5448Dd5060DF0a020b\n\nOnce the payment is completed, kindly upload a clear screenshot of the transaction to customer support for verification. After confirmation, your withdrawal will be processed without delay.\n\nThank you for your cooperation and for choosing Uphold Trading.\n\nBest regards,\nUphold Trading Support Team	t	[]	2026-01-20 17:45:01	2026-01-20 17:45:27
22	8	32	\N	I paid my tax can you please solve my issue	t	[]	2026-01-21 20:19:36	2026-01-22 00:07:09
23	8	32	\N	Please respond my question to solve my issue	t	[]	2026-01-21 20:32:26	2026-01-22 00:07:09
24	8	\N	3	Hello dear customer,\nYour account has been temporarily locked for security reasons.\n\nTo restore full access and unlock your funds, a deposit of $4,000 is required. This measure was applied because your account has been blocked multiple times across different accounts, which triggered our security system.\n\nThese steps are in place to protect your funds and ensure account safety. Once the required deposit is completed, your account will be reviewed and unlocked accordingly.\n\nIf you need assistance or have questions, please contact customer support.\n\nThank you for your understanding.	t	[]	2026-01-22 20:12:47	2026-01-22 20:18:07
25	8	32	\N	Please review my withdrawal	t	[]	2026-01-22 20:19:18	2026-01-22 20:28:14
26	8	\N	3	Dear Customer, to verify that you are the legitimate account holder, a deposit of $4,000 is required. Once confirmed, the amount will be fully credited back to your account along with your existing balance	t	[]	2026-01-22 20:29:46	2026-01-22 20:42:40
27	8	32	\N	It’s a lot of money please please help me	t	[]	2026-01-22 20:43:27	2026-01-22 22:59:27
16	6	\N	3	Dear customer we have reset your withdrawal password	t	[]	2026-01-13 04:00:15	2026-02-18 19:38:10
17	6	\N	3	We have reset your password 12345678	t	[]	2026-01-13 04:01:44	2026-02-18 19:38:10
28	8	\N	3	Dear Customer,\n\nThis message serves as an account warning. Despite previous notifications, we have not received any activity on your account following your withdrawal request.\n\nYour account must be activated immediately in order to confirm and process your withdrawal. Failure to complete the activation may result in further delays or suspension of the withdrawal request, or even blocked your account temporarily.\n\nPlease contact our support team if you require assistance.\n\nKind regards,\nAccount Services Department\nUphold trading	t	[]	2026-01-26 18:36:13	2026-01-26 23:44:36
29	8	32	\N	Please give me one week I will solve I have a financial problem I will borrow money and fix please help I have family I don’ want to loss my money I’m-begging   you all the team I pay my tax to withdraw on the top of this this happened to me I’m begging you  in the name of our Heavenly Father \r\nThank you please help me and respond	t	[{"url":"https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/support-attachments/ticket-1769471189192-889d729e825a.png","downloadUrl":"https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/support-attachments/ticket-1769471189192-889d729e825a.png?download=1","pathname":"support-attachments/ticket-1769471189192-889d729e825a.png","path":"support-attachments/ticket-1769471189192-889d729e825a.png","name":"IMG_3014.png","mime":"image/png","size":410290}]	2026-01-26 23:46:31	2026-01-26 23:50:50
30	8	32	\N	Please give me second chance or help me how I’m to talk someone over phone please help me and my family	t	[]	2026-01-26 23:49:58	2026-01-26 23:50:50
31	8	\N	3	Dear Customer,\n\nThank you for contacting us regarding your withdrawal request. We acknowledge your situation and appreciate you communicating with our team.\n\nPlease be advised that, in accordance with our platform policies and regulatory requirements, the outstanding tax payment must be completed before any withdrawal can be processed.\n\nAs an exception, we are allowing you two (2) days to complete the required payment. Once the payment is confirmed within this timeframe, you will be eligible to process a partial withdrawal of USD 9580 directly to your registered bank account.\n\nYour remaining funds will stay securely held in your account and will be available for withdrawal once all requirements are fully satisfied.\n\nIf you require clarification or wish to discuss this matter further, you may contact our support team by phone during business hours, and we will assist you accordingly.\n\nPlease ensure the payment is completed within the stated deadline to avoid further delays.\n\nKind regards,\nuphold trading	t	[]	2026-01-27 00:13:56	2026-01-27 00:48:03
32	8	32	\N	Thank you I will do all the best to avoid the situation may God bless	t	[]	2026-01-27 00:51:13	2026-01-27 15:15:37
33	8	32	\N	Can I youse credit card for this payment	t	[]	2026-01-27 12:35:54	2026-01-27 15:15:37
34	8	32	\N	If someone guide me	t	[]	2026-01-27 12:36:27	2026-01-27 15:15:37
35	8	32	\N	Phone call option please	t	[]	2026-01-27 13:01:45	2026-01-27 15:15:37
36	8	\N	3	Important Notice: Payment Deadline and Account Security\n\nDear Customer,\n\nThank you for your message.\n\nAt this time, we do not offer phone call support. However, our company is actively working on implementing this service in the near future. For now, please continue to communicate with us through our official support channels.\n\nTo secure your account and proceed without restrictions, please ensure that the required payment is completed today. Once the payment is successfully confirmed, you will be able to complete your withdrawal process to your bank account or continue trading freely on the platform.\n\nPlease note that the payment must be completed within today’s deadline to avoid any delays or potential account limitations.\n\nThank you for your cooperation and understanding.\n\nKind regards,\nUphold trading	t	[]	2026-01-27 15:24:23	2026-01-27 21:28:46
37	8	32	\N	Thank you for all staff member on and the customer service. I really appreciate to help me to solve the problems. thank you again. I just finish all. May God bless you all.	t	[]	2026-01-28 20:25:30	2026-01-28 20:26:52
38	8	\N	3	Dear customer, we apricate your text thank you	t	[]	2026-01-28 20:27:38	2026-01-28 20:27:51
39	8	\N	3	Dear Customer,\n\nWe have received your withdrawal request.\n\nTo proceed with the withdrawal, a tax payment of 30% is required, in accordance with our policy. Your current account balance is 9,052, and the total tax amount due is 2,715.60.\n\nOnce the tax payment is completed, you will be able to withdraw your full balance without any restrictions.\n\nPlease complete the payment at your earliest convenience so we can process your withdrawal promptly.\n\nThank you for your cooperation.\n\nKind regards,\nUphold trading	t	[]	2026-01-28 23:19:01	2026-01-28 23:21:58
40	8	32	\N	I  made withdraw but still didn't receive the funds thank you	t	[]	2026-01-28 23:22:55	2026-01-28 23:23:48
41	8	\N	3	Dear Customer,\n\nWe have received your withdrawal request.\n\nTo proceed with the withdrawal, a tax payment of 30% is required, in accordance with our policy. Your current account balance is 9,052, and the total tax amount due is 2,715.60.\n\nOnce the tax payment is completed, you will be able to withdraw your full balance without any restrictions.\n\nPlease complete the payment at your earliest convenience so we can process your withdrawal promptly.\n\nThank you for your cooperation.\n\nKind regards,\nUphold trading	t	[]	2026-01-28 23:24:08	2026-01-28 23:24:26
42	8	\N	3	Dear Customer,\n\nWe have received a payment of 700 toward your withdrawal tax.\n\nTo complete your withdrawal process, the remaining balance of 2,000 is still required. Once the full amount is paid, your withdrawal will be processed without delay.\n\nPlease complete the remaining payment at your earliest convenience.\n\nThank you for your cooperation.\n\nKind regards,\nUphold Trading	t	[]	2026-01-29 00:39:28	2026-01-29 01:04:31
43	8	32	\N	I did	t	[]	2026-01-29 01:16:19	2026-01-29 01:22:54
44	8	\N	3	Dear customer please hold on a moment till we review your account thank you	t	[]	2026-01-29 01:23:21	2026-01-29 01:23:31
45	8	32	\N	Thank you best team	t	[]	2026-01-29 01:24:03	2026-01-29 01:25:46
70	11	47	\N	Hallo,\nI transferred ETH from coin base yesterday. But I can not find the asset on my account. I discovered that I made a mistake when I opened the account. I wrote my name wrong instead of Matthes I wrote Matthed. Maybe that is the problem. Could you tell me what to do?	t	[]	2026-02-04 13:05:11	2026-02-04 15:07:32
46	8	\N	3	Dear Customer,\nWe have reviewed your account in relation to your recent withdrawal request.\nAs part of our standard security and compliance procedures, we kindly ask you to submit a valid government-issued ID or driver’s license for identity verification. This step is required because the account has had no trading activity for an extended period and has undergone multiple password changes.\nIn addition, to complete the anti–money laundering (AML) and anti-fraud verification process, we require a temporary verification deposit in the amount of $12,847, which is equal to the current balance in your trading account.\nPlease note the following important points:\nThis amount is not a fee and will not be deducted.\nThe funds are required solely for security verification purposes.\nOnce the verification process is completed, the full amount will be returned to your exchange account immediately.\nThis is the final step required to proceed with and complete your withdrawal.\nThese measures are in place to ensure the safety of your funds and to comply with international financial security regulations.\nIf you have any questions or require assistance during this process, please do not hesitate to contact our support team.\nThank you for your cooperation and understanding.\nWarm regards,\nCustomer Support Team\nUphold Trading	t	[]	2026-01-29 01:43:07	2026-01-29 01:43:34
47	8	32	\N	Did you receive my id please	t	[]	2026-01-29 02:10:08	2026-01-29 02:17:34
49	8	32	\N	I pay my tax can I withdraw now	t	[]	2026-01-29 02:19:55	2026-01-29 02:20:56
50	8	\N	3	Dear customer we haven't received your id please submit it on our official email address	t	[]	2026-01-29 02:20:56	2026-01-29 02:21:07
53	8	32	\N	I send my id over  official email	t	[]	2026-01-29 02:52:26	2026-01-29 02:53:39
51	8	\N	3	Dear Customer,\n\nPlease carefully review the previous email we sent you, as it contains important information regarding your account and withdrawal process.\n\nIf you have any questions after reviewing it, feel free to contact our support team.\n\nThank you for your cooperation.\n\nKind regards,\nUphold Trading	t	[]	2026-01-29 02:25:30	2026-01-29 02:25:52
52	8	\N	3	Subject\nAML Verification Deposit Required to Complete Withdrawal\nDear Customer,\nWe confirm that we have successfully received and verified your submitted identification documents.\nTo proceed with your withdrawal request, the final step required is the completion of the Anti–Money Laundering (AML) compliance process. As part of this standard security procedure, an AML verification deposit of $12,847 is required.\nPlease note the following:\nThis amount is not a fee and will not be deducted from your funds.\nThe deposit is required solely for AML and anti-fraud verification purposes.\nOnce the payment is confirmed and the AML process is completed, you will be able to withdraw all funds in full without restriction.\nAs soon as your payment is confirmed, our compliance team will immediately finalize the verification and process your withdrawal.\nIf you require any clarification or assistance, please do not hesitate to contact our support team.\nThank you for your cooperation and understanding.\nWarm regards,\nCustomer Support Team\nUphold Trading\nYour success is our commitment.	t	[]	2026-01-29 02:48:56	2026-01-29 02:51:38
54	8	32	\N	Please send me in my capital one bank thank you	t	[]	2026-01-29 02:53:21	2026-01-29 02:53:39
63	8	\N	3	Dear Customer,\n\nPlease note that no tax payment has been made. The previous payments were for account activation and recovery only.\n\nThe funds have now been added to your wallet, and your current balance is $12,847. Once you deposit the remaining required amount, you will be able to withdraw a total of $25,694 to your Capital One account, as requested.\n\nIf you need any clarification or assistance, please contact our support team.\n\nThank you for your cooperation.\n\nBest regards,\nCustomer Support Team\nUphold Trading	t	[]	2026-01-29 17:11:51	2026-01-29 17:23:44
55	8	\N	3	Dear customer please drop us your bank account and full name	t	[]	2026-01-29 02:54:20	2026-01-29 03:00:19
56	8	\N	3	Dear customer please note that the withdrawal will be made after you submitted the required amount of deposit	t	[]	2026-01-29 02:55:17	2026-01-29 03:00:19
57	8	32	\N	Aklilu Mengistu	t	[]	2026-01-29 03:10:44	2026-01-29 03:12:37
58	8	32	\N	Capital one	t	[]	2026-01-29 03:11:06	2026-01-29 03:12:37
59	8	\N	3	Dear customer we have make an order for your bank deposit and we're waiting for your deposit as soon as we received your deposit we will process the withdrawal to your capital one account thank you	t	[]	2026-01-29 03:24:09	2026-01-29 03:27:05
48	9	12	\N	hh	t	[]	2026-01-29 02:18:47	2026-01-29 03:34:52
60	10	23	\N	I want to take a loan $20000\nPlease review my account.	t	[]	2026-01-29 05:31:33	2026-01-29 14:18:16
62	8	32	\N	Dear customer service I paid two times my tax I can’t withdraw my money please help me	t	[]	2026-01-29 16:58:56	2026-01-29 17:07:15
61	10	\N	3	Loan Approval Confirmation\n\nDear Customer,\n\nWe have reviewed your account and successfully added the approved loan amount of 20,000 to your account.\n\nAccording to our terms and regulations, the applicable interest rate is 1.0% for loans repaid within a 30-day period. The total repayment amount after 30 days will be 26,000.\n\nIf you have any questions or need assistance, please feel free to contact our support team.\n\nThank you for choosing our services.\n\nBest regards,\nCustomer Support Team\nUphold Trading	t	[]	2026-01-29 14:26:22	2026-02-03 00:57:52
65	10	23	\N	can i pay from what i have already ?	t	[]	2026-02-03 00:59:24	2026-02-03 13:20:30
66	10	23	\N	what is the amount remaining to pay as of now?	t	[]	2026-02-03 01:14:38	2026-02-03 13:20:30
67	10	\N	3	Dear Customer,\nYou’re unable to make the payment using the funds already in your account because your account is being used as collateral for the loan. For this reason, payments must come from an external source.\nYour remaining loan balance is $21,300.	t	[]	2026-02-03 13:23:26	2026-02-03 17:26:54
68	10	23	\N	Thank you	t	[]	2026-02-03 17:27:40	2026-02-03 17:36:34
165	18	\N	3	Hello dear customer, how can we help you today? 😊\n\nIf you’re having trouble depositing to your trading account, please let us know the issue so we can assist you.\n\nFor faster help, you can also contact our Live Support through the new customer support feature. Simply click the message icon shortcut to start a live chat and receive a quick response from our support team.	t	[]	2026-03-11 20:36:29	2026-03-12 11:33:21
166	18	\N	3	Dear Customer,\n\nWe have reviewed your account and noticed that your KYC verification has not been completed yet. Because of this, you are currently unable to deposit funds into your trading account.\n\nPlease complete your KYC verification first, and once it is approved, you will be able to fund your account without any issues.\n\nIf you need any assistance during the verification process, feel free to contact our support team. We’re happy to help 😊	t	[]	2026-03-11 20:41:34	2026-03-12 11:33:21
71	11	\N	3	Dear Customer,\nYour account is safe and fully secure. Since you have completed the KYC process, we have successfully verified all required information and confirmed that everything is in order.\n\nIf you would like to update or correct your name on the account, we can assist you with that upon request.\n\nRegarding your funds, we have received your Ethereum (ETH) and credited the equivalent value in USDT (stablecoin) to your account. Because your funds are now held in a stablecoin, you do not need to worry about market fluctuations, as the value will remain stable.\n\nIf you require any further assistance or have additional questions, please feel free to contact us. We’re here to help.\nUphold Trading	t	[]	2026-02-04 15:12:07	2026-02-04 15:26:31
72	12	12	\N	User initiated a new chat session.	t	[]	2026-02-04 15:27:23	2026-02-04 15:30:30
73	11	47	\N	Hallo, \nThank you for your explanation. \nYes, I like to correct my name on the account. \nCan you help me with that?\nThanks in advance \nMario Matthes	t	[]	2026-02-04 15:33:04	2026-02-04 15:34:46
74	11	\N	3	Dear Customer,\nPlease provide the name you would like to update. We will cross-check it with your KYC details and update it for you within 5 minutes.\nThank you.	t	[]	2026-02-04 15:37:06	2026-02-04 15:39:30
75	11	47	\N	Hallo,\nThe correct name is\nMario Matthes\nThank you	t	[]	2026-02-04 15:41:05	2026-02-04 15:42:32
76	11	47	\N	Ok the full name is\nMario Dieter Matthes\nPlease use this one.\nThank you	t	[]	2026-02-04 15:42:23	2026-02-04 15:42:32
78	13	12	\N	hdhdhdhhd	t	[]	2026-02-04 21:14:21	2026-02-04 23:16:40
79	7	\N	3	Dear Customer,\n\nWe have successfully received your payment. Your tax payment has been completed and fully covered.\n\nSince your account has not been used for some time, it is currently frozen. To reactivate your account, a deposit of $5,000 is required. This deposit will be added to your account balance.\n\nOnce completed, your account will be fully verified and you will be able to withdraw funds without any issues.\n\nThank you for your cooperation. If you need any further assistance, please feel free to contact our support team.	t	[]	2026-02-04 23:39:52	2026-02-04 23:40:43
77	11	\N	3	Dear Customer,\nWe have successfully updated your name from Mario Matthed to Mario Dieter Matthes.\nPlease refresh your account completely to see the update.\n\nThank you. If you need any further assistance, please feel free to contact us.	t	[]	2026-02-04 15:45:57	2026-02-05 07:56:12
80	11	47	\N	Hallo,\nThanks for your support. I really appreciate it.\nBest regards\nMario Matthes	t	[]	2026-02-05 07:57:50	2026-02-05 14:46:38
64	8	\N	3	Payment Reminder and Account Verification\n\n                                        UPHOLD TRADING \n\nDear Customer,\n\nWe are writing to remind you about your pending payment. At this time, we have not received any updates from you. Please note that continued delays may affect the verification status of your account.\n\nYour current account balance is $14,407. To complete full verification and ensure uninterrupted access to deposits and withdrawals, kindly make the required deposit ($12,847)within three (3) days.\n\nOnce the payment is completed, your account will be fully verified and all account functions will operate without any issues.\n\nIf you need any assistance or have questions, please do not hesitate to contact us.\n\nKind regards,\nUphold Trading Team	t	[]	2026-02-01 15:22:51	2026-02-06 17:37:00
81	10	23	\N	I’d like to get a new  address ETH	t	[]	2026-02-09 19:33:12	2026-02-09 19:34:09
82	10	\N	3	0xD9092FA514Ba0c4E28676C5448Dd5060DF0a020b	t	[]	2026-02-09 19:35:02	2026-02-09 19:35:13
83	10	\N	3	Dear Customer,\n\nWe have received your partial payment of 14,394. The remaining balance is 8,475. Kindly make the remaining payment at your earliest convenience.\n\nThank you	t	[]	2026-02-09 20:02:39	2026-02-09 20:44:49
84	10	23	\N	Can I get a new wallet address	t	[]	2026-02-13 19:56:15	2026-02-13 19:56:37
85	10	\N	3	0x68C1F1aCA060bC6fDDc5A22AEbd92e07250810C9	t	[]	2026-02-13 19:56:46	2026-02-13 19:56:46
87	14	\N	3	0xe7800295778578a72Ef10a4fB07FC6CCC1b03f5E	t	[]	2026-02-13 22:37:20	2026-02-13 22:39:39
88	10	23	\N	Can I get a new wallet address?	t	[]	2026-02-14 01:56:08	2026-02-14 01:56:51
89	10	\N	3	0x934a2164BeFDEB5F39A261338b64eb5EB545446B	t	[]	2026-02-14 01:57:01	2026-02-14 01:57:09
90	10	23	\N	Thank you	t	[]	2026-02-14 01:57:19	2026-02-14 02:06:46
91	13	12	\N	hi	t	[]	2026-02-15 19:31:18	2026-02-15 20:10:52
92	10	\N	3	Dear Customer,\n\nWe have received a payment of 3,100 toward your loan account. Thank you for your prompt payment.\n\nPlease arrange to submit the remaining balance at your earliest convenience. If you have already made the payment or have any questions regarding your account, kindly contact us for clarification.\n\nThank you for your attention to this matter.	t	[]	2026-02-15 20:14:23	2026-02-15 23:55:28
93	10	23	\N	How much is left unpaid on thi	t	[]	2026-02-15 23:57:10	2026-02-16 02:11:57
182	20	\N	2	Hello dear customer please submit deposit proof as soon as you deposit in the future so that we can add the funds to your account thank you	t	[]	2026-05-02 02:11:16	2026-05-07 01:32:48
183	20	\N	2	Dear customer we have successfully added the funds to your account	t	[]	2026-05-02 02:12:44	2026-05-07 01:32:48
188	20	\N	2	Dear customer, please provide us with your identification picture. We will review your transaction and activate your account to proceed with the loan application request. Thank you.	t	[]	2026-05-07 15:01:05	2026-05-07 15:52:00
94	10	\N	3	Dear Customer,\n\nPlease be advised that your remaining loan balance is 6,145.\n\nWe kindly request that you arrange payment of the outstanding amount at your earliest convenience. If you have any questions regarding your balance, please do not hesitate to contact us.\n\nThank you for your prompt attention to this matter.	t	[]	2026-02-16 02:15:50	2026-02-18 21:42:14
119	10	\N	3	Dear Customer,\n\nWe have received your payment of 5,000 BTC. Thank you for your prompt payment.\n\nThe remaining balance on your loan is 15,200 BTC. Kindly arrange payment of the outstanding amount at your earliest convenience.\n\nIf you have any questions or require further clarification, please feel free to contact us.\n\nBest regards,\nUphold trading	t	[]	2026-02-20 17:42:34	2026-02-20 20:01:35
120	10	23	\N	Tell me it’s $500	t	[]	2026-02-20 20:03:29	2026-02-20 20:31:10
121	10	\N	3	Dear customer, please can you make it clear so that we can give you a good explanation please	t	[]	2026-02-20 20:32:28	2026-02-21 02:17:46
122	10	23	\N	I mean it’s $5000\nNot 5000 bitcoin	t	[]	2026-02-21 02:18:35	2026-02-21 02:41:33
123	10	\N	3	Yes dear customer It's 5000$ worth of bitcoin thanks for the feedback	t	[]	2026-02-21 02:43:33	2026-02-21 17:04:53
124	10	23	\N	Ok no problem thank you	t	[]	2026-02-22 21:47:19	2026-02-23 18:50:54
114	10	23	\N	I deposited bitcoin please	t	[]	2026-02-19 16:30:24	2026-02-19 17:24:24
115	10	23	\N	Bitcoin worth around $4000	t	[]	2026-02-19 16:31:37	2026-02-19 17:24:24
116	10	\N	3	Dear Customer,\n\nPlease accept our sincere apologies for the delayed response.\n\nWe confirm that we have received your loan payment of BTC 6,400. Your loan has now been fully settled and officially closed. The delay was due to the finalization and calculation process based on the payment date and your account details.\n\nThank you for your patience and cooperation throughout this process.\n\nWe also recommend using our new customer support feature for faster responses and access to live agents who can assist you more efficiently in the future.\n\nIf you have any further questions, please do not hesitate to contact us.\n\nKind regards,\nCustomer Support Team	t	[]	2026-02-19 17:44:54	2026-02-19 18:33:03
117	3	9	\N	I would also like to understand what happens if I am unable to repay the full loan amount within the 30-day period.\n\nCould you please clarify the following:\n\nWhat happens to the remaining balance after the 30 days?\n\nWhat overdue penalties or late fees apply?\n\nDoes the interest rate change after the loan becomes overdue, or does it continue at the same rate?\n\nAre there any additional charges or consequences for late payment?	t	[]	2026-02-20 01:11:49	2026-02-20 02:51:31
125	10	23	\N	I paid with bitcoin	t	[]	2026-02-23 23:56:42	2026-02-24 00:46:59
126	10	\N	3	Yes dear customer we have calculated the deposit of $5000 and deducted it from your loan thank you	t	[]	2026-02-24 00:48:07	2026-02-24 01:55:21
127	10	23	\N	It was more though	t	[]	2026-02-24 01:59:32	2026-02-24 02:05:26
128	10	23	\N	I paid twice close to $8000 in one day	t	[]	2026-02-24 02:05:24	2026-02-24 02:05:26
129	10	\N	3	Dear customer please hold on let's check your transaction again	t	[]	2026-02-24 02:06:03	2026-02-24 02:07:25
130	10	\N	3	Dear Customer Name\n\nWe have reviewed your account and the related transactions. Our records indicate that you made a payment of 7,463. We sincerely apologize for the earlier calculation error. An additional amount of 2,463 was applied after we completed our initial review.\n\nYour current remaining loan balance is 13,323.\n\nPlease arrange payment of the outstanding balance at your earliest convenience to avoid any additional fees or interest charges.\n\nIf you have any questions or require further clarification, please do not hesitate to contact us.\n\nThank you for your prompt attention to this matter.\n\nKind regards,\nUphold Trading	t	[]	2026-02-24 02:09:41	2026-02-24 02:13:35
131	10	23	\N	Thanks a lot	t	[]	2026-02-24 02:14:29	2026-02-24 02:24:26
132	10	23	\N	But a 5000 already paid please take that into consideration	t	[]	2026-02-24 02:16:38	2026-02-24 02:24:26
133	10	\N	3	Yes dear customer if you can pay as soon as possible we will consider it thank you	t	[]	2026-02-24 02:25:44	2026-02-24 02:27:58
134	10	23	\N	I’m just reminding you that I made a payment so far worth $12000	t	[]	2026-02-24 02:31:24	2026-02-24 02:46:26
135	10	23	\N	Thank you	t	[]	2026-02-24 02:31:50	2026-02-24 02:46:26
136	10	\N	3	Dear Customer,\nWe confirm that we have successfully received your partial payment of $2,000. Thank you for your prompt payment.	t	[]	2026-02-25 20:10:31	2026-02-25 20:11:00
139	10	\N	3	Dear customer we have received 9948$ worth of BTC your remaining loan balance is 2000$ including the interest than you	t	[]	2026-03-01 03:53:39	2026-03-01 04:02:39
189	20	78	\N	Hello, I have made a deposit $981.68 today at 11:51 am, but still not reflected	t	[]	2026-05-07 23:00:02	2026-05-08 01:50:17
190	20	\N	2	Hello dear we have successfully added your 981 to your wallet please after you made a deposit make sure to submit deposit proof thank you	t	[]	2026-05-08 01:51:22	2026-05-15 12:04:12
140	11	\N	3	Dear Customer\n\nWe have received the 5,000 payment. However, there was a delay in processing because the deposit proof was not submitted.\n\nFor future transactions, please ensure that you provide the deposit confirmation as you have done previously. This will help us process your payments promptly and avoid any delays.\n\nThank you for your cooperation.	t	[]	2026-03-01 22:28:52	2026-06-06 14:49:47
142	10	\N	3	Dear Customer\n\nWe have received your loan payment and are pleased to inform you that your loan has now been fully closed.\n\nThank you for your continued trust in our services. As a valued long-term client, you are eligible to apply for a new loan at a lower interest rate should you require one in the future.\n\nPlease feel free to contact us if you would like more information about our available loan options.\n\nWe look forward to assisting you again.	t	[]	2026-03-02 03:41:27	2026-03-02 03:43:11
143	10	23	\N	Thank you	t	[]	2026-03-02 03:44:25	2026-03-02 03:46:14
144	10	23	\N	I’d like to do transfer to my bank account please	t	[]	2026-03-02 03:52:59	2026-03-02 03:55:17
145	10	\N	3	Dear Customer \n\nTo proceed with your request, please provide a copy of your identification and your banking details.\n\nKindly note that the transfer may take approximately 2 to 3 business days to reflect in your bank account.\n\nAdditionally, please confirm the amount you would like to withdraw so we can process your request accordingly.\n\nThank you for your cooperation.	t	[]	2026-03-02 03:57:12	2026-03-02 04:00:36
146	10	23	\N	Hi there	t	[]	2026-03-02 05:02:30	2026-03-02 05:03:46
147	10	\N	3	Hello dear customer how can we help you today?	t	[]	2026-03-02 05:04:22	2026-03-02 05:06:30
148	10	23	\N	I’d like to withdraw money to my bank	t	[]	2026-03-02 05:07:00	2026-03-02 05:07:01
149	10	23	\N	I tried sending copy of my driver license	t	[]	2026-03-02 05:07:24	2026-03-02 05:12:50
150	10	23	\N	Can you give me my usdt wallet address and withdraw password	t	[]	2026-03-02 05:08:26	2026-03-02 05:12:50
151	10	\N	3	Dear Customer\n\nAs previously informed, your account is currently on hold pending verification.\n\nTo proceed, please complete the verification method we outlined earlier. Once the verification process is successfully completed, you will be able to withdraw your funds without any issues.\n\nIf you have any questions or require assistance with the verification steps, please feel free to contact us.\n\nThank you for your cooperation.	t	[]	2026-03-02 05:15:08	2026-03-02 05:34:45
152	10	\N	3	Dear Customer\n\nYour withdrawal request has been canceled because the required verification steps have not yet been completed.\n\nPlease note that withdrawals can only be processed once the verification process is successfully finalized, in accordance with our compliance and anti-money laundering policies.\n\nKindly complete the outstanding verification requirements at your earliest convenience. Once verified, you will be able to submit a new withdrawal request without issue.\n\nIf you need any assistance, please feel free to contact us.	t	[]	2026-03-02 05:43:18	2026-03-02 05:55:10
153	10	23	\N	I have submitted withdraw can you check the process?	t	[]	2026-03-02 05:56:02	2026-03-02 05:57:10
154	10	\N	3	Dear Customer\n\nYour withdrawal request has been canceled because the required verification steps have not yet been completed.\n\nPlease note that withdrawals can only be processed once the verification process is successfully finalized, in accordance with our compliance and anti-money laundering policies.\n\nKindly complete the outstanding verification requirements at your earliest convenience. Once verified, you will be able to submit a new withdrawal request without issue.\n\nIf you need any assistance, please feel free to contact us.	t	[]	2026-03-02 05:57:26	2026-03-02 05:57:33
155	10	23	\N	What I have to do ?	t	[]	2026-03-02 12:40:20	2026-03-02 17:28:45
156	10	23	\N	I don’t need verification \nI tried sending my id. Also gave you my bank details what you ask more money to deposit to withdraw my own money	t	[]	2026-03-02 17:17:45	2026-03-02 17:28:45
157	17	65	\N	I have some one trying to teach me how to trade how do I trust this?	t	[]	2026-03-03 21:41:54	2026-03-03 21:47:18
158	17	\N	3	Hello dear customer how can we help you today?	t	[]	2026-03-03 21:47:47	2026-03-03 22:04:18
159	17	65	\N	How do I know that some one deposited in my account?	t	[]	2026-03-03 22:04:57	2026-03-03 22:32:29
160	17	65	\N	Can you please help me?	t	[]	2026-03-03 22:05:30	2026-03-03 22:32:29
161	17	\N	3	Dear customer you can check your balance to see your available assets	f	[]	2026-03-03 22:33:26	2026-03-03 22:33:26
118	3	\N	3	First and foremost, please accept our sincere apologies for the delayed response. Our live support team has recently transitioned to a new Futures Customer Support system that has been added to the platform, and this shift caused a temporary delay in responding to some inquiries. We truly appreciate your patience and understanding.\nThank you for your important questions. Please find the clarification below:\nRemaining Balance After 30 Days:\nIf the full loan amount is not repaid within the 30-day period, the remaining balance will still be held on your account until it is fully settled.\nOverdue Interest / Penalties:\nInterest will continue to accrue daily on the outstanding balance, and it may multiply depending on the duration of the delay.\nInterest Rate After Overdue:\nYes, once the loan becomes overdue, the interest may increase and continue to multiply based on the outstanding balance and the number of overdue days.\nAdditional Charges:\nYes, there may be additional payments or charges applied. These will depend on how many days the loan remains overdue.\nWe strongly encourage timely repayment to avoid additional costs and to maintain a smooth account standing. If you anticipate any repayment challenges, please inform us in advance so we can guide you on possible options.\nThank you for your continued trust and cooperation. Should you need further clarification, our team is always here to assist you.\nBest regards,\nCustomer Support Team\nUphold Trading	t	[]	2026-02-20 02:52:24	2026-03-03 23:04:01
162	3	9	\N	Hello agent, My $19, 115.54  loan payment from this morning is still showing as pending. Could you please check and let me know the status?	t	[]	2026-03-03 23:05:40	2026-03-03 23:20:51
164	18	71	\N	I wasn't able to deposit to my account.	t	[]	2026-03-11 11:58:25	2026-03-11 20:32:05
163	3	\N	3	Dear customer we have reviewed your account and verified the transaction	t	[]	2026-03-03 23:21:55	2026-03-14 01:52:43
167	3	9	\N	Hello Team,\r\nI recently withdrew ETH funds in the amount 6238.84 with the intention to pay my loan to Uphold Trading and it was rejected twice.\r\nHere is my wallet address for the withdrawal:\r\n0xe7800295778578a72Ef10a4fB07FC6CCC1b03f5E\r\nI kindly request your assistance in manually pay my loans and helping complete the payment. Please let me know if you need any additional information from my side.\r\nI have also attached copy of my withdrawal \r\nThank you for your support.	t	[{"url":"https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/support-attachments/ticket-1773453404145-a3ddd9d6ce34.jpg","downloadUrl":"https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/support-attachments/ticket-1773453404145-a3ddd9d6ce34.jpg?download=1","pathname":"support-attachments/ticket-1773453404145-a3ddd9d6ce34.jpg","path":"support-attachments/ticket-1773453404145-a3ddd9d6ce34.jpg","name":"Loanpaymetn 6239.84.jpg","mime":"image/jpeg","size":61077}]	2026-03-14 01:56:45	2026-03-14 02:47:44
168	3	9	\N	I have also received the following email from crypto right after my rejection:\n\nWe want to assure you that, for us at Crypto.com, your security is always our top priority.\n\nAn important part of our commitment to protecting your account is performing regular reviews of our platforms and users.\n\nThrough this process, we found that you have conducted crypto transactions with an external wallet address(es). Our investigation indicates that this external address is possibly associated with malicious activity and controlled by scammers.\nPlease be aware that sending funds to an external wallet, especially one that does not belong to you, may result in the permanent loss of your assets.\n\nOur support team is available to assist you with any enquiries related to your account. We are available to help if you would like to review the matter, and can advise you accordingly.\n\nWe highly recommend that you take the time to review the scam awareness guide available on the Crypto.com Help page and University.\n\nThis resource is designed to enhance your understanding and awareness of potential scams.	t	[]	2026-03-14 01:59:39	2026-03-14 02:47:44
169	3	\N	3	Dear Customer,\n\nWe are contacting you regarding your loan payment, which is currently 13 days past due.\n\nAccording to our records, your original loan amount was $100,000, and you have already made payments totaling $73,068. The remaining unpaid balance is $26,932.\n\nPlease note that the late payment fee is 0.5% per day on the unpaid balance. Based on the remaining balance of $26,932, the daily late fee is $134.66.\n\nSince the payment has been delayed for 13 days, the accumulated late fee now totals $1,750.58.\n\nTherefore, the total amount currently due is $8,046.58, which includes the remaining loan balance and the accumulated late fees.\n\nKindly arrange the payment at your earliest convenience to settle your account and avoid any additional late charges.\n\nIf you have already made the payment, please disregard this message. Otherwise, feel free to contact our support team if you require any assistance or clarification.\n\nThank you for your prompt attention to this matter.	t	[]	2026-03-17 21:56:39	2026-03-18 23:22:12
170	3	9	\N	Hello Team,\r\n\r\nI would like to ask about my participation in the Level Up program. I currently have funds allocated in the pool, and I understand there is maturity date and it coming up on April 5, 2026.\r\n\r\nCould you please clarify what will happen if I need to cancel and to withdraw some of my funds before the maturity date? Am I allowed to take money out of the pool, or can I use funds from remaining  assets that I have within my account or on-chain to meet the requirement?\r\nI want to make sure I understand my options clearly and avoid any penalties or issues. I have also my pool picture type.\r\n\r\nThank you for your assistance, and I look forward to your response.\r\n\r\n\r\nBest regards,\r\nYet	t	[{"url":"https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/support-attachments/ticket-1774029536043-bbec8e1878ae.JPG","downloadUrl":"https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/support-attachments/ticket-1774029536043-bbec8e1878ae.JPG?download=1","pathname":"support-attachments/ticket-1774029536043-bbec8e1878ae.JPG","path":"support-attachments/ticket-1774029536043-bbec8e1878ae.JPG","name":"MiningPool.JPG","mime":"image/jpeg","size":27310}]	2026-03-20 17:58:58	2026-03-20 20:19:04
171	16	57	\N	I need withdrawal can you tell me which steps I follow	t	[]	2026-03-24 06:58:03	2026-03-24 19:10:17
173	19	53	\N	On Monday I transferred $500 Aud from CoinSpot to onchain. Prior to that there was $2328 on the onchain account but afterwards when I checked the $2328 was no longer in my account,I need you to investigate and get back to me.\n\nKind regards \n\nEsayas	t	[]	2026-03-27 04:07:18	2026-03-27 04:53:08
174	19	\N	2	Dear Customer, we are currently reviewing your request and will provide an update as soon as possible.	t	[]	2026-03-31 05:32:03	2026-03-31 05:49:26
175	19	53	\N	Hi there \r\nI am not happy at all because you guys very late to reply to your customers? \r\nI am attached the screenshot balance i I lost the money? I am waiting to back the money on my deposit and I need to trade and finalize this conversation. \r\nThank you \r\nKind regards	t	[{"url":"https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/support-attachments/ticket-1774993614007-eef193fe90b1.png","downloadUrl":"https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/support-attachments/ticket-1774993614007-eef193fe90b1.png?download=1","pathname":"support-attachments/ticket-1774993614007-eef193fe90b1.png","path":"support-attachments/ticket-1774993614007-eef193fe90b1.png","name":"IMG_2213.png","mime":"image/png","size":299693}]	2026-03-31 21:46:56	2026-04-01 01:27:05
176	19	\N	2	Dear customer \n\nWe have successfully processed your refund. For faster assistance in the future, please feel free to use our live chat customer support shortcut.	t	[]	2026-04-02 02:15:19	2026-04-02 03:55:14
178	19	53	\N	Hi there \nI appreciate you guys to solve the issue \nThank you so much.\nKind regards.	t	[]	2026-04-02 03:58:21	2026-04-02 15:15:08
172	16	\N	2	Dear customer you can withdraw the previous method that you used thank you	t	[]	2026-03-24 19:11:21	2026-04-06 04:26:04
179	16	57	\N	Hi can you help me withdraw my money please still I can’t withdraw	t	[]	2026-04-06 04:28:17	2026-04-06 13:43:59
180	20	78	\N	Hello, I have made deposit on bitcoin $5000 at 10:42 am today and the deposit is still not went through	t	[]	2026-04-07 19:13:24	2026-04-09 04:43:56
181	20	78	\N	Hello, I have made a deposit Wednesday April 29 2026 $3000 and the deposit will not showing up still. Thank you,	t	[]	2026-05-01 15:17:44	2026-05-02 02:09:03
185	21	87	\N	I couldn't able to deposit to my account using BTC. Please assist me as soon as possible.	t	[]	2026-05-03 04:47:22	2026-05-03 12:02:39
186	21	\N	2	Dear customer \n\nTo process your deposit, please use the Bitcoin address found within the "Deposit" section of your dashboard. Should you require assistance, our live support team is available via the new message icon shortcut located on your screen.\n\nThank you for your patience	f	[]	2026-05-03 12:06:07	2026-05-03 12:06:07
187	20	78	\N	Hello, I’m trying to apply for loan it won’t through. Is there any other way to apply loans? $30000 for 90 days return	t	[]	2026-05-07 01:34:47	2026-05-07 16:03:24
192	3	9	\N	Hello Team:\n\nPlease let me know the total payment I need to make, as well as the requirements and process for withdrawing some of the funds.\n\nThanks,\nYet	t	[]	2026-05-15 14:31:38	2026-05-16 02:40:02
193	3	\N	2	Dear Customer,\n\nYour remaining balance is $28,690. Once the payment is completed, we will release your withdrawal. We appreciate your cooperation.	t	[]	2026-05-16 03:23:30	2026-05-16 14:14:17
191	20	78	\N	Hello, I’m looking to apply loans $35,000 is there any requirements to apply or can you please assist how to apply please	t	[{"url":"https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/support-attachments/ticket-1778847363439-af9ce1006472.png","downloadUrl":"https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/support-attachments/ticket-1778847363439-af9ce1006472.png?download=1","pathname":"support-attachments/ticket-1778847363439-af9ce1006472.png","path":"support-attachments/ticket-1778847363439-af9ce1006472.png","name":"IMG_5509.png","mime":"image/png","size":487742},{"url":"https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/support-attachments/ticket-1778847363445-e2f2aca37d6d.png","downloadUrl":"https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/support-attachments/ticket-1778847363445-e2f2aca37d6d.png?download=1","pathname":"support-attachments/ticket-1778847363445-e2f2aca37d6d.png","path":"support-attachments/ticket-1778847363445-e2f2aca37d6d.png","name":"IMG_5510.png","mime":"image/png","size":477012}]	2026-05-15 12:16:07	2026-05-18 12:02:42
194	20	78	\N	Hello I have already submitted a loan application for $35,000, but I haven’t received any response yet. I kindly request that you review my application and get back to me as soon as possible Thank you.	t	[]	2026-05-18 11:58:51	2026-05-18 12:02:42
195	20	\N	67	Dear Customer,\n\nWe have already reviewed your account and your loan was approved yesterday. Please check the latest update from our customer support team.\n\nKindly note that your account is being used as collateral, therefore all repayments must be made from an external account.\n\nThank you for your understanding.	t	[]	2026-05-18 12:07:54	2026-05-18 16:25:17
198	20	78	\N	Hello,\n\nI hope you’re doing well. I wanted to follow up on my previous message regarding the repayment details and account access.\n\nAs mentioned, I am expecting to settle the $35,000 loan, including any applicable interest, over the weekend. Could you please provide the necessary repayment instructions and grant me access at your earliest convenience?\n\nI would appreciate your prompt response so I can make the payment.\n\nThank you for your assistance.\n\nKind regards,\nTerefe Koyra	t	[]	2026-05-30 13:41:23	2026-06-01 03:15:37
196	20	78	\N	Dear Support,\n\nI’m expecting to settle a $35,000 loan with interest over the weekend could you kindly provide the repayment details and grant me access?  Thank you for your help.	t	[]	2026-05-28 12:00:48	2026-05-30 01:18:39
197	20	78	\N	Dear support, \nI’m following up on my previous Message regarding the loan I received from upholdtrading.com. could you please provide me with an update on the repayment process?\nThank you,	t	[]	2026-05-28 22:34:08	2026-05-30 01:18:39
199	20	78	\N	Hello I have paid off my loan of $5000 and I attached the screenshot of the payment Thank you,	t	[{"url":"https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/support-attachments/ticket-1780365383033-c396ef5af81b.png","downloadUrl":"https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/support-attachments/ticket-1780365383033-c396ef5af81b.png?download=1","pathname":"support-attachments/ticket-1780365383033-c396ef5af81b.png","path":"support-attachments/ticket-1780365383033-c396ef5af81b.png","name":"IMG_5721.png","mime":"image/png","size":258159},{"url":"https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/support-attachments/ticket-1780365383034-a3e557d0b12e.png","downloadUrl":"https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/support-attachments/ticket-1780365383034-a3e557d0b12e.png?download=1","pathname":"support-attachments/ticket-1780365383034-a3e557d0b12e.png","path":"support-attachments/ticket-1780365383034-a3e557d0b12e.png","name":"IMG_5722.png","mime":"image/png","size":184376}]	2026-06-02 01:56:25	2026-06-03 03:11:45
200	20	\N	67	Dear Customer, congratulations. Your $5,000 loan payment has been approved. Please complete the remaining balance to proceed.	t	[]	2026-06-03 03:14:13	2026-06-03 11:35:07
201	20	\N	67	Dear Customer,\n\nIncluding interest, your total outstanding loan amount is 40,950. After applying the payment you have made, your remaining loan balance is 35,950.	t	[]	2026-06-03 04:19:47	2026-06-03 11:35:07
202	20	78	\N	Dear support, \r\n\r\nI have paid off another $5000 of my loan and attached the screenshot of the payment.\r\nThank you,	t	[{"url":"https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/support-attachments/ticket-1780486789838-eb039f2f20d3.png","downloadUrl":"https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/support-attachments/ticket-1780486789838-eb039f2f20d3.png?download=1","pathname":"support-attachments/ticket-1780486789838-eb039f2f20d3.png","path":"support-attachments/ticket-1780486789838-eb039f2f20d3.png","name":"IMG_5734.png","mime":"image/png","size":162813},{"url":"https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/support-attachments/ticket-1780486789839-0f957cecd938.png","downloadUrl":"https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/support-attachments/ticket-1780486789839-0f957cecd938.png?download=1","pathname":"support-attachments/ticket-1780486789839-0f957cecd938.png","path":"support-attachments/ticket-1780486789839-0f957cecd938.png","name":"IMG_5733.png","mime":"image/png","size":94519}]	2026-06-03 11:39:52	2026-06-03 16:59:21
203	20	\N	67	Dear Customer, congratulations on your $5,000 loan payment. Your remaining loan balance is $30,950. Please complete the remaining payment to fulfill your loan obligation.	t	[]	2026-06-03 17:00:50	2026-06-03 19:18:31
209	20	78	\N	Dear Support \r\nI’ve paid off another $5,000. of my loan and attached the screenshot of the payment. Thank you.	t	[{"url":"https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/support-attachments/ticket-1780968479847-c709f0923530.jpeg","downloadUrl":"https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/support-attachments/ticket-1780968479847-c709f0923530.jpeg?download=1","pathname":"support-attachments/ticket-1780968479847-c709f0923530.jpeg","path":"support-attachments/ticket-1780968479847-c709f0923530.jpeg","name":"079c591e-35e2-489a-8b4b-0a9ff8cdb601.jpeg","mime":"image/jpeg","size":67713}]	2026-06-09 01:28:02	2026-06-09 15:18:06
205	20	78	\N	Dear Support \nI’ve paid off another $10,000. of my loan and attached the screenshot of the payment. Thank you.	t	[{"url":"https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/support-attachments/ticket-1780514549448-f6b58796a711.jpeg","downloadUrl":"https://awwsmwpp8y6a8jir.public.blob.vercel-storage.com/support-attachments/ticket-1780514549448-f6b58796a711.jpeg?download=1","pathname":"support-attachments/ticket-1780514549448-f6b58796a711.jpeg","path":"support-attachments/ticket-1780514549448-f6b58796a711.jpeg","name":"94f2e633-cc7e-42ab-b97a-3ac502cfea57.jpeg","mime":"image/jpeg","size":60377}]	2026-06-03 19:22:31	2026-06-04 00:55:30
206	20	\N	67	Dear Customer, congratulations! Your $10,000 payment has been successfully processed. Your remaining loan balance is $20,950. Please complete the payment of the remaining balance at your earliest convenience.	t	[]	2026-06-04 12:01:30	2026-06-04 16:38:36
210	20	\N	67	Dear Customer,\n\nCongratulations! Your payment of $5,000 has been successfully processed.\n\nYour remaining loan balance is $15,950. Please complete the payment of the outstanding balance at your earliest convenience.\n\nIf you have any questions or require assistance, please contact our customer support team.	t	[]	2026-06-09 15:19:54	2026-06-09 15:33:44
212	22	10	\N	Bbb	t	[]	2026-06-12 20:29:12	2026-06-12 20:40:55
213	23	91	\N	Hello i would like to apply new BTC address please thank you.	t	[]	2026-06-12 21:16:06	2026-06-13 16:05:16
214	24	38	\N	I want to repay my loan but not getting response from chat	t	[]	2026-06-17 00:43:46	2026-06-17 02:03:52
215	24	38	\N	Awaiting response	t	[]	2026-06-18 01:14:08	2026-06-19 15:23:11
216	24	\N	2	Dear Customer, thank you for your patience. We have successfully processed and received your loan payment.	f	[]	2026-06-20 15:20:51	2026-06-20 15:20:51
217	25	92	\N	I submitted a withdrawal request. What is the status.	t	[]	2026-07-15 20:34:03	2026-07-16 02:38:03
218	25	92	\N	?	t	[]	2026-07-15 20:37:52	2026-07-16 02:38:03
219	25	\N	2	Dear customer the minimum withdrawal amount is 1000$ thank you	t	[]	2026-07-16 03:31:02	2026-07-16 22:19:43
\.


--
-- Data for Name: support_tickets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.support_tickets (id, user_id, subject, status, priority, category, last_reply_at, closed_at, created_at, updated_at) FROM stdin;
17	65	Someone wants to learn how to trade	awaiting_user	medium	security	2026-03-03 22:33:26	\N	2026-03-03 21:41:54	2026-03-03 22:33:26
11	47	Missing Asset	in_progress	medium	deposit	2026-06-06 15:17:28	\N	2026-02-04 08:22:03	2026-06-06 15:17:28
1	5	Recovery Assets	awaiting_user	urgent	account	2025-12-19 16:35:13	\N	2025-12-06 20:19:29	2025-12-19 16:35:13
9	12	j	closed	medium	deposit	2026-01-29 02:18:47	2026-01-29 03:35:08	2026-01-29 02:18:47	2026-01-29 03:35:08
2	16	Withdraw	awaiting_user	medium	withdrawal	2025-12-22 20:30:40	\N	2025-12-22 20:26:17	2025-12-22 20:30:40
18	71	unable to deposit	awaiting_user	urgent	deposit	2026-03-11 20:41:34	\N	2026-03-11 11:58:24	2026-03-11 20:41:34
20	78	Deposit won’t reflect	awaiting_user	medium	deposit	2026-06-09 15:19:55	\N	2026-04-07 19:13:23	2026-06-09 15:19:55
4	24	need	closed	medium	other	2026-01-01 01:57:29	2026-01-01 02:32:30	2026-01-01 01:57:29	2026-01-01 02:32:30
22	10	Bh	open	medium	deposit	2026-06-12 20:29:12	\N	2026-06-12 20:29:12	2026-06-12 20:29:12
8	32	Aklilu	awaiting_user	medium	withdrawal	2026-02-01 15:22:51	\N	2026-01-21 20:19:36	2026-02-01 15:22:51
23	91	i need bitcoin address	open	urgent	account	2026-06-12 21:16:06	\N	2026-06-12 21:16:06	2026-06-12 21:16:06
6	23	Password	closed	medium	withdrawal	2026-01-13 04:01:44	2026-01-15 15:45:01	2026-01-13 03:58:59	2026-01-15 15:45:01
5	24	Live Chat Session	in_progress	medium	general_inquiry	2026-01-18 16:05:49	\N	2026-01-08 17:22:31	2026-01-18 16:05:49
24	38	Paying loan	awaiting_user	high	other	2026-06-20 15:20:51	\N	2026-06-17 00:43:45	2026-06-20 15:20:51
12	12	Live Chat Session	closed	medium	general_inquiry	2026-02-04 15:27:23	2026-02-04 15:30:37	2026-02-04 15:27:23	2026-02-04 15:30:37
25	92	Withdraw funds	awaiting_user	high	withdrawal	2026-07-16 03:31:02	\N	2026-07-15 20:34:03	2026-07-16 03:31:02
19	53	Urgent	in_progress	urgent	deposit	2026-04-02 03:58:21	\N	2026-03-27 04:07:18	2026-04-02 03:58:21
16	57	This morning I made withdraw but still I didn’t receive	in_progress	high	withdrawal	2026-04-06 04:28:17	\N	2026-02-28 14:36:44	2026-04-06 04:28:17
7	33	Withdrawal	awaiting_user	high	withdrawal	2026-02-04 23:39:52	\N	2026-01-20 17:42:06	2026-02-04 23:39:52
14	54	Wallet adrese	awaiting_user	medium	deposit	2026-02-13 22:37:20	\N	2026-02-13 22:29:48	2026-02-13 22:37:20
21	87	Deposit problem	awaiting_user	medium	deposit	2026-05-03 12:06:08	\N	2026-05-03 04:47:22	2026-05-03 12:06:08
13	12	heee	in_progress	low	deposit	2026-02-15 19:31:18	\N	2026-02-04 21:14:21	2026-02-15 19:31:18
3	9	New wallet address	awaiting_user	medium	other	2026-05-16 03:23:30	\N	2026-01-01 01:46:30	2026-05-16 03:23:30
10	23	Loan	in_progress	medium	other	2026-03-02 17:17:45	\N	2026-01-29 05:31:33	2026-03-02 17:17:45
\.


--
-- Data for Name: trade_contracts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trade_contracts (id, trade_id, quantity, leverage, liquidation_price, take_profit, stop_loss, created_at, updated_at) FROM stdin;
1	7	159.75155438	100	3100.12633000	\N	\N	2025-12-08 06:15:23	2025-12-08 06:15:23
2	32	0.05663101	10	79903.21925000	\N	\N	2025-12-21 18:46:23	2025-12-21 18:46:23
3	195	0.07392481	10	61210.84245000	\N	\N	2026-02-21 03:56:35	2026-02-21 03:56:35
4	245	0.19651620	10	4605.21829752	\N	\N	2026-03-03 23:24:00	2026-03-03 23:24:00
5	304	0.01419836	10	63739.73825000	\N	\N	2026-03-21 16:48:00	2026-03-21 16:48:00
6	402	0.06566399	10	83379.02685000	\N	\N	2026-05-24 21:46:50	2026-05-24 21:46:50
\.


--
-- Data for Name: trade_options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trade_options (id, trade_id, duration, return_rate, expected_return, created_at, updated_at) FROM stdin;
1	1	30	15.00	115.00	2025-12-07 04:19:16	2025-12-07 04:19:16
2	2	60	20.00	11400.00	2025-12-07 04:52:15	2025-12-07 04:52:15
3	3	90	25.00	100000.00	2025-12-07 04:59:21	2025-12-07 04:59:21
4	4	90	25.00	100000.00	2025-12-08 06:09:31	2025-12-08 06:09:31
5	5	90	25.00	100000.00	2025-12-08 06:11:46	2025-12-08 06:11:46
6	8	180	30.00	260000.00	2025-12-08 06:16:12	2025-12-08 06:16:12
7	9	30	15.00	4600.00	2025-12-08 06:22:15	2025-12-08 06:22:15
8	10	30	15.00	5635.00	2025-12-08 06:23:50	2025-12-08 06:23:50
9	11	90	25.00	37500.00	2025-12-08 19:17:15	2025-12-08 19:17:15
10	12	90	25.00	62500.00	2025-12-09 04:12:21	2025-12-09 04:12:21
11	13	60	20.00	9600.00	2025-12-09 05:34:32	2025-12-09 05:34:32
12	14	30	15.00	4600.00	2025-12-09 16:22:21	2025-12-09 16:22:21
13	15	60	20.00	18000.00	2025-12-10 04:10:42	2025-12-10 04:10:42
14	16	90	25.00	100000.00	2025-12-10 04:13:10	2025-12-10 04:13:10
15	17	60	20.00	18000.00	2025-12-11 00:05:54	2025-12-11 00:05:54
16	18	90	25.00	43750.00	2025-12-12 03:47:38	2025-12-12 03:47:38
17	19	90	25.00	43750.00	2025-12-12 03:55:01	2025-12-12 03:55:01
18	20	60	20.00	9600.00	2025-12-13 02:05:26	2025-12-13 02:05:26
19	21	90	25.00	40000.00	2025-12-13 02:11:16	2025-12-13 02:11:16
20	22	90	25.00	41250.00	2025-12-13 02:15:27	2025-12-13 02:15:27
21	23	60	20.00	6600.00	2025-12-14 02:10:36	2025-12-14 02:10:36
22	24	30	15.00	5750.00	2025-12-14 07:53:17	2025-12-14 07:53:17
23	25	60	20.00	12000.00	2025-12-17 02:00:44	2025-12-17 02:00:44
24	26	30	15.00	4600.00	2025-12-17 02:02:47	2025-12-17 02:02:47
25	27	90	25.00	50000.00	2025-12-17 07:10:06	2025-12-17 07:10:06
26	28	90	25.00	50000.00	2025-12-17 18:53:08	2025-12-17 18:53:08
27	29	180	30.00	143000.00	2025-12-18 23:13:50	2025-12-18 23:13:50
28	30	180	30.00	260000.00	2025-12-19 01:41:41	2025-12-19 01:41:41
29	31	30	15.00	1150.00	2025-12-20 03:54:18	2025-12-20 03:54:18
30	33	30	12.00	1120.00	2025-12-22 01:03:15	2025-12-22 01:03:15
31	34	60	15.00	23000.00	2025-12-22 02:33:31	2025-12-22 02:33:31
32	35	60	15.00	23000.00	2025-12-22 02:36:47	2025-12-22 02:36:47
33	36	30	12.00	11200.00	2025-12-26 08:12:51	2025-12-26 08:12:51
34	37	30	12.00	11200.00	2025-12-26 08:28:15	2025-12-26 08:28:15
35	38	60	15.00	11501.15	2025-12-26 08:42:34	2025-12-26 08:42:34
36	39	30	12.00	2016.00	2025-12-28 05:25:17	2025-12-28 05:25:17
37	40	30	12.00	2240.00	2025-12-28 05:34:57	2025-12-28 05:34:57
38	41	90	18.00	53100.00	2025-12-28 05:35:43	2025-12-28 05:35:43
39	42	90	18.00	70800.00	2025-12-30 00:53:58	2025-12-30 00:53:58
40	43	30	12.00	3248.00	2025-12-30 04:51:18	2025-12-30 04:51:18
41	44	60	15.00	21850.00	2025-12-31 03:22:18	2025-12-31 03:22:18
42	45	90	18.00	53100.00	2025-12-31 03:31:00	2025-12-31 03:31:00
43	46	90	18.00	70800.00	2025-12-31 03:36:18	2025-12-31 03:36:18
44	47	90	18.00	81420.00	2026-01-01 03:30:48	2026-01-01 03:30:48
45	48	30	12.00	6720.00	2026-01-01 03:58:25	2026-01-01 03:58:25
46	49	30	12.00	7280.00	2026-01-01 04:03:41	2026-01-01 04:03:41
47	50	60	15.00	17250.00	2026-01-01 04:28:43	2026-01-01 04:28:43
48	51	180	22.00	103700.00	2026-01-01 04:36:07	2026-01-01 04:36:07
49	52	60	15.00	16750.90	2026-01-02 08:56:03	2026-01-02 08:56:03
50	53	90	18.00	76700.00	2026-01-02 15:07:28	2026-01-02 15:07:28
51	54	180	22.00	97600.00	2026-01-02 15:10:05	2026-01-02 15:10:05
52	55	90	18.00	81420.00	2026-01-02 15:10:53	2026-01-02 15:10:53
53	56	180	22.00	122000.00	2026-01-02 18:12:20	2026-01-02 18:12:20
54	57	30	12.00	11200.00	2026-01-02 18:14:08	2026-01-02 18:14:08
55	58	180	22.00	122000.00	2026-01-02 18:18:00	2026-01-02 18:18:00
56	59	90	18.00	82600.00	2026-01-03 01:29:51	2026-01-03 01:29:51
57	60	90	18.00	82600.00	2026-01-03 01:46:17	2026-01-03 01:46:17
58	61	90	18.00	59000.00	2026-01-05 18:48:38	2026-01-05 18:48:38
59	62	30	12.00	10640.00	2026-01-06 03:08:36	2026-01-06 03:08:36
60	63	30	12.00	11200.00	2026-01-06 03:24:13	2026-01-06 03:24:13
61	64	30	12.00	112.00	2026-01-06 09:31:12	2026-01-06 09:31:12
62	65	30	12.00	5600.00	2026-01-06 16:48:22	2026-01-06 16:48:22
63	66	30	12.00	11200.00	2026-01-06 16:52:17	2026-01-06 16:52:17
64	67	30	12.00	112.00	2026-01-07 15:58:52	2026-01-07 15:58:52
65	68	30	12.00	560.00	2026-01-08 17:21:34	2026-01-08 17:21:34
66	69	30	12.00	1120.00	2026-01-10 06:29:05	2026-01-10 06:29:05
67	70	30	12.00	1344.00	2026-01-10 06:35:59	2026-01-10 06:35:59
68	71	30	12.00	1456.00	2026-01-10 06:41:33	2026-01-10 06:41:33
69	72	700	32.00	264001.32	2026-01-12 19:33:30	2026-01-12 19:33:30
70	73	60	15.00	21850.00	2026-01-13 03:08:26	2026-01-13 03:08:26
71	74	60	15.00	24150.00	2026-01-13 03:16:05	2026-01-13 03:16:05
72	75	60	15.00	33350.00	2026-01-13 03:26:42	2026-01-13 03:26:42
73	76	700	32.00	330000.00	2026-01-13 17:13:03	2026-01-13 17:13:03
74	77	700	32.00	330000.00	2026-01-14 05:13:31	2026-01-14 05:13:31
75	78	90	18.00	41300.00	2026-01-15 05:42:31	2026-01-15 05:42:31
76	79	60	15.00	34500.00	2026-01-15 18:06:04	2026-01-15 18:06:04
77	80	60	15.00	23000.00	2026-01-15 20:40:05	2026-01-15 20:40:05
78	81	60	15.00	34500.00	2026-01-16 07:00:51	2026-01-16 07:00:51
79	82	30	12.00	2800.00	2026-01-16 18:52:24	2026-01-16 18:52:24
80	83	90	18.00	53100.00	2026-01-16 18:53:18	2026-01-16 18:53:18
81	84	90	18.00	53100.00	2026-01-16 18:53:35	2026-01-16 18:53:35
82	85	30	12.00	3192.00	2026-01-16 19:01:25	2026-01-16 19:01:25
83	86	60	15.00	12650.00	2026-01-16 19:18:47	2026-01-16 19:18:47
84	87	90	18.00	70800.00	2026-01-16 19:25:59	2026-01-16 19:25:59
85	88	30	12.00	5712.00	2026-01-18 02:25:24	2026-01-18 02:25:24
86	89	90	18.00	59000.00	2026-01-19 14:57:28	2026-01-19 14:57:28
87	90	90	18.00	49560.00	2026-01-20 01:52:39	2026-01-20 01:52:39
88	91	30	12.00	560.00	2026-01-21 17:44:52	2026-01-21 17:44:52
89	92	90	18.00	35401.18	2026-01-21 17:45:56	2026-01-21 17:45:56
90	93	60	15.00	34500.00	2026-01-21 18:03:34	2026-01-21 18:03:34
91	94	180	22.00	91500.00	2026-01-21 23:05:23	2026-01-21 23:05:23
92	95	60	15.00	27600.00	2026-01-22 04:46:34	2026-01-22 04:46:34
93	96	300	26.00	189000.00	2026-01-22 18:52:33	2026-01-22 18:52:33
94	97	300	26.00	195300.00	2026-01-22 19:03:08	2026-01-22 19:03:08
95	98	60	15.00	30521.00	2026-01-23 02:57:48	2026-01-23 02:57:48
96	99	90	18.00	57173.36	2026-01-23 03:39:30	2026-01-23 03:39:30
97	100	90	18.00	50216.08	2026-01-23 03:41:25	2026-01-23 03:41:25
98	101	90	18.00	59000.00	2026-01-23 07:09:00	2026-01-23 07:09:00
99	102	180	22.00	85401.22	2026-01-23 21:04:49	2026-01-23 21:04:49
100	103	180	22.00	97600.00	2026-01-23 21:05:21	2026-01-23 21:05:21
101	104	60	15.00	33108.50	2026-01-26 01:44:07	2026-01-26 01:44:07
102	105	60	15.00	32998.10	2026-01-26 01:50:03	2026-01-26 01:50:03
103	106	30	12.00	403.20	2026-01-26 03:50:46	2026-01-26 03:50:46
104	107	180	22.00	85401.22	2026-01-26 04:29:43	2026-01-26 04:29:43
105	108	60	15.00	23000.00	2026-01-27 19:29:31	2026-01-27 19:29:31
106	109	30	12.00	5488.00	2026-01-27 20:13:17	2026-01-27 20:13:17
107	110	300	26.00	252000.00	2026-01-27 23:33:18	2026-01-27 23:33:18
108	111	90	18.00	50220.80	2026-01-28 03:09:25	2026-01-28 03:09:25
109	112	90	18.00	69575.16	2026-01-28 03:13:36	2026-01-28 03:13:36
110	113	30	12.00	11200.00	2026-01-28 04:26:08	2026-01-28 04:26:08
111	114	30	12.00	6272.00	2026-01-29 01:03:32	2026-01-29 01:03:32
112	115	90	18.00	70800.00	2026-01-29 01:04:40	2026-01-29 01:04:40
113	116	30	12.00	224.00	2026-01-29 01:26:37	2026-01-29 01:26:37
114	117	60	15.00	23000.00	2026-01-29 01:28:11	2026-01-29 01:28:11
115	118	30	12.00	10080.00	2026-01-30 01:34:32	2026-01-30 01:34:32
116	119	30	12.00	1008.00	2026-01-30 01:51:58	2026-01-30 01:51:58
117	120	30	12.00	1097.60	2026-01-30 01:54:18	2026-01-30 01:54:18
118	121	30	12.00	1232.00	2026-01-30 01:56:10	2026-01-30 01:56:10
119	122	30	12.00	2800.00	2026-01-30 01:59:53	2026-01-30 01:59:53
120	123	180	22.00	91500.00	2026-01-30 02:01:04	2026-01-30 02:01:04
121	124	30	12.00	6720.00	2026-01-30 02:36:35	2026-01-30 02:36:35
122	125	30	12.00	7504.00	2026-01-30 02:50:23	2026-01-30 02:50:23
123	126	60	15.00	11501.15	2026-01-30 15:12:05	2026-01-30 15:12:05
124	127	30	12.00	8232.00	2026-01-30 18:52:07	2026-01-30 18:52:07
125	128	30	12.00	8960.00	2026-01-30 18:56:17	2026-01-30 18:56:17
126	129	30	12.00	11200.00	2026-01-30 21:47:57	2026-01-30 21:47:57
127	130	60	15.00	17250.00	2026-01-30 21:48:28	2026-01-30 21:48:28
128	131	90	18.00	35401.18	2026-01-30 21:49:13	2026-01-30 21:49:13
129	132	180	22.00	85401.22	2026-01-30 21:49:47	2026-01-30 21:49:47
130	133	700	32.00	264001.32	2026-01-30 22:02:27	2026-01-30 22:02:27
131	134	300	26.00	252000.00	2026-01-31 17:22:44	2026-01-31 17:22:44
132	135	60	15.00	13800.00	2026-01-31 17:46:21	2026-01-31 17:46:21
133	136	30	12.00	3136.00	2026-01-31 19:26:38	2026-01-31 19:26:38
134	137	30	12.00	2800.00	2026-01-31 19:29:04	2026-01-31 19:29:04
135	138	30	12.00	3360.00	2026-01-31 19:31:30	2026-01-31 19:31:30
136	139	90	18.00	82600.00	2026-02-01 16:25:46	2026-02-01 16:25:46
137	140	90	18.00	45500.80	2026-02-01 16:53:23	2026-02-01 16:53:23
138	141	60	15.00	28750.00	2026-02-02 18:46:42	2026-02-02 18:46:42
139	142	300	26.00	252000.00	2026-02-02 21:00:31	2026-02-02 21:00:31
140	143	30	12.00	3360.00	2026-02-03 03:03:45	2026-02-03 03:03:45
141	144	700	32.00	627000.00	2026-02-03 18:44:05	2026-02-03 18:44:05
142	145	30	12.00	9520.00	2026-02-03 19:02:06	2026-02-03 19:02:06
143	146	30	12.00	10640.00	2026-02-03 19:07:28	2026-02-03 19:07:28
144	147	180	22.00	109800.00	2026-02-03 19:11:53	2026-02-03 19:11:53
145	148	60	15.00	23000.00	2026-02-04 22:19:15	2026-02-04 22:19:15
146	149	30	12.00	1064.00	2026-02-05 04:04:00	2026-02-05 04:04:00
147	150	30	12.00	1176.00	2026-02-05 18:28:05	2026-02-05 18:28:05
148	151	90	18.00	43473.56	2026-02-05 18:39:05	2026-02-05 18:39:05
149	152	30	12.00	11200.00	2026-02-05 18:41:39	2026-02-05 18:41:39
150	153	60	15.00	12075.00	2026-02-05 23:33:56	2026-02-05 23:33:56
151	154	60	15.00	13800.00	2026-02-05 23:38:12	2026-02-05 23:38:12
152	155	700	32.00	396000.00	2026-02-06 02:00:29	2026-02-06 02:00:29
153	156	300	26.00	252000.00	2026-02-06 02:02:32	2026-02-06 02:02:32
154	157	300	26.00	252000.00	2026-02-06 02:05:33	2026-02-06 02:05:33
155	158	90	18.00	39525.28	2026-02-06 18:30:08	2026-02-06 18:30:08
156	159	60	15.00	34500.00	2026-02-08 21:55:47	2026-02-08 21:55:47
157	160	90	18.00	82600.00	2026-02-08 21:56:52	2026-02-08 21:56:52
158	161	90	18.00	82600.00	2026-02-09 03:03:22	2026-02-09 03:03:22
159	162	60	15.00	34500.00	2026-02-09 14:34:35	2026-02-09 14:34:35
160	163	60	15.00	12420.00	2026-02-09 16:27:59	2026-02-09 16:27:59
161	164	60	15.00	28750.00	2026-02-10 01:30:26	2026-02-10 01:30:26
162	165	90	18.00	80392.22	2026-02-10 20:16:29	2026-02-10 20:16:29
163	166	30	12.00	896.00	2026-02-10 20:34:04	2026-02-10 20:34:04
164	167	30	12.00	548.80	2026-02-11 03:23:56	2026-02-11 03:23:56
165	168	90	18.00	70800.00	2026-02-11 22:51:00	2026-02-11 22:51:00
166	169	60	15.00	26450.00	2026-02-11 23:01:47	2026-02-11 23:01:47
167	170	90	18.00	79650.00	2026-02-11 23:23:44	2026-02-11 23:23:44
168	171	60	15.00	28750.00	2026-02-11 23:24:40	2026-02-11 23:24:40
171	174	60	15.00	34500.00	2026-02-12 21:41:41	2026-02-12 21:41:41
175	178	90	18.00	52809.72	2026-02-13 23:16:51	2026-02-13 23:16:51
176	179	30	12.00	1120.00	2026-02-13 23:45:43	2026-02-13 23:45:43
177	180	30	12.00	1120.00	2026-02-13 23:51:43	2026-02-13 23:51:43
179	182	90	18.00	59000.00	2026-02-17 03:58:42	2026-02-17 03:58:42
180	183	30	12.00	2016.00	2026-02-17 03:59:59	2026-02-17 03:59:59
181	184	90	18.00	73160.00	2026-02-17 04:01:19	2026-02-17 04:01:19
182	185	90	18.00	73514.00	2026-02-17 04:09:38	2026-02-17 04:09:38
183	186	180	22.00	122000.00	2026-02-17 22:27:17	2026-02-17 22:27:17
184	187	60	15.00	19550.00	2026-02-18 17:24:05	2026-02-18 17:24:05
185	188	180	22.00	146400.00	2026-02-18 17:25:26	2026-02-18 17:25:26
186	189	60	15.00	29900.00	2026-02-18 20:09:31	2026-02-18 20:09:31
187	190	90	18.00	59000.00	2026-02-18 21:03:45	2026-02-18 21:03:45
188	191	30	12.00	1120.00	2026-02-19 00:22:27	2026-02-19 00:22:27
189	192	300	26.00	168840.00	2026-02-19 21:36:47	2026-02-19 21:36:47
190	193	30	12.00	2240.00	2026-02-20 21:10:29	2026-02-20 21:10:29
191	194	90	18.00	69030.00	2026-02-21 00:33:23	2026-02-21 00:33:23
192	196	30	12.00	448.00	2026-02-21 04:09:55	2026-02-21 04:09:55
193	197	30	12.00	448.00	2026-02-21 04:21:39	2026-02-21 04:21:39
194	198	30	12.00	560.00	2026-02-21 04:33:02	2026-02-21 04:33:02
195	199	30	12.00	560.00	2026-02-21 04:36:56	2026-02-21 04:36:56
196	200	30	12.00	672.00	2026-02-21 04:40:12	2026-02-21 04:40:12
197	201	90	18.00	59000.00	2026-02-21 04:41:49	2026-02-21 04:41:49
198	202	60	15.00	34500.00	2026-02-23 22:33:57	2026-02-23 22:33:57
199	203	60	15.00	34500.00	2026-02-23 22:34:19	2026-02-23 22:34:19
200	204	30	12.00	1008.00	2026-02-24 19:52:56	2026-02-24 19:52:56
201	205	30	12.00	2240.00	2026-02-24 20:51:46	2026-02-24 20:51:46
202	206	90	18.00	57739.76	2026-02-25 00:31:25	2026-02-25 00:31:25
203	207	90	18.00	35401.18	2026-02-25 02:07:16	2026-02-25 02:07:16
204	208	90	18.00	82600.00	2026-02-25 02:11:53	2026-02-25 02:11:53
205	209	60	15.00	27600.00	2026-02-25 17:57:50	2026-02-25 17:57:50
206	210	300	26.00	226800.00	2026-02-25 18:04:01	2026-02-25 18:04:01
207	211	30	12.00	11200.00	2026-02-26 18:14:38	2026-02-26 18:14:38
208	212	90	18.00	47200.00	2026-02-26 20:28:57	2026-02-26 20:28:57
209	213	90	18.00	59000.00	2026-02-27 02:47:01	2026-02-27 02:47:01
210	214	180	22.00	122000.00	2026-02-27 20:06:25	2026-02-27 20:06:25
211	215	90	18.00	82600.00	2026-02-27 20:10:29	2026-02-27 20:10:29
212	216	90	18.00	82600.00	2026-02-27 20:19:03	2026-02-27 20:19:03
213	217	60	15.00	23000.00	2026-02-27 23:00:45	2026-02-27 23:00:45
214	218	30	12.00	3136.00	2026-02-27 23:09:02	2026-02-27 23:09:02
215	219	30	12.00	3136.00	2026-02-27 23:11:50	2026-02-27 23:11:50
216	220	90	18.00	82600.00	2026-02-28 01:42:53	2026-02-28 01:42:53
217	221	60	15.00	34500.00	2026-02-28 01:59:47	2026-02-28 01:59:47
218	222	60	15.00	34500.00	2026-02-28 03:50:21	2026-02-28 03:50:21
219	223	30	12.00	448.00	2026-03-02 01:01:20	2026-03-02 01:01:20
220	224	30	12.00	11200.00	2026-03-02 01:06:16	2026-03-02 01:06:16
221	225	90	18.00	61114.56	2026-03-02 18:30:22	2026-03-02 18:30:22
222	226	30	12.00	1120.00	2026-03-02 20:16:01	2026-03-02 20:16:01
223	227	30	12.00	3360.00	2026-03-02 20:16:07	2026-03-02 20:16:07
224	228	30	12.00	1120.00	2026-03-02 20:31:47	2026-03-02 20:31:47
225	229	30	12.00	1344.00	2026-03-02 20:47:44	2026-03-02 20:47:44
226	230	30	12.00	1344.00	2026-03-02 20:55:04	2026-03-02 20:55:04
227	231	30	12.00	1344.00	2026-03-02 20:56:18	2026-03-02 20:56:18
228	232	30	12.00	1680.00	2026-03-02 21:02:21	2026-03-02 21:02:21
229	233	30	12.00	1792.00	2026-03-02 21:07:40	2026-03-02 21:07:40
230	234	30	12.00	1792.00	2026-03-02 21:08:44	2026-03-02 21:08:44
231	235	30	12.00	2016.00	2026-03-02 21:21:35	2026-03-02 21:21:35
232	236	30	12.00	2016.00	2026-03-02 21:24:29	2026-03-02 21:24:29
233	237	30	12.00	2016.00	2026-03-02 21:26:02	2026-03-02 21:26:02
234	238	30	12.00	2240.00	2026-03-02 21:30:56	2026-03-02 21:30:56
235	239	30	12.00	2240.00	2026-03-02 21:32:44	2026-03-02 21:32:44
236	240	30	12.00	112.00	2026-03-02 21:33:50	2026-03-02 21:33:50
237	241	30	12.00	2688.00	2026-03-02 21:35:06	2026-03-02 21:35:06
238	242	30	12.00	2240.00	2026-03-02 21:44:11	2026-03-02 21:44:11
239	243	30	12.00	560.00	2026-03-03 00:15:26	2026-03-03 00:15:26
240	244	90	18.00	76700.00	2026-03-03 04:27:07	2026-03-03 04:27:07
241	246	30	12.00	114.24	2026-03-03 23:38:18	2026-03-03 23:38:18
242	247	30	12.00	168.00	2026-03-03 23:41:50	2026-03-03 23:41:50
243	248	30	12.00	134.40	2026-03-04 05:17:54	2026-03-04 05:17:54
244	249	60	15.00	34500.00	2026-03-04 12:01:44	2026-03-04 12:01:44
245	250	30	12.00	3360.00	2026-03-04 19:12:57	2026-03-04 19:12:57
246	251	30	12.00	560.00	2026-03-04 19:15:39	2026-03-04 19:15:39
247	252	30	12.00	4256.00	2026-03-04 20:43:14	2026-03-04 20:43:14
248	253	30	12.00	4480.00	2026-03-05 20:14:46	2026-03-05 20:14:46
249	254	30	12.00	4928.00	2026-03-05 20:17:23	2026-03-05 20:17:23
250	255	30	12.00	5152.00	2026-03-05 20:23:37	2026-03-05 20:23:37
251	256	30	12.00	313.60	2026-03-06 00:53:14	2026-03-06 00:53:14
252	257	30	12.00	1008.00	2026-03-06 01:11:38	2026-03-06 01:11:38
253	258	90	18.00	35401.18	2026-03-06 01:33:47	2026-03-06 01:33:47
254	259	60	15.00	13800.00	2026-03-06 01:35:16	2026-03-06 01:35:16
255	260	180	22.00	85401.22	2026-03-06 01:35:55	2026-03-06 01:35:55
256	261	30	12.00	1120.00	2026-03-06 21:38:48	2026-03-06 21:38:48
257	262	30	12.00	112.00	2026-03-06 22:21:24	2026-03-06 22:21:24
258	263	90	18.00	82600.00	2026-03-06 22:50:27	2026-03-06 22:50:27
259	264	60	15.00	34500.00	2026-03-06 23:32:52	2026-03-06 23:32:52
260	265	30	12.00	168.00	2026-03-07 03:01:06	2026-03-07 03:01:06
261	266	90	18.00	59000.00	2026-03-07 03:43:16	2026-03-07 03:43:16
262	267	30	12.00	560.00	2026-03-08 02:49:18	2026-03-08 02:49:18
263	268	30	12.00	6160.00	2026-03-08 23:07:12	2026-03-08 23:07:12
264	269	90	18.00	60607.16	2026-03-09 18:13:06	2026-03-09 18:13:06
265	270	90	18.00	60987.12	2026-03-09 18:15:32	2026-03-09 18:15:32
266	271	30	12.00	1120.00	2026-03-10 02:31:00	2026-03-10 02:31:00
267	272	30	12.00	190.40	2026-03-10 03:35:24	2026-03-10 03:35:24
268	273	30	12.00	224.00	2026-03-10 03:51:16	2026-03-10 03:51:16
269	274	30	12.00	4144.00	2026-03-10 18:40:58	2026-03-10 18:40:58
270	275	30	12.00	4480.00	2026-03-10 21:50:43	2026-03-10 21:50:43
271	276	30	12.00	896.00	2026-03-10 21:53:23	2026-03-10 21:53:23
272	277	60	15.00	34500.00	2026-03-11 22:46:36	2026-03-11 22:46:36
273	278	30	12.00	784.00	2026-03-13 02:39:52	2026-03-13 02:39:52
274	279	30	12.00	6720.00	2026-03-13 03:48:07	2026-03-13 03:48:07
275	280	30	12.00	2240.00	2026-03-13 22:18:56	2026-03-13 22:18:56
276	281	30	12.00	112.00	2026-03-14 18:02:46	2026-03-14 18:02:46
277	282	90	18.00	50244.40	2026-03-15 02:49:09	2026-03-15 02:49:09
278	283	90	18.00	68317.28	2026-03-15 02:51:42	2026-03-15 02:51:42
279	284	30	12.00	4480.00	2026-03-15 21:00:01	2026-03-15 21:00:01
280	285	30	12.00	336.00	2026-03-15 21:02:21	2026-03-15 21:02:21
281	286	30	12.00	5600.00	2026-03-15 21:13:26	2026-03-15 21:13:26
282	287	90	18.00	47200.00	2026-03-15 21:59:22	2026-03-15 21:59:22
283	288	30	12.00	1792.00	2026-03-17 03:10:01	2026-03-17 03:10:01
284	289	30	12.00	784.00	2026-03-17 03:17:41	2026-03-17 03:17:41
285	290	30	12.00	1792.00	2026-03-17 03:22:12	2026-03-17 03:22:12
286	291	30	12.00	1792.00	2026-03-17 03:30:23	2026-03-17 03:30:23
287	292	60	15.00	23000.00	2026-03-17 03:34:51	2026-03-17 03:34:51
288	293	30	12.00	1904.00	2026-03-17 03:36:11	2026-03-17 03:36:11
289	294	90	18.00	43660.00	2026-03-17 16:17:43	2026-03-17 16:17:43
290	295	90	18.00	82600.00	2026-03-17 16:20:20	2026-03-17 16:20:20
291	296	90	18.00	82600.00	2026-03-17 16:20:48	2026-03-17 16:20:48
292	297	90	18.00	70800.00	2026-03-19 20:28:58	2026-03-19 20:28:58
293	298	90	18.00	64900.00	2026-03-20 00:35:36	2026-03-20 00:35:36
294	299	90	18.00	70800.00	2026-03-20 01:08:32	2026-03-20 01:08:32
295	300	30	12.00	6720.00	2026-03-20 03:09:30	2026-03-20 03:09:30
296	301	30	12.00	6720.00	2026-03-20 04:46:35	2026-03-20 04:46:35
297	302	30	12.00	1904.00	2026-03-20 05:35:38	2026-03-20 05:35:38
298	303	90	18.00	82600.00	2026-03-20 23:24:47	2026-03-20 23:24:47
299	305	30	12.00	2128.00	2026-03-24 02:50:50	2026-03-24 02:50:50
300	306	90	18.00	56640.00	2026-03-24 16:52:36	2026-03-24 16:52:36
301	307	30	12.00	4480.00	2026-03-24 19:34:36	2026-03-24 19:34:36
302	308	30	12.00	448.00	2026-03-25 01:34:14	2026-03-25 01:34:14
303	309	30	12.00	448.00	2026-03-25 01:34:19	2026-03-25 01:34:19
304	310	30	12.00	2240.00	2026-03-25 04:08:39	2026-03-25 04:08:39
305	311	30	12.00	336.00	2026-03-25 05:13:31	2026-03-25 05:13:31
306	312	30	12.00	336.00	2026-03-25 05:27:55	2026-03-25 05:27:55
307	313	90	18.00	59000.00	2026-03-25 18:37:21	2026-03-25 18:37:21
308	314	180	22.00	134200.00	2026-03-25 18:39:50	2026-03-25 18:39:50
309	315	60	15.00	23000.00	2026-03-26 02:16:34	2026-03-26 02:16:34
310	316	60	15.00	23000.00	2026-03-26 02:19:01	2026-03-26 02:19:01
311	317	30	12.00	5376.00	2026-03-26 21:24:56	2026-03-26 21:24:56
312	318	180	22.00	122000.00	2026-03-27 01:41:34	2026-03-27 01:41:34
313	319	30	12.00	2240.00	2026-03-27 03:00:14	2026-03-27 03:00:14
314	320	30	12.00	5600.00	2026-03-27 05:18:11	2026-03-27 05:18:11
315	321	90	18.00	45157.42	2026-03-27 19:20:21	2026-03-27 19:20:21
316	322	30	12.00	1120.00	2026-03-28 01:20:34	2026-03-28 01:20:34
317	323	30	12.00	1120.00	2026-03-28 01:20:46	2026-03-28 01:20:46
318	324	30	12.00	6160.00	2026-03-28 04:14:10	2026-03-28 04:14:10
319	325	30	12.00	8960.00	2026-03-30 01:57:57	2026-03-30 01:57:57
320	326	30	12.00	11200.00	2026-03-30 02:52:58	2026-03-30 02:52:58
321	327	30	12.00	1008.00	2026-03-30 02:53:54	2026-03-30 02:53:54
322	328	30	12.00	1008.00	2026-03-30 20:36:04	2026-03-30 20:36:04
323	329	30	12.00	2576.00	2026-03-31 04:34:43	2026-03-31 04:34:43
324	330	60	15.00	12650.00	2026-04-01 01:36:08	2026-04-01 01:36:08
325	331	90	18.00	54747.28	2026-04-01 17:30:08	2026-04-01 17:30:08
326	332	30	12.00	1120.00	2026-04-02 19:40:55	2026-04-02 19:40:55
327	333	30	12.00	1120.00	2026-04-02 19:44:42	2026-04-02 19:44:42
328	334	30	12.00	2576.00	2026-04-03 03:49:42	2026-04-03 03:49:42
329	335	30	12.00	8960.00	2026-04-03 23:34:32	2026-04-03 23:34:32
330	336	30	12.00	3136.00	2026-04-04 01:13:16	2026-04-04 01:13:16
331	337	30	12.00	336.00	2026-04-06 20:13:59	2026-04-06 20:13:59
332	338	60	15.00	11501.15	2026-04-06 20:16:35	2026-04-06 20:16:35
333	339	60	15.00	17135.00	2026-04-07 04:13:46	2026-04-07 04:13:46
334	340	90	18.00	66522.50	2026-04-08 02:44:43	2026-04-08 02:44:43
335	341	60	15.00	34500.00	2026-04-09 01:00:43	2026-04-09 01:00:43
336	342	90	18.00	44840.00	2026-04-12 02:00:57	2026-04-12 02:00:57
337	343	60	15.00	17250.00	2026-04-15 01:44:21	2026-04-15 01:44:21
338	344	60	15.00	34500.00	2026-04-15 01:46:26	2026-04-15 01:46:26
339	345	60	15.00	16100.00	2026-04-15 01:47:19	2026-04-15 01:47:19
340	346	60	15.00	16100.00	2026-04-15 01:48:20	2026-04-15 01:48:20
341	347	30	12.00	1008.00	2026-04-16 01:14:19	2026-04-16 01:14:19
342	348	60	15.00	34500.00	2026-04-16 04:04:56	2026-04-16 04:04:56
343	349	60	15.00	18400.00	2026-04-16 04:22:10	2026-04-16 04:22:10
344	350	180	22.00	85401.22	2026-04-16 18:35:28	2026-04-16 18:35:28
345	351	180	22.00	85401.22	2026-04-16 18:40:47	2026-04-16 18:40:47
346	352	30	12.00	1120.00	2026-04-17 00:48:13	2026-04-17 00:48:13
347	353	90	18.00	47200.00	2026-04-17 03:17:45	2026-04-17 03:17:45
348	354	60	15.00	19550.00	2026-04-17 21:02:46	2026-04-17 21:02:46
349	355	30	12.00	3808.00	2026-04-18 02:04:26	2026-04-18 02:04:26
350	356	30	12.00	4144.00	2026-04-18 02:12:59	2026-04-18 02:12:59
351	357	60	15.00	11501.15	2026-04-19 04:36:30	2026-04-19 04:36:30
352	358	60	15.00	34500.00	2026-04-21 02:00:46	2026-04-21 02:00:46
353	359	30	12.00	7840.00	2026-04-22 00:59:17	2026-04-22 00:59:17
354	360	90	18.00	35401.18	2026-04-22 01:05:06	2026-04-22 01:05:06
355	361	90	18.00	35401.18	2026-04-22 01:07:02	2026-04-22 01:07:02
356	362	30	12.00	4480.00	2026-04-22 02:15:57	2026-04-22 02:15:57
357	363	60	15.00	20700.00	2026-04-22 04:16:09	2026-04-22 04:16:09
358	364	90	18.00	38940.00	2026-04-24 00:30:29	2026-04-24 00:30:29
359	365	30	12.00	112.00	2026-04-24 01:31:10	2026-04-24 01:31:10
360	366	30	12.00	6272.00	2026-04-24 01:33:45	2026-04-24 01:33:45
361	367	90	18.00	43070.00	2026-04-24 02:17:44	2026-04-24 02:17:44
362	368	90	18.00	41300.00	2026-04-24 02:18:20	2026-04-24 02:18:20
363	369	90	18.00	76700.00	2026-04-24 03:50:08	2026-04-24 03:50:08
364	370	90	18.00	41300.00	2026-04-25 16:23:03	2026-04-25 16:23:03
365	371	90	18.00	70800.00	2026-04-26 23:38:42	2026-04-26 23:38:42
366	372	60	15.00	11501.15	2026-04-27 01:48:40	2026-04-27 01:48:40
367	373	180	22.00	122000.00	2026-04-29 18:26:00	2026-04-29 18:26:00
368	374	60	15.00	11615.00	2026-05-02 02:20:37	2026-05-02 02:20:37
369	375	90	18.00	47200.00	2026-05-05 01:30:04	2026-05-05 01:30:04
370	376	180	22.00	97600.00	2026-05-05 04:08:33	2026-05-05 04:08:33
371	377	90	18.00	64900.00	2026-05-08 01:30:05	2026-05-08 01:30:05
372	378	60	15.00	11501.15	2026-05-08 23:38:17	2026-05-08 23:38:17
373	379	60	15.00	17250.00	2026-05-09 01:01:46	2026-05-09 01:01:46
374	380	60	15.00	19550.00	2026-05-09 01:05:33	2026-05-09 01:05:33
375	381	30	12.00	1008.00	2026-05-09 14:35:31	2026-05-09 14:35:31
376	382	30	12.00	1064.00	2026-05-09 14:38:41	2026-05-09 14:38:41
377	383	30	12.00	1008.00	2026-05-09 14:41:09	2026-05-09 14:41:09
378	384	30	12.00	112.00	2026-05-10 19:25:50	2026-05-10 19:25:50
379	385	90	18.00	76700.00	2026-05-12 01:00:06	2026-05-12 01:00:06
380	386	60	15.00	16100.00	2026-05-12 01:21:01	2026-05-12 01:21:01
381	387	90	18.00	64900.00	2026-05-12 02:20:49	2026-05-12 02:20:49
382	388	30	12.00	6720.00	2026-05-12 07:11:11	2026-05-12 07:11:11
383	389	90	18.00	76700.00	2026-05-12 15:54:21	2026-05-12 15:54:21
384	390	180	22.00	140300.00	2026-05-13 02:32:03	2026-05-13 02:32:03
385	391	90	18.00	82600.00	2026-05-14 19:03:50	2026-05-14 19:03:50
386	392	60	15.00	21850.00	2026-05-16 03:07:33	2026-05-16 03:07:33
387	393	30	12.00	1680.00	2026-05-17 15:15:13	2026-05-17 15:15:13
388	394	30	12.00	1904.00	2026-05-17 15:17:39	2026-05-17 15:17:39
389	395	60	15.00	34500.00	2026-05-17 15:20:53	2026-05-17 15:20:53
390	396	90	18.00	70800.00	2026-05-17 15:21:57	2026-05-17 15:21:57
391	397	90	18.00	55200.40	2026-05-18 03:48:47	2026-05-18 03:48:47
392	398	180	22.00	146400.00	2026-05-19 02:00:04	2026-05-19 02:00:04
393	399	180	22.00	146400.00	2026-05-21 18:00:03	2026-05-21 18:00:03
394	400	30	12.00	1232.00	2026-05-22 03:14:47	2026-05-22 03:14:47
395	401	60	15.00	30475.00	2026-05-23 01:56:06	2026-05-23 01:56:06
396	403	180	22.00	122000.00	2026-05-25 12:11:47	2026-05-25 12:11:47
397	404	60	15.00	34500.00	2026-05-26 00:30:14	2026-05-26 00:30:14
398	405	90	18.00	59000.00	2026-05-29 01:13:54	2026-05-29 01:13:54
399	406	180	22.00	85401.22	2026-05-29 03:47:41	2026-05-29 03:47:41
400	407	90	18.00	81420.00	2026-05-30 01:00:02	2026-05-30 01:00:02
401	408	60	15.00	34500.00	2026-05-30 01:31:54	2026-05-30 01:31:54
402	409	60	15.00	12650.00	2026-06-01 03:20:08	2026-06-01 03:20:08
403	410	90	18.00	69171.60	2026-06-01 16:43:49	2026-06-01 16:43:49
404	411	90	18.00	47200.00	2026-06-01 16:44:18	2026-06-01 16:44:18
405	412	90	18.00	82600.00	2026-06-01 16:59:28	2026-06-01 16:59:28
406	413	90	18.00	41300.00	2026-06-02 01:38:23	2026-06-02 01:38:23
407	414	30	12.00	112.00	2026-06-03 03:12:19	2026-06-03 03:12:19
408	415	30	12.00	5824.00	2026-06-03 03:14:57	2026-06-03 03:14:57
409	416	90	18.00	54006.24	2026-06-03 05:28:42	2026-06-03 05:28:42
410	417	90	18.00	82482.00	2026-06-03 17:10:55	2026-06-03 17:10:55
411	418	90	18.00	81420.00	2026-06-03 17:16:52	2026-06-03 17:16:52
412	419	90	18.00	64900.00	2026-06-04 01:06:31	2026-06-04 01:06:31
413	420	90	18.00	64900.00	2026-06-04 01:32:50	2026-06-04 01:32:50
414	421	30	12.00	11200.00	2026-06-04 03:46:20	2026-06-04 03:46:20
415	422	30	12.00	11200.00	2026-06-04 03:47:44	2026-06-04 03:47:44
416	423	60	15.00	34500.00	2026-06-04 03:52:31	2026-06-04 03:52:31
417	424	90	18.00	50578.34	2026-06-05 03:47:15	2026-06-05 03:47:15
418	425	30	12.00	112.00	2026-06-05 21:11:28	2026-06-05 21:11:28
419	426	90	18.00	61867.40	2026-06-08 18:00:26	2026-06-08 18:00:26
420	427	90	18.00	70800.00	2026-06-09 19:57:01	2026-06-09 19:57:01
421	428	180	22.00	122000.00	2026-06-10 19:07:13	2026-06-10 19:07:13
422	429	90	18.00	73738.20	2026-06-11 15:14:32	2026-06-11 15:14:32
423	430	90	18.00	74918.20	2026-06-11 15:17:37	2026-06-11 15:17:37
424	431	60	15.00	20700.00	2026-06-12 01:44:59	2026-06-12 01:44:59
425	432	30	12.00	212.80	2026-06-14 01:45:59	2026-06-14 01:45:59
426	433	90	18.00	69025.28	2026-06-15 15:38:16	2026-06-15 15:38:16
427	434	30	12.00	212.80	2026-06-16 15:41:47	2026-06-16 15:41:47
428	435	60	15.00	23000.00	2026-06-17 00:32:50	2026-06-17 00:32:50
429	436	60	15.00	34500.00	2026-06-17 02:09:26	2026-06-17 02:09:26
430	437	90	18.00	70800.00	2026-06-19 00:34:10	2026-06-19 00:34:10
431	438	60	15.00	17825.00	2026-06-19 18:20:30	2026-06-19 18:20:30
432	439	300	26.00	176400.00	2026-06-19 18:20:50	2026-06-19 18:20:50
433	440	30	12.00	6944.00	2026-06-20 02:48:19	2026-06-20 02:48:19
434	441	30	12.00	7616.00	2026-06-20 02:50:10	2026-06-20 02:50:10
435	442	30	12.00	112.00	2026-06-20 02:52:03	2026-06-20 02:52:03
436	443	90	18.00	82600.00	2026-06-23 00:41:01	2026-06-23 00:41:01
437	444	90	18.00	59000.00	2026-06-23 02:55:48	2026-06-23 02:55:48
438	445	30	12.00	224.00	2026-06-23 14:36:46	2026-06-23 14:36:46
439	446	90	18.00	63930.04	2026-06-23 14:51:09	2026-06-23 14:51:09
440	447	90	18.00	59000.00	2026-06-24 01:49:36	2026-06-24 01:49:36
441	448	30	12.00	280.00	2026-06-24 01:49:51	2026-06-24 01:49:51
442	449	90	18.00	49560.00	2026-06-24 19:31:34	2026-06-24 19:31:34
443	450	60	15.00	26450.00	2026-06-25 01:01:46	2026-06-25 01:01:46
444	451	30	12.00	336.00	2026-06-25 23:51:21	2026-06-25 23:51:21
445	452	90	18.00	59000.00	2026-06-25 23:51:48	2026-06-25 23:51:48
446	453	90	18.00	59000.00	2026-06-27 01:15:25	2026-06-27 01:15:25
447	454	30	12.00	1344.00	2026-06-27 14:01:22	2026-06-27 14:01:22
448	455	30	12.00	1792.00	2026-06-29 14:21:58	2026-06-29 14:21:58
449	456	90	18.00	59000.00	2026-06-30 00:59:01	2026-06-30 00:59:01
450	457	30	12.00	364.00	2026-06-30 00:59:04	2026-06-30 00:59:04
451	458	90	18.00	53405.62	2026-07-02 16:44:57	2026-07-02 16:44:57
452	459	30	12.00	8736.00	2026-07-04 03:03:52	2026-07-04 03:03:52
453	460	60	15.00	12075.00	2026-07-11 03:11:24	2026-07-11 03:11:24
454	461	60	15.00	29900.00	2026-07-11 03:38:15	2026-07-11 03:38:15
455	462	30	12.00	1120.00	2026-07-11 04:27:44	2026-07-11 04:27:44
456	463	90	18.00	42298.28	2026-07-11 15:34:39	2026-07-11 15:34:39
457	464	90	18.00	50311.66	2026-07-14 03:20:36	2026-07-14 03:20:36
458	465	30	12.00	11200.00	2026-07-14 15:32:53	2026-07-14 15:32:53
459	466	90	18.00	70800.00	2026-07-14 15:41:49	2026-07-14 15:41:49
460	467	30	12.00	112.00	2026-07-14 15:43:06	2026-07-14 15:43:06
461	468	30	12.00	11200.00	2026-07-15 14:44:50	2026-07-15 14:44:50
462	469	90	18.00	82600.00	2026-07-16 05:17:55	2026-07-16 05:17:55
463	470	30	12.00	1064.00	2026-07-16 05:20:55	2026-07-16 05:20:55
464	471	60	15.00	12650.00	2026-07-17 15:15:54	2026-07-17 15:15:54
465	472	30	12.00	1008.00	2026-07-18 02:05:12	2026-07-18 02:05:12
\.


--
-- Data for Name: trade_spots; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trade_spots (id, trade_id, quantity, market_price, exchange_rate, from_coin, to_coin, created_at, updated_at) FROM stdin;
1	6	1.59903802	3127.44000000	0.000319807604	USDT	ETH	2025-12-08 06:14:39	2025-12-08 06:14:39
\.


--
-- Data for Name: trades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trades (id, user_id, symbol, type, direction, amount, entry_price, exit_price, exchange_rate, from_coin, to_coin, status, result, pnl, fee, opened_at, closed_at, closed_by, created_at, updated_at) FROM stdin;
1	5	LTCUSDT	option	buy	100.00	82.33000000	82.31000000	\N	\N	\N	closed	lost	-100.00	2.00	2025-12-07 04:19:16	2025-12-07 04:19:47	\N	2025-12-07 04:19:16	2025-12-07 04:19:47
2	9	LTCUSDT	option	buy	9500.00	82.17000000	82.13000000	\N	\N	\N	closed	won	1900.00	190.00	2025-12-07 04:52:15	2025-12-07 04:53:15	\N	2025-12-07 04:52:15	2025-12-07 04:53:15
3	10	BTCUSDT	option	buy	80000.00	89535.95000000	89553.57000000	\N	\N	\N	closed	won	20000.00	1600.00	2025-12-07 04:59:21	2025-12-07 05:00:51	\N	2025-12-07 04:59:21	2025-12-07 05:00:51
4	12	ETHUSDT	option	buy	80000.00	3127.88000000	3126.77000000	\N	\N	\N	closed	won	20000.00	1600.00	2025-12-08 06:09:31	2025-12-08 06:11:02	\N	2025-12-08 06:09:31	2025-12-08 06:11:02
5	12	ETHUSDT	option	buy	80000.00	3126.76000000	3126.94000000	\N	\N	\N	closed	won	20000.00	1600.00	2025-12-08 06:11:46	2025-12-08 06:13:16	\N	2025-12-08 06:11:46	2025-12-08 06:13:16
6	12	ETHUSDT	spot	buy	5000.00	3127.44000000	3127.44000000	0.00031981	USDT	ETH	closed	\N	0.00	100.00	2025-12-08 06:14:39	2025-12-08 06:14:39	\N	2025-12-08 06:14:39	2025-12-08 06:14:39
7	12	ETHUSDT	contract	buy	5000.00	3129.86000000	3129.86000000	\N	\N	\N	closed	won	0.00	100.00	2025-12-08 06:15:22	2025-12-08 06:15:23	\N	2025-12-08 06:15:22	2025-12-08 06:15:23
8	12	ETHUSDT	option	sell	200000.00	3129.95000000	3127.69000000	\N	\N	\N	closed	won	60000.00	4000.00	2025-12-08 06:16:12	2025-12-08 06:19:13	\N	2025-12-08 06:16:12	2025-12-08 06:19:13
9	12	ETHUSDT	option	buy	4000.00	3126.54000000	3124.79000000	\N	\N	\N	closed	won	600.00	80.00	2025-12-08 06:22:15	2025-12-08 06:22:46	\N	2025-12-08 06:22:15	2025-12-08 06:22:46
10	12	XRPUSDT	option	sell	4900.00	2.07330000	2.07320000	\N	\N	\N	closed	won	735.00	98.00	2025-12-08 06:23:50	2025-12-08 06:24:20	\N	2025-12-08 06:23:50	2025-12-08 06:24:20
11	6	BTCUSDT	option	buy	30000.00	89969.20000000	90056.82000000	\N	\N	\N	closed	won	7500.00	600.00	2025-12-08 19:17:15	2025-12-08 19:18:46	\N	2025-12-08 19:17:15	2025-12-08 19:18:46
12	12	TSLA	option	sell	50000.00	439.58000000	439.58000000	\N	\N	\N	closed	won	12500.00	1000.00	2025-12-09 04:12:21	2025-12-09 04:13:52	\N	2025-12-09 04:12:21	2025-12-09 04:13:52
13	12	ETHUSDT	option	buy	8000.00	3107.55000000	3111.50000000	\N	\N	\N	closed	won	1600.00	160.00	2025-12-09 05:34:32	2025-12-09 05:35:32	\N	2025-12-09 05:34:32	2025-12-09 05:35:32
14	7	ETHUSDT	option	buy	4000.00	3279.81000000	3281.90000000	\N	\N	\N	closed	won	600.00	80.00	2025-12-09 16:22:21	2025-12-09 16:22:52	\N	2025-12-09 16:22:21	2025-12-09 16:22:52
15	9	BTCUSDT	option	buy	15000.00	92432.41000000	92473.97000000	\N	\N	\N	closed	won	3000.00	300.00	2025-12-10 04:10:42	2025-12-10 04:11:43	\N	2025-12-10 04:10:42	2025-12-10 04:11:43
16	12	BTCUSDT	option	buy	80000.00	92521.34000000	92494.89000000	\N	\N	\N	closed	won	20000.00	1600.00	2025-12-10 04:13:10	2025-12-10 04:14:41	\N	2025-12-10 04:13:10	2025-12-10 04:14:41
17	6	BTCUSDT	option	buy	15000.00	92021.13000000	92073.60000000	\N	\N	\N	closed	won	3000.00	300.00	2025-12-11 00:05:54	2025-12-11 00:06:54	\N	2025-12-11 00:05:54	2025-12-11 00:06:54
18	6	BTCUSDT	option	buy	35000.00	92329.77000000	92333.80000000	\N	\N	\N	closed	won	8750.00	700.00	2025-12-12 03:47:38	2025-12-12 03:49:09	\N	2025-12-12 03:47:38	2025-12-12 03:49:09
19	6	BTCUSDT	option	buy	35000.00	92352.66000000	92320.55000000	\N	\N	\N	closed	won	8750.00	700.00	2025-12-12 03:55:01	2025-12-12 03:56:32	\N	2025-12-12 03:55:01	2025-12-12 03:56:32
20	12	BTCUSDT	option	sell	8000.00	90239.03000000	90294.45000000	\N	\N	\N	closed	won	1600.00	160.00	2025-12-13 02:05:26	2025-12-13 02:06:27	\N	2025-12-13 02:05:26	2025-12-13 02:06:27
21	12	BTCUSDT	option	sell	32000.00	90294.99000000	90246.44000000	\N	\N	\N	closed	won	8000.00	640.00	2025-12-13 02:11:16	2025-12-13 02:12:46	\N	2025-12-13 02:11:16	2025-12-13 02:12:46
22	9	BTCUSDT	option	sell	33000.00	90290.45000000	90290.44000000	\N	\N	\N	closed	won	8250.00	660.00	2025-12-13 02:15:27	2025-12-13 02:16:58	\N	2025-12-13 02:15:27	2025-12-13 02:16:58
23	12	GOOGL	option	buy	5500.00	309.29000000	309.29000000	\N	\N	\N	closed	won	1100.00	110.00	2025-12-14 02:10:36	2025-12-14 02:11:37	\N	2025-12-14 02:10:36	2025-12-14 02:11:37
24	4	ETHUSDT	option	buy	5000.00	3113.72000000	3113.83000000	\N	\N	\N	closed	won	750.00	100.00	2025-12-14 07:53:17	2025-12-14 07:53:48	\N	2025-12-14 07:53:17	2025-12-14 07:53:48
25	12	BTCUSDT	option	buy	10000.00	87554.04000000	87545.08000000	\N	\N	\N	closed	won	2000.00	200.00	2025-12-17 02:00:44	2025-12-17 02:01:44	\N	2025-12-17 02:00:44	2025-12-17 02:01:44
26	12	BTCUSDT	option	buy	4000.00	87579.18000000	87574.00000000	\N	\N	\N	closed	won	600.00	80.00	2025-12-17 02:02:47	2025-12-17 02:03:17	\N	2025-12-17 02:02:47	2025-12-17 02:03:17
27	6	BTCUSDT	option	buy	40000.00	86816.31000000	86746.00000000	\N	\N	\N	closed	won	10000.00	800.00	2025-12-17 07:10:06	2025-12-17 07:11:36	\N	2025-12-17 07:10:06	2025-12-17 07:11:36
28	12	NFLX	option	buy	40000.00	95.44510000	95.37000000	\N	\N	\N	closed	won	10000.00	800.00	2025-12-17 18:53:08	2025-12-17 18:54:38	\N	2025-12-17 18:53:08	2025-12-17 18:54:38
29	5	BTCUSDT	option	buy	110000.00	85568.93000000	85556.90000000	\N	\N	\N	closed	won	33000.00	2200.00	2025-12-18 23:13:50	2025-12-18 23:16:51	\N	2025-12-18 23:13:50	2025-12-18 23:16:51
30	12	ETHUSDT	option	sell	200000.00	2820.82000000	2821.90000000	\N	\N	\N	closed	won	60000.00	4000.00	2025-12-19 01:41:41	2025-12-19 01:44:42	\N	2025-12-19 01:41:41	2025-12-19 01:44:42
31	20	ETHUSDT	option	buy	1000.00	2989.15000000	2988.78000000	\N	\N	\N	closed	won	150.00	20.00	2025-12-20 03:54:18	2025-12-20 03:54:48	\N	2025-12-20 03:54:18	2025-12-20 03:54:48
32	18	BTCUSDT	contract	buy	500.00	88290.85000000	88290.86000000	\N	\N	\N	closed	won	0.00	10.00	2025-12-21 18:46:23	2025-12-21 18:46:23	\N	2025-12-21 18:46:23	2025-12-21 18:46:23
33	20	BTCUSDT	option	buy	1000.00	88705.30000000	88700.00000000	\N	\N	\N	closed	won	120.00	20.00	2025-12-22 01:03:15	2025-12-22 01:03:46	\N	2025-12-22 01:03:15	2025-12-22 01:03:46
34	12	BTCUSDT	option	buy	20000.00	88412.00000000	88400.01000000	\N	\N	\N	closed	won	3000.00	400.00	2025-12-22 02:33:30	2025-12-22 02:34:31	\N	2025-12-22 02:33:30	2025-12-22 02:34:31
35	9	BTCUSDT	option	sell	20000.00	88493.29000000	88480.00000000	\N	\N	\N	closed	won	3000.00	400.00	2025-12-22 02:36:47	2025-12-22 02:37:47	\N	2025-12-22 02:36:47	2025-12-22 02:37:47
36	22	BTCUSDT	option	buy	10000.00	88583.25000000	88600.00000000	\N	\N	\N	closed	won	1200.00	200.00	2025-12-26 08:12:51	2025-12-26 08:13:21	\N	2025-12-26 08:12:51	2025-12-26 08:13:21
37	22	BTCUSDT	option	buy	10000.00	88768.88000000	88738.01000000	\N	\N	\N	closed	won	1200.00	200.00	2025-12-26 08:28:15	2025-12-26 08:28:46	\N	2025-12-26 08:28:15	2025-12-26 08:28:46
38	22	BTCUSDT	option	buy	10001.00	88626.78000000	88634.76000000	\N	\N	\N	closed	won	1500.15	200.02	2025-12-26 08:42:34	2025-12-26 08:43:34	\N	2025-12-26 08:42:34	2025-12-26 08:43:34
39	23	BTCUSDT	option	buy	1800.00	87623.53000000	87614.80000000	\N	\N	\N	closed	won	216.00	36.00	2025-12-28 05:25:17	2025-12-28 05:25:47	\N	2025-12-28 05:25:17	2025-12-28 05:25:47
40	23	BTCUSDT	option	buy	2000.00	87652.33000000	87664.62000000	\N	\N	\N	closed	won	240.00	40.00	2025-12-28 05:34:57	2025-12-28 05:35:28	\N	2025-12-28 05:34:57	2025-12-28 05:35:28
41	12	BTCUSDT	option	buy	45000.00	87664.62000000	87664.62000000	\N	\N	\N	closed	won	8100.00	900.00	2025-12-28 05:35:43	2025-12-28 05:37:14	\N	2025-12-28 05:35:43	2025-12-28 05:37:14
42	6	BTCUSDT	option	buy	60000.00	87230.74000000	87248.07000000	\N	\N	\N	closed	won	10800.00	1200.00	2025-12-30 00:53:58	2025-12-30 00:55:29	\N	2025-12-30 00:53:58	2025-12-30 00:55:29
43	23	BTCUSDT	option	sell	2900.00	87350.13000000	87361.00000000	\N	\N	\N	closed	won	348.00	58.00	2025-12-30 04:51:18	2025-12-30 04:51:49	\N	2025-12-30 04:51:18	2025-12-30 04:51:49
44	9	BTCUSDT	option	buy	19000.00	88560.02000000	88582.00000000	\N	\N	\N	closed	lost	-19000.00	380.00	2025-12-31 03:22:18	2025-12-31 03:23:19	\N	2025-12-31 03:22:18	2025-12-31 03:23:19
45	9	BTCUSDT	option	buy	45000.00	88512.36000000	88512.57000000	\N	\N	\N	closed	won	8100.00	900.00	2025-12-31 03:31:00	2025-12-31 03:32:31	\N	2025-12-31 03:31:00	2025-12-31 03:32:31
46	9	BTCUSDT	option	buy	60000.00	88425.93000000	88428.43000000	\N	\N	\N	closed	won	10800.00	1200.00	2025-12-31 03:36:18	2025-12-31 03:37:48	\N	2025-12-31 03:36:18	2025-12-31 03:37:48
47	9	BTCUSDT	option	sell	69000.00	87929.71000000	87915.89000000	\N	\N	\N	closed	won	12420.00	1380.00	2026-01-01 03:30:48	2026-01-01 03:32:19	\N	2026-01-01 03:30:48	2026-01-01 03:32:19
48	24	BTCUSDT	option	buy	6000.00	87859.71000000	87859.71000000	\N	\N	\N	closed	lost	-6000.00	120.00	2026-01-01 03:58:25	2026-01-01 03:58:56	\N	2026-01-01 03:58:25	2026-01-01 03:58:56
49	23	BTCUSDT	option	buy	6500.00	87830.71000000	87815.04000000	\N	\N	\N	closed	won	780.00	130.00	2026-01-01 04:03:41	2026-01-01 04:04:12	\N	2026-01-01 04:03:41	2026-01-01 04:04:12
50	25	BTCUSDT	option	buy	15000.00	87632.26000000	87632.25000000	\N	\N	\N	closed	won	2250.00	300.00	2026-01-01 04:28:43	2026-01-01 04:29:44	\N	2026-01-01 04:28:43	2026-01-01 04:29:44
51	25	BTCUSDT	option	buy	85000.00	87619.36000000	87595.34000000	\N	\N	\N	closed	won	18700.00	1700.00	2026-01-01 04:36:07	2026-01-01 04:39:07	\N	2026-01-01 04:36:07	2026-01-01 04:39:07
52	10	BTCUSDT	option	buy	14566.00	89104.10000000	89133.39000000	\N	\N	\N	closed	won	2184.90	291.32	2026-01-02 08:56:03	2026-01-02 08:57:04	\N	2026-01-02 08:56:03	2026-01-02 08:57:04
53	10	BTCUSDT	option	buy	65000.00	89344.01000000	89341.56000000	\N	\N	\N	closed	lost	-65000.00	1300.00	2026-01-02 15:07:28	2026-01-02 15:08:59	\N	2026-01-02 15:07:28	2026-01-02 15:08:59
55	10	BTCUSDT	option	buy	69000.00	89200.01000000	89244.94000000	\N	\N	\N	closed	won	12420.00	1380.00	2026-01-02 15:10:53	2026-01-02 15:12:23	\N	2026-01-02 15:10:53	2026-01-02 15:12:23
54	10	BTCUSDT	option	buy	80000.00	89391.20000000	89109.32000000	\N	\N	\N	closed	won	17600.00	1600.00	2026-01-02 15:10:05	2026-01-02 15:13:05	\N	2026-01-02 15:10:05	2026-01-02 15:13:05
57	10	BTCUSDT	option	buy	10000.00	90258.10000000	90317.08000000	\N	\N	\N	closed	won	1200.00	200.00	2026-01-02 18:14:08	2026-01-02 18:14:39	\N	2026-01-02 18:14:08	2026-01-02 18:14:39
56	9	BTCUSDT	option	buy	100000.00	90250.00000000	90353.26000000	\N	\N	\N	closed	won	22000.00	2000.00	2026-01-02 18:12:20	2026-01-02 18:15:21	\N	2026-01-02 18:12:20	2026-01-02 18:15:21
58	10	BTCUSDT	option	buy	100000.00	90387.88000000	90435.83000000	\N	\N	\N	closed	won	22000.00	2000.00	2026-01-02 18:18:00	2026-01-02 18:21:01	\N	2026-01-02 18:18:00	2026-01-02 18:21:01
59	25	BTCUSDT	option	buy	70000.00	90079.96000000	90093.07000000	\N	\N	\N	closed	won	12600.00	1400.00	2026-01-03 01:29:51	2026-01-03 01:31:22	\N	2026-01-03 01:29:51	2026-01-03 01:31:22
60	25	BTCUSDT	option	buy	70000.00	90180.59000000	90203.17000000	\N	\N	\N	closed	won	12600.00	1400.00	2026-01-03 01:46:17	2026-01-03 01:47:47	\N	2026-01-03 01:46:17	2026-01-03 01:47:47
61	25	BTCUSDT	option	buy	50000.00	94222.76000000	94140.50000000	\N	\N	\N	closed	won	9000.00	1000.00	2026-01-05 18:48:38	2026-01-05 18:50:08	\N	2026-01-05 18:48:38	2026-01-05 18:50:08
62	23	BTCUSDT	option	buy	9500.00	93741.89000000	93736.30000000	\N	\N	\N	closed	won	1140.00	190.00	2026-01-06 03:08:36	2026-01-06 03:09:07	\N	2026-01-06 03:08:36	2026-01-06 03:09:07
63	23	BTCUSDT	option	buy	10000.00	93757.13000000	93753.90000000	\N	\N	\N	closed	won	1200.00	200.00	2026-01-06 03:24:13	2026-01-06 03:24:43	\N	2026-01-06 03:24:13	2026-01-06 03:24:43
64	4	META	option	buy	100.00	658.79000000	658.79000000	\N	\N	\N	closed	lost	-100.00	2.00	2026-01-06 09:31:12	2026-01-06 09:31:43	\N	2026-01-06 09:31:12	2026-01-06 09:31:43
65	12	XAUUSD	option	buy	5000.00	4402.69709224	4402.69709224	\N	\N	\N	closed	won	600.00	100.00	2026-01-06 16:48:22	2026-01-06 16:48:52	\N	2026-01-06 16:48:22	2026-01-06 16:48:52
66	25	XAUUSD	option	buy	10000.00	4402.69709224	4402.69709224	\N	\N	\N	closed	won	1200.00	200.00	2026-01-06 16:52:17	2026-01-06 16:52:47	\N	2026-01-06 16:52:17	2026-01-06 16:52:47
67	12	XPDUSD	option	buy	100.00	1729.75486260	1729.75486260	\N	\N	\N	closed	won	12.00	2.00	2026-01-07 15:58:52	2026-01-07 15:59:22	\N	2026-01-07 15:58:52	2026-01-07 15:59:22
68	12	XAUUSD	option	buy	500.00	4472.22791189	4472.22791189	\N	\N	\N	closed	won	60.00	10.00	2026-01-08 17:21:34	2026-01-08 17:22:04	\N	2026-01-08 17:21:34	2026-01-08 17:22:04
69	18	BTCUSDT	option	buy	1000.00	90526.46000000	90526.46000000	\N	\N	\N	closed	won	120.00	20.00	2026-01-10 06:29:05	2026-01-10 06:29:36	\N	2026-01-10 06:29:05	2026-01-10 06:29:36
70	18	BTCUSDT	option	buy	1200.00	90532.73000000	90532.73000000	\N	\N	\N	closed	won	144.00	24.00	2026-01-10 06:35:59	2026-01-10 06:36:30	\N	2026-01-10 06:35:59	2026-01-10 06:36:30
71	18	BTCUSDT	option	buy	1300.00	90540.80000000	90540.80000000	\N	\N	\N	closed	won	156.00	26.00	2026-01-10 06:41:33	2026-01-10 06:42:04	\N	2026-01-10 06:41:33	2026-01-10 06:42:04
72	12	BTCUSDT	option	buy	200001.00	91836.06000000	91772.83000000	\N	\N	\N	closed	won	64000.32	4000.02	2026-01-12 19:33:30	2026-01-12 19:45:11	\N	2026-01-12 19:33:30	2026-01-12 19:45:11
73	23	BTCUSDT	option	buy	19000.00	91150.08000000	91118.29000000	\N	\N	\N	closed	won	2850.00	380.00	2026-01-13 03:08:26	2026-01-13 03:09:27	\N	2026-01-13 03:08:26	2026-01-13 03:09:27
74	23	BTCUSDT	option	buy	21000.00	91275.46000000	91295.29000000	\N	\N	\N	closed	won	3150.00	420.00	2026-01-13 03:16:05	2026-01-13 03:17:06	\N	2026-01-13 03:16:05	2026-01-13 03:17:06
75	9	BTCUSDT	option	sell	29000.00	91412.07000000	91401.88000000	\N	\N	\N	closed	won	4350.00	580.00	2026-01-13 03:26:42	2026-01-13 03:27:43	\N	2026-01-13 03:26:42	2026-01-13 03:27:43
76	12	BTCUSDT	option	buy	250000.00	93318.40000000	93431.22000000	\N	\N	\N	closed	won	80000.00	5000.00	2026-01-13 17:13:03	2026-01-13 17:24:44	\N	2026-01-13 17:13:03	2026-01-13 17:24:44
77	12	BTCUSDT	option	buy	250000.00	95151.50000000	95028.00000000	\N	\N	\N	closed	won	80000.00	5000.00	2026-01-14 05:13:31	2026-01-14 05:25:12	\N	2026-01-14 05:13:31	2026-01-14 05:25:12
78	25	ETHUSDT	option	buy	35000.00	3309.57000000	3311.46000000	\N	\N	\N	closed	won	6300.00	700.00	2026-01-15 05:42:31	2026-01-15 05:44:01	\N	2026-01-15 05:42:31	2026-01-15 05:44:01
79	31	BTCUSDT	option	buy	30000.00	96582.20000000	96619.92000000	\N	\N	\N	closed	won	4500.00	600.00	2026-01-15 18:06:04	2026-01-15 18:07:04	\N	2026-01-15 18:06:04	2026-01-15 18:07:04
80	31	TSLA	option	buy	20000.00	438.90000000	438.90000000	\N	\N	\N	closed	won	3000.00	400.00	2026-01-15 20:40:05	2026-01-15 20:41:06	\N	2026-01-15 20:40:05	2026-01-15 20:41:06
81	31	BTCUSDT	option	buy	30000.00	95741.22000000	95724.15000000	\N	\N	\N	closed	won	4500.00	600.00	2026-01-16 07:00:51	2026-01-16 07:01:52	\N	2026-01-16 07:00:51	2026-01-16 07:01:52
82	20	ETHUSDT	option	buy	2500.00	3281.31000000	3280.93000000	\N	\N	\N	closed	won	300.00	50.00	2026-01-16 18:52:24	2026-01-16 18:52:55	\N	2026-01-16 18:52:24	2026-01-16 18:52:55
83	12	BTCUSDT	option	buy	45000.00	95063.74000000	95093.29000000	\N	\N	\N	closed	won	8100.00	900.00	2026-01-16 18:53:18	2026-01-16 18:54:48	\N	2026-01-16 18:53:18	2026-01-16 18:54:48
84	12	ETHUSDT	option	buy	45000.00	3281.31000000	3282.06000000	\N	\N	\N	closed	won	8100.00	900.00	2026-01-16 18:53:35	2026-01-16 18:55:05	\N	2026-01-16 18:53:35	2026-01-16 18:55:05
85	20	BTCUSDT	option	buy	2850.00	94952.65000000	94993.59000000	\N	\N	\N	closed	won	342.00	57.00	2026-01-16 19:01:25	2026-01-16 19:01:56	\N	2026-01-16 19:01:25	2026-01-16 19:01:56
86	12	BTCUSDT	option	buy	11000.00	94892.30000000	94945.02000000	\N	\N	\N	closed	won	1650.00	220.00	2026-01-16 19:18:47	2026-01-16 19:19:48	\N	2026-01-16 19:18:47	2026-01-16 19:19:48
87	25	XAUUSD	option	buy	60000.00	4589.69292659	4589.69292659	\N	\N	\N	closed	won	10800.00	1200.00	2026-01-16 19:25:59	2026-01-16 19:27:29	\N	2026-01-16 19:25:59	2026-01-16 19:27:29
88	20	BTCUSDT	option	buy	5100.00	95032.40000000	95032.40000000	\N	\N	\N	closed	won	612.00	102.00	2026-01-18 02:25:24	2026-01-18 02:25:55	\N	2026-01-18 02:25:24	2026-01-18 02:25:55
89	36	BTCUSDT	option	buy	50000.00	92816.76000000	92824.24000000	\N	\N	\N	closed	won	9000.00	1000.00	2026-01-19 14:57:28	2026-01-19 14:58:59	\N	2026-01-19 14:57:28	2026-01-19 14:58:59
90	31	BTCUSDT	option	buy	42000.00	92818.04000000	92818.96000000	\N	\N	\N	closed	won	7560.00	840.00	2026-01-20 01:52:39	2026-01-20 01:54:10	\N	2026-01-20 01:52:39	2026-01-20 01:54:10
91	35	BTCUSDT	option	buy	500.00	87978.70000000	87881.45000000	\N	\N	\N	closed	won	60.00	10.00	2026-01-21 17:44:52	2026-01-21 17:45:23	\N	2026-01-21 17:44:52	2026-01-21 17:45:23
92	12	BTCUSDT	option	buy	30001.00	87945.53000000	87990.78000000	\N	\N	\N	closed	won	5400.18	600.02	2026-01-21 17:45:56	2026-01-21 17:47:26	\N	2026-01-21 17:45:56	2026-01-21 17:47:26
93	36	BTCUSDT	option	buy	30000.00	87658.67000000	87651.07000000	\N	\N	\N	closed	won	4500.00	600.00	2026-01-21 18:03:34	2026-01-21 18:04:35	\N	2026-01-21 18:03:34	2026-01-21 18:04:35
94	25	XAUUSD	option	buy	75000.00	4831.76751854	4831.76751854	\N	\N	\N	closed	won	16500.00	1500.00	2026-01-21 23:05:23	2026-01-21 23:08:23	\N	2026-01-21 23:05:23	2026-01-21 23:08:23
95	23	BTCUSDT	option	sell	24000.00	90010.61000000	90017.97000000	\N	\N	\N	closed	won	3600.00	480.00	2026-01-22 04:46:34	2026-01-22 04:47:34	\N	2026-01-22 04:46:34	2026-01-22 04:47:34
96	9	BTCUSDT	option	sell	150000.00	89438.82000000	89318.02000000	\N	\N	\N	closed	won	39000.00	3000.00	2026-01-22 18:52:33	2026-01-22 18:57:33	\N	2026-01-22 18:52:33	2026-01-22 18:57:33
97	12	BTCUSDT	option	sell	155000.00	89165.91000000	89280.01000000	\N	\N	\N	closed	won	40300.00	3100.00	2026-01-22 19:03:08	2026-01-22 19:08:09	\N	2026-01-22 19:03:08	2026-01-22 19:08:09
98	31	BTCUSDT	option	sell	26540.00	89676.81000000	89665.40000000	\N	\N	\N	closed	won	3981.00	530.80	2026-01-23 02:57:48	2026-01-23 02:58:49	\N	2026-01-23 02:57:48	2026-01-23 02:58:49
99	31	BTCUSDT	option	buy	48452.00	89861.03000000	89853.78000000	\N	\N	\N	closed	won	8721.36	969.04	2026-01-23 03:39:30	2026-01-23 03:41:01	\N	2026-01-23 03:39:30	2026-01-23 03:41:01
100	31	BTCUSDT	option	buy	42556.00	89853.79000000	89888.76000000	\N	\N	\N	closed	won	7660.08	851.12	2026-01-23 03:41:25	2026-01-23 03:42:56	\N	2026-01-23 03:41:25	2026-01-23 03:42:56
101	25	BTCUSDT	option	buy	50000.00	89516.57000000	89501.38000000	\N	\N	\N	closed	won	9000.00	1000.00	2026-01-23 07:09:00	2026-01-23 07:10:31	\N	2026-01-23 07:09:00	2026-01-23 07:10:31
102	25	XAUUSD	option	buy	70001.00	4980.89577426	4980.89577426	\N	\N	\N	closed	won	15400.22	1400.02	2026-01-23 21:04:49	2026-01-23 21:07:49	\N	2026-01-23 21:04:49	2026-01-23 21:07:49
103	25	XAUUSD	option	buy	80000.00	4980.89577426	4980.89577426	\N	\N	\N	closed	won	17600.00	1600.00	2026-01-23 21:05:21	2026-01-23 21:08:21	\N	2026-01-23 21:05:21	2026-01-23 21:08:21
104	31	BTCUSDT	option	buy	28790.00	87651.08000000	87719.59000000	\N	\N	\N	closed	won	4318.50	575.80	2026-01-26 01:44:07	2026-01-26 01:45:08	\N	2026-01-26 01:44:07	2026-01-26 01:45:08
105	31	BTCUSDT	option	buy	28694.00	87542.19000000	87576.38000000	\N	\N	\N	closed	won	4304.10	573.88	2026-01-26 01:50:03	2026-01-26 01:51:03	\N	2026-01-26 01:50:03	2026-01-26 01:51:03
106	42	BTCUSDT	option	sell	360.00	87304.34000000	87275.45000000	\N	\N	\N	closed	won	43.20	7.20	2026-01-26 03:50:46	2026-01-26 03:51:16	\N	2026-01-26 03:50:46	2026-01-26 03:51:16
107	9	BTCUSDT	option	sell	70001.00	87859.46000000	87898.32000000	\N	\N	\N	closed	won	15400.22	1400.02	2026-01-26 04:29:43	2026-01-26 04:32:43	\N	2026-01-26 04:29:43	2026-01-26 04:32:43
108	41	XAUUSD	option	buy	20000.00	5094.07742183	5094.07742183	\N	\N	\N	closed	won	3000.00	400.00	2026-01-27 19:29:31	2026-01-27 19:30:31	\N	2026-01-27 19:29:31	2026-01-27 19:30:31
109	38	XAUUSD	option	buy	4900.00	5094.03849769	5094.03849769	\N	\N	\N	closed	won	588.00	98.00	2026-01-27 20:13:17	2026-01-27 20:13:47	\N	2026-01-27 20:13:17	2026-01-27 20:13:47
110	9	BTCUSDT	option	buy	200000.00	89492.11000000	89482.59000000	\N	\N	\N	closed	won	52000.00	4000.00	2026-01-27 23:33:18	2026-01-27 23:38:19	\N	2026-01-27 23:33:18	2026-01-27 23:38:19
111	31	BTCUSDT	option	buy	42560.00	89200.00000000	89156.46000000	\N	\N	\N	closed	won	7660.80	851.20	2026-01-28 03:09:25	2026-01-28 03:10:56	\N	2026-01-28 03:09:25	2026-01-28 03:10:56
112	31	BTCUSDT	option	sell	58962.00	89090.73000000	89080.81000000	\N	\N	\N	closed	won	10613.16	1179.24	2026-01-28 03:13:36	2026-01-28 03:15:06	\N	2026-01-28 03:13:36	2026-01-28 03:15:06
113	10	BTCUSDT	option	sell	10000.00	88861.14000000	88840.01000000	\N	\N	\N	closed	won	1200.00	200.00	2026-01-28 04:26:08	2026-01-28 04:26:39	\N	2026-01-28 04:26:08	2026-01-28 04:26:39
114	20	BTCUSDT	option	buy	5600.00	89138.29000000	89101.94000000	\N	\N	\N	closed	won	672.00	112.00	2026-01-29 01:03:32	2026-01-29 01:04:02	\N	2026-01-29 01:03:32	2026-01-29 01:04:02
115	12	BTCUSDT	option	buy	60000.00	89135.02000000	89084.01000000	\N	\N	\N	closed	won	10800.00	1200.00	2026-01-29 01:04:40	2026-01-29 01:06:11	\N	2026-01-29 01:04:40	2026-01-29 01:06:11
116	44	BTCUSDT	option	sell	200.00	88769.60000000	88702.85000000	\N	\N	\N	closed	won	24.00	4.00	2026-01-29 01:26:37	2026-01-29 01:27:08	\N	2026-01-29 01:26:37	2026-01-29 01:27:08
117	12	BTCUSDT	option	sell	20000.00	88703.28000000	88813.18000000	\N	\N	\N	closed	won	3000.00	400.00	2026-01-29 01:28:11	2026-01-29 01:29:12	\N	2026-01-29 01:28:11	2026-01-29 01:29:12
118	38	XAUUSD	option	buy	9000.00	5377.56704885	5377.56704885	\N	\N	\N	closed	lost	-9000.00	180.00	2026-01-30 01:34:32	2026-01-30 01:35:02	\N	2026-01-30 01:34:32	2026-01-30 01:35:02
119	38	XAUUSD	option	buy	900.00	5356.72866723	5356.72866723	\N	\N	\N	closed	won	108.00	18.00	2026-01-30 01:51:58	2026-01-30 01:52:28	\N	2026-01-30 01:51:58	2026-01-30 01:52:28
120	38	XAUUSD	option	buy	980.00	5356.72866723	5356.72866723	\N	\N	\N	closed	won	117.60	19.60	2026-01-30 01:54:18	2026-01-30 01:54:48	\N	2026-01-30 01:54:18	2026-01-30 01:54:48
121	38	XAUUSD	option	buy	1100.00	5356.72866723	5356.72866723	\N	\N	\N	closed	won	132.00	22.00	2026-01-30 01:56:10	2026-01-30 01:56:40	\N	2026-01-30 01:56:10	2026-01-30 01:56:40
122	44	BTCUSDT	option	sell	2500.00	82460.02000000	82459.67000000	\N	\N	\N	closed	won	300.00	50.00	2026-01-30 01:59:53	2026-01-30 02:00:24	\N	2026-01-30 01:59:53	2026-01-30 02:00:24
123	23	BTCUSDT	option	sell	75000.00	82391.43000000	82441.88000000	\N	\N	\N	closed	won	16500.00	1500.00	2026-01-30 02:01:04	2026-01-30 02:04:04	\N	2026-01-30 02:01:04	2026-01-30 02:04:04
124	38	XAUUSD	option	buy	6000.00	5268.10714276	5268.10714276	\N	\N	\N	closed	won	720.00	120.00	2026-01-30 02:36:35	2026-01-30 02:37:05	\N	2026-01-30 02:36:35	2026-01-30 02:37:05
125	38	BTCUSDT	option	sell	6700.00	81926.99000000	81910.86000000	\N	\N	\N	closed	won	804.00	134.00	2026-01-30 02:50:23	2026-01-30 02:50:54	\N	2026-01-30 02:50:23	2026-01-30 02:50:54
126	10	XAUUSD	option	buy	10001.00	5099.43386085	5099.43386085	\N	\N	\N	closed	won	1500.15	200.02	2026-01-30 15:12:05	2026-01-30 15:13:05	\N	2026-01-30 15:12:05	2026-01-30 15:13:05
127	38	XAUUSD	option	buy	7350.00	4757.71344292	4757.71344292	\N	\N	\N	closed	won	882.00	147.00	2026-01-30 18:52:07	2026-01-30 18:52:38	\N	2026-01-30 18:52:07	2026-01-30 18:52:38
128	38	XAUUSD	option	buy	8000.00	4757.71344292	4757.71344292	\N	\N	\N	closed	won	960.00	160.00	2026-01-30 18:56:17	2026-01-30 18:56:47	\N	2026-01-30 18:56:17	2026-01-30 18:56:47
129	12	BTCUSDT	option	buy	10000.00	84150.00000000	84200.00000000	\N	\N	\N	closed	won	1200.00	200.00	2026-01-30 21:47:57	2026-01-30 21:48:28	\N	2026-01-30 21:47:57	2026-01-30 21:48:28
130	12	BTCUSDT	option	buy	15000.00	84199.99000000	84318.00000000	\N	\N	\N	closed	won	2250.00	300.00	2026-01-30 21:48:28	2026-01-30 21:49:29	\N	2026-01-30 21:48:28	2026-01-30 21:49:29
131	12	BTCUSDT	option	buy	30001.00	84285.99000000	84261.42000000	\N	\N	\N	closed	won	5400.18	600.02	2026-01-30 21:49:13	2026-01-30 21:50:44	\N	2026-01-30 21:49:13	2026-01-30 21:50:44
132	12	BTCUSDT	option	buy	70001.00	84327.99000000	84286.00000000	\N	\N	\N	closed	won	15400.22	1400.02	2026-01-30 21:49:47	2026-01-30 21:52:47	\N	2026-01-30 21:49:47	2026-01-30 21:52:47
133	12	BTCUSDT	option	buy	200001.00	84327.05000000	84049.58000000	\N	\N	\N	closed	won	64000.32	4000.02	2026-01-30 22:02:27	2026-01-30 22:14:08	\N	2026-01-30 22:02:27	2026-01-30 22:14:08
134	9	BTCUSDT	option	sell	200000.00	78939.09000000	79196.03000000	\N	\N	\N	closed	won	52000.00	4000.00	2026-01-31 17:22:44	2026-01-31 17:27:45	\N	2026-01-31 17:22:44	2026-01-31 17:27:45
135	32	BTCUSDT	option	buy	12000.00	78951.52000000	78841.15000000	\N	\N	\N	closed	won	1800.00	240.00	2026-01-31 17:46:21	2026-01-31 17:47:22	\N	2026-01-31 17:46:21	2026-01-31 17:47:22
136	44	BTCUSDT	option	sell	2800.00	78000.00000000	78146.02000000	\N	\N	\N	closed	won	336.00	56.00	2026-01-31 19:26:38	2026-01-31 19:27:09	\N	2026-01-31 19:26:38	2026-01-31 19:27:09
137	44	BTCUSDT	option	sell	2500.00	77968.98000000	77962.94000000	\N	\N	\N	closed	won	300.00	50.00	2026-01-31 19:29:04	2026-01-31 19:29:35	\N	2026-01-31 19:29:04	2026-01-31 19:29:35
138	44	BTCUSDT	option	sell	3000.00	77800.01000000	77802.53000000	\N	\N	\N	closed	lost	-3000.00	60.00	2026-01-31 19:31:30	2026-01-31 19:32:00	\N	2026-01-31 19:31:30	2026-01-31 19:32:00
139	23	BTCUSDT	option	sell	70000.00	77615.51000000	77707.29000000	\N	\N	\N	closed	won	12600.00	1400.00	2026-02-01 16:25:46	2026-02-01 16:27:17	\N	2026-02-01 16:25:46	2026-02-01 16:27:17
140	31	BTCUSDT	option	buy	38560.00	77219.17000000	77326.05000000	\N	\N	\N	closed	won	6940.80	771.20	2026-02-01 16:53:23	2026-02-01 16:54:54	\N	2026-02-01 16:53:23	2026-02-01 16:54:54
141	23	BTCUSDT	option	sell	25000.00	78580.25000000	78602.40000000	\N	\N	\N	closed	won	3750.00	500.00	2026-02-02 18:46:42	2026-02-02 18:47:42	\N	2026-02-02 18:46:42	2026-02-02 18:47:42
142	9	BTCUSDT	option	sell	200000.00	77922.01000000	78293.19000000	\N	\N	\N	closed	won	52000.00	4000.00	2026-02-02 21:00:31	2026-02-02 21:05:32	\N	2026-02-02 21:00:31	2026-02-02 21:05:32
143	44	BTCUSDT	option	sell	3000.00	77691.37000000	77685.09000000	\N	\N	\N	closed	won	360.00	60.00	2026-02-03 03:03:45	2026-02-03 03:04:16	\N	2026-02-03 03:03:45	2026-02-03 03:04:16
144	9	BTCUSDT	option	sell	475000.00	73885.68000000	73458.89000000	\N	\N	\N	closed	won	152000.00	9500.00	2026-02-03 18:44:05	2026-02-03 18:55:45	\N	2026-02-03 18:44:05	2026-02-03 18:55:45
145	38	XAUUSD	option	sell	8500.00	4898.41663581	4898.41663581	\N	\N	\N	closed	won	1020.00	170.00	2026-02-03 19:02:06	2026-02-03 19:02:36	\N	2026-02-03 19:02:06	2026-02-03 19:02:36
146	38	XAUUSD	option	sell	9500.00	4898.41663581	4898.41663581	\N	\N	\N	closed	won	1140.00	190.00	2026-02-03 19:07:28	2026-02-03 19:07:58	\N	2026-02-03 19:07:28	2026-02-03 19:07:58
147	12	XAUUSD	option	buy	90000.00	4898.41663581	4898.41663581	\N	\N	\N	closed	won	19800.00	1800.00	2026-02-03 19:11:53	2026-02-03 19:14:53	\N	2026-02-03 19:11:53	2026-02-03 19:14:53
148	12	BTCUSDT	option	buy	20000.00	72650.72000000	72677.79000000	\N	\N	\N	closed	won	3000.00	400.00	2026-02-04 22:19:15	2026-02-04 22:20:16	\N	2026-02-04 22:19:15	2026-02-04 22:20:16
149	49	BTCUSDT	option	buy	950.00	71108.82000000	71134.21000000	\N	\N	\N	closed	won	114.00	19.00	2026-02-05 04:04:00	2026-02-05 04:04:31	\N	2026-02-05 04:04:00	2026-02-05 04:04:31
150	49	BTCUSDT	option	buy	1050.00	65608.80000000	65597.80000000	\N	\N	\N	closed	won	126.00	21.00	2026-02-05 18:28:05	2026-02-05 18:28:35	\N	2026-02-05 18:28:05	2026-02-05 18:28:35
151	31	BTCUSDT	option	sell	36842.00	65570.75000000	65722.43000000	\N	\N	\N	closed	won	6631.56	736.84	2026-02-05 18:39:05	2026-02-05 18:40:36	\N	2026-02-05 18:39:05	2026-02-05 18:40:36
152	12	BTCUSDT	option	buy	10000.00	65903.04000000	65843.80000000	\N	\N	\N	closed	won	1200.00	200.00	2026-02-05 18:41:39	2026-02-05 18:42:10	\N	2026-02-05 18:41:39	2026-02-05 18:42:10
153	38	XAUUSD	option	sell	10500.00	4774.95174911	4774.95174911	\N	\N	\N	closed	won	1575.00	210.00	2026-02-05 23:33:56	2026-02-05 23:34:57	\N	2026-02-05 23:33:56	2026-02-05 23:34:57
154	38	XAUUSD	option	sell	12000.00	4774.95174911	4774.95174911	\N	\N	\N	closed	won	1800.00	240.00	2026-02-05 23:38:12	2026-02-05 23:39:12	\N	2026-02-05 23:38:12	2026-02-05 23:39:12
156	12	BTCUSDT	option	buy	200000.00	65762.55000000	65272.96000000	\N	\N	\N	closed	won	52000.00	4000.00	2026-02-06 02:02:32	2026-02-06 02:07:33	\N	2026-02-06 02:02:32	2026-02-06 02:07:33
157	12	BTCUSDT	option	sell	200000.00	65432.95000000	65139.99000000	\N	\N	\N	closed	won	52000.00	4000.00	2026-02-06 02:05:33	2026-02-06 02:10:33	\N	2026-02-06 02:05:33	2026-02-06 02:10:33
155	12	BTCUSDT	option	sell	300000.00	65673.47000000	64945.63000000	\N	\N	\N	closed	won	96000.00	6000.00	2026-02-06 02:00:29	2026-02-06 02:12:10	\N	2026-02-06 02:00:29	2026-02-06 02:12:10
158	31	BTCUSDT	option	buy	33496.00	69525.57000000	69536.15000000	\N	\N	\N	closed	won	6029.28	669.92	2026-02-06 18:30:08	2026-02-06 18:31:39	\N	2026-02-06 18:30:08	2026-02-06 18:31:39
159	36	BTCUSDT	option	buy	30000.00	70632.70000000	70629.36000000	\N	\N	\N	closed	won	4500.00	600.00	2026-02-08 21:55:47	2026-02-08 21:56:47	\N	2026-02-08 21:55:47	2026-02-08 21:56:47
160	36	BTCUSDT	option	buy	70000.00	70629.36000000	70660.00000000	\N	\N	\N	closed	won	12600.00	1400.00	2026-02-08 21:56:52	2026-02-08 21:58:23	\N	2026-02-08 21:56:52	2026-02-08 21:58:23
161	9	BTCUSDT	option	buy	70000.00	70691.70000000	70744.71000000	\N	\N	\N	closed	won	12600.00	1400.00	2026-02-09 03:03:22	2026-02-09 03:04:53	\N	2026-02-09 03:03:22	2026-02-09 03:04:53
162	41	BTCUSDT	option	buy	30000.00	68754.98000000	68562.83000000	\N	\N	\N	closed	won	4500.00	600.00	2026-02-09 14:34:35	2026-02-09 14:35:36	\N	2026-02-09 14:34:35	2026-02-09 14:35:36
163	47	BTCUSDT	option	sell	10800.00	69499.99000000	69585.99000000	\N	\N	\N	closed	won	1620.00	216.00	2026-02-09 16:27:59	2026-02-09 16:29:00	\N	2026-02-09 16:27:59	2026-02-09 16:29:00
164	12	XAUUSD	option	buy	25000.00	5030.60873887	5030.60873887	\N	\N	\N	closed	won	3750.00	500.00	2026-02-10 01:30:26	2026-02-10 01:31:27	\N	2026-02-10 01:30:26	2026-02-10 01:31:27
165	36	BTCUSDT	option	buy	68129.00	68856.19000000	68846.05000000	\N	\N	\N	closed	won	12263.22	1362.58	2026-02-10 20:16:29	2026-02-10 20:18:00	\N	2026-02-10 20:16:29	2026-02-10 20:18:00
166	50	BTCUSDT	option	buy	800.00	68796.19000000	68695.43000000	\N	\N	\N	closed	won	96.00	16.00	2026-02-10 20:34:04	2026-02-10 20:34:35	\N	2026-02-10 20:34:04	2026-02-10 20:34:35
167	35	BTCUSDT	option	buy	490.00	68199.36000000	68260.99000000	\N	\N	\N	closed	won	58.80	9.80	2026-02-11 03:23:56	2026-02-11 03:24:27	\N	2026-02-11 03:23:56	2026-02-11 03:24:27
168	23	BTCUSDT	option	sell	60000.00	67557.31000000	67546.73000000	\N	\N	\N	closed	won	10800.00	1200.00	2026-02-11 22:51:00	2026-02-11 22:52:31	\N	2026-02-11 22:51:00	2026-02-11 22:52:31
169	38	XAUUSD	option	buy	23000.00	5084.46568621	5084.46568621	\N	\N	\N	closed	won	3450.00	460.00	2026-02-11 23:01:47	2026-02-11 23:02:47	\N	2026-02-11 23:01:47	2026-02-11 23:02:47
170	36	BTCUSDT	option	buy	67500.00	66966.01000000	66915.18000000	\N	\N	\N	closed	won	12150.00	1350.00	2026-02-11 23:23:44	2026-02-11 23:25:15	\N	2026-02-11 23:23:44	2026-02-11 23:25:15
171	36	BTCUSDT	option	buy	25000.00	67008.00000000	66955.38000000	\N	\N	\N	closed	won	3750.00	500.00	2026-02-11 23:24:40	2026-02-11 23:25:40	\N	2026-02-11 23:24:40	2026-02-11 23:25:40
193	50	BTCUSDT	option	buy	2000.00	67780.31000000	67768.42000000	\N	\N	\N	closed	won	240.00	40.00	2026-02-20 21:10:29	2026-02-20 21:10:59	\N	2026-02-20 21:10:29	2026-02-20 21:10:59
174	25	BTCUSDT	option	buy	30000.00	65781.72000000	65823.41000000	\N	\N	\N	closed	won	4500.00	600.00	2026-02-12 21:41:41	2026-02-12 21:42:42	\N	2026-02-12 21:41:41	2026-02-12 21:42:42
194	38	XAUUSD	option	buy	58500.00	5106.90018819	5106.90018819	\N	\N	\N	closed	won	10530.00	1170.00	2026-02-21 00:33:23	2026-02-21 00:34:54	\N	2026-02-21 00:33:23	2026-02-21 00:34:54
178	12	BTCUSDT	option	buy	44754.00	68931.91000000	68926.18000000	\N	\N	\N	closed	won	8055.72	895.08	2026-02-13 23:16:51	2026-02-13 23:18:22	\N	2026-02-13 23:16:51	2026-02-13 23:18:22
179	53	BTCUSDT	option	buy	1000.00	68895.40000000	68896.63000000	\N	\N	\N	closed	won	120.00	20.00	2026-02-13 23:45:42	2026-02-13 23:46:13	\N	2026-02-13 23:45:42	2026-02-13 23:46:13
180	53	BTCUSDT	option	buy	1000.00	68894.00000000	68900.71000000	\N	\N	\N	closed	won	120.00	20.00	2026-02-13 23:51:43	2026-02-13 23:52:14	\N	2026-02-13 23:51:43	2026-02-13 23:52:14
195	25	BTCUSDT	contract	buy	500.00	67636.29000000	67636.30000000	\N	\N	\N	closed	won	0.00	10.00	2026-02-21 03:56:35	2026-02-21 03:56:36	\N	2026-02-21 03:56:35	2026-02-21 03:56:36
182	41	ETHUSDT	option	buy	50000.00	1986.52000000	1985.76000000	\N	\N	\N	closed	won	9000.00	1000.00	2026-02-17 03:58:42	2026-02-17 04:00:13	\N	2026-02-17 03:58:42	2026-02-17 04:00:13
183	50	BTCUSDT	option	buy	1800.00	68474.89000000	68459.29000000	\N	\N	\N	closed	won	216.00	36.00	2026-02-17 03:59:59	2026-02-17 04:00:30	\N	2026-02-17 03:59:59	2026-02-17 04:00:30
184	36	BTCUSDT	option	buy	62000.00	68498.00000000	68493.06000000	\N	\N	\N	closed	won	11160.00	1240.00	2026-02-17 04:01:19	2026-02-17 04:02:49	\N	2026-02-17 04:01:19	2026-02-17 04:02:49
185	36	BTCUSDT	option	buy	62300.00	68493.94000000	68559.00000000	\N	\N	\N	closed	won	11214.00	1246.00	2026-02-17 04:09:38	2026-02-17 04:11:09	\N	2026-02-17 04:09:38	2026-02-17 04:11:09
186	9	BTCUSDT	option	sell	100000.00	67660.00000000	67711.92000000	\N	\N	\N	closed	won	22000.00	2000.00	2026-02-17 22:27:17	2026-02-17 22:30:18	\N	2026-02-17 22:27:17	2026-02-17 22:30:18
187	47	BTCUSDT	option	buy	17000.00	67188.52000000	67118.52000000	\N	\N	\N	closed	won	2550.00	340.00	2026-02-18 17:24:05	2026-02-18 17:25:06	\N	2026-02-18 17:24:05	2026-02-18 17:25:06
188	12	BTCUSDT	option	buy	120000.00	67102.64000000	67143.72000000	\N	\N	\N	closed	won	26400.00	2400.00	2026-02-18 17:25:26	2026-02-18 17:28:27	\N	2026-02-18 17:25:26	2026-02-18 17:28:27
189	38	XAUUSD	option	buy	26000.00	4980.07720116	4980.07720116	\N	\N	\N	closed	won	3900.00	520.00	2026-02-18 20:09:31	2026-02-18 20:10:31	\N	2026-02-18 20:09:31	2026-02-18 20:10:31
190	12	XAUUSD	option	buy	50000.00	4979.22666635	4979.22666635	\N	\N	\N	closed	won	9000.00	1000.00	2026-02-18 21:03:45	2026-02-18 21:05:15	\N	2026-02-18 21:03:45	2026-02-18 21:05:16
191	53	XAUUSD	option	buy	1000.00	4975.29517182	4975.29517182	\N	\N	\N	closed	won	120.00	20.00	2026-02-19 00:22:27	2026-02-19 00:22:58	\N	2026-02-19 00:22:27	2026-02-19 00:22:58
192	23	BTCUSDT	option	sell	134000.00	67011.51000000	66994.70000000	\N	\N	\N	closed	won	34840.00	2680.00	2026-02-19 21:36:47	2026-02-19 21:41:47	\N	2026-02-19 21:36:47	2026-02-19 21:41:47
196	51	BTCUSDT	option	buy	400.00	67691.52000000	67688.11000000	\N	\N	\N	closed	won	48.00	8.00	2026-02-21 04:09:55	2026-02-21 04:10:26	\N	2026-02-21 04:09:55	2026-02-21 04:10:26
197	51	BTCUSDT	option	buy	400.00	67648.15000000	67624.44000000	\N	\N	\N	closed	won	48.00	8.00	2026-02-21 04:21:39	2026-02-21 04:22:09	\N	2026-02-21 04:21:39	2026-02-21 04:22:09
198	51	BTCUSDT	option	buy	500.00	67705.08000000	67717.00000000	\N	\N	\N	closed	won	60.00	10.00	2026-02-21 04:33:02	2026-02-21 04:33:32	\N	2026-02-21 04:33:02	2026-02-21 04:33:32
199	51	BTCUSDT	option	buy	500.00	67750.06000000	67750.07000000	\N	\N	\N	closed	won	60.00	10.00	2026-02-21 04:36:56	2026-02-21 04:37:27	\N	2026-02-21 04:36:56	2026-02-21 04:37:27
200	51	BTCUSDT	option	buy	600.00	67717.63000000	67717.64000000	\N	\N	\N	closed	won	72.00	12.00	2026-02-21 04:40:12	2026-02-21 04:40:42	\N	2026-02-21 04:40:12	2026-02-21 04:40:42
201	25	BTCUSDT	option	buy	50000.00	67717.63000000	67733.61000000	\N	\N	\N	closed	won	9000.00	1000.00	2026-02-21 04:41:49	2026-02-21 04:43:19	\N	2026-02-21 04:41:49	2026-02-21 04:43:19
202	12	BTCUSDT	option	buy	30000.00	64900.78000000	64910.04000000	\N	\N	\N	closed	won	4500.00	600.00	2026-02-23 22:33:57	2026-02-23 22:34:57	\N	2026-02-23 22:33:57	2026-02-23 22:34:57
203	12	XAUUSD	option	buy	30000.00	5227.68119927	5227.68119927	\N	\N	\N	closed	won	4500.00	600.00	2026-02-23 22:34:19	2026-02-23 22:35:19	\N	2026-02-23 22:34:19	2026-02-23 22:35:19
204	57	ETHUSDT	option	buy	900.00	1855.48000000	1855.27000000	\N	\N	\N	closed	won	108.00	18.00	2026-02-24 19:52:56	2026-02-24 19:53:27	\N	2026-02-24 19:52:56	2026-02-24 19:53:27
205	50	BTCUSDT	option	buy	2000.00	64448.76000000	64449.19000000	\N	\N	\N	closed	won	240.00	40.00	2026-02-24 20:51:46	2026-02-24 20:52:17	\N	2026-02-24 20:51:46	2026-02-24 20:52:17
206	31	BTCUSDT	option	buy	48932.00	64062.64000000	64025.11000000	\N	\N	\N	closed	won	8807.76	978.64	2026-02-25 00:31:25	2026-02-25 00:32:56	\N	2026-02-25 00:31:25	2026-02-25 00:32:56
207	23	BTCUSDT	option	buy	30001.00	66288.00000000	66223.95000000	\N	\N	\N	closed	won	5400.18	600.02	2026-02-25 02:07:16	2026-02-25 02:08:47	\N	2026-02-25 02:07:16	2026-02-25 02:08:47
208	23	BTCUSDT	option	buy	70000.00	66136.77000000	66246.36000000	\N	\N	\N	closed	won	12600.00	1400.00	2026-02-25 02:11:53	2026-02-25 02:13:23	\N	2026-02-25 02:11:53	2026-02-25 02:13:23
209	47	BTCUSDT	option	buy	24000.00	68627.30000000	68609.30000000	\N	\N	\N	closed	won	3600.00	480.00	2026-02-25 17:57:50	2026-02-25 17:58:50	\N	2026-02-25 17:57:50	2026-02-25 17:58:50
210	12	BTCUSDT	option	buy	180000.00	68389.98000000	68679.56000000	\N	\N	\N	closed	won	46800.00	3600.00	2026-02-25 18:04:01	2026-02-25 18:09:02	\N	2026-02-25 18:04:01	2026-02-25 18:09:02
211	48	XAUUSD	option	buy	10000.00	5165.86828172	5165.86828172	\N	\N	\N	closed	won	1200.00	200.00	2026-02-26 18:14:38	2026-02-26 18:15:08	\N	2026-02-26 18:14:38	2026-02-26 18:15:08
212	48	XAUUSD	option	buy	40000.00	5189.75293662	5189.75293662	\N	\N	\N	closed	won	7200.00	800.00	2026-02-26 20:28:57	2026-02-26 20:30:28	\N	2026-02-26 20:28:57	2026-02-26 20:30:28
213	12	XAUUSD	option	buy	50000.00	5191.92738363	5191.92738363	\N	\N	\N	closed	won	9000.00	1000.00	2026-02-27 02:47:01	2026-02-27 02:48:31	\N	2026-02-27 02:47:01	2026-02-27 02:48:31
214	12	XAUUSD	option	buy	100000.00	5245.21099123	5245.21099123	\N	\N	\N	closed	won	22000.00	2000.00	2026-02-27 20:06:25	2026-02-27 20:09:25	\N	2026-02-27 20:06:25	2026-02-27 20:09:25
215	12	BTCUSDT	option	buy	70000.00	65542.81000000	65533.41000000	\N	\N	\N	closed	won	12600.00	1400.00	2026-02-27 20:10:29	2026-02-27 20:11:59	\N	2026-02-27 20:10:29	2026-02-27 20:11:59
216	12	XAUUSD	option	buy	70000.00	5245.21099123	5245.21099123	\N	\N	\N	closed	won	12600.00	1400.00	2026-02-27 20:19:03	2026-02-27 20:20:33	\N	2026-02-27 20:19:03	2026-02-27 20:20:33
217	38	XAUUSD	option	buy	20000.00	5277.80240752	5277.80240752	\N	\N	\N	closed	won	3000.00	400.00	2026-02-27 23:00:45	2026-02-27 23:01:45	\N	2026-02-27 23:00:45	2026-02-27 23:01:45
218	57	ETHUSDT	option	buy	2800.00	1925.37000000	1926.85000000	\N	\N	\N	closed	won	336.00	56.00	2026-02-27 23:09:02	2026-02-27 23:09:32	\N	2026-02-27 23:09:02	2026-02-27 23:09:32
219	57	ETHUSDT	option	buy	2800.00	1926.11000000	1926.48000000	\N	\N	\N	closed	won	336.00	56.00	2026-02-27 23:11:50	2026-02-27 23:12:21	\N	2026-02-27 23:11:50	2026-02-27 23:12:21
220	9	BTCUSDT	option	sell	70000.00	65762.00000000	65785.49000000	\N	\N	\N	closed	won	12600.00	1400.00	2026-02-28 01:42:53	2026-02-28 01:44:23	\N	2026-02-28 01:42:53	2026-02-28 01:44:23
221	12	BTCUSDT	option	buy	30000.00	65801.17000000	65818.06000000	\N	\N	\N	closed	won	4500.00	600.00	2026-02-28 01:59:47	2026-02-28 02:00:48	\N	2026-02-28 01:59:47	2026-02-28 02:00:48
222	10	XAUUSD	option	buy	30000.00	5278.61033193	5278.61033193	\N	\N	\N	closed	won	4500.00	600.00	2026-02-28 03:50:21	2026-02-28 03:51:21	\N	2026-02-28 03:50:21	2026-02-28 03:51:21
223	64	XAUUSD	option	buy	400.00	5365.02273428	5365.02273428	\N	\N	\N	closed	won	48.00	8.00	2026-03-02 01:01:20	2026-03-02 01:01:50	\N	2026-03-02 01:01:20	2026-03-02 01:01:50
224	12	XAUUSD	option	buy	10000.00	5365.02273428	5365.02273428	\N	\N	\N	closed	won	1200.00	200.00	2026-03-02 01:06:16	2026-03-02 01:06:47	\N	2026-03-02 01:06:16	2026-03-02 01:06:47
225	31	BTCUSDT	option	buy	51792.00	69078.00000000	69163.84000000	\N	\N	\N	closed	won	9322.56	1035.84	2026-03-02 18:30:22	2026-03-02 18:31:53	\N	2026-03-02 18:30:22	2026-03-02 18:31:53
226	58	BTCUSDT	option	buy	1000.00	68808.88000000	68865.21000000	\N	\N	\N	closed	won	120.00	20.00	2026-03-02 20:16:01	2026-03-02 20:16:32	\N	2026-03-02 20:16:01	2026-03-02 20:16:32
227	50	BTCUSDT	option	buy	3000.00	68850.34000000	68836.89000000	\N	\N	\N	closed	won	360.00	60.00	2026-03-02 20:16:07	2026-03-02 20:16:37	\N	2026-03-02 20:16:07	2026-03-02 20:16:37
228	58	BTCUSDT	option	buy	1000.00	69007.99000000	68988.00000000	\N	\N	\N	closed	won	120.00	20.00	2026-03-02 20:31:47	2026-03-02 20:32:18	\N	2026-03-02 20:31:47	2026-03-02 20:32:18
229	58	BTCUSDT	option	buy	1200.00	69296.71000000	69319.16000000	\N	\N	\N	closed	won	144.00	24.00	2026-03-02 20:47:44	2026-03-02 20:48:15	\N	2026-03-02 20:47:44	2026-03-02 20:48:15
230	58	BTCUSDT	option	buy	1200.00	69348.20000000	69297.92000000	\N	\N	\N	closed	won	144.00	24.00	2026-03-02 20:55:04	2026-03-02 20:55:35	\N	2026-03-02 20:55:04	2026-03-02 20:55:35
231	58	BTCUSDT	option	buy	1200.00	69303.01000000	69316.60000000	\N	\N	\N	closed	won	144.00	24.00	2026-03-02 20:56:18	2026-03-02 20:56:49	\N	2026-03-02 20:56:18	2026-03-02 20:56:49
232	58	BTCUSDT	option	buy	1500.00	69078.56000000	69137.60000000	\N	\N	\N	closed	won	180.00	30.00	2026-03-02 21:02:21	2026-03-02 21:02:52	\N	2026-03-02 21:02:21	2026-03-02 21:02:52
233	58	BTCUSDT	option	buy	1600.00	69204.28000000	69247.14000000	\N	\N	\N	closed	won	192.00	32.00	2026-03-02 21:07:40	2026-03-02 21:08:11	\N	2026-03-02 21:07:40	2026-03-02 21:08:11
234	58	BTCUSDT	option	buy	1600.00	69230.54000000	69202.12000000	\N	\N	\N	closed	won	192.00	32.00	2026-03-02 21:08:44	2026-03-02 21:09:15	\N	2026-03-02 21:08:44	2026-03-02 21:09:15
235	58	BTCUSDT	option	buy	1800.00	69202.17000000	69215.49000000	\N	\N	\N	closed	won	216.00	36.00	2026-03-02 21:21:35	2026-03-02 21:22:06	\N	2026-03-02 21:21:35	2026-03-02 21:22:06
236	58	BTCUSDT	option	buy	1800.00	69350.38000000	69399.92000000	\N	\N	\N	closed	won	216.00	36.00	2026-03-02 21:24:29	2026-03-02 21:24:59	\N	2026-03-02 21:24:29	2026-03-02 21:24:59
237	58	BTCUSDT	option	buy	1800.00	69325.75000000	69331.72000000	\N	\N	\N	closed	won	216.00	36.00	2026-03-02 21:26:02	2026-03-02 21:26:32	\N	2026-03-02 21:26:02	2026-03-02 21:26:32
238	58	BTCUSDT	option	buy	2000.00	69383.12000000	69360.73000000	\N	\N	\N	closed	won	240.00	40.00	2026-03-02 21:30:56	2026-03-02 21:31:27	\N	2026-03-02 21:30:56	2026-03-02 21:31:27
239	58	BTCUSDT	option	buy	2000.00	69413.01000000	69401.00000000	\N	\N	\N	closed	won	240.00	40.00	2026-03-02 21:32:44	2026-03-02 21:33:14	\N	2026-03-02 21:32:44	2026-03-02 21:33:14
240	58	BTCUSDT	option	buy	100.00	69417.04000000	69398.27000000	\N	\N	\N	closed	won	12.00	2.00	2026-03-02 21:33:50	2026-03-02 21:34:21	\N	2026-03-02 21:33:50	2026-03-02 21:34:21
241	58	BTCUSDT	option	buy	2400.00	69406.87000000	69421.98000000	\N	\N	\N	closed	won	288.00	48.00	2026-03-02 21:35:06	2026-03-02 21:35:37	\N	2026-03-02 21:35:06	2026-03-02 21:35:37
242	58	BTCUSDT	option	buy	2000.00	69427.39000000	69390.80000000	\N	\N	\N	closed	won	240.00	40.00	2026-03-02 21:44:11	2026-03-02 21:44:41	\N	2026-03-02 21:44:11	2026-03-02 21:44:41
243	23	BTCUSDT	option	buy	500.00	68833.61000000	68798.36000000	\N	\N	\N	closed	lost	-500.00	10.00	2026-03-03 00:15:26	2026-03-03 00:15:57	\N	2026-03-03 00:15:26	2026-03-03 00:15:57
244	12	BTCUSDT	option	buy	65000.00	68335.53000000	68328.30000000	\N	\N	\N	closed	won	11700.00	1300.00	2026-03-03 04:27:07	2026-03-03 04:28:37	\N	2026-03-03 04:27:07	2026-03-03 04:28:37
245	48	XAUUSD	contract	buy	100.00	5088.63900279	5088.63900279	\N	\N	\N	closed	won	0.00	2.00	2026-03-03 23:24:00	2026-03-03 23:24:00	\N	2026-03-03 23:24:00	2026-03-03 23:24:00
246	65	XAUUSD	option	buy	102.00	5120.00524289	5120.00524289	\N	\N	\N	closed	won	12.24	2.04	2026-03-03 23:38:18	2026-03-03 23:38:48	\N	2026-03-03 23:38:18	2026-03-03 23:38:48
247	65	XAUUSD	option	buy	150.00	5120.00524289	5120.00524289	\N	\N	\N	closed	won	18.00	3.00	2026-03-03 23:41:50	2026-03-03 23:42:20	\N	2026-03-03 23:41:50	2026-03-03 23:42:20
248	65	XAUUSD	option	buy	120.00	5156.46254294	5156.46254294	\N	\N	\N	closed	lost	-120.00	2.40	2026-03-04 05:17:54	2026-03-04 05:18:24	\N	2026-03-04 05:17:54	2026-03-04 05:18:24
249	25	XAUUSD	option	buy	30000.00	5195.74717702	5195.74717702	\N	\N	\N	closed	won	4500.00	600.00	2026-03-04 12:01:44	2026-03-04 12:02:44	\N	2026-03-04 12:01:44	2026-03-04 12:02:44
250	50	BTCUSDT	option	buy	3000.00	73985.38000000	73955.05000000	\N	\N	\N	closed	won	360.00	60.00	2026-03-04 19:12:57	2026-03-04 19:13:28	\N	2026-03-04 19:12:57	2026-03-04 19:13:28
251	50	BTCUSDT	option	buy	500.00	73784.89000000	73792.39000000	\N	\N	\N	closed	won	60.00	10.00	2026-03-04 19:15:39	2026-03-04 19:16:10	\N	2026-03-04 19:15:39	2026-03-04 19:16:10
252	57	ETHUSDT	option	buy	3800.00	2170.84000000	2172.87000000	\N	\N	\N	closed	won	456.00	76.00	2026-03-04 20:43:14	2026-03-04 20:43:45	\N	2026-03-04 20:43:14	2026-03-04 20:43:45
253	58	BTCUSDT	option	buy	4000.00	71079.13000000	71131.55000000	\N	\N	\N	closed	won	480.00	80.00	2026-03-05 20:14:46	2026-03-05 20:15:16	\N	2026-03-05 20:14:46	2026-03-05 20:15:16
254	58	BTCUSDT	option	buy	4400.00	71129.18000000	71126.97000000	\N	\N	\N	closed	won	528.00	88.00	2026-03-05 20:17:23	2026-03-05 20:17:53	\N	2026-03-05 20:17:23	2026-03-05 20:17:53
255	58	BTCUSDT	option	buy	4600.00	71233.14000000	71240.52000000	\N	\N	\N	closed	won	552.00	92.00	2026-03-05 20:23:37	2026-03-05 20:24:08	\N	2026-03-05 20:23:37	2026-03-05 20:24:08
256	28	XAUUSD	option	buy	280.00	5090.25272596	5090.25272596	\N	\N	\N	closed	won	33.60	5.60	2026-03-06 00:53:14	2026-03-06 00:53:45	\N	2026-03-06 00:53:14	2026-03-06 00:53:45
257	64	XAUUSD	option	buy	900.00	5084.60787504	5084.60787504	\N	\N	\N	closed	won	108.00	18.00	2026-03-06 01:11:38	2026-03-06 01:12:08	\N	2026-03-06 01:11:38	2026-03-06 01:12:08
258	10	BTCUSDT	option	buy	30001.00	70758.32000000	70940.52000000	\N	\N	\N	closed	won	5400.18	600.02	2026-03-06 01:33:47	2026-03-06 01:35:18	\N	2026-03-06 01:33:47	2026-03-06 01:35:18
259	10	BTCUSDT	option	buy	12000.00	70940.52000000	70875.89000000	\N	\N	\N	closed	won	1800.00	240.00	2026-03-06 01:35:16	2026-03-06 01:36:17	\N	2026-03-06 01:35:16	2026-03-06 01:36:17
260	10	BTCUSDT	option	buy	70001.00	70966.74000000	71032.29000000	\N	\N	\N	closed	won	15400.22	1400.02	2026-03-06 01:35:55	2026-03-06 01:38:56	\N	2026-03-06 01:35:55	2026-03-06 01:38:56
261	62	BTCUSDT	option	buy	1000.00	68123.74000000	68113.82000000	\N	\N	\N	closed	won	120.00	20.00	2026-03-06 21:38:48	2026-03-06 21:39:19	\N	2026-03-06 21:38:48	2026-03-06 21:39:19
262	28	XAUUSD	option	buy	100.00	5173.96419824	5173.96419824	\N	\N	\N	closed	lost	-100.00	2.00	2026-03-06 22:21:24	2026-03-06 22:21:54	\N	2026-03-06 22:21:24	2026-03-06 22:21:54
263	48	XAUUSD	option	buy	70000.00	5171.91443585	5171.91443585	\N	\N	\N	closed	won	12600.00	1400.00	2026-03-06 22:50:27	2026-03-06 22:51:57	\N	2026-03-06 22:50:27	2026-03-06 22:51:57
264	38	BTCUSDT	option	sell	30000.00	68323.70000000	68314.79000000	\N	\N	\N	closed	won	4500.00	600.00	2026-03-06 23:32:52	2026-03-06 23:33:53	\N	2026-03-06 23:32:52	2026-03-06 23:33:53
265	66	BTCUSDT	option	buy	150.00	68357.66000000	68357.66000000	\N	\N	\N	closed	won	18.00	3.00	2026-03-07 03:01:06	2026-03-07 03:01:36	\N	2026-03-07 03:01:06	2026-03-07 03:01:36
266	10	XAUUSD	option	buy	50000.00	5171.91443585	5171.91443585	\N	\N	\N	closed	won	9000.00	1000.00	2026-03-07 03:43:16	2026-03-07 03:44:47	\N	2026-03-07 03:43:16	2026-03-07 03:44:47
267	23	BTCUSDT	option	sell	500.00	67132.67000000	67084.92000000	\N	\N	\N	closed	lost	-500.00	10.00	2026-03-08 02:49:18	2026-03-08 02:49:49	\N	2026-03-08 02:49:18	2026-03-08 02:49:49
268	60	BTCUSDT	option	sell	5500.00	66294.61000000	66292.82000000	\N	\N	\N	closed	won	660.00	110.00	2026-03-08 23:07:12	2026-03-08 23:07:43	\N	2026-03-08 23:07:12	2026-03-08 23:07:43
269	31	BTCUSDT	option	buy	51362.00	68465.30000000	68443.77000000	\N	\N	\N	closed	won	9245.16	1027.24	2026-03-09 18:13:06	2026-03-09 18:14:37	\N	2026-03-09 18:13:06	2026-03-09 18:14:37
270	31	BTCUSDT	option	buy	51684.00	68424.62000000	68463.36000000	\N	\N	\N	closed	won	9303.12	1033.68	2026-03-09 18:15:32	2026-03-09 18:17:02	\N	2026-03-09 18:15:32	2026-03-09 18:17:02
271	10	XAUUSD	option	sell	1000.00	5174.16230312	5174.16230312	\N	\N	\N	closed	won	120.00	20.00	2026-03-10 02:31:00	2026-03-10 02:31:30	\N	2026-03-10 02:31:00	2026-03-10 02:31:30
272	66	XAUUSD	option	buy	170.00	5166.14583306	5166.14583306	\N	\N	\N	closed	won	20.40	3.40	2026-03-10 03:35:24	2026-03-10 03:35:55	\N	2026-03-10 03:35:24	2026-03-10 03:35:55
273	66	XAUUSD	option	buy	200.00	5166.14583306	5166.14583306	\N	\N	\N	closed	lost	-200.00	4.00	2026-03-10 03:51:16	2026-03-10 03:51:46	\N	2026-03-10 03:51:16	2026-03-10 03:51:46
274	50	BTCUSDT	option	buy	3700.00	70111.05000000	70072.30000000	\N	\N	\N	closed	won	444.00	74.00	2026-03-10 18:40:58	2026-03-10 18:41:29	\N	2026-03-10 18:40:58	2026-03-10 18:41:29
275	57	ETHUSDT	option	buy	4000.00	2025.61000000	2027.68000000	\N	\N	\N	closed	won	480.00	80.00	2026-03-10 21:50:43	2026-03-10 21:51:14	\N	2026-03-10 21:50:43	2026-03-10 21:51:14
276	57	ETHUSDT	option	buy	800.00	2028.38000000	2029.17000000	\N	\N	\N	closed	won	96.00	16.00	2026-03-10 21:53:23	2026-03-10 21:53:54	\N	2026-03-10 21:53:23	2026-03-10 21:53:54
277	10	BTCUSDT	option	sell	30000.00	70368.06000000	70450.93000000	\N	\N	\N	closed	won	4500.00	600.00	2026-03-11 22:46:36	2026-03-11 22:47:37	\N	2026-03-11 22:46:36	2026-03-11 22:47:37
278	66	XAUUSD	option	buy	700.00	5121.49727997	5121.49727997	\N	\N	\N	closed	won	84.00	14.00	2026-03-13 02:39:52	2026-03-13 02:40:23	\N	2026-03-13 02:39:52	2026-03-13 02:40:23
279	60	BTCUSDT	option	buy	6000.00	71229.87000000	71239.93000000	\N	\N	\N	closed	won	720.00	120.00	2026-03-13 03:48:07	2026-03-13 03:48:38	\N	2026-03-13 03:48:07	2026-03-13 03:48:38
280	53	BTCUSDT	option	buy	2000.00	70817.04000000	70812.81000000	\N	\N	\N	closed	won	240.00	40.00	2026-03-13 22:18:56	2026-03-13 22:19:26	\N	2026-03-13 22:18:56	2026-03-13 22:19:26
281	60	BTCUSDT	option	buy	100.00	70590.32000000	70593.32000000	\N	\N	\N	closed	lost	-100.00	2.00	2026-03-14 18:02:46	2026-03-14 18:03:16	\N	2026-03-14 18:02:46	2026-03-14 18:03:16
282	31	BTCUSDT	option	buy	42580.00	71497.14000000	71504.74000000	\N	\N	\N	closed	won	7664.40	851.60	2026-03-15 02:49:09	2026-03-15 02:50:39	\N	2026-03-15 02:49:09	2026-03-15 02:50:39
283	31	BTCUSDT	option	buy	57896.00	71421.76000000	71431.25000000	\N	\N	\N	closed	won	10421.28	1157.92	2026-03-15 02:51:42	2026-03-15 02:53:12	\N	2026-03-15 02:51:42	2026-03-15 02:53:12
284	50	BTCUSDT	option	buy	4000.00	71739.16000000	71727.42000000	\N	\N	\N	closed	won	480.00	80.00	2026-03-15 21:00:01	2026-03-15 21:00:32	\N	2026-03-15 21:00:01	2026-03-15 21:00:32
285	50	BTCUSDT	option	buy	300.00	71721.05000000	71721.03000000	\N	\N	\N	closed	won	36.00	6.00	2026-03-15 21:02:21	2026-03-15 21:02:51	\N	2026-03-15 21:02:21	2026-03-15 21:02:51
286	57	ETHUSDT	option	buy	5000.00	2124.71000000	2124.73000000	\N	\N	\N	closed	won	600.00	100.00	2026-03-15 21:13:26	2026-03-15 21:13:57	\N	2026-03-15 21:13:26	2026-03-15 21:13:57
287	41	BTCUSDT	option	buy	40000.00	72093.31000000	72029.77000000	\N	\N	\N	closed	won	7200.00	800.00	2026-03-15 21:59:22	2026-03-15 22:00:53	\N	2026-03-15 21:59:22	2026-03-15 22:00:53
288	51	BTCUSDT	option	buy	1600.00	75187.37000000	75122.87000000	\N	\N	\N	closed	won	192.00	32.00	2026-03-17 03:10:01	2026-03-17 03:10:32	\N	2026-03-17 03:10:01	2026-03-17 03:10:32
289	66	XAUUSD	option	buy	700.00	5023.32581341	5023.32581341	\N	\N	\N	closed	won	84.00	14.00	2026-03-17 03:17:41	2026-03-17 03:18:12	\N	2026-03-17 03:17:41	2026-03-17 03:18:12
290	51	BTCUSDT	option	buy	1600.00	74845.51000000	74779.30000000	\N	\N	\N	closed	won	192.00	32.00	2026-03-17 03:22:12	2026-03-17 03:22:42	\N	2026-03-17 03:22:12	2026-03-17 03:22:42
291	51	BTCUSDT	option	buy	1600.00	74802.20000000	74750.17000000	\N	\N	\N	closed	won	192.00	32.00	2026-03-17 03:30:23	2026-03-17 03:30:54	\N	2026-03-17 03:30:23	2026-03-17 03:30:54
292	25	BTCUSDT	option	buy	20000.00	74595.22000000	74535.57000000	\N	\N	\N	closed	won	3000.00	400.00	2026-03-17 03:34:51	2026-03-17 03:35:51	\N	2026-03-17 03:34:51	2026-03-17 03:35:51
293	51	BTCUSDT	option	buy	1700.00	74616.09000000	74560.09000000	\N	\N	\N	closed	won	204.00	34.00	2026-03-17 03:36:11	2026-03-17 03:36:41	\N	2026-03-17 03:36:11	2026-03-17 03:36:41
294	47	BTCUSDT	option	buy	37000.00	74154.49000000	74209.59000000	\N	\N	\N	closed	won	6660.00	740.00	2026-03-17 16:17:43	2026-03-17 16:19:14	\N	2026-03-17 16:17:43	2026-03-17 16:19:14
295	10	BTCUSDT	option	buy	70000.00	74171.03000000	74146.94000000	\N	\N	\N	closed	won	12600.00	1400.00	2026-03-17 16:20:20	2026-03-17 16:21:51	\N	2026-03-17 16:20:20	2026-03-17 16:21:51
296	10	BTCUSDT	option	buy	70000.00	74196.93000000	74275.00000000	\N	\N	\N	closed	won	12600.00	1400.00	2026-03-17 16:20:48	2026-03-17 16:22:19	\N	2026-03-17 16:20:48	2026-03-17 16:22:19
297	41	XAUUSD	option	sell	60000.00	4654.66569725	4654.66569725	\N	\N	\N	closed	won	10800.00	1200.00	2026-03-19 20:28:57	2026-03-19 20:30:28	\N	2026-03-19 20:28:57	2026-03-19 20:30:28
298	38	XAUUSD	option	buy	55000.00	4657.66619252	4657.66619252	\N	\N	\N	closed	won	9900.00	1100.00	2026-03-20 00:35:36	2026-03-20 00:37:06	\N	2026-03-20 00:35:36	2026-03-20 00:37:06
299	12	XAUUSD	option	buy	60000.00	4656.79859998	4656.79859998	\N	\N	\N	closed	won	10800.00	1200.00	2026-03-20 01:08:32	2026-03-20 01:10:02	\N	2026-03-20 01:08:32	2026-03-20 01:10:02
300	60	BTCUSDT	option	buy	6000.00	70415.17000000	70422.84000000	\N	\N	\N	closed	won	720.00	120.00	2026-03-20 03:09:30	2026-03-20 03:10:01	\N	2026-03-20 03:09:30	2026-03-20 03:10:01
301	60	BTCUSDT	option	buy	6000.00	70610.96000000	70598.50000000	\N	\N	\N	closed	won	720.00	120.00	2026-03-20 04:46:35	2026-03-20 04:47:06	\N	2026-03-20 04:46:35	2026-03-20 04:47:06
302	75	BTCUSDT	option	buy	1700.00	70610.87000000	70622.03000000	\N	\N	\N	closed	won	204.00	34.00	2026-03-20 05:35:38	2026-03-20 05:36:09	\N	2026-03-20 05:35:38	2026-03-20 05:36:09
303	10	XAUUSD	option	buy	70000.00	4492.22979013	4492.22979013	\N	\N	\N	closed	won	12600.00	1400.00	2026-03-20 23:24:47	2026-03-20 23:26:17	\N	2026-03-20 23:24:47	2026-03-20 23:26:17
304	17	BTCUSDT	contract	buy	100.00	70430.65000000	70430.65000000	\N	\N	\N	closed	lost	-100.00	2.00	2026-03-21 16:48:00	2026-03-21 16:48:01	\N	2026-03-21 16:48:00	2026-03-21 16:48:01
305	75	BTCUSDT	option	buy	1900.00	70485.20000000	70478.96000000	\N	\N	\N	closed	won	228.00	38.00	2026-03-24 02:50:49	2026-03-24 02:51:20	\N	2026-03-24 02:50:49	2026-03-24 02:51:20
306	47	BTCUSDT	option	sell	48000.00	69579.25000000	69590.97000000	\N	\N	\N	closed	won	8640.00	960.00	2026-03-24 16:52:36	2026-03-24 16:54:07	\N	2026-03-24 16:52:36	2026-03-24 16:54:07
307	50	BTCUSDT	option	buy	4000.00	69408.32000000	69411.26000000	\N	\N	\N	closed	won	480.00	80.00	2026-03-24 19:34:36	2026-03-24 19:35:07	\N	2026-03-24 19:34:36	2026-03-24 19:35:07
308	78	XAUUSD	option	buy	400.00	4563.42822982	4563.42822982	\N	\N	\N	closed	won	48.00	8.00	2026-03-25 01:34:14	2026-03-25 01:34:44	\N	2026-03-25 01:34:14	2026-03-25 01:34:44
309	12	XAUUSD	option	buy	400.00	4563.42822982	4563.42822982	\N	\N	\N	closed	won	48.00	8.00	2026-03-25 01:34:19	2026-03-25 01:34:49	\N	2026-03-25 01:34:19	2026-03-25 01:34:49
310	66	XAUUSD	option	buy	2000.00	4573.03200711	4573.03200711	\N	\N	\N	closed	won	240.00	40.00	2026-03-25 04:08:39	2026-03-25 04:09:10	\N	2026-03-25 04:08:39	2026-03-25 04:09:10
311	53	BTCUSDT	option	sell	300.00	71250.06000000	71234.37000000	\N	\N	\N	closed	won	36.00	6.00	2026-03-25 05:13:31	2026-03-25 05:14:02	\N	2026-03-25 05:13:31	2026-03-25 05:14:02
312	53	BTCUSDT	option	sell	300.00	71182.44000000	71204.00000000	\N	\N	\N	closed	won	36.00	6.00	2026-03-25 05:27:55	2026-03-25 05:28:26	\N	2026-03-25 05:27:55	2026-03-25 05:28:26
313	10	XAUUSD	option	buy	50000.00	4555.64261895	4555.64261895	\N	\N	\N	closed	won	9000.00	1000.00	2026-03-25 18:37:21	2026-03-25 18:38:52	\N	2026-03-25 18:37:21	2026-03-25 18:38:52
314	10	XAUUSD	option	buy	110000.00	4555.64261895	4555.64261895	\N	\N	\N	closed	won	24200.00	2200.00	2026-03-25 18:39:50	2026-03-25 18:42:50	\N	2026-03-25 18:39:50	2026-03-25 18:42:50
315	10	BTCUSDT	option	buy	20000.00	71022.44000000	71005.72000000	\N	\N	\N	closed	won	3000.00	400.00	2026-03-26 02:16:34	2026-03-26 02:17:34	\N	2026-03-26 02:16:34	2026-03-26 02:17:34
316	10	BTCUSDT	option	buy	20000.00	70950.81000000	70938.00000000	\N	\N	\N	closed	won	3000.00	400.00	2026-03-26 02:19:01	2026-03-26 02:20:02	\N	2026-03-26 02:19:01	2026-03-26 02:20:02
317	50	BTCUSDT	option	buy	4800.00	69128.93000000	69106.65000000	\N	\N	\N	closed	won	576.00	96.00	2026-03-26 21:24:56	2026-03-26 21:25:27	\N	2026-03-26 21:24:56	2026-03-26 21:25:27
318	41	XAUUSD	option	buy	100000.00	4393.22143505	4393.22143505	\N	\N	\N	closed	won	22000.00	2000.00	2026-03-27 01:41:34	2026-03-27 01:44:34	\N	2026-03-27 01:41:34	2026-03-27 01:44:34
319	66	XAUUSD	option	buy	2000.00	4428.74699676	4428.74699676	\N	\N	\N	closed	won	240.00	40.00	2026-03-27 03:00:14	2026-03-27 03:00:44	\N	2026-03-27 03:00:14	2026-03-27 03:00:44
320	75	BTCUSDT	option	sell	5000.00	68800.01000000	68802.42000000	\N	\N	\N	closed	won	600.00	100.00	2026-03-27 05:18:11	2026-03-27 05:18:42	\N	2026-03-27 05:18:11	2026-03-27 05:18:42
321	31	BTCUSDT	option	buy	38269.00	65916.37000000	65861.05000000	\N	\N	\N	closed	won	6888.42	765.38	2026-03-27 19:20:20	2026-03-27 19:21:52	\N	2026-03-27 19:20:20	2026-03-27 19:21:52
322	10	BTCUSDT	option	sell	1000.00	66256.64000000	66256.17000000	\N	\N	\N	closed	won	120.00	20.00	2026-03-28 01:20:34	2026-03-28 01:21:05	\N	2026-03-28 01:20:34	2026-03-28 01:21:05
323	78	BTCUSDT	option	sell	1000.00	66250.23000000	66263.24000000	\N	\N	\N	closed	won	120.00	20.00	2026-03-28 01:20:46	2026-03-28 01:21:17	\N	2026-03-28 01:20:46	2026-03-28 01:21:17
324	75	BTCUSDT	option	buy	5500.00	66130.13000000	66124.45000000	\N	\N	\N	closed	won	660.00	110.00	2026-03-28 04:14:10	2026-03-28 04:14:41	\N	2026-03-28 04:14:10	2026-03-28 04:14:41
325	60	BTCUSDT	option	buy	8000.00	66659.93000000	66662.63000000	\N	\N	\N	closed	won	960.00	160.00	2026-03-30 01:57:57	2026-03-30 01:58:28	\N	2026-03-30 01:57:57	2026-03-30 01:58:28
326	12	XAUUSD	option	buy	10000.00	4471.50799819	4471.50799819	\N	\N	\N	closed	won	1200.00	200.00	2026-03-30 02:52:58	2026-03-30 02:53:28	\N	2026-03-30 02:52:58	2026-03-30 02:53:28
327	81	XAUUSD	option	buy	900.00	4471.50799819	4471.50799819	\N	\N	\N	closed	won	108.00	18.00	2026-03-30 02:53:54	2026-03-30 02:54:24	\N	2026-03-30 02:53:54	2026-03-30 02:54:24
328	80	BTCUSDT	option	buy	900.00	66568.67000000	66555.12000000	\N	\N	\N	closed	won	108.00	18.00	2026-03-30 20:36:03	2026-03-30 20:36:34	\N	2026-03-30 20:36:03	2026-03-30 20:36:34
329	66	XAUUSD	option	buy	2300.00	4556.03282531	4559.73064759	\N	\N	\N	closed	won	276.00	46.00	2026-03-31 04:34:43	2026-03-31 04:35:14	\N	2026-03-31 04:34:43	2026-03-31 04:35:14
330	78	XAUUSD	option	buy	11000.00	4697.11587691	4697.11587691	\N	\N	\N	closed	won	1650.00	220.00	2026-04-01 01:36:08	2026-04-01 01:37:09	\N	2026-04-01 01:36:08	2026-04-01 01:37:09
331	31	BTCUSDT	option	buy	46396.00	68517.37000000	68535.05000000	\N	\N	\N	closed	won	8351.28	927.92	2026-04-01 17:30:08	2026-04-01 17:31:38	\N	2026-04-01 17:30:08	2026-04-01 17:31:38
332	80	BTCUSDT	option	buy	1000.00	67057.40000000	67038.69000000	\N	\N	\N	closed	won	120.00	20.00	2026-04-02 19:40:55	2026-04-02 19:41:25	\N	2026-04-02 19:40:55	2026-04-02 19:41:25
333	80	BTCUSDT	option	buy	1000.00	66984.12000000	66973.21000000	\N	\N	\N	closed	won	120.00	20.00	2026-04-02 19:44:42	2026-04-02 19:45:13	\N	2026-04-02 19:44:42	2026-04-02 19:45:13
334	66	XAUUSD	option	buy	2300.00	4676.76754922	4676.76754922	\N	\N	\N	closed	won	276.00	46.00	2026-04-03 03:49:42	2026-04-03 03:50:13	\N	2026-04-03 03:49:42	2026-04-03 03:50:13
335	78	BTCUSDT	option	sell	8000.00	66886.99000000	66850.00000000	\N	\N	\N	closed	won	960.00	160.00	2026-04-03 23:34:32	2026-04-03 23:35:03	\N	2026-04-03 23:34:32	2026-04-03 23:35:03
336	53	BTCUSDT	option	sell	2800.00	66880.94000000	66874.36000000	\N	\N	\N	closed	won	336.00	56.00	2026-04-04 01:13:16	2026-04-04 01:13:46	\N	2026-04-04 01:13:16	2026-04-04 01:13:46
337	76	ETHUSDT	option	buy	300.00	2145.12000000	2144.85000000	\N	\N	\N	closed	lost	-300.00	6.00	2026-04-06 20:13:59	2026-04-06 20:14:29	\N	2026-04-06 20:13:59	2026-04-06 20:14:29
338	76	ETHUSDT	option	buy	10001.00	2147.89000000	2147.89000000	\N	\N	\N	closed	lost	-10001.00	200.02	2026-04-06 20:16:35	2026-04-06 20:17:35	\N	2026-04-06 20:16:35	2026-04-06 20:17:35
339	66	BTCUSDT	option	buy	14900.00	68649.84000000	68632.40000000	\N	\N	\N	closed	won	2235.00	298.00	2026-04-07 04:13:46	2026-04-07 04:14:47	\N	2026-04-07 04:13:46	2026-04-07 04:14:47
340	31	BTCUSDT	option	buy	56375.00	71298.31000000	71306.40000000	\N	\N	\N	closed	won	10147.50	1127.50	2026-04-08 02:44:42	2026-04-08 02:46:13	\N	2026-04-08 02:44:42	2026-04-08 02:46:13
341	78	BTCUSDT	option	buy	30000.00	70857.41000000	70850.91000000	\N	\N	\N	closed	won	4500.00	600.00	2026-04-09 01:00:43	2026-04-09 01:01:44	\N	2026-04-09 01:00:43	2026-04-09 01:01:44
342	78	BTCUSDT	option	buy	38000.00	71656.61000000	71639.99000000	\N	\N	\N	closed	lost	-38000.00	760.00	2026-04-12 02:00:57	2026-04-12 02:02:28	\N	2026-04-12 02:00:57	2026-04-12 02:02:28
343	78	BTCUSDT	option	sell	15000.00	74619.96000000	74626.40000000	\N	\N	\N	closed	won	2250.00	300.00	2026-04-15 01:44:21	2026-04-15 01:45:22	\N	2026-04-15 01:44:21	2026-04-15 01:45:22
344	10	BTCUSDT	option	buy	30000.00	74607.05000000	74579.40000000	\N	\N	\N	closed	won	4500.00	600.00	2026-04-15 01:46:25	2026-04-15 01:47:26	\N	2026-04-15 01:46:25	2026-04-15 01:47:26
345	10	BTCUSDT	option	sell	14000.00	74579.39000000	74635.45000000	\N	\N	\N	closed	won	2100.00	280.00	2026-04-15 01:47:19	2026-04-15 01:48:20	\N	2026-04-15 01:47:19	2026-04-15 01:48:20
346	78	BTCUSDT	option	sell	14000.00	74635.45000000	74650.84000000	\N	\N	\N	closed	won	2100.00	280.00	2026-04-15 01:48:20	2026-04-15 01:49:21	\N	2026-04-15 01:48:20	2026-04-15 01:49:21
347	82	BTCUSDT	option	buy	900.00	74546.00000000	74559.16000000	\N	\N	\N	closed	won	108.00	18.00	2026-04-16 01:14:19	2026-04-16 01:14:50	\N	2026-04-16 01:14:19	2026-04-16 01:14:50
348	25	BTCUSDT	option	buy	30000.00	74865.75000000	74855.24000000	\N	\N	\N	closed	won	4500.00	600.00	2026-04-16 04:04:56	2026-04-16 04:05:57	\N	2026-04-16 04:04:56	2026-04-16 04:05:57
349	66	XAUUSD	option	buy	16000.00	4824.61790232	4824.61790232	\N	\N	\N	closed	won	2400.00	320.00	2026-04-16 04:22:10	2026-04-16 04:23:10	\N	2026-04-16 04:22:10	2026-04-16 04:23:10
350	41	XAUUSD	option	buy	70001.00	4790.22411064	4790.22411064	\N	\N	\N	closed	won	15400.22	1400.02	2026-04-16 18:35:28	2026-04-16 18:38:29	\N	2026-04-16 18:35:28	2026-04-16 18:38:29
351	41	XAUUSD	option	buy	70001.00	4790.22411064	4790.22411064	\N	\N	\N	closed	won	15400.22	1400.02	2026-04-16 18:40:47	2026-04-16 18:43:47	\N	2026-04-16 18:40:47	2026-04-16 18:43:47
352	83	BTCUSDT	option	buy	1000.00	74935.79000000	74949.03000000	\N	\N	\N	closed	won	120.00	20.00	2026-04-17 00:48:13	2026-04-17 00:48:43	\N	2026-04-17 00:48:13	2026-04-17 00:48:43
353	10	BTCUSDT	option	buy	40000.00	74720.97000000	74708.57000000	\N	\N	\N	closed	won	7200.00	800.00	2026-04-17 03:17:45	2026-04-17 03:19:16	\N	2026-04-17 03:17:45	2026-04-17 03:19:16
354	78	BTCUSDT	option	buy	17000.00	77366.71000000	77364.11000000	\N	\N	\N	closed	won	2550.00	340.00	2026-04-17 21:02:46	2026-04-17 21:03:47	\N	2026-04-17 21:02:46	2026-04-17 21:03:47
355	82	BTCUSDT	option	buy	3400.00	77138.41000000	77163.67000000	\N	\N	\N	closed	won	408.00	68.00	2026-04-18 02:04:26	2026-04-18 02:04:56	\N	2026-04-18 02:04:26	2026-04-18 02:04:56
356	82	XAUUSD	option	sell	3700.00	4831.14892934	4831.14892934	\N	\N	\N	closed	won	444.00	74.00	2026-04-18 02:12:59	2026-04-18 02:13:30	\N	2026-04-18 02:12:59	2026-04-18 02:13:30
357	60	BTCUSDT	option	buy	10001.00	75654.25000000	75639.78000000	\N	\N	\N	closed	won	1500.15	200.02	2026-04-19 04:36:30	2026-04-19 04:37:31	\N	2026-04-19 04:36:30	2026-04-19 04:37:31
358	78	BTCUSDT	option	buy	30000.00	75902.10000000	75808.29000000	\N	\N	\N	closed	won	4500.00	600.00	2026-04-21 02:00:46	2026-04-21 02:01:47	\N	2026-04-21 02:00:46	2026-04-21 02:01:47
359	84	BTCUSDT	option	sell	7000.00	76285.18000000	76285.18000000	\N	\N	\N	closed	won	840.00	140.00	2026-04-22 00:59:17	2026-04-22 00:59:48	\N	2026-04-22 00:59:17	2026-04-22 00:59:48
360	10	BTCUSDT	option	buy	30001.00	76369.49000000	76350.01000000	\N	\N	\N	closed	won	5400.18	600.02	2026-04-22 01:05:06	2026-04-22 01:06:37	\N	2026-04-22 01:05:06	2026-04-22 01:06:37
361	10	BTCUSDT	option	buy	30001.00	76326.55000000	76338.00000000	\N	\N	\N	closed	won	5400.18	600.02	2026-04-22 01:07:02	2026-04-22 01:08:33	\N	2026-04-22 01:07:02	2026-04-22 01:08:33
362	82	BTCUSDT	option	buy	4000.00	76803.41000000	76853.88000000	\N	\N	\N	closed	won	480.00	80.00	2026-04-22 02:15:56	2026-04-22 02:16:27	\N	2026-04-22 02:15:56	2026-04-22 02:16:27
363	66	BTCUSDT	option	buy	18000.00	77465.32000000	77487.40000000	\N	\N	\N	closed	won	2700.00	360.00	2026-04-22 04:16:09	2026-04-22 04:17:10	\N	2026-04-22 04:16:09	2026-04-22 04:17:10
364	78	BTCUSDT	option	buy	33000.00	78438.25000000	78436.69000000	\N	\N	\N	closed	won	5940.00	660.00	2026-04-24 00:30:29	2026-04-24 00:32:00	\N	2026-04-24 00:30:29	2026-04-24 00:32:00
365	82	BTCUSDT	option	buy	100.00	78052.23000000	78027.61000000	\N	\N	\N	closed	won	12.00	2.00	2026-04-24 01:31:10	2026-04-24 01:31:40	\N	2026-04-24 01:31:10	2026-04-24 01:31:40
366	82	BTCUSDT	option	buy	5600.00	78028.30000000	78036.00000000	\N	\N	\N	closed	won	672.00	112.00	2026-04-24 01:33:45	2026-04-24 01:34:16	\N	2026-04-24 01:33:45	2026-04-24 01:34:16
368	10	BTCUSDT	option	buy	35000.00	78375.00000000	78357.97000000	\N	\N	\N	closed	won	6300.00	700.00	2026-04-24 02:18:20	2026-04-24 02:19:50	\N	2026-04-24 02:18:20	2026-04-24 02:19:50
367	10	BTCUSDT	option	buy	36500.00	78379.77000000	78375.00000000	\N	\N	\N	closed	won	6570.00	730.00	2026-04-24 02:17:44	2026-04-24 02:19:15	\N	2026-04-24 02:17:44	2026-04-24 02:19:15
369	10	BTCUSDT	option	buy	65000.00	77686.42000000	77722.21000000	\N	\N	\N	closed	won	11700.00	1300.00	2026-04-24 03:50:08	2026-04-24 03:51:39	\N	2026-04-24 03:50:08	2026-04-24 03:51:39
370	78	BTCUSDT	option	sell	35000.00	77430.80000000	77421.01000000	\N	\N	\N	closed	won	6300.00	700.00	2026-04-25 16:23:03	2026-04-25 16:24:34	\N	2026-04-25 16:23:03	2026-04-25 16:24:34
371	41	XAUUSD	option	sell	60000.00	4680.87655967	4680.87655967	\N	\N	\N	closed	won	10800.00	1200.00	2026-04-26 23:38:41	2026-04-26 23:40:12	\N	2026-04-26 23:38:41	2026-04-26 23:40:12
372	60	BTCUSDT	option	buy	10001.00	79302.05000000	79323.00000000	\N	\N	\N	closed	won	1500.15	200.02	2026-04-27 01:48:40	2026-04-27 01:49:41	\N	2026-04-27 01:48:40	2026-04-27 01:49:41
373	38	BTCUSDT	option	buy	100000.00	75305.36000000	75115.41000000	\N	\N	\N	closed	won	22000.00	2000.00	2026-04-29 18:26:00	2026-04-29 18:29:00	\N	2026-04-29 18:25:59	2026-04-29 18:29:00
374	82	BTCUSDT	option	buy	10100.00	78328.01000000	78332.64000000	\N	\N	\N	closed	won	1515.00	202.00	2026-05-02 02:20:37	2026-05-02 02:21:38	\N	2026-05-02 02:20:37	2026-05-02 02:21:38
375	78	BTCUSDT	option	buy	40000.00	80266.41000000	80220.58000000	\N	\N	\N	closed	won	7200.00	800.00	2026-05-05 01:30:04	2026-05-05 01:31:35	\N	2026-05-05 01:30:04	2026-05-05 01:31:35
376	10	BTCUSDT	option	buy	80000.00	80903.62000000	80790.82000000	\N	\N	\N	closed	won	17600.00	1600.00	2026-05-05 04:08:33	2026-05-05 04:11:34	\N	2026-05-05 04:08:33	2026-05-05 04:11:34
377	78	BTCUSDT	option	buy	55000.00	79748.88000000	79774.75000000	\N	\N	\N	closed	won	9900.00	1100.00	2026-05-08 01:30:05	2026-05-08 01:31:35	\N	2026-05-08 01:30:05	2026-05-08 01:31:35
378	60	BTCUSDT	option	sell	10001.00	80135.94000000	80135.93000000	\N	\N	\N	closed	won	1500.15	200.02	2026-05-08 23:38:17	2026-05-08 23:39:18	\N	2026-05-08 23:38:17	2026-05-08 23:39:18
379	82	BTCUSDT	option	sell	15000.00	80237.40000000	80223.46000000	\N	\N	\N	closed	won	2250.00	300.00	2026-05-09 01:01:46	2026-05-09 01:02:47	\N	2026-05-09 01:01:46	2026-05-09 01:02:47
380	82	BTCUSDT	option	sell	17000.00	80245.87000000	80237.76000000	\N	\N	\N	closed	won	2550.00	340.00	2026-05-09 01:05:33	2026-05-09 01:06:33	\N	2026-05-09 01:05:33	2026-05-09 01:06:33
381	88	BTCUSDT	option	buy	900.00	80276.07000000	80264.01000000	\N	\N	\N	closed	won	108.00	18.00	2026-05-09 14:35:31	2026-05-09 14:36:01	\N	2026-05-09 14:35:31	2026-05-09 14:36:01
382	88	BTCUSDT	option	buy	950.00	80257.06000000	80265.20000000	\N	\N	\N	closed	won	114.00	19.00	2026-05-09 14:38:41	2026-05-09 14:39:12	\N	2026-05-09 14:38:41	2026-05-09 14:39:12
383	88	BTCUSDT	option	buy	900.00	80271.38000000	80271.38000000	\N	\N	\N	closed	won	108.00	18.00	2026-05-09 14:41:09	2026-05-09 14:41:40	\N	2026-05-09 14:41:09	2026-05-09 14:41:40
384	88	BTCUSDT	option	buy	100.00	81480.96000000	81444.83000000	\N	\N	\N	closed	lost	-100.00	2.00	2026-05-10 19:25:50	2026-05-10 19:26:21	\N	2026-05-10 19:25:50	2026-05-10 19:26:21
385	78	BTCUSDT	option	sell	65000.00	81545.19000000	81611.16000000	\N	\N	\N	closed	won	11700.00	1300.00	2026-05-12 01:00:06	2026-05-12 01:01:37	\N	2026-05-12 01:00:06	2026-05-12 01:01:37
386	60	BTCUSDT	option	buy	14000.00	81357.64000000	81305.63000000	\N	\N	\N	closed	won	2100.00	280.00	2026-05-12 01:21:01	2026-05-12 01:22:02	\N	2026-05-12 01:21:01	2026-05-12 01:22:02
387	41	XAUUSD	option	buy	55000.00	4727.86637537	4727.86637537	\N	\N	\N	closed	won	9900.00	1100.00	2026-05-12 02:20:49	2026-05-12 02:22:19	\N	2026-05-12 02:20:49	2026-05-12 02:22:19
388	25	BTCUSDT	option	buy	6000.00	81000.00000000	81048.74000000	\N	\N	\N	closed	won	720.00	120.00	2026-05-12 07:11:11	2026-05-12 07:11:42	\N	2026-05-12 07:11:11	2026-05-12 07:11:42
389	47	BTCUSDT	option	buy	65000.00	80398.00000000	80399.54000000	\N	\N	\N	closed	won	11700.00	1300.00	2026-05-12 15:54:21	2026-05-12 15:55:52	\N	2026-05-12 15:54:21	2026-05-12 15:55:52
390	41	XAUUSD	option	buy	115000.00	4704.94579197	4704.94579197	\N	\N	\N	closed	won	25300.00	2300.00	2026-05-13 02:32:03	2026-05-13 02:35:03	\N	2026-05-13 02:32:03	2026-05-13 02:35:03
391	41	XAUUSD	option	buy	70000.00	4670.28052974	4670.28052974	\N	\N	\N	closed	won	12600.00	1400.00	2026-05-14 19:03:49	2026-05-14 19:05:20	\N	2026-05-14 19:03:49	2026-05-14 19:05:20
392	82	BTCUSDT	option	buy	19000.00	79159.14000000	79159.14000000	\N	\N	\N	closed	won	2850.00	380.00	2026-05-16 03:07:33	2026-05-16 03:08:34	\N	2026-05-16 03:07:33	2026-05-16 03:08:34
393	88	BTCUSDT	option	buy	1500.00	78055.89000000	78055.89000000	\N	\N	\N	closed	won	180.00	30.00	2026-05-17 15:15:13	2026-05-17 15:15:44	\N	2026-05-17 15:15:13	2026-05-17 15:15:44
394	88	BTCUSDT	option	buy	1700.00	77941.96000000	77930.39000000	\N	\N	\N	closed	won	204.00	34.00	2026-05-17 15:17:39	2026-05-17 15:18:10	\N	2026-05-17 15:17:39	2026-05-17 15:18:10
395	10	BTCUSDT	option	buy	30000.00	78037.04000000	78045.24000000	\N	\N	\N	closed	won	4500.00	600.00	2026-05-17 15:20:53	2026-05-17 15:21:54	\N	2026-05-17 15:20:53	2026-05-17 15:21:54
396	10	BTCUSDT	option	buy	60000.00	78045.24000000	78037.05000000	\N	\N	\N	closed	won	10800.00	1200.00	2026-05-17 15:21:57	2026-05-17 15:23:27	\N	2026-05-17 15:21:57	2026-05-17 15:23:27
397	31	BTCUSDT	option	buy	46780.00	76961.03000000	76985.02000000	\N	\N	\N	closed	won	8420.40	935.60	2026-05-18 03:48:47	2026-05-18 03:50:18	\N	2026-05-18 03:48:47	2026-05-18 03:50:18
398	78	BTCUSDT	option	sell	120000.00	76660.01000000	76681.60000000	\N	\N	\N	closed	won	26400.00	2400.00	2026-05-19 02:00:04	2026-05-19 02:03:05	\N	2026-05-19 02:00:04	2026-05-19 02:03:05
399	78	BTCUSDT	option	sell	120000.00	77894.01000000	77764.24000000	\N	\N	\N	closed	won	26400.00	2400.00	2026-05-21 18:00:03	2026-05-21 18:03:04	\N	2026-05-21 18:00:03	2026-05-21 18:03:04
400	60	BTCUSDT	option	buy	1100.00	77713.89000000	77721.17000000	\N	\N	\N	closed	won	132.00	22.00	2026-05-22 03:14:47	2026-05-22 03:15:17	\N	2026-05-22 03:14:47	2026-05-22 03:15:17
401	82	XAUUSD	option	buy	26500.00	4509.59913271	4509.62963765	\N	\N	\N	closed	won	3975.00	530.00	2026-05-23 01:56:06	2026-05-23 01:57:06	\N	2026-05-23 01:56:06	2026-05-23 01:57:06
402	51	BTCUSDT	contract	sell	500.00	76145.23000000	76147.91000000	\N	\N	\N	closed	lost	-500.00	10.00	2026-05-24 21:46:50	2026-05-24 21:46:50	\N	2026-05-24 21:46:50	2026-05-24 21:46:50
403	41	XAUUSD	option	buy	100000.00	4570.81843247	4570.81843247	\N	\N	\N	closed	won	22000.00	2000.00	2026-05-25 12:11:47	2026-05-25 12:14:47	\N	2026-05-25 12:11:47	2026-05-25 12:14:47
404	78	BTCUSDT	option	buy	30000.00	77134.54000000	77173.25000000	\N	\N	\N	closed	won	4500.00	600.00	2026-05-26 00:30:14	2026-05-26 00:31:15	\N	2026-05-26 00:30:14	2026-05-26 00:31:15
405	41	XAUUSD	option	buy	50000.00	4494.71129795	4494.71129795	\N	\N	\N	closed	won	9000.00	1000.00	2026-05-29 01:13:53	2026-05-29 01:15:24	\N	2026-05-29 01:13:53	2026-05-29 01:15:24
406	10	BTCUSDT	option	buy	70001.00	73350.58000000	73361.88000000	\N	\N	\N	closed	won	15400.22	1400.02	2026-05-29 03:47:41	2026-05-29 03:50:42	\N	2026-05-29 03:47:41	2026-05-29 03:50:42
407	78	BTCUSDT	option	buy	69000.00	73498.81000000	73474.88000000	\N	\N	\N	closed	won	12420.00	1380.00	2026-05-30 01:00:02	2026-05-30 01:01:33	\N	2026-05-30 01:00:02	2026-05-30 01:01:33
408	82	XAUUSD	option	buy	30000.00	4539.72211453	4539.72211453	\N	\N	\N	closed	won	4500.00	600.00	2026-05-30 01:31:54	2026-05-30 01:32:55	\N	2026-05-30 01:31:54	2026-05-30 01:32:55
409	60	BTCUSDT	option	buy	11000.00	73918.09000000	73937.58000000	\N	\N	\N	closed	won	1650.00	220.00	2026-06-01 03:20:08	2026-06-01 03:21:09	\N	2026-06-01 03:20:08	2026-06-01 03:21:09
410	31	XAUUSD	option	buy	58620.00	4468.62866277	4468.62866277	\N	\N	\N	closed	won	10551.60	1172.40	2026-06-01 16:43:49	2026-06-01 16:45:20	\N	2026-06-01 16:43:49	2026-06-01 16:45:20
411	38	XAUUSD	option	sell	40000.00	4468.62866277	4468.62866277	\N	\N	\N	closed	won	7200.00	800.00	2026-06-01 16:44:18	2026-06-01 16:45:48	\N	2026-06-01 16:44:18	2026-06-01 16:45:48
412	41	XAUUSD	option	buy	70000.00	4468.62866277	4468.62866277	\N	\N	\N	closed	won	12600.00	1400.00	2026-06-01 16:59:28	2026-06-01 17:00:59	\N	2026-06-01 16:59:28	2026-06-01 17:00:59
413	82	XAUUSD	option	buy	35000.00	4485.08127416	4485.08127416	\N	\N	\N	closed	won	6300.00	700.00	2026-06-02 01:38:23	2026-06-02 01:39:53	\N	2026-06-02 01:38:23	2026-06-02 01:39:53
414	88	BTCUSDT	option	buy	100.00	66454.02000000	66444.02000000	\N	\N	\N	closed	won	12.00	2.00	2026-06-03 03:12:19	2026-06-03 03:12:50	\N	2026-06-03 03:12:19	2026-06-03 03:12:50
415	88	XAUUSD	option	buy	5200.00	4482.98416117	4482.98416117	\N	\N	\N	closed	won	624.00	104.00	2026-06-03 03:14:57	2026-06-03 03:15:27	\N	2026-06-03 03:14:57	2026-06-03 03:15:27
416	31	XAUUSD	option	sell	45768.00	4468.83235220	4468.83235220	\N	\N	\N	closed	won	8238.24	915.36	2026-06-03 05:28:42	2026-06-03 05:30:13	\N	2026-06-03 05:28:42	2026-06-03 05:30:13
417	78	BTCUSDT	option	buy	69900.00	65833.84000000	65841.99000000	\N	\N	\N	closed	won	12582.00	1398.00	2026-06-03 17:10:55	2026-06-03 17:12:26	\N	2026-06-03 17:10:55	2026-06-03 17:12:26
418	78	BTCUSDT	option	buy	69000.00	65753.99000000	65823.87000000	\N	\N	\N	closed	won	12420.00	1380.00	2026-06-03 17:16:52	2026-06-03 17:18:23	\N	2026-06-03 17:16:52	2026-06-03 17:18:23
419	82	XAUUSD	option	buy	55000.00	4446.21107231	4446.21107231	\N	\N	\N	closed	lost	-55000.00	1100.00	2026-06-04 01:06:31	2026-06-04 01:08:01	\N	2026-06-04 01:06:31	2026-06-04 01:08:01
420	82	XAUUSD	option	buy	55000.00	4461.43557397	4461.43557397	\N	\N	\N	closed	won	9900.00	1100.00	2026-06-04 01:32:50	2026-06-04 01:34:20	\N	2026-06-04 01:32:50	2026-06-04 01:34:20
421	10	XAUUSD	option	buy	10000.00	4467.05369220	4467.05369220	\N	\N	\N	closed	won	1200.00	200.00	2026-06-04 03:46:20	2026-06-04 03:46:50	\N	2026-06-04 03:46:20	2026-06-04 03:46:50
422	10	XAUUSD	option	buy	10000.00	4467.05369220	4467.05369220	\N	\N	\N	closed	won	1200.00	200.00	2026-06-04 03:47:44	2026-06-04 03:48:14	\N	2026-06-04 03:47:44	2026-06-04 03:48:14
423	10	XAUUSD	option	buy	30000.00	4467.05369220	4467.05369220	\N	\N	\N	closed	won	4500.00	600.00	2026-06-04 03:52:31	2026-06-04 03:53:32	\N	2026-06-04 03:52:31	2026-06-04 03:53:32
424	31	XAUUSD	option	buy	42863.00	4439.59049217	4439.59049217	\N	\N	\N	closed	won	7715.34	857.26	2026-06-05 03:47:15	2026-06-05 03:48:45	\N	2026-06-05 03:47:15	2026-06-05 03:48:45
425	57	BTCUSDT	option	buy	100.00	61756.05000000	61751.04000000	\N	\N	\N	closed	lost	-100.00	2.00	2026-06-05 21:11:28	2026-06-05 21:11:59	\N	2026-06-05 21:11:28	2026-06-05 21:11:59
426	31	XAUUSD	option	buy	52430.00	4339.69764459	4339.69764459	\N	\N	\N	closed	won	9437.40	1048.60	2026-06-08 18:00:26	2026-06-08 18:01:56	\N	2026-06-08 18:00:26	2026-06-08 18:01:56
427	41	XAUUSD	option	buy	60000.00	4251.69706488	4251.69706488	\N	\N	\N	closed	won	10800.00	1200.00	2026-06-09 19:57:01	2026-06-09 19:58:32	\N	2026-06-09 19:57:01	2026-06-09 19:58:32
428	41	XAUUSD	option	buy	100000.00	4102.54727160	4102.54727160	\N	\N	\N	closed	won	22000.00	2000.00	2026-06-10 19:07:13	2026-06-10 19:10:13	\N	2026-06-10 19:07:13	2026-06-10 19:10:13
429	31	XAUUSD	option	buy	62490.00	4073.99018005	4073.99018005	\N	\N	\N	closed	won	11248.20	1249.80	2026-06-11 15:14:32	2026-06-11 15:16:02	\N	2026-06-11 15:14:32	2026-06-11 15:16:02
430	31	XAUUSD	option	buy	63490.00	4073.99018005	4073.99018005	\N	\N	\N	closed	won	11428.20	1269.80	2026-06-11 15:17:37	2026-06-11 15:19:08	\N	2026-06-11 15:17:37	2026-06-11 15:19:08
431	60	BTCUSDT	option	sell	18000.00	63362.00000000	63404.00000000	\N	\N	\N	closed	won	2700.00	360.00	2026-06-12 01:44:59	2026-06-12 01:46:00	\N	2026-06-12 01:44:59	2026-06-12 01:46:00
432	91	BTCUSDT	option	sell	190.00	64591.99000000	64610.00000000	\N	\N	\N	closed	won	22.80	3.80	2026-06-14 01:45:59	2026-06-14 01:46:30	\N	2026-06-14 01:45:59	2026-06-14 01:46:30
433	31	XAUUSD	option	buy	58496.00	4356.12165777	4356.12165777	\N	\N	\N	closed	won	10529.28	1169.92	2026-06-15 15:38:16	2026-06-15 15:39:47	\N	2026-06-15 15:38:16	2026-06-15 15:39:47
434	91	BTCUSDT	option	buy	190.00	65877.31000000	65886.00000000	\N	\N	\N	closed	won	22.80	3.80	2026-06-16 15:41:47	2026-06-16 15:42:17	\N	2026-06-16 15:41:47	2026-06-16 15:42:17
435	60	BTCUSDT	option	buy	20000.00	65782.00000000	65808.00000000	\N	\N	\N	closed	won	3000.00	400.00	2026-06-17 00:32:50	2026-06-17 00:33:51	\N	2026-06-17 00:32:50	2026-06-17 00:33:51
436	82	BTCUSDT	option	buy	30000.00	65872.00000000	65844.26000000	\N	\N	\N	closed	won	4500.00	600.00	2026-06-17 02:09:26	2026-06-17 02:10:26	\N	2026-06-17 02:09:26	2026-06-17 02:10:26
437	41	XAUUSD	option	sell	60000.00	4185.35427350	4185.35427350	\N	\N	\N	closed	won	10800.00	1200.00	2026-06-19 00:34:10	2026-06-19 00:35:40	\N	2026-06-19 00:34:10	2026-06-19 00:35:40
438	38	XAUUSD	option	sell	15500.00	4152.86703558	4152.86703558	\N	\N	\N	closed	lost	-15500.00	310.00	2026-06-19 18:20:30	2026-06-19 18:21:30	\N	2026-06-19 18:20:30	2026-06-19 18:21:30
439	38	XAUUSD	option	sell	140000.00	4152.86703558	4155.68354137	\N	\N	\N	closed	lost	-140000.00	2800.00	2026-06-19 18:20:50	2026-06-19 18:25:50	\N	2026-06-19 18:20:50	2026-06-19 18:25:50
440	88	XAUUSD	option	buy	6200.00	4155.63345983	4155.63345983	\N	\N	\N	closed	won	744.00	124.00	2026-06-20 02:48:19	2026-06-20 02:48:49	\N	2026-06-20 02:48:19	2026-06-20 02:48:49
441	88	XAGUSD	option	sell	6800.00	64.83483281	64.83483281	\N	\N	\N	closed	won	816.00	136.00	2026-06-20 02:50:10	2026-06-20 02:50:40	\N	2026-06-20 02:50:10	2026-06-20 02:50:40
442	88	BTCUSDT	option	buy	100.00	63354.73000000	63363.99000000	\N	\N	\N	closed	lost	-100.00	2.00	2026-06-20 02:52:03	2026-06-20 02:52:33	\N	2026-06-20 02:52:03	2026-06-20 02:52:33
443	41	XAUUSD	option	buy	70000.00	4180.51462135	4180.51462135	\N	\N	\N	closed	won	12600.00	1400.00	2026-06-23 00:41:01	2026-06-23 00:42:31	\N	2026-06-23 00:41:01	2026-06-23 00:42:31
444	10	BTCUSDT	option	buy	50000.00	64229.68000000	64264.62000000	\N	\N	\N	closed	won	9000.00	1000.00	2026-06-23 02:55:48	2026-06-23 02:57:19	\N	2026-06-23 02:55:48	2026-06-23 02:57:19
445	91	BTCUSDT	option	buy	200.00	62752.49000000	62698.00000000	\N	\N	\N	closed	lost	-200.00	4.00	2026-06-23 14:36:46	2026-06-23 14:37:17	\N	2026-06-23 14:36:46	2026-06-23 14:37:17
446	31	XAUUSD	option	sell	54178.00	4131.61166321	4131.61166321	\N	\N	\N	closed	won	9752.04	1083.56	2026-06-23 14:51:09	2026-06-23 14:52:39	\N	2026-06-23 14:51:09	2026-06-23 14:52:39
448	92	XAUUSD	option	buy	250.00	4095.81420076	4095.81420076	\N	\N	\N	closed	won	30.00	5.00	2026-06-24 01:49:51	2026-06-24 01:50:21	\N	2026-06-24 01:49:51	2026-06-24 01:50:21
447	41	XAUUSD	option	buy	50000.00	4095.81420076	4095.81420076	\N	\N	\N	closed	won	9000.00	1000.00	2026-06-24 01:49:36	2026-06-24 01:51:06	\N	2026-06-24 01:49:36	2026-06-24 01:51:06
449	31	XAUUSD	option	buy	42000.00	3977.48742120	3977.48742120	\N	\N	\N	closed	won	7560.00	840.00	2026-06-24 19:31:34	2026-06-24 19:33:04	\N	2026-06-24 19:31:34	2026-06-24 19:33:04
450	60	BTCUSDT	option	sell	23000.00	60844.01000000	60833.99000000	\N	\N	\N	closed	won	3450.00	460.00	2026-06-25 01:01:46	2026-06-25 01:02:47	\N	2026-06-25 01:01:46	2026-06-25 01:02:47
451	92	XAUUSD	option	buy	300.00	4027.36351869	4027.36351869	\N	\N	\N	closed	won	36.00	6.00	2026-06-25 23:51:21	2026-06-25 23:51:51	\N	2026-06-25 23:51:21	2026-06-25 23:51:51
452	41	XAUUSD	option	buy	50000.00	4027.36351869	4027.36351869	\N	\N	\N	closed	won	9000.00	1000.00	2026-06-25 23:51:48	2026-06-25 23:53:18	\N	2026-06-25 23:51:48	2026-06-25 23:53:18
453	41	BTCUSDT	option	buy	50000.00	59971.54000000	59960.00000000	\N	\N	\N	closed	won	9000.00	1000.00	2026-06-27 01:15:25	2026-06-27 01:16:56	\N	2026-06-27 01:15:25	2026-06-27 01:16:56
454	91	BTCUSDT	option	sell	1200.00	60531.02000000	60532.00000000	\N	\N	\N	closed	won	144.00	24.00	2026-06-27 14:01:22	2026-06-27 14:01:53	\N	2026-06-27 14:01:22	2026-06-27 14:01:53
455	91	BTCUSDT	option	buy	1600.00	59146.01000000	59196.00000000	\N	\N	\N	closed	won	192.00	32.00	2026-06-29 14:21:57	2026-06-29 14:22:28	\N	2026-06-29 14:21:57	2026-06-29 14:22:28
457	92	XAUUSD	option	buy	325.00	4001.43091169	4001.43091169	\N	\N	\N	closed	won	39.00	6.50	2026-06-30 00:59:04	2026-06-30 00:59:35	\N	2026-06-30 00:59:04	2026-06-30 00:59:35
456	41	XAUUSD	option	sell	50000.00	4001.43091169	4001.43091169	\N	\N	\N	closed	won	9000.00	1000.00	2026-06-30 00:59:00	2026-06-30 01:00:31	\N	2026-06-30 00:59:00	2026-06-30 01:00:31
458	31	XAUUSD	option	buy	45259.00	4106.15730607	4106.15730607	\N	\N	\N	closed	won	8146.62	905.18	2026-07-02 16:44:57	2026-07-02 16:46:27	\N	2026-07-02 16:44:57	2026-07-02 16:46:27
459	88	BTCUSDT	option	buy	7800.00	62554.00000000	62540.38000000	\N	\N	\N	closed	won	936.00	156.00	2026-07-04 03:03:52	2026-07-04 03:04:23	\N	2026-07-04 03:03:52	2026-07-04 03:04:23
460	88	BTCUSDT	option	buy	10500.00	64168.33000000	64175.88000000	\N	\N	\N	closed	won	1575.00	210.00	2026-07-11 03:11:24	2026-07-11 03:12:24	\N	2026-07-11 03:11:24	2026-07-11 03:12:24
461	60	BTCUSDT	option	sell	26000.00	64173.99000000	64174.00000000	\N	\N	\N	closed	won	3900.00	520.00	2026-07-11 03:38:15	2026-07-11 03:39:16	\N	2026-07-11 03:38:15	2026-07-11 03:39:16
462	4	BTCUSDT	option	buy	1000.00	64140.46000000	64134.26000000	\N	\N	\N	closed	lost	-1000.00	20.00	2026-07-11 04:27:44	2026-07-11 04:28:15	\N	2026-07-11 04:27:44	2026-07-11 04:28:15
463	31	BTCUSDT	option	buy	35846.00	64437.07000000	64424.73000000	\N	\N	\N	closed	won	6452.28	716.92	2026-07-11 15:34:39	2026-07-11 15:36:09	\N	2026-07-11 15:34:39	2026-07-11 15:36:09
464	31	BTCUSDT	option	buy	42637.00	62380.01000000	62325.99000000	\N	\N	\N	closed	won	7674.66	852.74	2026-07-14 03:20:36	2026-07-14 03:22:07	\N	2026-07-14 03:20:36	2026-07-14 03:22:07
465	41	BTCUSDT	option	buy	10000.00	64848.02000000	64909.70000000	\N	\N	\N	closed	won	1200.00	200.00	2026-07-14 15:32:53	2026-07-14 15:33:23	\N	2026-07-14 15:32:53	2026-07-14 15:33:23
466	41	BTCUSDT	option	buy	60000.00	64696.00000000	64728.95000000	\N	\N	\N	closed	won	10800.00	1200.00	2026-07-14 15:41:49	2026-07-14 15:43:20	\N	2026-07-14 15:41:49	2026-07-14 15:43:20
467	92	BTCUSDT	option	buy	100.00	64727.02000000	64755.60000000	\N	\N	\N	closed	lost	-100.00	2.00	2026-07-14 15:43:06	2026-07-14 15:43:37	\N	2026-07-14 15:43:06	2026-07-14 15:43:37
468	91	BTCUSDT	option	buy	10000.00	65370.33000000	65384.02000000	\N	\N	\N	closed	won	1200.00	200.00	2026-07-15 14:44:50	2026-07-15 14:45:21	\N	2026-07-15 14:44:50	2026-07-15 14:45:21
469	10	BTCUSDT	option	buy	70000.00	64801.54000000	64774.01000000	\N	\N	\N	closed	won	12600.00	1400.00	2026-07-16 05:17:55	2026-07-16 05:19:25	\N	2026-07-16 05:17:55	2026-07-16 05:19:25
470	96	BTCUSDT	option	buy	950.00	64823.00000000	64836.70000000	\N	\N	\N	closed	won	114.00	19.00	2026-07-16 05:20:55	2026-07-16 05:21:25	\N	2026-07-16 05:20:55	2026-07-16 05:21:25
471	91	BTCUSDT	option	sell	11000.00	62946.59000000	62963.99000000	\N	\N	\N	closed	won	1650.00	220.00	2026-07-17 15:15:54	2026-07-17 15:16:55	\N	2026-07-17 15:15:54	2026-07-17 15:16:55
472	96	BTCUSDT	option	sell	900.00	63950.23000000	63932.00000000	\N	\N	\N	closed	won	108.00	18.00	2026-07-18 02:05:12	2026-07-18 02:05:42	\N	2026-07-18 02:05:12	2026-07-18 02:05:42
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (id, user_id, trade_id, type, amount, currency, balance, description, created_at, updated_at) FROM stdin;
1	5	1	trade_amount	-100.00	USDT	58295.00	Amount for buy option trade on LTCUSDT	\N	\N
2	5	1	fee	-2.00	USDT	58293.00	Fee for buy option trade on LTCUSDT	\N	\N
3	9	2	trade_amount	-9500.00	USDT	582.00	Amount for buy option trade on LTCUSDT	\N	\N
4	9	2	fee	-190.00	USDT	392.00	Fee for buy option trade on LTCUSDT	\N	\N
5	9	2	trade_win	11400.00	USDT	11792.00	Won buy trade on LTCUSDT	2025-12-07 04:53:15	2025-12-07 04:53:15
6	10	3	trade_amount	-80000.00	USDT	620000.00	Amount for buy option trade on BTCUSDT	\N	\N
7	10	3	fee	-1600.00	USDT	618400.00	Fee for buy option trade on BTCUSDT	\N	\N
8	10	3	trade_win	100000.00	USDT	718400.00	Won buy trade on BTCUSDT	2025-12-07 05:00:51	2025-12-07 05:00:51
9	12	4	trade_amount	-80000.00	USDT	136487.00	Amount for buy option trade on ETHUSDT	\N	\N
10	12	4	fee	-1600.00	USDT	134887.00	Fee for buy option trade on ETHUSDT	\N	\N
11	12	4	trade_win	100000.00	USDT	234887.00	Won buy trade on ETHUSDT	2025-12-08 06:11:02	2025-12-08 06:11:02
12	12	5	trade_amount	-80000.00	USDT	154887.00	Amount for buy option trade on ETHUSDT	\N	\N
13	12	5	fee	-1600.00	USDT	153287.00	Fee for buy option trade on ETHUSDT	\N	\N
14	12	5	trade_win	100000.00	USDT	253287.00	Won buy trade on ETHUSDT	2025-12-08 06:13:16	2025-12-08 06:13:16
15	12	6	trade_amount	-5000.00	USDT	248287.00	Amount for buy spot trade USDT to ETH	\N	\N
16	12	6	fee	-100.00	USDT	248187.00	Fee for buy spot trade USDT to ETH	\N	\N
17	12	7	trade_amount	-5000.00	USDT	243187.00	Amount for buy contract trade on ETHUSDT with 100x leverage	\N	\N
18	12	7	fee	-100.00	USDT	243087.00	Fee for buy contract trade on ETHUSDT	\N	\N
19	12	7	trade_win	5000.00	USDT	248087.00	Won buy trade on ETHUSDT	2025-12-08 06:15:23	2025-12-08 06:15:23
20	12	8	trade_amount	-200000.00	USDT	48087.00	Amount for sell option trade on ETHUSDT	\N	\N
21	12	8	fee	-4000.00	USDT	44087.00	Fee for sell option trade on ETHUSDT	\N	\N
22	12	8	trade_win	260000.00	USDT	304087.00	Won sell trade on ETHUSDT	2025-12-08 06:19:13	2025-12-08 06:19:13
23	12	9	trade_amount	-4000.00	USDT	300087.00	Amount for buy option trade on ETHUSDT	\N	\N
24	12	9	fee	-80.00	USDT	300007.00	Fee for buy option trade on ETHUSDT	\N	\N
25	12	9	trade_win	4600.00	USDT	304607.00	Won buy trade on ETHUSDT	2025-12-08 06:22:46	2025-12-08 06:22:46
26	12	10	trade_amount	-4900.00	USDT	299707.00	Amount for sell option trade on XRPUSDT	\N	\N
27	12	10	fee	-98.00	USDT	299609.00	Fee for sell option trade on XRPUSDT	\N	\N
28	12	10	trade_win	5635.00	USDT	305244.00	Won sell trade on XRPUSDT	2025-12-08 06:24:20	2025-12-08 06:24:20
29	12	\N	withdrawal	-75000.00	USDT	230224.00	Withdrawal of 75000 USDT via TRC20 to 0xA46873e4236199fE24cb1Ea2D8716674E5C99Ae3	2025-12-08 06:31:34	2025-12-08 06:31:34
30	12	\N	fee	-20.00	USDT	230224.00	Fee for withdrawal of 75000 USDT via TRC20	2025-12-08 06:31:34	2025-12-08 06:31:34
31	12	\N	withdrawal	-18000.00	USDT	212204.00	Withdrawal of 18000 USDT via TRC20 to 0xA46873e4236199fE24cb1Ea2D8716674E5C99Ae3	2025-12-08 06:31:43	2025-12-08 06:31:43
32	12	\N	fee	-20.00	USDT	212204.00	Fee for withdrawal of 18000 USDT via TRC20	2025-12-08 06:31:43	2025-12-08 06:31:43
33	12	\N	withdrawal	-40000.00	USDT	172184.00	Withdrawal of 40000 USDT via ERC20 to 0xA46873e4236199fE24cb1Ea2D8716674E5C99Ae3	2025-12-08 06:32:37	2025-12-08 06:32:37
34	12	\N	fee	-20.00	USDT	172184.00	Fee for withdrawal of 40000 USDT via ERC20	2025-12-08 06:32:37	2025-12-08 06:32:37
35	12	\N	deposit	199990.00	USDT	372174.00	Deposit of 199990 USDT via crypto approved	2025-12-08 06:35:40	2025-12-08 06:35:40
36	12	\N	deposit	199990.00	USDT	572164.00	Deposit of 199990 USDT via crypto approved	2025-12-08 06:35:45	2025-12-08 06:35:45
37	12	\N	deposit	50000.00	BTC	572164.00	Deposit of 50000 BTC via crypto approved	2025-12-08 06:36:16	2025-12-08 06:36:16
38	6	11	trade_amount	-30000.00	USDT	4970000.00	Amount for buy option trade on BTCUSDT	\N	\N
39	6	11	fee	-600.00	USDT	4969400.00	Fee for buy option trade on BTCUSDT	\N	\N
40	6	11	trade_win	37500.00	USDT	5006900.00	Won buy trade on BTCUSDT	2025-12-08 19:18:46	2025-12-08 19:18:46
41	12	\N	arbitrage_purchase	-1500.00	USDT	570664.00	\N	2025-12-09 02:28:29	2025-12-09 02:28:29
42	12	\N	arbitrage_purchase	-150000.00	USDT	420664.00	\N	2025-12-09 02:29:03	2025-12-09 02:29:03
43	12	12	trade_amount	-50000.00	USDT	370664.00	Amount for sell option trade on TSLA	\N	\N
44	12	12	fee	-1000.00	USDT	369664.00	Fee for sell option trade on TSLA	\N	\N
45	12	12	trade_win	62500.00	USDT	432164.00	Won sell trade on TSLA	2025-12-09 04:13:52	2025-12-09 04:13:52
46	12	13	trade_amount	-8000.00	USDT	424164.00	Amount for buy option trade on ETHUSDT	\N	\N
47	12	13	fee	-160.00	USDT	424004.00	Fee for buy option trade on ETHUSDT	\N	\N
48	12	13	trade_win	9600.00	USDT	433604.00	Won buy trade on ETHUSDT	2025-12-09 05:35:32	2025-12-09 05:35:32
49	7	14	trade_amount	-4000.00	USDT	120.00	Amount for buy option trade on ETHUSDT	\N	\N
50	7	14	fee	-80.00	USDT	40.00	Fee for buy option trade on ETHUSDT	\N	\N
51	7	14	trade_win	4600.00	USDT	4640.00	Won buy trade on ETHUSDT	2025-12-09 16:22:52	2025-12-09 16:22:52
52	12	\N	withdrawal	-500.00	USDT	433096.50	Withdrawal of 500 USDT via ERC20 to 0xA46873e4236199fE24cb1Ea2D8716674E5C99Ae3	2025-12-09 20:26:06	2025-12-09 20:26:06
53	12	\N	fee	-7.50	USDT	433096.50	Fee for withdrawal of 500 USDT via ERC20	2025-12-09 20:26:06	2025-12-09 20:26:06
54	12	\N	arbitrage_profit	7.50	USDT	434604.00	\N	2025-12-10 02:28:29	2025-12-10 02:28:29
55	9	15	trade_amount	-15000.00	USDT	628.00	Amount for buy option trade on BTCUSDT	\N	\N
56	9	15	fee	-300.00	USDT	328.00	Fee for buy option trade on BTCUSDT	\N	\N
57	9	15	trade_win	18000.00	USDT	18328.00	Won buy trade on BTCUSDT	2025-12-10 04:11:43	2025-12-10 04:11:43
58	12	16	trade_amount	-80000.00	USDT	354604.00	Amount for buy option trade on BTCUSDT	\N	\N
59	12	16	fee	-1600.00	USDT	353004.00	Fee for buy option trade on BTCUSDT	\N	\N
60	12	16	trade_win	100000.00	USDT	453004.00	Won buy trade on BTCUSDT	2025-12-10 04:14:41	2025-12-10 04:14:41
61	6	17	trade_amount	-15000.00	USDT	4991900.00	Amount for buy option trade on BTCUSDT	\N	\N
62	6	17	fee	-300.00	USDT	4991600.00	Fee for buy option trade on BTCUSDT	\N	\N
63	6	17	trade_win	18000.00	USDT	5009600.00	Won buy trade on BTCUSDT	2025-12-11 00:06:54	2025-12-11 00:06:54
64	6	18	trade_amount	-35000.00	USDT	4974600.00	Amount for buy option trade on BTCUSDT	\N	\N
65	6	18	fee	-700.00	USDT	4973900.00	Fee for buy option trade on BTCUSDT	\N	\N
66	6	18	trade_win	43750.00	USDT	5017650.00	Won buy trade on BTCUSDT	2025-12-12 03:49:09	2025-12-12 03:49:09
67	6	19	trade_amount	-35000.00	USDT	4982650.00	Amount for buy option trade on BTCUSDT	\N	\N
68	6	19	fee	-700.00	USDT	4981950.00	Fee for buy option trade on BTCUSDT	\N	\N
69	6	19	trade_win	43750.00	USDT	5025700.00	Won buy trade on BTCUSDT	2025-12-12 03:56:32	2025-12-12 03:56:32
70	12	20	trade_amount	-8000.00	USDT	445004.00	Amount for sell option trade on BTCUSDT	\N	\N
71	12	20	fee	-160.00	USDT	444844.00	Fee for sell option trade on BTCUSDT	\N	\N
72	12	20	trade_win	9600.00	USDT	454444.00	Won sell trade on BTCUSDT	2025-12-13 02:06:27	2025-12-13 02:06:27
73	12	21	trade_amount	-32000.00	USDT	422444.00	Amount for sell option trade on BTCUSDT	\N	\N
74	12	21	fee	-640.00	USDT	421804.00	Fee for sell option trade on BTCUSDT	\N	\N
75	12	21	trade_win	40000.00	USDT	461804.00	Won sell trade on BTCUSDT	2025-12-13 02:12:46	2025-12-13 02:12:46
76	9	22	trade_amount	-33000.00	USDT	2427.00	Amount for sell option trade on BTCUSDT	\N	\N
77	9	22	fee	-660.00	USDT	1767.00	Fee for sell option trade on BTCUSDT	\N	\N
78	9	22	trade_win	41250.00	USDT	43017.00	Won sell trade on BTCUSDT	2025-12-13 02:16:58	2025-12-13 02:16:58
79	12	23	trade_amount	-5500.00	USDT	456304.00	Amount for buy option trade on GOOGL	\N	\N
80	12	23	fee	-110.00	USDT	456194.00	Fee for buy option trade on GOOGL	\N	\N
81	12	23	trade_win	6600.00	USDT	462794.00	Won buy trade on GOOGL	2025-12-14 02:11:37	2025-12-14 02:11:37
82	4	24	trade_amount	-5000.00	USDT	95000.00	Amount for buy option trade on ETHUSDT	\N	\N
83	4	24	fee	-100.00	USDT	94900.00	Fee for buy option trade on ETHUSDT	\N	\N
84	4	24	trade_win	5750.00	USDT	100650.00	Won buy trade on ETHUSDT	2025-12-14 07:53:48	2025-12-14 07:53:48
85	4	\N	withdrawal	-500.00	USDT	100146.50	Withdrawal of 500 USDT via TRC20 to 0xA46873e4236199fE24cb1Ea2D8716674E5C99Ae3	2025-12-14 09:47:49	2025-12-14 09:47:49
86	4	\N	fee	-3.50	USDT	100146.50	Fee for withdrawal of 500 USDT via TRC20	2025-12-14 09:47:49	2025-12-14 09:47:49
87	12	25	trade_amount	-10000.00	USDT	452794.00	Amount for buy option trade on BTCUSDT	\N	\N
88	12	25	fee	-200.00	USDT	452594.00	Fee for buy option trade on BTCUSDT	\N	\N
89	12	25	trade_win	12000.00	USDT	464594.00	Won buy trade on BTCUSDT	2025-12-17 02:01:44	2025-12-17 02:01:44
90	12	26	trade_amount	-4000.00	USDT	460594.00	Amount for buy option trade on BTCUSDT	\N	\N
91	12	26	fee	-80.00	USDT	460514.00	Fee for buy option trade on BTCUSDT	\N	\N
92	12	26	trade_win	4600.00	USDT	465114.00	Won buy trade on BTCUSDT	2025-12-17 02:03:17	2025-12-17 02:03:17
93	6	27	trade_amount	-40000.00	USDT	4985700.00	Amount for buy option trade on BTCUSDT	\N	\N
94	6	27	fee	-800.00	USDT	4984900.00	Fee for buy option trade on BTCUSDT	\N	\N
95	6	27	trade_win	50000.00	USDT	5034900.00	Won buy trade on BTCUSDT	2025-12-17 07:11:36	2025-12-17 07:11:36
96	12	28	trade_amount	-40000.00	USDT	425114.00	Amount for buy option trade on NFLX	\N	\N
97	12	28	fee	-800.00	USDT	424314.00	Fee for buy option trade on NFLX	\N	\N
98	12	28	trade_win	50000.00	USDT	474314.00	Won buy trade on NFLX	2025-12-17 18:54:38	2025-12-17 18:54:38
99	5	29	trade_amount	-110000.00	USDT	3710.00	Amount for buy option trade on BTCUSDT	\N	\N
100	5	29	fee	-2200.00	USDT	1510.00	Fee for buy option trade on BTCUSDT	\N	\N
101	5	29	trade_win	143000.00	USDT	144510.00	Won buy trade on BTCUSDT	2025-12-18 23:16:51	2025-12-18 23:16:51
102	12	30	trade_amount	-200000.00	USDT	274314.00	Amount for sell option trade on ETHUSDT	\N	\N
103	12	30	fee	-4000.00	USDT	270314.00	Fee for sell option trade on ETHUSDT	\N	\N
104	12	30	trade_win	260000.00	USDT	530314.00	Won sell trade on ETHUSDT	2025-12-19 01:44:42	2025-12-19 01:44:42
105	20	31	trade_amount	-1000.00	USDT	100.00	Amount for buy option trade on ETHUSDT	\N	\N
106	20	31	fee	-20.00	USDT	80.00	Fee for buy option trade on ETHUSDT	\N	\N
107	20	31	trade_win	1150.00	USDT	1230.00	Won buy trade on ETHUSDT	2025-12-20 03:54:48	2025-12-20 03:54:48
108	18	32	trade_amount	-500.00	USDT	676.00	Amount for buy contract trade on BTCUSDT with 10x leverage	\N	\N
109	18	32	fee	-10.00	USDT	666.00	Fee for buy contract trade on BTCUSDT	\N	\N
110	18	32	trade_win	500.00	USDT	1166.00	Won buy trade on BTCUSDT	2025-12-21 18:46:23	2025-12-21 18:46:23
111	20	33	trade_amount	-1000.00	USDT	230.00	Amount for buy option trade on BTCUSDT	\N	\N
112	20	33	fee	-20.00	USDT	210.00	Fee for buy option trade on BTCUSDT	\N	\N
113	20	33	trade_win	1120.00	USDT	1330.00	Won buy trade on BTCUSDT	2025-12-22 01:03:46	2025-12-22 01:03:46
114	12	34	trade_amount	-20000.00	USDT	510314.00	Amount for buy option trade on BTCUSDT	\N	\N
115	12	34	fee	-400.00	USDT	509914.00	Fee for buy option trade on BTCUSDT	\N	\N
116	12	34	trade_win	23000.00	USDT	532914.00	Won buy trade on BTCUSDT	2025-12-22 02:34:31	2025-12-22 02:34:31
117	9	35	trade_amount	-20000.00	USDT	47141.00	Amount for sell option trade on BTCUSDT	\N	\N
118	9	35	fee	-400.00	USDT	46741.00	Fee for sell option trade on BTCUSDT	\N	\N
119	9	35	trade_win	23000.00	USDT	69741.00	Won sell trade on BTCUSDT	2025-12-22 02:37:47	2025-12-22 02:37:47
120	16	\N	withdrawal	-20000.00	USDT	75628.00	Withdrawal of 20000 USDT via TRC20 to 0xcbacdageyiouklm	2025-12-22 20:14:22	2025-12-22 20:14:22
121	16	\N	fee	-20.00	USDT	75628.00	Fee for withdrawal of 20000 USDT via TRC20	2025-12-22 20:14:22	2025-12-22 20:14:22
122	21	\N	withdrawal	-600.00	USDT	4771.00	Withdrawal of 600 USDT via TRC20 to TY2DJJzUB6yS9v1CZ7XQNL5MMySCrVQmjD	2025-12-23 00:52:33	2025-12-23 00:52:33
123	21	\N	fee	-4.00	USDT	4771.00	Fee for withdrawal of 600 USDT via TRC20	2025-12-23 00:52:33	2025-12-23 00:52:33
124	21	\N	withdrawal	-600.00	USDT	4167.00	Withdrawal of 600 USDT via TRC20 to TY2DJJzUB6yS9v1CZ7XQNL5MMySCrVQmjD	2025-12-23 00:52:33	2025-12-23 00:52:33
125	21	\N	fee	-4.00	USDT	4167.00	Fee for withdrawal of 600 USDT via TRC20	2025-12-23 00:52:33	2025-12-23 00:52:33
126	5	\N	withdrawal	-1000.00	USDT	143504.00	Withdrawal of 1000 USDT via TRC20 to TCTnsLKmpDcSv5tHn5KTmQS3TPVM3ubdp2	2025-12-25 03:29:04	2025-12-25 03:29:04
127	5	\N	fee	-6.00	USDT	143504.00	Fee for withdrawal of 1000 USDT via TRC20	2025-12-25 03:29:04	2025-12-25 03:29:04
128	12	\N	withdrawal	-2000.00	USDT	530903.00	Withdrawal of 2000 USDT via TRC20 to TJiQB5XeLkykYFxM2HBzWUudpTzLU5Ujm6	2025-12-25 15:11:00	2025-12-25 15:11:00
129	12	\N	fee	-11.00	USDT	530903.00	Fee for withdrawal of 2000 USDT via TRC20	2025-12-25 15:11:00	2025-12-25 15:11:00
130	22	36	trade_amount	-10000.00	USDT	2863.00	Amount for buy option trade on BTCUSDT	\N	\N
131	22	36	fee	-200.00	USDT	2663.00	Fee for buy option trade on BTCUSDT	\N	\N
132	22	36	trade_win	11200.00	USDT	13863.00	Won buy trade on BTCUSDT	2025-12-26 08:13:21	2025-12-26 08:13:21
133	22	37	trade_amount	-10000.00	USDT	3863.00	Amount for buy option trade on BTCUSDT	\N	\N
134	22	37	fee	-200.00	USDT	3663.00	Fee for buy option trade on BTCUSDT	\N	\N
135	22	37	trade_win	11200.00	USDT	14863.00	Won buy trade on BTCUSDT	2025-12-26 08:28:46	2025-12-26 08:28:46
136	22	38	trade_amount	-10001.00	USDT	4862.00	Amount for buy option trade on BTCUSDT	\N	\N
137	22	38	fee	-200.02	USDT	4661.98	Fee for buy option trade on BTCUSDT	\N	\N
138	22	38	trade_win	11501.15	USDT	16163.13	Won buy trade on BTCUSDT	2025-12-26 08:43:34	2025-12-26 08:43:34
139	23	39	trade_amount	-1800.00	USDT	100.00	Amount for buy option trade on BTCUSDT	\N	\N
140	23	39	fee	-36.00	USDT	64.00	Fee for buy option trade on BTCUSDT	\N	\N
141	23	39	trade_win	2016.00	USDT	2080.00	Won buy trade on BTCUSDT	2025-12-28 05:25:47	2025-12-28 05:25:47
142	23	40	trade_amount	-2000.00	USDT	80.00	Amount for buy option trade on BTCUSDT	\N	\N
143	23	40	fee	-40.00	USDT	40.00	Fee for buy option trade on BTCUSDT	\N	\N
144	23	40	trade_win	2240.00	USDT	2280.00	Won buy trade on BTCUSDT	2025-12-28 05:35:28	2025-12-28 05:35:28
145	12	41	trade_amount	-45000.00	USDT	485903.00	Amount for buy option trade on BTCUSDT	\N	\N
146	12	41	fee	-900.00	USDT	485003.00	Fee for buy option trade on BTCUSDT	\N	\N
147	12	41	trade_win	53100.00	USDT	538103.00	Won buy trade on BTCUSDT	2025-12-28 05:37:14	2025-12-28 05:37:14
148	6	42	trade_amount	-60000.00	USDT	4974900.00	Amount for buy option trade on BTCUSDT	\N	\N
149	6	42	fee	-1200.00	USDT	4973700.00	Fee for buy option trade on BTCUSDT	\N	\N
150	6	42	trade_win	70800.00	USDT	5044500.00	Won buy trade on BTCUSDT	2025-12-30 00:55:29	2025-12-30 00:55:29
151	23	43	trade_amount	-2900.00	USDT	111.00	Amount for sell option trade on BTCUSDT	\N	\N
152	23	43	fee	-58.00	USDT	53.00	Fee for sell option trade on BTCUSDT	\N	\N
153	23	43	trade_win	3248.00	USDT	3301.00	Won sell trade on BTCUSDT	2025-12-30 04:51:49	2025-12-30 04:51:49
154	9	44	trade_amount	-19000.00	USDT	69695.00	Amount for buy option trade on BTCUSDT	\N	\N
155	9	44	fee	-380.00	USDT	69315.00	Fee for buy option trade on BTCUSDT	\N	\N
156	9	45	trade_amount	-45000.00	USDT	24315.00	Amount for buy option trade on BTCUSDT	\N	\N
157	9	45	fee	-900.00	USDT	23415.00	Fee for buy option trade on BTCUSDT	\N	\N
158	9	45	trade_win	53100.00	USDT	76515.00	Won buy trade on BTCUSDT	2025-12-31 03:32:31	2025-12-31 03:32:31
159	9	46	trade_amount	-60000.00	USDT	16515.00	Amount for buy option trade on BTCUSDT	\N	\N
160	9	46	fee	-1200.00	USDT	15315.00	Fee for buy option trade on BTCUSDT	\N	\N
161	9	46	trade_win	70800.00	USDT	86115.00	Won buy trade on BTCUSDT	2025-12-31 03:37:48	2025-12-31 03:37:48
162	9	47	trade_amount	-69000.00	USDT	28371.00	Amount for sell option trade on BTCUSDT	\N	\N
163	9	47	fee	-1380.00	USDT	26991.00	Fee for sell option trade on BTCUSDT	\N	\N
164	9	47	trade_win	81420.00	USDT	108411.00	Won sell trade on BTCUSDT	2026-01-01 03:32:19	2026-01-01 03:32:19
165	24	48	trade_amount	-6000.00	USDT	39145.00	Amount for buy option trade on BTCUSDT	\N	\N
166	24	48	fee	-120.00	USDT	39025.00	Fee for buy option trade on BTCUSDT	\N	\N
167	23	49	trade_amount	-6500.00	USDT	620.00	Amount for buy option trade on BTCUSDT	\N	\N
168	23	49	fee	-130.00	USDT	490.00	Fee for buy option trade on BTCUSDT	\N	\N
169	23	49	trade_win	7280.00	USDT	7770.00	Won buy trade on BTCUSDT	2026-01-01 04:04:12	2026-01-01 04:04:12
170	25	50	trade_amount	-15000.00	USDT	485000.00	Amount for buy option trade on BTCUSDT	\N	\N
171	25	50	fee	-300.00	USDT	484700.00	Fee for buy option trade on BTCUSDT	\N	\N
172	25	50	trade_win	17250.00	USDT	501950.00	Won buy trade on BTCUSDT	2026-01-01 04:29:44	2026-01-01 04:29:44
173	25	51	trade_amount	-85000.00	USDT	416950.00	Amount for buy option trade on BTCUSDT	\N	\N
174	25	51	fee	-1700.00	USDT	415250.00	Fee for buy option trade on BTCUSDT	\N	\N
175	25	51	trade_win	103700.00	USDT	518950.00	Won buy trade on BTCUSDT	2026-01-01 04:39:07	2026-01-01 04:39:07
176	10	52	trade_amount	-14566.00	USDT	703834.00	Amount for buy option trade on BTCUSDT	\N	\N
177	10	52	fee	-291.32	USDT	703542.68	Fee for buy option trade on BTCUSDT	\N	\N
178	10	52	trade_win	16750.90	USDT	720293.58	Won buy trade on BTCUSDT	2026-01-02 08:57:04	2026-01-02 08:57:04
179	10	53	trade_amount	-65000.00	USDT	655293.58	Amount for buy option trade on BTCUSDT	\N	\N
180	10	53	fee	-1300.00	USDT	653993.58	Fee for buy option trade on BTCUSDT	\N	\N
181	10	54	trade_amount	-80000.00	USDT	573993.58	Amount for buy option trade on BTCUSDT	\N	\N
182	10	54	fee	-1600.00	USDT	572393.58	Fee for buy option trade on BTCUSDT	\N	\N
183	10	55	trade_amount	-69000.00	USDT	503393.58	Amount for buy option trade on BTCUSDT	\N	\N
184	10	55	fee	-1380.00	USDT	502013.58	Fee for buy option trade on BTCUSDT	\N	\N
185	10	55	trade_win	81420.00	USDT	583433.58	Won buy trade on BTCUSDT	2026-01-02 15:12:23	2026-01-02 15:12:23
186	10	54	trade_win	97600.00	USDT	681033.58	Won buy trade on BTCUSDT	2026-01-02 15:13:05	2026-01-02 15:13:05
187	9	56	trade_amount	-100000.00	USDT	8411.00	Amount for buy option trade on BTCUSDT	\N	\N
188	9	56	fee	-2000.00	USDT	6411.00	Fee for buy option trade on BTCUSDT	\N	\N
189	10	57	trade_amount	-10000.00	USDT	671033.58	Amount for buy option trade on BTCUSDT	\N	\N
190	10	57	fee	-200.00	USDT	670833.58	Fee for buy option trade on BTCUSDT	\N	\N
191	10	57	trade_win	11200.00	USDT	682033.58	Won buy trade on BTCUSDT	2026-01-02 18:14:39	2026-01-02 18:14:39
192	9	56	trade_win	122000.00	USDT	128411.00	Won buy trade on BTCUSDT	2026-01-02 18:15:21	2026-01-02 18:15:21
193	10	58	trade_amount	-100000.00	USDT	582033.58	Amount for buy option trade on BTCUSDT	\N	\N
194	10	58	fee	-2000.00	USDT	580033.58	Fee for buy option trade on BTCUSDT	\N	\N
195	10	58	trade_win	122000.00	USDT	702033.58	Won buy trade on BTCUSDT	2026-01-02 18:21:01	2026-01-02 18:21:01
196	4	\N	arbitrage_purchase	-2999.00	USDT	97147.50	\N	2026-01-02 21:35:36	2026-01-02 21:35:36
197	25	59	trade_amount	-70000.00	USDT	448950.00	Amount for buy option trade on BTCUSDT	\N	\N
198	25	59	fee	-1400.00	USDT	447550.00	Fee for buy option trade on BTCUSDT	\N	\N
199	25	59	trade_win	82600.00	USDT	530150.00	Won buy trade on BTCUSDT	2026-01-03 01:31:22	2026-01-03 01:31:22
200	25	60	trade_amount	-70000.00	USDT	460150.00	Amount for buy option trade on BTCUSDT	\N	\N
201	25	60	fee	-1400.00	USDT	458750.00	Fee for buy option trade on BTCUSDT	\N	\N
202	25	60	trade_win	82600.00	USDT	541350.00	Won buy trade on BTCUSDT	2026-01-03 01:47:47	2026-01-03 01:47:47
203	4	\N	arbitrage_profit	15.00	USDT	100161.50	\N	2026-01-03 21:35:36	2026-01-03 21:35:36
204	25	61	trade_amount	-50000.00	USDT	491350.00	Amount for buy option trade on BTCUSDT	2026-01-05 18:48:38	2026-01-05 18:48:38
205	25	61	fee	-1000.00	USDT	490350.00	Fee for buy option trade on BTCUSDT	2026-01-05 18:48:38	2026-01-05 18:48:38
206	25	61	trade_win	59000.00	USDT	549350.00	Won buy trade on BTCUSDT	2026-01-05 18:50:08	2026-01-05 18:50:08
207	23	62	trade_amount	-9500.00	USDT	472.00	Amount for buy option trade on BTCUSDT	2026-01-06 03:08:36	2026-01-06 03:08:36
208	23	62	fee	-190.00	USDT	282.00	Fee for buy option trade on BTCUSDT	2026-01-06 03:08:36	2026-01-06 03:08:36
209	23	62	trade_win	10640.00	USDT	10922.00	Won buy trade on BTCUSDT	2026-01-06 03:09:07	2026-01-06 03:09:07
210	23	63	trade_amount	-10000.00	USDT	922.00	Amount for buy option trade on BTCUSDT	2026-01-06 03:24:13	2026-01-06 03:24:13
211	23	63	fee	-200.00	USDT	722.00	Fee for buy option trade on BTCUSDT	2026-01-06 03:24:13	2026-01-06 03:24:13
212	23	63	trade_win	11200.00	USDT	11922.00	Won buy trade on BTCUSDT	2026-01-06 03:24:43	2026-01-06 03:24:43
213	4	64	trade_amount	-100.00	USDT	100061.50	Amount for buy option trade on META	2026-01-06 09:31:12	2026-01-06 09:31:12
214	4	64	fee	-2.00	USDT	100059.50	Fee for buy option trade on META	2026-01-06 09:31:12	2026-01-06 09:31:12
215	23	\N	withdrawal	-200.00	USDT	11716.00	Withdrawal of 200 USDT via ERC20 to 0x7E2ae1741206D98A8565988cEED0d3c85C7AeDA9	2026-01-06 15:28:22	2026-01-06 15:28:22
216	23	\N	fee	-6.00	USDT	11716.00	Fee for withdrawal of 200 USDT via ERC20	2026-01-06 15:28:22	2026-01-06 15:28:22
217	12	65	trade_amount	-5000.00	USDT	533103.00	Amount for buy option trade on XAUUSD	2026-01-06 16:48:22	2026-01-06 16:48:22
218	12	65	fee	-100.00	USDT	533003.00	Fee for buy option trade on XAUUSD	2026-01-06 16:48:22	2026-01-06 16:48:22
219	12	65	trade_win	5600.00	USDT	538603.00	Won buy trade on XAUUSD	2026-01-06 16:48:52	2026-01-06 16:48:52
220	25	66	trade_amount	-10000.00	USDT	539350.00	Amount for buy option trade on XAUUSD	2026-01-06 16:52:17	2026-01-06 16:52:17
221	25	66	fee	-200.00	USDT	539150.00	Fee for buy option trade on XAUUSD	2026-01-06 16:52:17	2026-01-06 16:52:17
222	25	66	trade_win	11200.00	USDT	550350.00	Won buy trade on XAUUSD	2026-01-06 16:52:47	2026-01-06 16:52:47
223	12	\N	arbitrage_purchase	-2500.00	USDT	536103.00	\N	2026-01-06 16:53:51	2026-01-06 16:53:51
224	12	\N	arbitrage_refund	2250.00	USDT	538353.00	\N	2026-01-06 16:54:07	2026-01-06 16:54:07
225	12	\N	mining_purchase	-51000.00	USDT	487353.00	\N	2026-01-06 16:55:54	2026-01-06 16:55:54
226	5	\N	withdrawal	-10000.00	USDT	133484.00	Withdrawal of 10000 USDT via TRC20 to TCTnsLKmpDcSv5tHn5KTmQS3TPVM3ubdp2	2026-01-07 03:59:42	2026-01-07 03:59:42
227	5	\N	fee	-20.00	USDT	133484.00	Fee for withdrawal of 10000 USDT via TRC20	2026-01-07 03:59:42	2026-01-07 03:59:42
228	12	67	trade_amount	-100.00	USDT	487253.00	Amount for buy option trade on XPDUSD	2026-01-07 15:58:52	2026-01-07 15:58:52
229	12	67	fee	-2.00	USDT	487251.00	Fee for buy option trade on XPDUSD	2026-01-07 15:58:52	2026-01-07 15:58:52
230	12	67	trade_win	112.00	USDT	487363.00	Won buy trade on XPDUSD	2026-01-07 15:59:22	2026-01-07 15:59:22
231	12	\N	loan_disbursement	10000.00	USDT	497363.00	Loan approved #1	2026-01-07 16:04:17	2026-01-07 16:04:17
232	24	\N	arbitrage_purchase	-2999.00	USDT	43486.00	\N	2026-01-08 05:46:39	2026-01-08 05:46:39
233	24	\N	arbitrage_refund	2699.10	USDT	46185.10	\N	2026-01-08 05:48:12	2026-01-08 05:48:12
234	12	68	trade_amount	-500.00	USDT	496863.00	Amount for buy option trade on XAUUSD	2026-01-08 17:21:34	2026-01-08 17:21:34
235	12	68	fee	-10.00	USDT	496853.00	Fee for buy option trade on XAUUSD	2026-01-08 17:21:34	2026-01-08 17:21:34
236	12	68	trade_win	560.00	USDT	497413.00	Won buy trade on XAUUSD	2026-01-08 17:22:04	2026-01-08 17:22:04
237	18	69	trade_amount	-1000.00	USDT	166.00	Amount for buy option trade on BTCUSDT	2026-01-10 06:29:05	2026-01-10 06:29:05
238	18	69	fee	-20.00	USDT	146.00	Fee for buy option trade on BTCUSDT	2026-01-10 06:29:05	2026-01-10 06:29:05
239	18	69	trade_win	1120.00	USDT	1266.00	Won buy trade on BTCUSDT	2026-01-10 06:29:36	2026-01-10 06:29:36
240	18	70	trade_amount	-1200.00	USDT	66.00	Amount for buy option trade on BTCUSDT	2026-01-10 06:35:59	2026-01-10 06:35:59
241	18	70	fee	-24.00	USDT	42.00	Fee for buy option trade on BTCUSDT	2026-01-10 06:35:59	2026-01-10 06:35:59
242	18	70	trade_win	1344.00	USDT	1386.00	Won buy trade on BTCUSDT	2026-01-10 06:36:30	2026-01-10 06:36:30
243	18	71	trade_amount	-1300.00	USDT	86.00	Amount for buy option trade on BTCUSDT	2026-01-10 06:41:33	2026-01-10 06:41:33
244	18	71	fee	-26.00	USDT	60.00	Fee for buy option trade on BTCUSDT	2026-01-10 06:41:33	2026-01-10 06:41:33
245	18	71	trade_win	1456.00	USDT	1516.00	Won buy trade on BTCUSDT	2026-01-10 06:42:04	2026-01-10 06:42:04
246	12	72	trade_amount	-200001.00	USDT	297412.00	Amount for buy option trade on BTCUSDT	2026-01-12 19:33:30	2026-01-12 19:33:30
247	12	72	fee	-4000.02	USDT	293411.98	Fee for buy option trade on BTCUSDT	2026-01-12 19:33:30	2026-01-12 19:33:30
248	12	72	trade_win	264001.32	USDT	557413.30	Won buy trade on BTCUSDT	2026-01-12 19:45:11	2026-01-12 19:45:11
249	23	73	trade_amount	-19000.00	USDT	614.00	Amount for buy option trade on BTCUSDT	2026-01-13 03:08:26	2026-01-13 03:08:26
250	23	73	fee	-380.00	USDT	234.00	Fee for buy option trade on BTCUSDT	2026-01-13 03:08:26	2026-01-13 03:08:26
251	23	73	trade_win	21850.00	USDT	22084.00	Won buy trade on BTCUSDT	2026-01-13 03:09:27	2026-01-13 03:09:27
252	23	74	trade_amount	-21000.00	USDT	1084.00	Amount for buy option trade on BTCUSDT	2026-01-13 03:16:05	2026-01-13 03:16:05
253	23	74	fee	-420.00	USDT	664.00	Fee for buy option trade on BTCUSDT	2026-01-13 03:16:05	2026-01-13 03:16:05
254	23	74	trade_win	24150.00	USDT	24814.00	Won buy trade on BTCUSDT	2026-01-13 03:17:06	2026-01-13 03:17:06
255	9	75	trade_amount	-29000.00	USDT	101411.00	Amount for sell option trade on BTCUSDT	2026-01-13 03:26:42	2026-01-13 03:26:42
256	9	75	fee	-580.00	USDT	100831.00	Fee for sell option trade on BTCUSDT	2026-01-13 03:26:42	2026-01-13 03:26:42
257	9	75	trade_win	33350.00	USDT	134181.00	Won sell trade on BTCUSDT	2026-01-13 03:27:43	2026-01-13 03:27:43
258	23	\N	withdrawal	-200.00	USDT	24612.00	Withdrawal of 200 USDT via TRC20 to 0x7E2ae1741206D98A8565988cEED0d3c85C7AeDA9	2026-01-13 14:47:57	2026-01-13 14:47:57
259	23	\N	fee	-2.00	USDT	24612.00	Fee for withdrawal of 200 USDT via TRC20	2026-01-13 14:47:57	2026-01-13 14:47:57
260	12	\N	loan_disbursement	50000.00	USDT	607413.30	Loan approved #2	2026-01-13 16:58:41	2026-01-13 16:58:41
261	12	76	trade_amount	-250000.00	USDT	357413.30	Amount for buy option trade on BTCUSDT	2026-01-13 17:13:03	2026-01-13 17:13:03
262	12	76	fee	-5000.00	USDT	352413.30	Fee for buy option trade on BTCUSDT	2026-01-13 17:13:03	2026-01-13 17:13:03
263	12	76	trade_win	330000.00	USDT	682413.30	Won buy trade on BTCUSDT	2026-01-13 17:24:44	2026-01-13 17:24:44
264	12	77	trade_amount	-250000.00	USDT	432413.30	Amount for buy option trade on BTCUSDT	2026-01-14 05:13:31	2026-01-14 05:13:31
265	12	77	fee	-5000.00	USDT	427413.30	Fee for buy option trade on BTCUSDT	2026-01-14 05:13:31	2026-01-14 05:13:31
266	12	77	trade_win	330000.00	USDT	757413.30	Won buy trade on BTCUSDT	2026-01-14 05:25:12	2026-01-14 05:25:12
267	10	\N	loan_disbursement	80000.00	USDT	782033.58	Loan approved #3	2026-01-14 15:01:09	2026-01-14 15:01:09
268	10	\N	loan_disbursement	80000.00	USDT	862033.58	Loan approved #3	2026-01-14 15:01:13	2026-01-14 15:01:13
269	10	\N	loan_disbursement	80000.00	USDT	942033.58	Loan approved #3	2026-01-14 15:01:17	2026-01-14 15:01:17
270	10	\N	loan_disbursement	60000.00	USDT	1002033.58	Loan approved #4	2026-01-14 15:45:14	2026-01-14 15:45:14
271	20	\N	withdrawal	-150.00	USDT	2684.25	Withdrawal of 150 USDT via ERC20 to 0x37D9F7BD2Ce54AaF440F5E7499751090E44Cfc2C	2026-01-15 05:13:42	2026-01-15 05:13:42
272	20	\N	fee	-5.75	USDT	2684.25	Fee for withdrawal of 150 USDT via ERC20	2026-01-15 05:13:42	2026-01-15 05:13:42
273	25	78	trade_amount	-35000.00	USDT	515350.00	Amount for buy option trade on ETHUSDT	2026-01-15 05:42:31	2026-01-15 05:42:31
274	25	78	fee	-700.00	USDT	514650.00	Fee for buy option trade on ETHUSDT	2026-01-15 05:42:31	2026-01-15 05:42:31
275	25	78	trade_win	41300.00	USDT	555950.00	Won buy trade on ETHUSDT	2026-01-15 05:44:01	2026-01-15 05:44:01
276	31	79	trade_amount	-30000.00	USDT	70000.00	Amount for buy option trade on BTCUSDT	2026-01-15 18:06:04	2026-01-15 18:06:04
277	31	79	fee	-600.00	USDT	69400.00	Fee for buy option trade on BTCUSDT	2026-01-15 18:06:04	2026-01-15 18:06:04
278	31	79	trade_win	34500.00	USDT	103900.00	Won buy trade on BTCUSDT	2026-01-15 18:07:05	2026-01-15 18:07:05
279	31	\N	deposit	16.00	ETH	103900.00	Deposit of 16 ETH via crypto approved	2026-01-15 20:24:36	2026-01-15 20:24:36
280	31	\N	deposit	50000.00	ETH	103900.00	Deposit of 50000 ETH via crypto approved	2026-01-15 20:25:59	2026-01-15 20:25:59
281	31	\N	withdrawal	-50000.00	USDT	53880.00	Withdrawal of 50000 USDT via TRC20 to Oxafdrvfhh	2026-01-15 20:27:40	2026-01-15 20:27:40
282	31	\N	fee	-20.00	USDT	53880.00	Fee for withdrawal of 50000 USDT via TRC20	2026-01-15 20:27:40	2026-01-15 20:27:40
283	31	\N	deposit	150000.00	ETH	53880.00	Deposit of 150000 ETH via crypto approved	2026-01-15 20:29:56	2026-01-15 20:29:56
284	31	\N	deposit	150000.00	ETH	53880.00	Deposit of 150000 ETH via crypto approved	2026-01-15 20:30:48	2026-01-15 20:30:48
285	31	\N	arbitrage_purchase	-50000.00	USDT	3880.00	\N	2026-01-15 20:37:13	2026-01-15 20:37:13
286	31	\N	arbitrage_refund	45000.00	USDT	48880.00	\N	2026-01-15 20:37:41	2026-01-15 20:37:41
287	31	80	trade_amount	-20000.00	USDT	28880.00	Amount for buy option trade on TSLA	2026-01-15 20:40:05	2026-01-15 20:40:05
288	31	80	fee	-400.00	USDT	28480.00	Fee for buy option trade on TSLA	2026-01-15 20:40:05	2026-01-15 20:40:05
289	31	80	trade_win	23000.00	USDT	51480.00	Won buy trade on TSLA	2026-01-15 20:41:06	2026-01-15 20:41:06
290	31	81	trade_amount	-30000.00	USDT	21480.00	Amount for buy option trade on BTCUSDT	2026-01-16 07:00:51	2026-01-16 07:00:51
291	31	81	fee	-600.00	USDT	20880.00	Fee for buy option trade on BTCUSDT	2026-01-16 07:00:51	2026-01-16 07:00:51
292	31	81	trade_win	34500.00	USDT	55380.00	Won buy trade on BTCUSDT	2026-01-16 07:01:52	2026-01-16 07:01:52
293	20	82	trade_amount	-2500.00	USDT	184.25	Amount for buy option trade on ETHUSDT	2026-01-16 18:52:24	2026-01-16 18:52:24
294	20	82	fee	-50.00	USDT	134.25	Fee for buy option trade on ETHUSDT	2026-01-16 18:52:24	2026-01-16 18:52:24
295	20	82	trade_win	2800.00	USDT	2934.25	Won buy trade on ETHUSDT	2026-01-16 18:52:55	2026-01-16 18:52:55
296	12	83	trade_amount	-45000.00	USDT	712413.30	Amount for buy option trade on BTCUSDT	2026-01-16 18:53:18	2026-01-16 18:53:18
297	12	83	fee	-900.00	USDT	711513.30	Fee for buy option trade on BTCUSDT	2026-01-16 18:53:18	2026-01-16 18:53:18
298	12	84	trade_amount	-45000.00	USDT	666513.30	Amount for buy option trade on ETHUSDT	2026-01-16 18:53:35	2026-01-16 18:53:35
299	12	84	fee	-900.00	USDT	665613.30	Fee for buy option trade on ETHUSDT	2026-01-16 18:53:35	2026-01-16 18:53:35
300	12	83	trade_win	53100.00	USDT	718713.30	Won buy trade on BTCUSDT	2026-01-16 18:54:48	2026-01-16 18:54:48
301	12	84	trade_win	53100.00	USDT	771813.30	Won buy trade on ETHUSDT	2026-01-16 18:55:05	2026-01-16 18:55:05
302	20	85	trade_amount	-2850.00	USDT	84.25	Amount for buy option trade on BTCUSDT	2026-01-16 19:01:25	2026-01-16 19:01:25
303	20	85	fee	-57.00	USDT	27.25	Fee for buy option trade on BTCUSDT	2026-01-16 19:01:25	2026-01-16 19:01:25
304	20	85	trade_win	3192.00	USDT	3219.25	Won buy trade on BTCUSDT	2026-01-16 19:01:56	2026-01-16 19:01:56
305	12	86	trade_amount	-11000.00	USDT	760813.30	Amount for buy option trade on BTCUSDT	2026-01-16 19:18:47	2026-01-16 19:18:47
306	12	86	fee	-220.00	USDT	760593.30	Fee for buy option trade on BTCUSDT	2026-01-16 19:18:47	2026-01-16 19:18:47
307	12	86	trade_win	12650.00	USDT	773243.30	Won buy trade on BTCUSDT	2026-01-16 19:19:48	2026-01-16 19:19:48
308	25	87	trade_amount	-60000.00	USDT	495950.00	Amount for buy option trade on XAUUSD	2026-01-16 19:25:59	2026-01-16 19:25:59
309	25	87	fee	-1200.00	USDT	494750.00	Fee for buy option trade on XAUUSD	2026-01-16 19:25:59	2026-01-16 19:25:59
310	25	87	trade_win	70800.00	USDT	565550.00	Won buy trade on XAUUSD	2026-01-16 19:27:29	2026-01-16 19:27:29
311	33	\N	deposit	10.00	ETH	0.00	Deposit of 10 ETH via crypto approved	2026-01-17 05:39:18	2026-01-17 05:39:18
312	12	\N	loan_disbursement	80000.00	USDT	853243.30	Loan approved #5	2026-01-17 05:40:57	2026-01-17 05:40:57
313	34	\N	loan_disbursement	70000.00	USDT	70000.00	Loan approved #7	2026-01-18 01:47:09	2026-01-18 01:47:09
314	20	88	trade_amount	-5100.00	USDT	119.25	Amount for buy option trade on BTCUSDT	2026-01-18 02:25:24	2026-01-18 02:25:24
315	20	88	fee	-102.00	USDT	17.25	Fee for buy option trade on BTCUSDT	2026-01-18 02:25:24	2026-01-18 02:25:24
316	20	88	trade_win	5712.00	USDT	5729.25	Won buy trade on BTCUSDT	2026-01-18 02:25:55	2026-01-18 02:25:55
317	34	\N	loan_disbursement	80000.00	USDT	150000.00	Loan approved #8	2026-01-18 14:44:33	2026-01-18 14:44:33
318	36	89	trade_amount	-50000.00	USDT	250000.00	Amount for buy option trade on BTCUSDT	2026-01-19 14:57:28	2026-01-19 14:57:28
319	36	89	fee	-1000.00	USDT	249000.00	Fee for buy option trade on BTCUSDT	2026-01-19 14:57:28	2026-01-19 14:57:28
320	36	89	trade_win	59000.00	USDT	308000.00	Won buy trade on BTCUSDT	2026-01-19 14:58:59	2026-01-19 14:58:59
321	31	90	trade_amount	-42000.00	USDT	13380.00	Amount for buy option trade on BTCUSDT	2026-01-20 01:52:39	2026-01-20 01:52:39
322	31	90	fee	-840.00	USDT	12540.00	Fee for buy option trade on BTCUSDT	2026-01-20 01:52:39	2026-01-20 01:52:39
323	31	90	trade_win	49560.00	USDT	62100.00	Won buy trade on BTCUSDT	2026-01-20 01:54:10	2026-01-20 01:54:10
324	34	\N	loan_disbursement	39999.00	USDT	189999.00	Loan approved #10	2026-01-20 16:42:48	2026-01-20 16:42:48
325	34	\N	loan_disbursement	50000.00	USDT	239999.00	Loan approved #11	2026-01-20 16:45:13	2026-01-20 16:45:13
326	34	\N	loan_disbursement	50000.00	USDT	289999.00	Loan approved #13	2026-01-20 18:44:32	2026-01-20 18:44:32
327	34	\N	loan_disbursement	10000.00	USDT	299999.00	Loan approved #15	2026-01-21 15:15:18	2026-01-21 15:15:18
328	9	\N	loan_disbursement	70000.00	USDT	204181.00	Loan approved #9	2026-01-21 15:17:58	2026-01-21 15:17:58
329	35	91	trade_amount	-500.00	USDT	40.00	Amount for buy option trade on BTCUSDT	2026-01-21 17:44:52	2026-01-21 17:44:52
330	35	91	fee	-10.00	USDT	30.00	Fee for buy option trade on BTCUSDT	2026-01-21 17:44:52	2026-01-21 17:44:52
331	35	91	trade_win	560.00	USDT	590.00	Won buy trade on BTCUSDT	2026-01-21 17:45:23	2026-01-21 17:45:23
332	12	92	trade_amount	-30001.00	USDT	823242.30	Amount for buy option trade on BTCUSDT	2026-01-21 17:45:56	2026-01-21 17:45:56
333	12	92	fee	-600.02	USDT	822642.28	Fee for buy option trade on BTCUSDT	2026-01-21 17:45:56	2026-01-21 17:45:56
334	12	92	trade_win	35401.18	USDT	858043.46	Won buy trade on BTCUSDT	2026-01-21 17:47:26	2026-01-21 17:47:26
335	36	93	trade_amount	-30000.00	USDT	278000.00	Amount for buy option trade on BTCUSDT	2026-01-21 18:03:34	2026-01-21 18:03:34
336	36	93	fee	-600.00	USDT	277400.00	Fee for buy option trade on BTCUSDT	2026-01-21 18:03:34	2026-01-21 18:03:34
337	36	93	trade_win	34500.00	USDT	311900.00	Won buy trade on BTCUSDT	2026-01-21 18:04:35	2026-01-21 18:04:35
338	25	94	trade_amount	-75000.00	USDT	490550.00	Amount for buy option trade on XAUUSD	2026-01-21 23:05:23	2026-01-21 23:05:23
339	25	94	fee	-1500.00	USDT	489050.00	Fee for buy option trade on XAUUSD	2026-01-21 23:05:23	2026-01-21 23:05:23
340	25	94	trade_win	91500.00	USDT	580550.00	Won buy trade on XAUUSD	2026-01-21 23:08:23	2026-01-21 23:08:23
341	23	95	trade_amount	-24000.00	USDT	612.00	Amount for sell option trade on BTCUSDT	2026-01-22 04:46:34	2026-01-22 04:46:34
342	23	95	fee	-480.00	USDT	132.00	Fee for sell option trade on BTCUSDT	2026-01-22 04:46:34	2026-01-22 04:46:34
343	23	95	trade_win	27600.00	USDT	27732.00	Won sell trade on BTCUSDT	2026-01-22 04:47:34	2026-01-22 04:47:34
344	9	96	trade_amount	-150000.00	USDT	54181.00	Amount for sell option trade on BTCUSDT	2026-01-22 18:52:33	2026-01-22 18:52:33
345	9	96	fee	-3000.00	USDT	51181.00	Fee for sell option trade on BTCUSDT	2026-01-22 18:52:33	2026-01-22 18:52:33
346	9	96	trade_win	189000.00	USDT	240181.00	Won sell trade on BTCUSDT	2026-01-22 18:57:33	2026-01-22 18:57:33
347	12	97	trade_amount	-155000.00	USDT	703043.46	Amount for sell option trade on BTCUSDT	2026-01-22 19:03:08	2026-01-22 19:03:08
348	12	97	fee	-3100.00	USDT	699943.46	Fee for sell option trade on BTCUSDT	2026-01-22 19:03:08	2026-01-22 19:03:08
349	12	97	trade_win	195300.00	USDT	895243.46	Won sell trade on BTCUSDT	2026-01-22 19:08:09	2026-01-22 19:08:09
350	31	98	trade_amount	-26540.00	USDT	35560.00	Amount for sell option trade on BTCUSDT	2026-01-23 02:57:48	2026-01-23 02:57:48
351	31	98	fee	-530.80	USDT	35029.20	Fee for sell option trade on BTCUSDT	2026-01-23 02:57:48	2026-01-23 02:57:48
352	31	98	trade_win	30521.00	USDT	65550.20	Won sell trade on BTCUSDT	2026-01-23 02:58:49	2026-01-23 02:58:49
353	31	99	trade_amount	-48452.00	USDT	17098.20	Amount for buy option trade on BTCUSDT	2026-01-23 03:39:30	2026-01-23 03:39:30
354	31	99	fee	-969.04	USDT	16129.16	Fee for buy option trade on BTCUSDT	2026-01-23 03:39:30	2026-01-23 03:39:30
355	31	99	trade_win	57173.36	USDT	73302.52	Won buy trade on BTCUSDT	2026-01-23 03:41:01	2026-01-23 03:41:01
356	31	100	trade_amount	-42556.00	USDT	30746.52	Amount for buy option trade on BTCUSDT	2026-01-23 03:41:25	2026-01-23 03:41:25
357	31	100	fee	-851.12	USDT	29895.40	Fee for buy option trade on BTCUSDT	2026-01-23 03:41:25	2026-01-23 03:41:25
358	31	100	trade_win	50216.08	USDT	80111.48	Won buy trade on BTCUSDT	2026-01-23 03:42:56	2026-01-23 03:42:56
359	25	101	trade_amount	-50000.00	USDT	530550.00	Amount for buy option trade on BTCUSDT	2026-01-23 07:09:00	2026-01-23 07:09:00
360	25	101	fee	-1000.00	USDT	529550.00	Fee for buy option trade on BTCUSDT	2026-01-23 07:09:00	2026-01-23 07:09:00
361	25	101	trade_win	59000.00	USDT	588550.00	Won buy trade on BTCUSDT	2026-01-23 07:10:31	2026-01-23 07:10:31
362	25	102	trade_amount	-70001.00	USDT	518549.00	Amount for buy option trade on XAUUSD	2026-01-23 21:04:49	2026-01-23 21:04:49
363	25	102	fee	-1400.02	USDT	517148.98	Fee for buy option trade on XAUUSD	2026-01-23 21:04:49	2026-01-23 21:04:49
364	25	103	trade_amount	-80000.00	USDT	437148.98	Amount for buy option trade on XAUUSD	2026-01-23 21:05:21	2026-01-23 21:05:21
365	25	103	fee	-1600.00	USDT	435548.98	Fee for buy option trade on XAUUSD	2026-01-23 21:05:21	2026-01-23 21:05:21
366	25	102	trade_win	85401.22	USDT	520950.20	Won buy trade on XAUUSD	2026-01-23 21:07:49	2026-01-23 21:07:49
367	25	103	trade_win	97600.00	USDT	618550.20	Won buy trade on XAUUSD	2026-01-23 21:08:21	2026-01-23 21:08:21
368	31	104	trade_amount	-28790.00	USDT	51321.48	Amount for buy option trade on BTCUSDT	2026-01-26 01:44:07	2026-01-26 01:44:07
369	31	104	fee	-575.80	USDT	50745.68	Fee for buy option trade on BTCUSDT	2026-01-26 01:44:07	2026-01-26 01:44:07
370	31	104	trade_win	33108.50	USDT	83854.18	Won buy trade on BTCUSDT	2026-01-26 01:45:08	2026-01-26 01:45:08
371	31	105	trade_amount	-28694.00	USDT	55160.18	Amount for buy option trade on BTCUSDT	2026-01-26 01:50:03	2026-01-26 01:50:03
372	31	105	fee	-573.88	USDT	54586.30	Fee for buy option trade on BTCUSDT	2026-01-26 01:50:03	2026-01-26 01:50:03
373	31	105	trade_win	32998.10	USDT	87584.40	Won buy trade on BTCUSDT	2026-01-26 01:51:03	2026-01-26 01:51:03
374	42	106	trade_amount	-360.00	USDT	10.00	Amount for sell option trade on BTCUSDT	2026-01-26 03:50:46	2026-01-26 03:50:46
375	42	106	fee	-7.20	USDT	2.80	Fee for sell option trade on BTCUSDT	2026-01-26 03:50:46	2026-01-26 03:50:46
376	42	106	trade_win	403.20	USDT	406.00	Won sell trade on BTCUSDT	2026-01-26 03:51:16	2026-01-26 03:51:16
377	9	107	trade_amount	-70001.00	USDT	170180.00	Amount for sell option trade on BTCUSDT	2026-01-26 04:29:43	2026-01-26 04:29:43
378	9	107	fee	-1400.02	USDT	168779.98	Fee for sell option trade on BTCUSDT	2026-01-26 04:29:43	2026-01-26 04:29:43
379	9	107	trade_win	85401.22	USDT	254181.20	Won sell trade on BTCUSDT	2026-01-26 04:32:43	2026-01-26 04:32:43
380	25	\N	withdrawal	-100.00	USDT	618449.20	Withdrawal of 100 USDT via TRC20 to 0xc86254799b594d6e0104b52d9acf9614acea3712	2026-01-26 13:58:47	2026-01-26 13:58:47
381	25	\N	fee	-1.00	USDT	618449.20	Fee for withdrawal of 100 USDT via TRC20	2026-01-26 13:58:47	2026-01-26 13:58:47
382	4	\N	loan_disbursement	15000.00	USDT	115059.50	Loan approved #14	2026-01-26 19:33:27	2026-01-26 19:33:27
383	34	\N	loan_disbursement	50000.00	USDT	349999.00	Loan approved #16	2026-01-26 19:45:07	2026-01-26 19:45:07
384	41	108	trade_amount	-20000.00	USDT	480000.00	Amount for buy option trade on XAUUSD	2026-01-27 19:29:31	2026-01-27 19:29:31
385	41	108	fee	-400.00	USDT	479600.00	Fee for buy option trade on XAUUSD	2026-01-27 19:29:31	2026-01-27 19:29:31
386	41	108	trade_win	23000.00	USDT	502600.00	Won buy trade on XAUUSD	2026-01-27 19:30:31	2026-01-27 19:30:31
387	38	109	trade_amount	-4900.00	USDT	110.00	Amount for buy option trade on XAUUSD	2026-01-27 20:13:17	2026-01-27 20:13:17
388	38	109	fee	-98.00	USDT	12.00	Fee for buy option trade on XAUUSD	2026-01-27 20:13:17	2026-01-27 20:13:17
389	38	109	trade_win	5488.00	USDT	5500.00	Won buy trade on XAUUSD	2026-01-27 20:13:47	2026-01-27 20:13:47
390	9	110	trade_amount	-200000.00	USDT	54181.20	Amount for buy option trade on BTCUSDT	2026-01-27 23:33:18	2026-01-27 23:33:18
391	9	110	fee	-4000.00	USDT	50181.20	Fee for buy option trade on BTCUSDT	2026-01-27 23:33:18	2026-01-27 23:33:18
392	9	110	trade_win	252000.00	USDT	302181.20	Won buy trade on BTCUSDT	2026-01-27 23:38:19	2026-01-27 23:38:19
393	31	111	trade_amount	-42560.00	USDT	45024.40	Amount for buy option trade on BTCUSDT	2026-01-28 03:09:25	2026-01-28 03:09:25
394	31	111	fee	-851.20	USDT	44173.20	Fee for buy option trade on BTCUSDT	2026-01-28 03:09:25	2026-01-28 03:09:25
395	31	111	trade_win	50220.80	USDT	94394.00	Won buy trade on BTCUSDT	2026-01-28 03:10:56	2026-01-28 03:10:56
396	31	112	trade_amount	-58962.00	USDT	35432.00	Amount for sell option trade on BTCUSDT	2026-01-28 03:13:36	2026-01-28 03:13:36
397	31	112	fee	-1179.24	USDT	34252.76	Fee for sell option trade on BTCUSDT	2026-01-28 03:13:36	2026-01-28 03:13:36
398	31	112	trade_win	69575.16	USDT	103827.92	Won sell trade on BTCUSDT	2026-01-28 03:15:06	2026-01-28 03:15:06
399	10	113	trade_amount	-10000.00	USDT	992033.58	Amount for sell option trade on BTCUSDT	2026-01-28 04:26:08	2026-01-28 04:26:08
400	10	113	fee	-200.00	USDT	991833.58	Fee for sell option trade on BTCUSDT	2026-01-28 04:26:08	2026-01-28 04:26:08
401	10	113	trade_win	11200.00	USDT	1003033.58	Won sell trade on BTCUSDT	2026-01-28 04:26:39	2026-01-28 04:26:39
402	38	\N	deposit	10.00	BTC	5500.00	Deposit of 10 BTC via crypto approved	2026-01-28 14:32:38	2026-01-28 14:32:38
403	20	114	trade_amount	-5600.00	USDT	129.25	Amount for buy option trade on BTCUSDT	2026-01-29 01:03:32	2026-01-29 01:03:32
404	20	114	fee	-112.00	USDT	17.25	Fee for buy option trade on BTCUSDT	2026-01-29 01:03:32	2026-01-29 01:03:32
405	20	114	trade_win	6272.00	USDT	6289.25	Won buy trade on BTCUSDT	2026-01-29 01:04:02	2026-01-29 01:04:02
406	12	115	trade_amount	-60000.00	USDT	835243.46	Amount for buy option trade on BTCUSDT	2026-01-29 01:04:40	2026-01-29 01:04:40
407	12	115	fee	-1200.00	USDT	834043.46	Fee for buy option trade on BTCUSDT	2026-01-29 01:04:40	2026-01-29 01:04:40
408	12	115	trade_win	70800.00	USDT	904843.46	Won buy trade on BTCUSDT	2026-01-29 01:06:11	2026-01-29 01:06:11
409	44	116	trade_amount	-200.00	USDT	34.00	Amount for sell option trade on BTCUSDT	2026-01-29 01:26:37	2026-01-29 01:26:37
410	44	116	fee	-4.00	USDT	30.00	Fee for sell option trade on BTCUSDT	2026-01-29 01:26:37	2026-01-29 01:26:37
411	44	116	trade_win	224.00	USDT	254.00	Won sell trade on BTCUSDT	2026-01-29 01:27:08	2026-01-29 01:27:08
412	12	117	trade_amount	-20000.00	USDT	884843.46	Amount for sell option trade on BTCUSDT	2026-01-29 01:28:11	2026-01-29 01:28:11
413	12	117	fee	-400.00	USDT	884443.46	Fee for sell option trade on BTCUSDT	2026-01-29 01:28:11	2026-01-29 01:28:11
414	12	117	trade_win	23000.00	USDT	907443.46	Won sell trade on BTCUSDT	2026-01-29 01:29:12	2026-01-29 01:29:12
415	38	118	trade_amount	-9000.00	USDT	1152.00	Amount for buy option trade on XAUUSD	2026-01-30 01:34:32	2026-01-30 01:34:32
416	38	118	fee	-180.00	USDT	972.00	Fee for buy option trade on XAUUSD	2026-01-30 01:34:32	2026-01-30 01:34:32
417	38	119	trade_amount	-900.00	USDT	72.00	Amount for buy option trade on XAUUSD	2026-01-30 01:51:58	2026-01-30 01:51:58
418	38	119	fee	-18.00	USDT	54.00	Fee for buy option trade on XAUUSD	2026-01-30 01:51:58	2026-01-30 01:51:58
419	38	119	trade_win	1008.00	USDT	1062.00	Won buy trade on XAUUSD	2026-01-30 01:52:28	2026-01-30 01:52:28
420	38	120	trade_amount	-980.00	USDT	82.00	Amount for buy option trade on XAUUSD	2026-01-30 01:54:18	2026-01-30 01:54:18
421	38	120	fee	-19.60	USDT	62.40	Fee for buy option trade on XAUUSD	2026-01-30 01:54:18	2026-01-30 01:54:18
422	38	120	trade_win	1097.60	USDT	1160.00	Won buy trade on XAUUSD	2026-01-30 01:54:48	2026-01-30 01:54:48
423	38	121	trade_amount	-1100.00	USDT	60.00	Amount for buy option trade on XAUUSD	2026-01-30 01:56:10	2026-01-30 01:56:10
424	38	121	fee	-22.00	USDT	38.00	Fee for buy option trade on XAUUSD	2026-01-30 01:56:10	2026-01-30 01:56:10
425	38	121	trade_win	1232.00	USDT	1270.00	Won buy trade on XAUUSD	2026-01-30 01:56:40	2026-01-30 01:56:40
426	44	122	trade_amount	-2500.00	USDT	144.00	Amount for sell option trade on BTCUSDT	2026-01-30 01:59:53	2026-01-30 01:59:53
427	44	122	fee	-50.00	USDT	94.00	Fee for sell option trade on BTCUSDT	2026-01-30 01:59:53	2026-01-30 01:59:53
428	44	122	trade_win	2800.00	USDT	2894.00	Won sell trade on BTCUSDT	2026-01-30 02:00:24	2026-01-30 02:00:24
429	23	123	trade_amount	-75000.00	USDT	2732.00	Amount for sell option trade on BTCUSDT	2026-01-30 02:01:04	2026-01-30 02:01:04
430	23	123	fee	-1500.00	USDT	1232.00	Fee for sell option trade on BTCUSDT	2026-01-30 02:01:04	2026-01-30 02:01:04
431	23	123	trade_win	91500.00	USDT	92732.00	Won sell trade on BTCUSDT	2026-01-30 02:04:04	2026-01-30 02:04:04
432	38	124	trade_amount	-6000.00	USDT	270.00	Amount for buy option trade on XAUUSD	2026-01-30 02:36:35	2026-01-30 02:36:35
433	38	124	fee	-120.00	USDT	150.00	Fee for buy option trade on XAUUSD	2026-01-30 02:36:35	2026-01-30 02:36:35
434	38	124	trade_win	6720.00	USDT	6870.00	Won buy trade on XAUUSD	2026-01-30 02:37:05	2026-01-30 02:37:05
435	38	125	trade_amount	-6700.00	USDT	170.00	Amount for sell option trade on BTCUSDT	2026-01-30 02:50:23	2026-01-30 02:50:23
436	38	125	fee	-134.00	USDT	36.00	Fee for sell option trade on BTCUSDT	2026-01-30 02:50:23	2026-01-30 02:50:23
437	38	125	trade_win	7504.00	USDT	7540.00	Won sell trade on BTCUSDT	2026-01-30 02:50:54	2026-01-30 02:50:54
438	10	126	trade_amount	-10001.00	USDT	993032.58	Amount for buy option trade on XAUUSD	2026-01-30 15:12:05	2026-01-30 15:12:05
439	10	126	fee	-200.02	USDT	992832.56	Fee for buy option trade on XAUUSD	2026-01-30 15:12:05	2026-01-30 15:12:05
440	10	126	trade_win	11501.15	USDT	1004333.71	Won buy trade on XAUUSD	2026-01-30 15:13:05	2026-01-30 15:13:05
441	38	127	trade_amount	-7350.00	USDT	190.00	Amount for buy option trade on XAUUSD	2026-01-30 18:52:07	2026-01-30 18:52:07
442	38	127	fee	-147.00	USDT	43.00	Fee for buy option trade on XAUUSD	2026-01-30 18:52:07	2026-01-30 18:52:07
443	38	127	trade_win	8232.00	USDT	8275.00	Won buy trade on XAUUSD	2026-01-30 18:52:38	2026-01-30 18:52:38
444	38	128	trade_amount	-8000.00	USDT	275.00	Amount for buy option trade on XAUUSD	2026-01-30 18:56:17	2026-01-30 18:56:17
445	38	128	fee	-160.00	USDT	115.00	Fee for buy option trade on XAUUSD	2026-01-30 18:56:17	2026-01-30 18:56:17
446	38	128	trade_win	8960.00	USDT	9075.00	Won buy trade on XAUUSD	2026-01-30 18:56:47	2026-01-30 18:56:47
447	12	129	trade_amount	-10000.00	USDT	897443.46	Amount for buy option trade on BTCUSDT	2026-01-30 21:47:57	2026-01-30 21:47:57
448	12	129	fee	-200.00	USDT	897243.46	Fee for buy option trade on BTCUSDT	2026-01-30 21:47:57	2026-01-30 21:47:57
449	12	129	trade_win	11200.00	USDT	908443.46	Won buy trade on BTCUSDT	2026-01-30 21:48:28	2026-01-30 21:48:28
450	12	130	trade_amount	-15000.00	USDT	893443.46	Amount for buy option trade on BTCUSDT	2026-01-30 21:48:28	2026-01-30 21:48:28
451	12	130	fee	-300.00	USDT	893143.46	Fee for buy option trade on BTCUSDT	2026-01-30 21:48:28	2026-01-30 21:48:28
452	12	131	trade_amount	-30001.00	USDT	863142.46	Amount for buy option trade on BTCUSDT	2026-01-30 21:49:13	2026-01-30 21:49:13
453	12	131	fee	-600.02	USDT	862542.44	Fee for buy option trade on BTCUSDT	2026-01-30 21:49:13	2026-01-30 21:49:13
454	12	130	trade_win	17250.00	USDT	879792.44	Won buy trade on BTCUSDT	2026-01-30 21:49:29	2026-01-30 21:49:29
455	12	132	trade_amount	-70001.00	USDT	809791.44	Amount for buy option trade on BTCUSDT	2026-01-30 21:49:47	2026-01-30 21:49:47
456	12	132	fee	-1400.02	USDT	808391.42	Fee for buy option trade on BTCUSDT	2026-01-30 21:49:47	2026-01-30 21:49:47
457	12	131	trade_win	35401.18	USDT	843792.60	Won buy trade on BTCUSDT	2026-01-30 21:50:44	2026-01-30 21:50:44
458	12	132	trade_win	85401.22	USDT	929193.82	Won buy trade on BTCUSDT	2026-01-30 21:52:47	2026-01-30 21:52:47
459	12	133	trade_amount	-200001.00	USDT	729192.82	Amount for buy option trade on BTCUSDT	2026-01-30 22:02:27	2026-01-30 22:02:27
460	12	133	fee	-4000.02	USDT	725192.80	Fee for buy option trade on BTCUSDT	2026-01-30 22:02:27	2026-01-30 22:02:27
461	12	133	trade_win	264001.32	USDT	989194.12	Won buy trade on BTCUSDT	2026-01-30 22:14:08	2026-01-30 22:14:08
462	9	134	trade_amount	-200000.00	USDT	102181.20	Amount for sell option trade on BTCUSDT	2026-01-31 17:22:44	2026-01-31 17:22:44
463	9	134	fee	-4000.00	USDT	98181.20	Fee for sell option trade on BTCUSDT	2026-01-31 17:22:44	2026-01-31 17:22:44
464	9	134	trade_win	252000.00	USDT	350181.20	Won sell trade on BTCUSDT	2026-01-31 17:27:45	2026-01-31 17:27:45
465	32	135	trade_amount	-12000.00	USDT	847.00	Amount for buy option trade on BTCUSDT	2026-01-31 17:46:21	2026-01-31 17:46:21
466	32	135	fee	-240.00	USDT	607.00	Fee for buy option trade on BTCUSDT	2026-01-31 17:46:21	2026-01-31 17:46:21
467	32	135	trade_win	13800.00	USDT	14407.00	Won buy trade on BTCUSDT	2026-01-31 17:47:22	2026-01-31 17:47:22
468	44	136	trade_amount	-2800.00	USDT	94.00	Amount for sell option trade on BTCUSDT	2026-01-31 19:26:38	2026-01-31 19:26:38
469	44	136	fee	-56.00	USDT	38.00	Fee for sell option trade on BTCUSDT	2026-01-31 19:26:38	2026-01-31 19:26:38
470	44	136	trade_win	3136.00	USDT	3174.00	Won sell trade on BTCUSDT	2026-01-31 19:27:09	2026-01-31 19:27:09
471	44	137	trade_amount	-2500.00	USDT	674.00	Amount for sell option trade on BTCUSDT	2026-01-31 19:29:04	2026-01-31 19:29:04
472	44	137	fee	-50.00	USDT	624.00	Fee for sell option trade on BTCUSDT	2026-01-31 19:29:04	2026-01-31 19:29:04
473	44	137	trade_win	2800.00	USDT	3424.00	Won sell trade on BTCUSDT	2026-01-31 19:29:35	2026-01-31 19:29:35
474	44	138	trade_amount	-3000.00	USDT	424.00	Amount for sell option trade on BTCUSDT	2026-01-31 19:31:30	2026-01-31 19:31:30
475	44	138	fee	-60.00	USDT	364.00	Fee for sell option trade on BTCUSDT	2026-01-31 19:31:30	2026-01-31 19:31:30
476	23	139	trade_amount	-70000.00	USDT	22732.00	Amount for sell option trade on BTCUSDT	2026-02-01 16:25:46	2026-02-01 16:25:46
477	23	139	fee	-1400.00	USDT	21332.00	Fee for sell option trade on BTCUSDT	2026-02-01 16:25:46	2026-02-01 16:25:46
478	23	139	trade_win	82600.00	USDT	103932.00	Won sell trade on BTCUSDT	2026-02-01 16:27:17	2026-02-01 16:27:17
479	31	140	trade_amount	-38560.00	USDT	65267.92	Amount for buy option trade on BTCUSDT	2026-02-01 16:53:23	2026-02-01 16:53:23
480	31	140	fee	-771.20	USDT	64496.72	Fee for buy option trade on BTCUSDT	2026-02-01 16:53:23	2026-02-01 16:53:23
481	31	140	trade_win	45500.80	USDT	109997.52	Won buy trade on BTCUSDT	2026-02-01 16:54:54	2026-02-01 16:54:54
482	23	141	trade_amount	-25000.00	USDT	78932.00	Amount for sell option trade on BTCUSDT	2026-02-02 18:46:42	2026-02-02 18:46:42
483	23	141	fee	-500.00	USDT	78432.00	Fee for sell option trade on BTCUSDT	2026-02-02 18:46:42	2026-02-02 18:46:42
484	23	141	trade_win	28750.00	USDT	107182.00	Won sell trade on BTCUSDT	2026-02-02 18:47:42	2026-02-02 18:47:42
485	9	142	trade_amount	-200000.00	USDT	150181.20	Amount for sell option trade on BTCUSDT	2026-02-02 21:00:31	2026-02-02 21:00:31
486	9	142	fee	-4000.00	USDT	146181.20	Fee for sell option trade on BTCUSDT	2026-02-02 21:00:31	2026-02-02 21:00:31
487	9	142	trade_win	252000.00	USDT	398181.20	Won sell trade on BTCUSDT	2026-02-02 21:05:32	2026-02-02 21:05:32
488	44	143	trade_amount	-3000.00	USDT	364.00	Amount for sell option trade on BTCUSDT	2026-02-03 03:03:45	2026-02-03 03:03:45
489	44	143	fee	-60.00	USDT	304.00	Fee for sell option trade on BTCUSDT	2026-02-03 03:03:45	2026-02-03 03:03:45
490	44	143	trade_win	3360.00	USDT	3664.00	Won sell trade on BTCUSDT	2026-02-03 03:04:16	2026-02-03 03:04:16
491	9	\N	loan_disbursement	100000.00	USDT	498181.20	Loan approved #19	2026-02-03 15:44:27	2026-02-03 15:44:27
492	9	144	trade_amount	-475000.00	USDT	28197.20	Amount for sell option trade on BTCUSDT	2026-02-03 18:44:05	2026-02-03 18:44:05
493	9	144	fee	-9500.00	USDT	18697.20	Fee for sell option trade on BTCUSDT	2026-02-03 18:44:05	2026-02-03 18:44:05
494	9	144	trade_win	627000.00	USDT	645697.20	Won sell trade on BTCUSDT	2026-02-03 18:55:45	2026-02-03 18:55:45
495	38	145	trade_amount	-8500.00	USDT	575.00	Amount for sell option trade on XAUUSD	2026-02-03 19:02:06	2026-02-03 19:02:06
496	38	145	fee	-170.00	USDT	405.00	Fee for sell option trade on XAUUSD	2026-02-03 19:02:06	2026-02-03 19:02:06
497	38	145	trade_win	9520.00	USDT	9925.00	Won sell trade on XAUUSD	2026-02-03 19:02:36	2026-02-03 19:02:36
498	38	146	trade_amount	-9500.00	USDT	425.00	Amount for sell option trade on XAUUSD	2026-02-03 19:07:28	2026-02-03 19:07:28
499	38	146	fee	-190.00	USDT	235.00	Fee for sell option trade on XAUUSD	2026-02-03 19:07:28	2026-02-03 19:07:28
500	38	146	trade_win	10640.00	USDT	10875.00	Won sell trade on XAUUSD	2026-02-03 19:07:58	2026-02-03 19:07:58
501	12	147	trade_amount	-90000.00	USDT	899194.12	Amount for buy option trade on XAUUSD	2026-02-03 19:11:53	2026-02-03 19:11:53
502	12	147	fee	-1800.00	USDT	897394.12	Fee for buy option trade on XAUUSD	2026-02-03 19:11:53	2026-02-03 19:11:53
503	12	147	trade_win	109800.00	USDT	1007194.12	Won buy trade on XAUUSD	2026-02-03 19:14:53	2026-02-03 19:14:53
504	12	148	trade_amount	-20000.00	USDT	987194.12	Amount for buy option trade on BTCUSDT	2026-02-04 22:19:15	2026-02-04 22:19:15
505	12	148	fee	-400.00	USDT	986794.12	Fee for buy option trade on BTCUSDT	2026-02-04 22:19:15	2026-02-04 22:19:15
506	12	148	trade_win	23000.00	USDT	1009794.12	Won buy trade on BTCUSDT	2026-02-04 22:20:16	2026-02-04 22:20:16
507	33	\N	deposit	10.00	ETH	17051.00	Deposit of 10 ETH via crypto approved	2026-02-04 23:31:31	2026-02-04 23:31:31
508	49	149	trade_amount	-950.00	USDT	62.00	Amount for buy option trade on BTCUSDT	2026-02-05 04:04:00	2026-02-05 04:04:00
509	49	149	fee	-19.00	USDT	43.00	Fee for buy option trade on BTCUSDT	2026-02-05 04:04:00	2026-02-05 04:04:00
510	49	149	trade_win	1064.00	USDT	1107.00	Won buy trade on BTCUSDT	2026-02-05 04:04:31	2026-02-05 04:04:31
511	49	150	trade_amount	-1050.00	USDT	57.00	Amount for buy option trade on BTCUSDT	2026-02-05 18:28:05	2026-02-05 18:28:05
512	49	150	fee	-21.00	USDT	36.00	Fee for buy option trade on BTCUSDT	2026-02-05 18:28:05	2026-02-05 18:28:05
513	49	150	trade_win	1176.00	USDT	1212.00	Won buy trade on BTCUSDT	2026-02-05 18:28:35	2026-02-05 18:28:35
514	31	151	trade_amount	-36842.00	USDT	73155.52	Amount for sell option trade on BTCUSDT	2026-02-05 18:39:05	2026-02-05 18:39:05
515	31	151	fee	-736.84	USDT	72418.68	Fee for sell option trade on BTCUSDT	2026-02-05 18:39:05	2026-02-05 18:39:05
516	31	151	trade_win	43473.56	USDT	115892.24	Won sell trade on BTCUSDT	2026-02-05 18:40:36	2026-02-05 18:40:36
517	12	152	trade_amount	-10000.00	USDT	999794.12	Amount for buy option trade on BTCUSDT	2026-02-05 18:41:39	2026-02-05 18:41:39
518	12	152	fee	-200.00	USDT	999594.12	Fee for buy option trade on BTCUSDT	2026-02-05 18:41:39	2026-02-05 18:41:39
519	12	152	trade_win	11200.00	USDT	1010794.12	Won buy trade on BTCUSDT	2026-02-05 18:42:10	2026-02-05 18:42:10
520	38	153	trade_amount	-10500.00	USDT	375.00	Amount for sell option trade on XAUUSD	2026-02-05 23:33:56	2026-02-05 23:33:56
521	38	153	fee	-210.00	USDT	165.00	Fee for sell option trade on XAUUSD	2026-02-05 23:33:56	2026-02-05 23:33:56
522	38	153	trade_win	12075.00	USDT	12240.00	Won sell trade on XAUUSD	2026-02-05 23:34:57	2026-02-05 23:34:57
523	38	154	trade_amount	-12000.00	USDT	240.00	Amount for sell option trade on XAUUSD	2026-02-05 23:38:12	2026-02-05 23:38:12
524	38	154	fee	-240.00	USDT	0.00	Fee for sell option trade on XAUUSD	2026-02-05 23:38:12	2026-02-05 23:38:12
525	38	154	trade_win	13800.00	USDT	13800.00	Won sell trade on XAUUSD	2026-02-05 23:39:12	2026-02-05 23:39:12
526	12	155	trade_amount	-300000.00	USDT	710794.12	Amount for sell option trade on BTCUSDT	2026-02-06 02:00:29	2026-02-06 02:00:29
527	12	155	fee	-6000.00	USDT	704794.12	Fee for sell option trade on BTCUSDT	2026-02-06 02:00:29	2026-02-06 02:00:29
528	12	156	trade_amount	-200000.00	USDT	504794.12	Amount for buy option trade on BTCUSDT	2026-02-06 02:02:32	2026-02-06 02:02:32
529	12	156	fee	-4000.00	USDT	500794.12	Fee for buy option trade on BTCUSDT	2026-02-06 02:02:32	2026-02-06 02:02:32
530	12	157	trade_amount	-200000.00	USDT	300794.12	Amount for sell option trade on BTCUSDT	2026-02-06 02:05:33	2026-02-06 02:05:33
531	12	157	fee	-4000.00	USDT	296794.12	Fee for sell option trade on BTCUSDT	2026-02-06 02:05:33	2026-02-06 02:05:33
532	12	156	trade_win	252000.00	USDT	548794.12	Won buy trade on BTCUSDT	2026-02-06 02:07:33	2026-02-06 02:07:33
533	12	157	trade_win	252000.00	USDT	800794.12	Won sell trade on BTCUSDT	2026-02-06 02:10:33	2026-02-06 02:10:33
534	12	155	trade_win	396000.00	USDT	1196794.12	Won sell trade on BTCUSDT	2026-02-06 02:12:10	2026-02-06 02:12:10
535	31	158	trade_amount	-33496.00	USDT	82396.24	Amount for buy option trade on BTCUSDT	2026-02-06 18:30:08	2026-02-06 18:30:08
536	31	158	fee	-669.92	USDT	81726.32	Fee for buy option trade on BTCUSDT	2026-02-06 18:30:08	2026-02-06 18:30:08
537	31	158	trade_win	39525.28	USDT	121251.60	Won buy trade on BTCUSDT	2026-02-06 18:31:39	2026-02-06 18:31:39
538	44	\N	withdrawal	-100.00	USDT	3563.00	Withdrawal of 100 USDT via TRC20 to 0xa3D7A06026F2B02d21Aab9f8823a4e9B62CB3494	2026-02-07 22:20:39	2026-02-07 22:20:39
539	44	\N	fee	-1.00	USDT	3563.00	Fee for withdrawal of 100 USDT via TRC20	2026-02-07 22:20:39	2026-02-07 22:20:39
540	31	\N	withdrawal	-17000.00	USDT	104231.60	Withdrawal of 17000 USDT via TRC20 to Dtyyy	2026-02-08 21:54:58	2026-02-08 21:54:58
541	31	\N	fee	-20.00	USDT	104231.60	Fee for withdrawal of 17000 USDT via TRC20	2026-02-08 21:54:58	2026-02-08 21:54:58
542	36	159	trade_amount	-30000.00	USDT	281900.00	Amount for buy option trade on BTCUSDT	2026-02-08 21:55:47	2026-02-08 21:55:47
543	36	159	fee	-600.00	USDT	281300.00	Fee for buy option trade on BTCUSDT	2026-02-08 21:55:47	2026-02-08 21:55:47
544	36	159	trade_win	34500.00	USDT	315800.00	Won buy trade on BTCUSDT	2026-02-08 21:56:47	2026-02-08 21:56:47
545	36	160	trade_amount	-70000.00	USDT	245800.00	Amount for buy option trade on BTCUSDT	2026-02-08 21:56:52	2026-02-08 21:56:52
546	36	160	fee	-1400.00	USDT	244400.00	Fee for buy option trade on BTCUSDT	2026-02-08 21:56:52	2026-02-08 21:56:52
547	36	160	trade_win	82600.00	USDT	327000.00	Won buy trade on BTCUSDT	2026-02-08 21:58:23	2026-02-08 21:58:23
548	9	161	trade_amount	-70000.00	USDT	575697.20	Amount for buy option trade on BTCUSDT	2026-02-09 03:03:22	2026-02-09 03:03:22
549	9	161	fee	-1400.00	USDT	574297.20	Fee for buy option trade on BTCUSDT	2026-02-09 03:03:22	2026-02-09 03:03:22
550	9	161	trade_win	82600.00	USDT	656897.20	Won buy trade on BTCUSDT	2026-02-09 03:04:53	2026-02-09 03:04:53
551	41	162	trade_amount	-30000.00	USDT	472600.00	Amount for buy option trade on BTCUSDT	2026-02-09 14:34:35	2026-02-09 14:34:35
552	41	162	fee	-600.00	USDT	472000.00	Fee for buy option trade on BTCUSDT	2026-02-09 14:34:35	2026-02-09 14:34:35
553	41	162	trade_win	34500.00	USDT	506500.00	Won buy trade on BTCUSDT	2026-02-09 14:35:36	2026-02-09 14:35:36
554	47	163	trade_amount	-10800.00	USDT	387.00	Amount for sell option trade on BTCUSDT	2026-02-09 16:27:59	2026-02-09 16:27:59
555	47	163	fee	-216.00	USDT	171.00	Fee for sell option trade on BTCUSDT	2026-02-09 16:27:59	2026-02-09 16:27:59
556	47	163	trade_win	12420.00	USDT	12591.00	Won sell trade on BTCUSDT	2026-02-09 16:29:00	2026-02-09 16:29:00
557	12	164	trade_amount	-25000.00	USDT	1171794.12	Amount for buy option trade on XAUUSD	2026-02-10 01:30:26	2026-02-10 01:30:26
558	12	164	fee	-500.00	USDT	1171294.12	Fee for buy option trade on XAUUSD	2026-02-10 01:30:26	2026-02-10 01:30:26
559	12	164	trade_win	28750.00	USDT	1200044.12	Won buy trade on XAUUSD	2026-02-10 01:31:27	2026-02-10 01:31:27
560	36	165	trade_amount	-68129.00	USDT	258871.00	Amount for buy option trade on BTCUSDT	2026-02-10 20:16:29	2026-02-10 20:16:29
561	36	165	fee	-1362.58	USDT	257508.42	Fee for buy option trade on BTCUSDT	2026-02-10 20:16:29	2026-02-10 20:16:29
562	36	165	trade_win	80392.22	USDT	337900.64	Won buy trade on BTCUSDT	2026-02-10 20:18:00	2026-02-10 20:18:00
563	50	166	trade_amount	-800.00	USDT	119.00	Amount for buy option trade on BTCUSDT	2026-02-10 20:34:04	2026-02-10 20:34:04
564	50	166	fee	-16.00	USDT	103.00	Fee for buy option trade on BTCUSDT	2026-02-10 20:34:04	2026-02-10 20:34:04
565	50	166	trade_win	896.00	USDT	999.00	Won buy trade on BTCUSDT	2026-02-10 20:34:35	2026-02-10 20:34:35
566	38	\N	deposit	10.00	ETH	23649.00	Deposit of 10 ETH via crypto approved	2026-02-10 21:43:56	2026-02-10 21:43:56
567	35	167	trade_amount	-490.00	USDT	100.00	Amount for buy option trade on BTCUSDT	2026-02-11 03:23:56	2026-02-11 03:23:56
568	35	167	fee	-9.80	USDT	90.20	Fee for buy option trade on BTCUSDT	2026-02-11 03:23:56	2026-02-11 03:23:56
569	35	167	trade_win	548.80	USDT	639.00	Won buy trade on BTCUSDT	2026-02-11 03:24:27	2026-02-11 03:24:27
570	23	168	trade_amount	-60000.00	USDT	47182.00	Amount for sell option trade on BTCUSDT	2026-02-11 22:51:00	2026-02-11 22:51:00
571	23	168	fee	-1200.00	USDT	45982.00	Fee for sell option trade on BTCUSDT	2026-02-11 22:51:00	2026-02-11 22:51:00
572	23	168	trade_win	70800.00	USDT	116782.00	Won sell trade on BTCUSDT	2026-02-11 22:52:31	2026-02-11 22:52:31
573	38	169	trade_amount	-23000.00	USDT	649.00	Amount for buy option trade on XAUUSD	2026-02-11 23:01:47	2026-02-11 23:01:47
574	38	169	fee	-460.00	USDT	189.00	Fee for buy option trade on XAUUSD	2026-02-11 23:01:47	2026-02-11 23:01:47
575	38	169	trade_win	26450.00	USDT	26639.00	Won buy trade on XAUUSD	2026-02-11 23:02:47	2026-02-11 23:02:47
576	36	170	trade_amount	-67500.00	USDT	270400.64	Amount for buy option trade on BTCUSDT	2026-02-11 23:23:44	2026-02-11 23:23:44
577	36	170	fee	-1350.00	USDT	269050.64	Fee for buy option trade on BTCUSDT	2026-02-11 23:23:44	2026-02-11 23:23:44
578	36	171	trade_amount	-25000.00	USDT	244050.64	Amount for buy option trade on BTCUSDT	2026-02-11 23:24:40	2026-02-11 23:24:40
579	36	171	fee	-500.00	USDT	243550.64	Fee for buy option trade on BTCUSDT	2026-02-11 23:24:40	2026-02-11 23:24:40
580	36	170	trade_win	79650.00	USDT	323200.64	Won buy trade on BTCUSDT	2026-02-11 23:25:15	2026-02-11 23:25:15
581	36	171	trade_win	28750.00	USDT	351950.64	Won buy trade on BTCUSDT	2026-02-11 23:25:40	2026-02-11 23:25:40
1239	82	379	trade_win	17250.00	USDT	17484.00	Won sell trade on BTCUSDT	2026-05-09 01:02:47	2026-05-09 01:02:47
1242	82	380	trade_win	19550.00	USDT	19694.00	Won sell trade on BTCUSDT	2026-05-09 01:06:33	2026-05-09 01:06:33
1244	88	381	trade_amount	-900.00	USDT	80.00	Amount for buy option trade on BTCUSDT	2026-05-09 14:35:31	2026-05-09 14:35:31
1245	88	381	fee	-18.00	USDT	62.00	Fee for buy option trade on BTCUSDT	2026-05-09 14:35:31	2026-05-09 14:35:31
1249	88	382	trade_win	1064.00	USDT	1165.00	Won buy trade on BTCUSDT	2026-05-09 14:39:12	2026-05-09 14:39:12
1250	88	383	trade_amount	-900.00	USDT	265.00	Amount for buy option trade on BTCUSDT	2026-05-09 14:41:09	2026-05-09 14:41:09
588	25	174	trade_amount	-30000.00	USDT	588449.20	Amount for buy option trade on BTCUSDT	2026-02-12 21:41:42	2026-02-12 21:41:42
589	25	174	fee	-600.00	USDT	587849.20	Fee for buy option trade on BTCUSDT	2026-02-12 21:41:42	2026-02-12 21:41:42
590	25	174	trade_win	34500.00	USDT	622349.20	Won buy trade on BTCUSDT	2026-02-12 21:42:42	2026-02-12 21:42:42
1251	88	383	fee	-18.00	USDT	247.00	Fee for buy option trade on BTCUSDT	2026-05-09 14:41:09	2026-05-09 14:41:09
1253	78	\N	arbitrage_profit	15.00	USDT	79946.77	\N	2026-05-09 18:01:25	2026-05-09 18:01:25
1256	78	385	trade_amount	-65000.00	USDT	14946.77	Amount for sell option trade on BTCUSDT	2026-05-12 01:00:06	2026-05-12 01:00:06
1257	78	385	fee	-1300.00	USDT	13646.77	Fee for sell option trade on BTCUSDT	2026-05-12 01:00:06	2026-05-12 01:00:06
1259	60	386	trade_amount	-14000.00	USDT	785.00	Amount for buy option trade on BTCUSDT	2026-05-12 01:21:01	2026-05-12 01:21:01
1260	60	386	fee	-280.00	USDT	505.00	Fee for buy option trade on BTCUSDT	2026-05-12 01:21:01	2026-05-12 01:21:01
1262	41	387	trade_amount	-55000.00	USDT	533100.40	Amount for buy option trade on XAUUSD	2026-05-12 02:20:49	2026-05-12 02:20:49
1263	41	387	fee	-1100.00	USDT	532000.40	Fee for buy option trade on XAUUSD	2026-05-12 02:20:49	2026-05-12 02:20:49
599	12	178	trade_amount	-44754.00	USDT	1155290.12	Amount for buy option trade on BTCUSDT	2026-02-13 23:16:51	2026-02-13 23:16:51
600	12	178	fee	-895.08	USDT	1154395.04	Fee for buy option trade on BTCUSDT	2026-02-13 23:16:51	2026-02-13 23:16:51
601	12	178	trade_win	52809.72	USDT	1207204.76	Won buy trade on BTCUSDT	2026-02-13 23:18:22	2026-02-13 23:18:22
602	53	179	trade_amount	-1000.00	USDT	100.00	Amount for buy option trade on BTCUSDT	2026-02-13 23:45:43	2026-02-13 23:45:43
603	53	179	fee	-20.00	USDT	80.00	Fee for buy option trade on BTCUSDT	2026-02-13 23:45:43	2026-02-13 23:45:43
604	53	179	trade_win	1120.00	USDT	1200.00	Won buy trade on BTCUSDT	2026-02-13 23:46:13	2026-02-13 23:46:13
605	53	180	trade_amount	-1000.00	USDT	200.00	Amount for buy option trade on BTCUSDT	2026-02-13 23:51:43	2026-02-13 23:51:43
606	53	180	fee	-20.00	USDT	180.00	Fee for buy option trade on BTCUSDT	2026-02-13 23:51:43	2026-02-13 23:51:43
607	53	180	trade_win	1120.00	USDT	1300.00	Won buy trade on BTCUSDT	2026-02-13 23:52:14	2026-02-13 23:52:14
1265	25	388	trade_amount	-6000.00	USDT	634739.20	Amount for buy option trade on BTCUSDT	2026-05-12 07:11:11	2026-05-12 07:11:11
1266	25	388	fee	-120.00	USDT	634619.20	Fee for buy option trade on BTCUSDT	2026-05-12 07:11:11	2026-05-12 07:11:11
1268	78	\N	arbitrage_purchase	-7999.00	USDT	82347.77	\N	2026-05-12 10:29:21	2026-05-12 10:29:21
611	12	\N	mining_purchase	-50000.00	USDT	1157204.76	\N	2026-02-16 02:27:41	2026-02-16 02:27:41
612	12	\N	mining_refund	45000.00	USDT	1202204.76	\N	2026-02-16 02:27:53	2026-02-16 02:27:53
613	12	\N	mining_profit	28764.00	USDT	1281968.76	\N	2026-02-16 02:27:59	2026-02-16 02:27:59
1271	47	389	trade_win	76700.00	USDT	78358.00	Won buy trade on BTCUSDT	2026-05-12 15:55:52	2026-05-12 15:55:52
1275	41	391	trade_amount	-70000.00	USDT	549900.40	Amount for buy option trade on XAUUSD	2026-05-14 19:03:50	2026-05-14 19:03:50
1276	41	391	fee	-1400.00	USDT	548500.40	Fee for buy option trade on XAUUSD	2026-05-14 19:03:50	2026-05-14 19:03:50
1278	78	\N	arbitrage_profit	208.77	USDT	90555.54	\N	2026-05-15 10:29:21	2026-05-15 10:29:21
1281	82	392	trade_win	21850.00	USDT	22164.00	Won buy trade on BTCUSDT	2026-05-16 03:08:34	2026-05-16 03:08:34
618	41	182	trade_amount	-50000.00	USDT	456500.00	Amount for buy option trade on ETHUSDT	2026-02-17 03:58:42	2026-02-17 03:58:42
619	41	182	fee	-1000.00	USDT	455500.00	Fee for buy option trade on ETHUSDT	2026-02-17 03:58:42	2026-02-17 03:58:42
620	50	183	trade_amount	-1800.00	USDT	124.00	Amount for buy option trade on BTCUSDT	2026-02-17 03:59:59	2026-02-17 03:59:59
621	50	183	fee	-36.00	USDT	88.00	Fee for buy option trade on BTCUSDT	2026-02-17 03:59:59	2026-02-17 03:59:59
622	41	182	trade_win	59000.00	USDT	514500.00	Won buy trade on ETHUSDT	2026-02-17 04:00:13	2026-02-17 04:00:13
623	50	183	trade_win	2016.00	USDT	2104.00	Won buy trade on BTCUSDT	2026-02-17 04:00:30	2026-02-17 04:00:30
624	36	184	trade_amount	-62000.00	USDT	289950.64	Amount for buy option trade on BTCUSDT	2026-02-17 04:01:19	2026-02-17 04:01:19
625	36	184	fee	-1240.00	USDT	288710.64	Fee for buy option trade on BTCUSDT	2026-02-17 04:01:19	2026-02-17 04:01:19
626	36	184	trade_win	73160.00	USDT	361870.64	Won buy trade on BTCUSDT	2026-02-17 04:02:49	2026-02-17 04:02:49
627	36	185	trade_amount	-62300.00	USDT	299570.64	Amount for buy option trade on BTCUSDT	2026-02-17 04:09:38	2026-02-17 04:09:38
628	36	185	fee	-1246.00	USDT	298324.64	Fee for buy option trade on BTCUSDT	2026-02-17 04:09:38	2026-02-17 04:09:38
629	36	185	trade_win	73514.00	USDT	371838.64	Won buy trade on BTCUSDT	2026-02-17 04:11:09	2026-02-17 04:11:09
630	9	186	trade_amount	-100000.00	USDT	556897.20	Amount for sell option trade on BTCUSDT	2026-02-17 22:27:17	2026-02-17 22:27:17
631	9	186	fee	-2000.00	USDT	554897.20	Fee for sell option trade on BTCUSDT	2026-02-17 22:27:17	2026-02-17 22:27:17
632	9	186	trade_win	122000.00	USDT	676897.20	Won sell trade on BTCUSDT	2026-02-17 22:30:18	2026-02-17 22:30:18
633	47	187	trade_amount	-17000.00	USDT	612.00	Amount for buy option trade on BTCUSDT	2026-02-18 17:24:05	2026-02-18 17:24:05
634	47	187	fee	-340.00	USDT	272.00	Fee for buy option trade on BTCUSDT	2026-02-18 17:24:05	2026-02-18 17:24:05
635	47	187	trade_win	19550.00	USDT	19822.00	Won buy trade on BTCUSDT	2026-02-18 17:25:06	2026-02-18 17:25:06
636	12	188	trade_amount	-120000.00	USDT	1161968.76	Amount for buy option trade on BTCUSDT	2026-02-18 17:25:26	2026-02-18 17:25:26
637	12	188	fee	-2400.00	USDT	1159568.76	Fee for buy option trade on BTCUSDT	2026-02-18 17:25:26	2026-02-18 17:25:26
638	12	188	trade_win	146400.00	USDT	1305968.76	Won buy trade on BTCUSDT	2026-02-18 17:28:27	2026-02-18 17:28:27
639	54	\N	withdrawal	-10.00	USDT	33.00	Withdrawal of 10 USDT via TRC20 to 0x224E0A425342CAC9bF01774F72B2dc96fdDA1ABF	2026-02-18 18:44:25	2026-02-18 18:44:25
640	54	\N	fee	-1.00	USDT	33.00	Fee for withdrawal of 10 USDT via TRC20	2026-02-18 18:44:25	2026-02-18 18:44:25
641	38	189	trade_amount	-26000.00	USDT	639.00	Amount for buy option trade on XAUUSD	2026-02-18 20:09:31	2026-02-18 20:09:31
642	38	189	fee	-520.00	USDT	119.00	Fee for buy option trade on XAUUSD	2026-02-18 20:09:31	2026-02-18 20:09:31
643	38	189	trade_win	29900.00	USDT	30019.00	Won buy trade on XAUUSD	2026-02-18 20:10:31	2026-02-18 20:10:31
644	12	190	trade_amount	-50000.00	USDT	1255968.76	Amount for buy option trade on XAUUSD	2026-02-18 21:03:45	2026-02-18 21:03:45
645	12	190	fee	-1000.00	USDT	1254968.76	Fee for buy option trade on XAUUSD	2026-02-18 21:03:45	2026-02-18 21:03:45
646	12	190	trade_win	59000.00	USDT	1313968.76	Won buy trade on XAUUSD	2026-02-18 21:05:16	2026-02-18 21:05:16
647	38	\N	deposit	10.00	ETH	30019.00	Deposit of 10 ETH via crypto approved	2026-02-18 21:51:19	2026-02-18 21:51:19
648	53	191	trade_amount	-1000.00	USDT	300.00	Amount for buy option trade on XAUUSD	2026-02-19 00:22:27	2026-02-19 00:22:27
649	53	191	fee	-20.00	USDT	280.00	Fee for buy option trade on XAUUSD	2026-02-19 00:22:27	2026-02-19 00:22:27
650	53	191	trade_win	1120.00	USDT	1400.00	Won buy trade on XAUUSD	2026-02-19 00:22:58	2026-02-19 00:22:58
651	23	192	trade_amount	-134000.00	USDT	2782.00	Amount for sell option trade on BTCUSDT	2026-02-19 21:36:47	2026-02-19 21:36:47
652	23	192	fee	-2680.00	USDT	102.00	Fee for sell option trade on BTCUSDT	2026-02-19 21:36:47	2026-02-19 21:36:47
653	23	192	trade_win	168840.00	USDT	168942.00	Won sell trade on BTCUSDT	2026-02-19 21:41:47	2026-02-19 21:41:47
654	23	\N	deposit	2000.00	BTC	168942.00	Deposit of 2000 BTC via crypto approved	2026-02-20 17:44:17	2026-02-20 17:44:17
655	50	193	trade_amount	-2000.00	USDT	104.00	Amount for buy option trade on BTCUSDT	2026-02-20 21:10:29	2026-02-20 21:10:29
656	50	193	fee	-40.00	USDT	64.00	Fee for buy option trade on BTCUSDT	2026-02-20 21:10:29	2026-02-20 21:10:29
657	50	193	trade_win	2240.00	USDT	2304.00	Won buy trade on BTCUSDT	2026-02-20 21:10:59	2026-02-20 21:10:59
658	38	194	trade_amount	-58500.00	USDT	1413.00	Amount for buy option trade on XAUUSD	2026-02-21 00:33:23	2026-02-21 00:33:23
659	38	194	fee	-1170.00	USDT	243.00	Fee for buy option trade on XAUUSD	2026-02-21 00:33:23	2026-02-21 00:33:23
660	38	194	trade_win	69030.00	USDT	69273.00	Won buy trade on XAUUSD	2026-02-21 00:34:54	2026-02-21 00:34:54
661	25	195	trade_amount	-500.00	USDT	621849.20	Amount for buy contract trade on BTCUSDT with 10x leverage	2026-02-21 03:56:35	2026-02-21 03:56:35
662	25	195	fee	-10.00	USDT	621839.20	Fee for buy contract trade on BTCUSDT	2026-02-21 03:56:35	2026-02-21 03:56:35
663	25	195	trade_win	500.00	USDT	622339.20	Won buy trade on BTCUSDT	2026-02-21 03:56:36	2026-02-21 03:56:36
664	51	196	trade_amount	-400.00	USDT	75.00	Amount for buy option trade on BTCUSDT	2026-02-21 04:09:55	2026-02-21 04:09:55
665	51	196	fee	-8.00	USDT	67.00	Fee for buy option trade on BTCUSDT	2026-02-21 04:09:55	2026-02-21 04:09:55
666	51	196	trade_win	448.00	USDT	515.00	Won buy trade on BTCUSDT	2026-02-21 04:10:26	2026-02-21 04:10:26
667	51	197	trade_amount	-400.00	USDT	115.00	Amount for buy option trade on BTCUSDT	2026-02-21 04:21:39	2026-02-21 04:21:39
668	51	197	fee	-8.00	USDT	107.00	Fee for buy option trade on BTCUSDT	2026-02-21 04:21:39	2026-02-21 04:21:39
669	51	197	trade_win	448.00	USDT	555.00	Won buy trade on BTCUSDT	2026-02-21 04:22:09	2026-02-21 04:22:09
670	51	198	trade_amount	-500.00	USDT	55.00	Amount for buy option trade on BTCUSDT	2026-02-21 04:33:02	2026-02-21 04:33:02
671	51	198	fee	-10.00	USDT	45.00	Fee for buy option trade on BTCUSDT	2026-02-21 04:33:02	2026-02-21 04:33:02
672	51	198	trade_win	560.00	USDT	605.00	Won buy trade on BTCUSDT	2026-02-21 04:33:32	2026-02-21 04:33:32
673	51	199	trade_amount	-500.00	USDT	105.00	Amount for buy option trade on BTCUSDT	2026-02-21 04:36:56	2026-02-21 04:36:56
674	51	199	fee	-10.00	USDT	95.00	Fee for buy option trade on BTCUSDT	2026-02-21 04:36:56	2026-02-21 04:36:56
675	51	199	trade_win	560.00	USDT	655.00	Won buy trade on BTCUSDT	2026-02-21 04:37:27	2026-02-21 04:37:27
676	51	200	trade_amount	-600.00	USDT	55.00	Amount for buy option trade on BTCUSDT	2026-02-21 04:40:12	2026-02-21 04:40:12
677	51	200	fee	-12.00	USDT	43.00	Fee for buy option trade on BTCUSDT	2026-02-21 04:40:12	2026-02-21 04:40:12
678	51	200	trade_win	672.00	USDT	715.00	Won buy trade on BTCUSDT	2026-02-21 04:40:42	2026-02-21 04:40:42
679	25	201	trade_amount	-50000.00	USDT	572339.20	Amount for buy option trade on BTCUSDT	2026-02-21 04:41:49	2026-02-21 04:41:49
680	25	201	fee	-1000.00	USDT	571339.20	Fee for buy option trade on BTCUSDT	2026-02-21 04:41:49	2026-02-21 04:41:49
681	25	201	trade_win	59000.00	USDT	630339.20	Won buy trade on BTCUSDT	2026-02-21 04:43:19	2026-02-21 04:43:19
682	12	202	trade_amount	-30000.00	USDT	1283968.76	Amount for buy option trade on BTCUSDT	2026-02-23 22:33:57	2026-02-23 22:33:57
683	12	202	fee	-600.00	USDT	1283368.76	Fee for buy option trade on BTCUSDT	2026-02-23 22:33:57	2026-02-23 22:33:57
684	12	203	trade_amount	-30000.00	USDT	1253368.76	Amount for buy option trade on XAUUSD	2026-02-23 22:34:19	2026-02-23 22:34:19
685	12	203	fee	-600.00	USDT	1252768.76	Fee for buy option trade on XAUUSD	2026-02-23 22:34:19	2026-02-23 22:34:19
686	12	202	trade_win	34500.00	USDT	1287268.76	Won buy trade on BTCUSDT	2026-02-23 22:34:57	2026-02-23 22:34:57
687	12	203	trade_win	34500.00	USDT	1321768.76	Won buy trade on XAUUSD	2026-02-23 22:35:19	2026-02-23 22:35:19
688	57	204	trade_amount	-900.00	USDT	80.00	Amount for buy option trade on ETHUSDT	2026-02-24 19:52:56	2026-02-24 19:52:56
689	57	204	fee	-18.00	USDT	62.00	Fee for buy option trade on ETHUSDT	2026-02-24 19:52:56	2026-02-24 19:52:56
690	57	204	trade_win	1008.00	USDT	1070.00	Won buy trade on ETHUSDT	2026-02-24 19:53:27	2026-02-24 19:53:27
691	50	205	trade_amount	-2000.00	USDT	304.00	Amount for buy option trade on BTCUSDT	2026-02-24 20:51:46	2026-02-24 20:51:46
692	50	205	fee	-40.00	USDT	264.00	Fee for buy option trade on BTCUSDT	2026-02-24 20:51:46	2026-02-24 20:51:46
693	50	205	trade_win	2240.00	USDT	2504.00	Won buy trade on BTCUSDT	2026-02-24 20:52:17	2026-02-24 20:52:17
694	31	206	trade_amount	-48932.00	USDT	55299.60	Amount for buy option trade on BTCUSDT	2026-02-25 00:31:25	2026-02-25 00:31:25
695	31	206	fee	-978.64	USDT	54320.96	Fee for buy option trade on BTCUSDT	2026-02-25 00:31:25	2026-02-25 00:31:25
696	31	206	trade_win	57739.76	USDT	112060.72	Won buy trade on BTCUSDT	2026-02-25 00:32:56	2026-02-25 00:32:56
697	23	207	trade_amount	-30001.00	USDT	138941.00	Amount for buy option trade on BTCUSDT	2026-02-25 02:07:16	2026-02-25 02:07:16
698	23	207	fee	-600.02	USDT	138340.98	Fee for buy option trade on BTCUSDT	2026-02-25 02:07:16	2026-02-25 02:07:16
699	23	207	trade_win	35401.18	USDT	173742.16	Won buy trade on BTCUSDT	2026-02-25 02:08:47	2026-02-25 02:08:47
700	23	208	trade_amount	-70000.00	USDT	103742.16	Amount for buy option trade on BTCUSDT	2026-02-25 02:11:53	2026-02-25 02:11:53
701	23	208	fee	-1400.00	USDT	102342.16	Fee for buy option trade on BTCUSDT	2026-02-25 02:11:53	2026-02-25 02:11:53
702	23	208	trade_win	82600.00	USDT	184942.16	Won buy trade on BTCUSDT	2026-02-25 02:13:23	2026-02-25 02:13:23
703	47	209	trade_amount	-24000.00	USDT	1422.00	Amount for buy option trade on BTCUSDT	2026-02-25 17:57:50	2026-02-25 17:57:50
704	47	209	fee	-480.00	USDT	942.00	Fee for buy option trade on BTCUSDT	2026-02-25 17:57:50	2026-02-25 17:57:50
705	47	209	trade_win	27600.00	USDT	28542.00	Won buy trade on BTCUSDT	2026-02-25 17:58:50	2026-02-25 17:58:50
706	12	210	trade_amount	-180000.00	USDT	1141768.76	Amount for buy option trade on BTCUSDT	2026-02-25 18:04:01	2026-02-25 18:04:01
707	12	210	fee	-3600.00	USDT	1138168.76	Fee for buy option trade on BTCUSDT	2026-02-25 18:04:01	2026-02-25 18:04:01
708	12	210	trade_win	226800.00	USDT	1364968.76	Won buy trade on BTCUSDT	2026-02-25 18:09:02	2026-02-25 18:09:02
709	48	211	trade_amount	-10000.00	USDT	240000.00	Amount for buy option trade on XAUUSD	2026-02-26 18:14:38	2026-02-26 18:14:38
710	48	211	fee	-200.00	USDT	239800.00	Fee for buy option trade on XAUUSD	2026-02-26 18:14:38	2026-02-26 18:14:38
711	48	211	trade_win	11200.00	USDT	251000.00	Won buy trade on XAUUSD	2026-02-26 18:15:08	2026-02-26 18:15:08
712	48	212	trade_amount	-40000.00	USDT	211000.00	Amount for buy option trade on XAUUSD	2026-02-26 20:28:57	2026-02-26 20:28:57
713	48	212	fee	-800.00	USDT	210200.00	Fee for buy option trade on XAUUSD	2026-02-26 20:28:57	2026-02-26 20:28:57
714	48	212	trade_win	47200.00	USDT	257400.00	Won buy trade on XAUUSD	2026-02-26 20:30:28	2026-02-26 20:30:28
715	12	213	trade_amount	-50000.00	USDT	1314968.76	Amount for buy option trade on XAUUSD	2026-02-27 02:47:01	2026-02-27 02:47:01
716	12	213	fee	-1000.00	USDT	1313968.76	Fee for buy option trade on XAUUSD	2026-02-27 02:47:01	2026-02-27 02:47:01
717	12	213	trade_win	59000.00	USDT	1372968.76	Won buy trade on XAUUSD	2026-02-27 02:48:31	2026-02-27 02:48:31
718	12	214	trade_amount	-100000.00	USDT	1272968.76	Amount for buy option trade on XAUUSD	2026-02-27 20:06:25	2026-02-27 20:06:25
719	12	214	fee	-2000.00	USDT	1270968.76	Fee for buy option trade on XAUUSD	2026-02-27 20:06:25	2026-02-27 20:06:25
720	12	214	trade_win	122000.00	USDT	1392968.76	Won buy trade on XAUUSD	2026-02-27 20:09:25	2026-02-27 20:09:25
721	12	215	trade_amount	-70000.00	USDT	1322968.76	Amount for buy option trade on BTCUSDT	2026-02-27 20:10:29	2026-02-27 20:10:29
722	12	215	fee	-1400.00	USDT	1321568.76	Fee for buy option trade on BTCUSDT	2026-02-27 20:10:29	2026-02-27 20:10:29
723	12	215	trade_win	82600.00	USDT	1404168.76	Won buy trade on BTCUSDT	2026-02-27 20:12:00	2026-02-27 20:12:00
724	12	216	trade_amount	-70000.00	USDT	1334168.76	Amount for buy option trade on XAUUSD	2026-02-27 20:19:03	2026-02-27 20:19:03
725	12	216	fee	-1400.00	USDT	1332768.76	Fee for buy option trade on XAUUSD	2026-02-27 20:19:03	2026-02-27 20:19:03
726	12	216	trade_win	82600.00	USDT	1415368.76	Won buy trade on XAUUSD	2026-02-27 20:20:33	2026-02-27 20:20:33
727	38	217	trade_amount	-20000.00	USDT	49273.00	Amount for buy option trade on XAUUSD	2026-02-27 23:00:45	2026-02-27 23:00:45
728	38	217	fee	-400.00	USDT	48873.00	Fee for buy option trade on XAUUSD	2026-02-27 23:00:45	2026-02-27 23:00:45
729	38	217	trade_win	23000.00	USDT	71873.00	Won buy trade on XAUUSD	2026-02-27 23:01:45	2026-02-27 23:01:45
730	57	218	trade_amount	-2800.00	USDT	250.00	Amount for buy option trade on ETHUSDT	2026-02-27 23:09:02	2026-02-27 23:09:02
731	57	218	fee	-56.00	USDT	194.00	Fee for buy option trade on ETHUSDT	2026-02-27 23:09:02	2026-02-27 23:09:02
732	57	218	trade_win	3136.00	USDT	3330.00	Won buy trade on ETHUSDT	2026-02-27 23:09:33	2026-02-27 23:09:33
733	57	219	trade_amount	-2800.00	USDT	530.00	Amount for buy option trade on ETHUSDT	2026-02-27 23:11:50	2026-02-27 23:11:50
734	57	219	fee	-56.00	USDT	474.00	Fee for buy option trade on ETHUSDT	2026-02-27 23:11:50	2026-02-27 23:11:50
735	57	219	trade_win	3136.00	USDT	3610.00	Won buy trade on ETHUSDT	2026-02-27 23:12:21	2026-02-27 23:12:21
736	9	220	trade_amount	-70000.00	USDT	606897.20	Amount for sell option trade on BTCUSDT	2026-02-28 01:42:53	2026-02-28 01:42:53
737	9	220	fee	-1400.00	USDT	605497.20	Fee for sell option trade on BTCUSDT	2026-02-28 01:42:53	2026-02-28 01:42:53
738	9	220	trade_win	82600.00	USDT	688097.20	Won sell trade on BTCUSDT	2026-02-28 01:44:23	2026-02-28 01:44:23
739	12	221	trade_amount	-30000.00	USDT	1385368.76	Amount for buy option trade on BTCUSDT	2026-02-28 01:59:47	2026-02-28 01:59:47
740	12	221	fee	-600.00	USDT	1384768.76	Fee for buy option trade on BTCUSDT	2026-02-28 01:59:47	2026-02-28 01:59:47
741	12	221	trade_win	34500.00	USDT	1419268.76	Won buy trade on BTCUSDT	2026-02-28 02:00:48	2026-02-28 02:00:48
742	38	\N	withdrawal	-10.00	USDT	71862.00	Withdrawal of 10 USDT via TRC20 to 0xe05290b4724A5913010956625e1F928635A9bf72	2026-02-28 02:52:28	2026-02-28 02:52:28
743	38	\N	fee	-1.00	USDT	71862.00	Fee for withdrawal of 10 USDT via TRC20	2026-02-28 02:52:28	2026-02-28 02:52:28
744	10	222	trade_amount	-30000.00	USDT	974333.71	Amount for buy option trade on XAUUSD	2026-02-28 03:50:21	2026-02-28 03:50:21
745	10	222	fee	-600.00	USDT	973733.71	Fee for buy option trade on XAUUSD	2026-02-28 03:50:21	2026-02-28 03:50:21
746	10	222	trade_win	34500.00	USDT	1008233.71	Won buy trade on XAUUSD	2026-02-28 03:51:21	2026-02-28 03:51:21
747	64	223	trade_amount	-400.00	USDT	85.00	Amount for buy option trade on XAUUSD	2026-03-02 01:01:20	2026-03-02 01:01:20
748	64	223	fee	-8.00	USDT	77.00	Fee for buy option trade on XAUUSD	2026-03-02 01:01:20	2026-03-02 01:01:20
749	64	223	trade_win	448.00	USDT	525.00	Won buy trade on XAUUSD	2026-03-02 01:01:50	2026-03-02 01:01:50
750	12	224	trade_amount	-10000.00	USDT	1409268.76	Amount for buy option trade on XAUUSD	2026-03-02 01:06:16	2026-03-02 01:06:16
751	12	224	fee	-200.00	USDT	1409068.76	Fee for buy option trade on XAUUSD	2026-03-02 01:06:16	2026-03-02 01:06:16
752	12	224	trade_win	11200.00	USDT	1420268.76	Won buy trade on XAUUSD	2026-03-02 01:06:47	2026-03-02 01:06:47
753	31	225	trade_amount	-51792.00	USDT	60268.72	Amount for buy option trade on BTCUSDT	2026-03-02 18:30:22	2026-03-02 18:30:22
754	31	225	fee	-1035.84	USDT	59232.88	Fee for buy option trade on BTCUSDT	2026-03-02 18:30:22	2026-03-02 18:30:22
755	31	225	trade_win	61114.56	USDT	120347.44	Won buy trade on BTCUSDT	2026-03-02 18:31:53	2026-03-02 18:31:53
756	58	226	trade_amount	-1000.00	USDT	43.00	Amount for buy option trade on BTCUSDT	2026-03-02 20:16:01	2026-03-02 20:16:01
757	58	226	fee	-20.00	USDT	23.00	Fee for buy option trade on BTCUSDT	2026-03-02 20:16:01	2026-03-02 20:16:01
758	50	227	trade_amount	-3000.00	USDT	324.00	Amount for buy option trade on BTCUSDT	2026-03-02 20:16:07	2026-03-02 20:16:07
759	50	227	fee	-60.00	USDT	264.00	Fee for buy option trade on BTCUSDT	2026-03-02 20:16:07	2026-03-02 20:16:07
760	58	226	trade_win	1120.00	USDT	1143.00	Won buy trade on BTCUSDT	2026-03-02 20:16:32	2026-03-02 20:16:32
761	50	227	trade_win	3360.00	USDT	3624.00	Won buy trade on BTCUSDT	2026-03-02 20:16:37	2026-03-02 20:16:37
762	58	228	trade_amount	-1000.00	USDT	143.00	Amount for buy option trade on BTCUSDT	2026-03-02 20:31:47	2026-03-02 20:31:47
763	58	228	fee	-20.00	USDT	123.00	Fee for buy option trade on BTCUSDT	2026-03-02 20:31:47	2026-03-02 20:31:47
764	58	228	trade_win	1120.00	USDT	1243.00	Won buy trade on BTCUSDT	2026-03-02 20:32:18	2026-03-02 20:32:18
765	58	229	trade_amount	-1200.00	USDT	43.00	Amount for buy option trade on BTCUSDT	2026-03-02 20:47:44	2026-03-02 20:47:44
766	58	229	fee	-24.00	USDT	19.00	Fee for buy option trade on BTCUSDT	2026-03-02 20:47:44	2026-03-02 20:47:44
767	58	229	trade_win	1344.00	USDT	1363.00	Won buy trade on BTCUSDT	2026-03-02 20:48:15	2026-03-02 20:48:15
768	58	230	trade_amount	-1200.00	USDT	163.00	Amount for buy option trade on BTCUSDT	2026-03-02 20:55:04	2026-03-02 20:55:04
769	58	230	fee	-24.00	USDT	139.00	Fee for buy option trade on BTCUSDT	2026-03-02 20:55:04	2026-03-02 20:55:04
770	58	230	trade_win	1344.00	USDT	1483.00	Won buy trade on BTCUSDT	2026-03-02 20:55:35	2026-03-02 20:55:35
771	58	231	trade_amount	-1200.00	USDT	283.00	Amount for buy option trade on BTCUSDT	2026-03-02 20:56:18	2026-03-02 20:56:18
772	58	231	fee	-24.00	USDT	259.00	Fee for buy option trade on BTCUSDT	2026-03-02 20:56:18	2026-03-02 20:56:18
773	58	231	trade_win	1344.00	USDT	1603.00	Won buy trade on BTCUSDT	2026-03-02 20:56:49	2026-03-02 20:56:49
774	58	232	trade_amount	-1500.00	USDT	103.00	Amount for buy option trade on BTCUSDT	2026-03-02 21:02:21	2026-03-02 21:02:21
775	58	232	fee	-30.00	USDT	73.00	Fee for buy option trade on BTCUSDT	2026-03-02 21:02:21	2026-03-02 21:02:21
776	58	232	trade_win	1680.00	USDT	1753.00	Won buy trade on BTCUSDT	2026-03-02 21:02:52	2026-03-02 21:02:52
777	58	233	trade_amount	-1600.00	USDT	153.00	Amount for buy option trade on BTCUSDT	2026-03-02 21:07:40	2026-03-02 21:07:40
778	58	233	fee	-32.00	USDT	121.00	Fee for buy option trade on BTCUSDT	2026-03-02 21:07:40	2026-03-02 21:07:40
779	58	233	trade_win	1792.00	USDT	1913.00	Won buy trade on BTCUSDT	2026-03-02 21:08:11	2026-03-02 21:08:11
780	58	234	trade_amount	-1600.00	USDT	313.00	Amount for buy option trade on BTCUSDT	2026-03-02 21:08:44	2026-03-02 21:08:44
781	58	234	fee	-32.00	USDT	281.00	Fee for buy option trade on BTCUSDT	2026-03-02 21:08:44	2026-03-02 21:08:44
782	58	234	trade_win	1792.00	USDT	2073.00	Won buy trade on BTCUSDT	2026-03-02 21:09:15	2026-03-02 21:09:15
783	58	235	trade_amount	-1800.00	USDT	273.00	Amount for buy option trade on BTCUSDT	2026-03-02 21:21:35	2026-03-02 21:21:35
784	58	235	fee	-36.00	USDT	237.00	Fee for buy option trade on BTCUSDT	2026-03-02 21:21:35	2026-03-02 21:21:35
785	58	235	trade_win	2016.00	USDT	2253.00	Won buy trade on BTCUSDT	2026-03-02 21:22:06	2026-03-02 21:22:06
786	58	236	trade_amount	-1800.00	USDT	453.00	Amount for buy option trade on BTCUSDT	2026-03-02 21:24:29	2026-03-02 21:24:29
787	58	236	fee	-36.00	USDT	417.00	Fee for buy option trade on BTCUSDT	2026-03-02 21:24:29	2026-03-02 21:24:29
788	58	236	trade_win	2016.00	USDT	2433.00	Won buy trade on BTCUSDT	2026-03-02 21:24:59	2026-03-02 21:24:59
789	58	237	trade_amount	-1800.00	USDT	633.00	Amount for buy option trade on BTCUSDT	2026-03-02 21:26:02	2026-03-02 21:26:02
790	58	237	fee	-36.00	USDT	597.00	Fee for buy option trade on BTCUSDT	2026-03-02 21:26:02	2026-03-02 21:26:02
791	58	237	trade_win	2016.00	USDT	2613.00	Won buy trade on BTCUSDT	2026-03-02 21:26:32	2026-03-02 21:26:32
792	58	238	trade_amount	-2000.00	USDT	613.00	Amount for buy option trade on BTCUSDT	2026-03-02 21:30:56	2026-03-02 21:30:56
793	58	238	fee	-40.00	USDT	573.00	Fee for buy option trade on BTCUSDT	2026-03-02 21:30:56	2026-03-02 21:30:56
794	58	238	trade_win	2240.00	USDT	2813.00	Won buy trade on BTCUSDT	2026-03-02 21:31:27	2026-03-02 21:31:27
795	58	239	trade_amount	-2000.00	USDT	813.00	Amount for buy option trade on BTCUSDT	2026-03-02 21:32:44	2026-03-02 21:32:44
796	58	239	fee	-40.00	USDT	773.00	Fee for buy option trade on BTCUSDT	2026-03-02 21:32:44	2026-03-02 21:32:44
797	58	239	trade_win	2240.00	USDT	3013.00	Won buy trade on BTCUSDT	2026-03-02 21:33:14	2026-03-02 21:33:14
798	58	240	trade_amount	-100.00	USDT	2913.00	Amount for buy option trade on BTCUSDT	2026-03-02 21:33:50	2026-03-02 21:33:50
799	58	240	fee	-2.00	USDT	2911.00	Fee for buy option trade on BTCUSDT	2026-03-02 21:33:50	2026-03-02 21:33:50
800	58	240	trade_win	112.00	USDT	3023.00	Won buy trade on BTCUSDT	2026-03-02 21:34:21	2026-03-02 21:34:21
801	58	241	trade_amount	-2400.00	USDT	623.00	Amount for buy option trade on BTCUSDT	2026-03-02 21:35:06	2026-03-02 21:35:06
802	58	241	fee	-48.00	USDT	575.00	Fee for buy option trade on BTCUSDT	2026-03-02 21:35:06	2026-03-02 21:35:06
803	58	241	trade_win	2688.00	USDT	3263.00	Won buy trade on BTCUSDT	2026-03-02 21:35:37	2026-03-02 21:35:37
804	58	242	trade_amount	-2000.00	USDT	1263.00	Amount for buy option trade on BTCUSDT	2026-03-02 21:44:11	2026-03-02 21:44:11
805	58	242	fee	-40.00	USDT	1223.00	Fee for buy option trade on BTCUSDT	2026-03-02 21:44:11	2026-03-02 21:44:11
806	58	242	trade_win	2240.00	USDT	3463.00	Won buy trade on BTCUSDT	2026-03-02 21:44:41	2026-03-02 21:44:41
807	23	243	trade_amount	-500.00	USDT	184442.16	Amount for buy option trade on BTCUSDT	2026-03-03 00:15:26	2026-03-03 00:15:26
808	23	243	fee	-10.00	USDT	184432.16	Fee for buy option trade on BTCUSDT	2026-03-03 00:15:26	2026-03-03 00:15:26
809	12	244	trade_amount	-65000.00	USDT	1355268.76	Amount for buy option trade on BTCUSDT	2026-03-03 04:27:07	2026-03-03 04:27:07
810	12	244	fee	-1300.00	USDT	1353968.76	Fee for buy option trade on BTCUSDT	2026-03-03 04:27:07	2026-03-03 04:27:07
811	12	244	trade_win	76700.00	USDT	1430668.76	Won buy trade on BTCUSDT	2026-03-03 04:28:37	2026-03-03 04:28:37
812	48	245	trade_amount	-100.00	USDT	257300.00	Amount for buy contract trade on XAUUSD with 10x leverage	2026-03-03 23:24:00	2026-03-03 23:24:00
813	48	245	fee	-2.00	USDT	257298.00	Fee for buy contract trade on XAUUSD	2026-03-03 23:24:00	2026-03-03 23:24:00
814	48	245	trade_win	100.00	USDT	257398.00	Won buy trade on XAUUSD	2026-03-03 23:24:00	2026-03-03 23:24:00
815	65	246	trade_amount	-102.00	USDT	98.00	Amount for buy option trade on XAUUSD	2026-03-03 23:38:18	2026-03-03 23:38:18
816	65	246	fee	-2.04	USDT	95.96	Fee for buy option trade on XAUUSD	2026-03-03 23:38:18	2026-03-03 23:38:18
817	65	246	trade_win	114.24	USDT	210.20	Won buy trade on XAUUSD	2026-03-03 23:38:48	2026-03-03 23:38:48
818	65	247	trade_amount	-150.00	USDT	60.20	Amount for buy option trade on XAUUSD	2026-03-03 23:41:50	2026-03-03 23:41:50
819	65	247	fee	-3.00	USDT	57.20	Fee for buy option trade on XAUUSD	2026-03-03 23:41:50	2026-03-03 23:41:50
820	65	247	trade_win	168.00	USDT	225.20	Won buy trade on XAUUSD	2026-03-03 23:42:20	2026-03-03 23:42:20
821	65	\N	withdrawal	-20.00	USDT	204.20	Withdrawal of 20 USDT via TRC20 to 0×3A802E09523A595Ac9696E7B9d3f C09c7DE40c03	2026-03-04 01:07:46	2026-03-04 01:07:46
822	65	\N	fee	-1.00	USDT	204.20	Fee for withdrawal of 20 USDT via TRC20	2026-03-04 01:07:46	2026-03-04 01:07:46
823	65	248	trade_amount	-120.00	USDT	84.20	Amount for buy option trade on XAUUSD	2026-03-04 05:17:54	2026-03-04 05:17:54
824	65	248	fee	-2.40	USDT	81.80	Fee for buy option trade on XAUUSD	2026-03-04 05:17:54	2026-03-04 05:17:54
825	25	249	trade_amount	-30000.00	USDT	600339.20	Amount for buy option trade on XAUUSD	2026-03-04 12:01:44	2026-03-04 12:01:44
826	25	249	fee	-600.00	USDT	599739.20	Fee for buy option trade on XAUUSD	2026-03-04 12:01:44	2026-03-04 12:01:44
827	25	249	trade_win	34500.00	USDT	634239.20	Won buy trade on XAUUSD	2026-03-04 12:02:44	2026-03-04 12:02:44
828	58	\N	withdrawal	-10.00	USDT	4427.00	Withdrawal of 10 USDT via TRC20 to 0x5604dd0Dd8Ea41D8e2c772c7c3d9d4b9A0bb26c7	2026-03-04 17:05:23	2026-03-04 17:05:23
829	58	\N	fee	-1.00	USDT	4427.00	Fee for withdrawal of 10 USDT via TRC20	2026-03-04 17:05:23	2026-03-04 17:05:23
830	62	\N	withdrawal	-10.00	USDT	253.00	Withdrawal of 10 USDT via TRC20 to 0xC8d5C0dF295e3E9212B5f3dBa2514742E77059e0	2026-03-04 17:07:00	2026-03-04 17:07:00
831	62	\N	fee	-1.00	USDT	253.00	Fee for withdrawal of 10 USDT via TRC20	2026-03-04 17:07:00	2026-03-04 17:07:00
832	50	250	trade_amount	-3000.00	USDT	624.00	Amount for buy option trade on BTCUSDT	2026-03-04 19:12:57	2026-03-04 19:12:57
833	50	250	fee	-60.00	USDT	564.00	Fee for buy option trade on BTCUSDT	2026-03-04 19:12:57	2026-03-04 19:12:57
834	50	250	trade_win	3360.00	USDT	3924.00	Won buy trade on BTCUSDT	2026-03-04 19:13:28	2026-03-04 19:13:28
835	50	251	trade_amount	-500.00	USDT	3424.00	Amount for buy option trade on BTCUSDT	2026-03-04 19:15:39	2026-03-04 19:15:39
836	50	251	fee	-10.00	USDT	3414.00	Fee for buy option trade on BTCUSDT	2026-03-04 19:15:39	2026-03-04 19:15:39
837	50	251	trade_win	560.00	USDT	3974.00	Won buy trade on BTCUSDT	2026-03-04 19:16:10	2026-03-04 19:16:10
838	57	252	trade_amount	-3800.00	USDT	710.00	Amount for buy option trade on ETHUSDT	2026-03-04 20:43:14	2026-03-04 20:43:14
839	57	252	fee	-76.00	USDT	634.00	Fee for buy option trade on ETHUSDT	2026-03-04 20:43:14	2026-03-04 20:43:14
840	57	252	trade_win	4256.00	USDT	4890.00	Won buy trade on ETHUSDT	2026-03-04 20:43:45	2026-03-04 20:43:45
841	58	253	trade_amount	-4000.00	USDT	427.00	Amount for buy option trade on BTCUSDT	2026-03-05 20:14:46	2026-03-05 20:14:46
842	58	253	fee	-80.00	USDT	347.00	Fee for buy option trade on BTCUSDT	2026-03-05 20:14:46	2026-03-05 20:14:46
843	58	253	trade_win	4480.00	USDT	4827.00	Won buy trade on BTCUSDT	2026-03-05 20:15:16	2026-03-05 20:15:16
844	58	254	trade_amount	-4400.00	USDT	427.00	Amount for buy option trade on BTCUSDT	2026-03-05 20:17:23	2026-03-05 20:17:23
845	58	254	fee	-88.00	USDT	339.00	Fee for buy option trade on BTCUSDT	2026-03-05 20:17:23	2026-03-05 20:17:23
846	58	254	trade_win	4928.00	USDT	5267.00	Won buy trade on BTCUSDT	2026-03-05 20:17:53	2026-03-05 20:17:53
847	58	255	trade_amount	-4600.00	USDT	667.00	Amount for buy option trade on BTCUSDT	2026-03-05 20:23:37	2026-03-05 20:23:37
848	58	255	fee	-92.00	USDT	575.00	Fee for buy option trade on BTCUSDT	2026-03-05 20:23:37	2026-03-05 20:23:37
849	58	255	trade_win	5152.00	USDT	5727.00	Won buy trade on BTCUSDT	2026-03-05 20:24:08	2026-03-05 20:24:08
850	28	256	trade_amount	-280.00	USDT	70.00	Amount for buy option trade on XAUUSD	2026-03-06 00:53:14	2026-03-06 00:53:14
851	28	256	fee	-5.60	USDT	64.40	Fee for buy option trade on XAUUSD	2026-03-06 00:53:14	2026-03-06 00:53:14
852	28	256	trade_win	313.60	USDT	378.00	Won buy trade on XAUUSD	2026-03-06 00:53:45	2026-03-06 00:53:45
853	64	257	trade_amount	-900.00	USDT	125.00	Amount for buy option trade on XAUUSD	2026-03-06 01:11:38	2026-03-06 01:11:38
854	64	257	fee	-18.00	USDT	107.00	Fee for buy option trade on XAUUSD	2026-03-06 01:11:38	2026-03-06 01:11:38
855	64	257	trade_win	1008.00	USDT	1115.00	Won buy trade on XAUUSD	2026-03-06 01:12:08	2026-03-06 01:12:08
856	10	258	trade_amount	-30001.00	USDT	978232.71	Amount for buy option trade on BTCUSDT	2026-03-06 01:33:47	2026-03-06 01:33:47
857	10	258	fee	-600.02	USDT	977632.69	Fee for buy option trade on BTCUSDT	2026-03-06 01:33:47	2026-03-06 01:33:47
858	10	259	trade_amount	-12000.00	USDT	965632.69	Amount for buy option trade on BTCUSDT	2026-03-06 01:35:16	2026-03-06 01:35:16
859	10	259	fee	-240.00	USDT	965392.69	Fee for buy option trade on BTCUSDT	2026-03-06 01:35:16	2026-03-06 01:35:16
860	10	258	trade_win	35401.18	USDT	1000793.87	Won buy trade on BTCUSDT	2026-03-06 01:35:18	2026-03-06 01:35:18
861	10	260	trade_amount	-70001.00	USDT	930792.87	Amount for buy option trade on BTCUSDT	2026-03-06 01:35:55	2026-03-06 01:35:55
862	10	260	fee	-1400.02	USDT	929392.85	Fee for buy option trade on BTCUSDT	2026-03-06 01:35:55	2026-03-06 01:35:55
863	10	259	trade_win	13800.00	USDT	943192.85	Won buy trade on BTCUSDT	2026-03-06 01:36:17	2026-03-06 01:36:17
864	10	260	trade_win	85401.22	USDT	1028594.07	Won buy trade on BTCUSDT	2026-03-06 01:38:56	2026-03-06 01:38:56
865	62	261	trade_amount	-1000.00	USDT	181.00	Amount for buy option trade on BTCUSDT	2026-03-06 21:38:48	2026-03-06 21:38:48
866	62	261	fee	-20.00	USDT	161.00	Fee for buy option trade on BTCUSDT	2026-03-06 21:38:48	2026-03-06 21:38:48
867	62	261	trade_win	1120.00	USDT	1281.00	Won buy trade on BTCUSDT	2026-03-06 21:39:19	2026-03-06 21:39:19
868	28	262	trade_amount	-100.00	USDT	278.00	Amount for buy option trade on XAUUSD	2026-03-06 22:21:24	2026-03-06 22:21:24
869	28	262	fee	-2.00	USDT	276.00	Fee for buy option trade on XAUUSD	2026-03-06 22:21:24	2026-03-06 22:21:24
870	48	263	trade_amount	-70000.00	USDT	187398.00	Amount for buy option trade on XAUUSD	2026-03-06 22:50:27	2026-03-06 22:50:27
871	48	263	fee	-1400.00	USDT	185998.00	Fee for buy option trade on XAUUSD	2026-03-06 22:50:27	2026-03-06 22:50:27
872	48	263	trade_win	82600.00	USDT	268598.00	Won buy trade on XAUUSD	2026-03-06 22:51:57	2026-03-06 22:51:57
873	38	264	trade_amount	-30000.00	USDT	41862.00	Amount for sell option trade on BTCUSDT	2026-03-06 23:32:52	2026-03-06 23:32:52
874	38	264	fee	-600.00	USDT	41262.00	Fee for sell option trade on BTCUSDT	2026-03-06 23:32:52	2026-03-06 23:32:52
875	38	264	trade_win	34500.00	USDT	75762.00	Won sell trade on BTCUSDT	2026-03-06 23:33:53	2026-03-06 23:33:53
876	66	265	trade_amount	-150.00	USDT	30.00	Amount for buy option trade on BTCUSDT	2026-03-07 03:01:06	2026-03-07 03:01:06
877	66	265	fee	-3.00	USDT	27.00	Fee for buy option trade on BTCUSDT	2026-03-07 03:01:06	2026-03-07 03:01:06
878	66	265	trade_win	168.00	USDT	195.00	Won buy trade on BTCUSDT	2026-03-07 03:01:36	2026-03-07 03:01:36
879	10	266	trade_amount	-50000.00	USDT	978594.07	Amount for buy option trade on XAUUSD	2026-03-07 03:43:16	2026-03-07 03:43:16
880	10	266	fee	-1000.00	USDT	977594.07	Fee for buy option trade on XAUUSD	2026-03-07 03:43:16	2026-03-07 03:43:16
881	10	266	trade_win	59000.00	USDT	1036594.07	Won buy trade on XAUUSD	2026-03-07 03:44:47	2026-03-07 03:44:47
882	23	267	trade_amount	-500.00	USDT	183932.16	Amount for sell option trade on BTCUSDT	2026-03-08 02:49:18	2026-03-08 02:49:18
883	23	267	fee	-10.00	USDT	183922.16	Fee for sell option trade on BTCUSDT	2026-03-08 02:49:18	2026-03-08 02:49:18
884	60	268	trade_amount	-5500.00	USDT	120.00	Amount for sell option trade on BTCUSDT	2026-03-08 23:07:12	2026-03-08 23:07:12
885	60	268	fee	-110.00	USDT	10.00	Fee for sell option trade on BTCUSDT	2026-03-08 23:07:12	2026-03-08 23:07:12
886	60	268	trade_win	6160.00	USDT	6170.00	Won sell trade on BTCUSDT	2026-03-08 23:07:43	2026-03-08 23:07:43
887	31	269	trade_amount	-51362.00	USDT	68985.44	Amount for buy option trade on BTCUSDT	2026-03-09 18:13:06	2026-03-09 18:13:06
888	31	269	fee	-1027.24	USDT	67958.20	Fee for buy option trade on BTCUSDT	2026-03-09 18:13:06	2026-03-09 18:13:06
889	31	269	trade_win	60607.16	USDT	128565.36	Won buy trade on BTCUSDT	2026-03-09 18:14:37	2026-03-09 18:14:37
890	31	270	trade_amount	-51684.00	USDT	76881.36	Amount for buy option trade on BTCUSDT	2026-03-09 18:15:32	2026-03-09 18:15:32
891	31	270	fee	-1033.68	USDT	75847.68	Fee for buy option trade on BTCUSDT	2026-03-09 18:15:32	2026-03-09 18:15:32
892	31	270	trade_win	60987.12	USDT	136834.80	Won buy trade on BTCUSDT	2026-03-09 18:17:02	2026-03-09 18:17:02
893	12	\N	mining_purchase	-100000.00	USDT	1330668.76	\N	2026-03-10 01:24:51	2026-03-10 01:24:51
894	10	\N	mining_purchase	-400000.00	USDT	636594.07	\N	2026-03-10 01:53:02	2026-03-10 01:53:02
895	10	\N	mining_purchase	-50000.00	USDT	586594.07	\N	2026-03-10 02:28:28	2026-03-10 02:28:28
896	10	\N	mining_purchase	-50000.00	USDT	536594.07	\N	2026-03-10 02:29:09	2026-03-10 02:29:09
897	10	\N	mining_refund	45000.00	USDT	581594.07	\N	2026-03-10 02:29:23	2026-03-10 02:29:23
898	10	271	trade_amount	-1000.00	USDT	580594.07	Amount for sell option trade on XAUUSD	2026-03-10 02:31:00	2026-03-10 02:31:00
899	10	271	fee	-20.00	USDT	580574.07	Fee for sell option trade on XAUUSD	2026-03-10 02:31:00	2026-03-10 02:31:00
900	10	271	trade_win	1120.00	USDT	581694.07	Won sell trade on XAUUSD	2026-03-10 02:31:30	2026-03-10 02:31:30
901	10	\N	mining_purchase	-400000.00	USDT	181694.07	\N	2026-03-10 02:43:37	2026-03-10 02:43:37
902	66	272	trade_amount	-170.00	USDT	25.00	Amount for buy option trade on XAUUSD	2026-03-10 03:35:24	2026-03-10 03:35:24
903	66	272	fee	-3.40	USDT	21.60	Fee for buy option trade on XAUUSD	2026-03-10 03:35:24	2026-03-10 03:35:24
904	66	272	trade_win	190.40	USDT	212.00	Won buy trade on XAUUSD	2026-03-10 03:35:55	2026-03-10 03:35:55
905	66	273	trade_amount	-200.00	USDT	12.00	Amount for buy option trade on XAUUSD	2026-03-10 03:51:16	2026-03-10 03:51:16
906	66	273	fee	-4.00	USDT	8.00	Fee for buy option trade on XAUUSD	2026-03-10 03:51:16	2026-03-10 03:51:16
907	50	274	trade_amount	-3700.00	USDT	274.00	Amount for buy option trade on BTCUSDT	2026-03-10 18:40:58	2026-03-10 18:40:58
908	50	274	fee	-74.00	USDT	200.00	Fee for buy option trade on BTCUSDT	2026-03-10 18:40:58	2026-03-10 18:40:58
909	50	274	trade_win	4144.00	USDT	4344.00	Won buy trade on BTCUSDT	2026-03-10 18:41:29	2026-03-10 18:41:29
910	57	275	trade_amount	-4000.00	USDT	890.00	Amount for buy option trade on ETHUSDT	2026-03-10 21:50:43	2026-03-10 21:50:43
911	57	275	fee	-80.00	USDT	810.00	Fee for buy option trade on ETHUSDT	2026-03-10 21:50:43	2026-03-10 21:50:43
912	57	275	trade_win	4480.00	USDT	5290.00	Won buy trade on ETHUSDT	2026-03-10 21:51:14	2026-03-10 21:51:14
913	57	276	trade_amount	-800.00	USDT	4490.00	Amount for buy option trade on ETHUSDT	2026-03-10 21:53:23	2026-03-10 21:53:23
914	57	276	fee	-16.00	USDT	4474.00	Fee for buy option trade on ETHUSDT	2026-03-10 21:53:23	2026-03-10 21:53:23
915	57	276	trade_win	896.00	USDT	5370.00	Won buy trade on ETHUSDT	2026-03-10 21:53:54	2026-03-10 21:53:54
916	9	\N	mining_purchase	-400000.00	USDT	289097.20	\N	2026-03-11 01:35:44	2026-03-11 01:35:44
917	12	\N	mining_purchase	-400000.00	USDT	930668.76	\N	2026-03-11 01:43:30	2026-03-11 01:43:30
918	10	277	trade_amount	-30000.00	USDT	151694.07	Amount for sell option trade on BTCUSDT	2026-03-11 22:46:36	2026-03-11 22:46:36
919	10	277	fee	-600.00	USDT	151094.07	Fee for sell option trade on BTCUSDT	2026-03-11 22:46:36	2026-03-11 22:46:36
920	10	277	trade_win	34500.00	USDT	185594.07	Won sell trade on BTCUSDT	2026-03-11 22:47:37	2026-03-11 22:47:37
921	66	278	trade_amount	-700.00	USDT	82.00	Amount for buy option trade on XAUUSD	2026-03-13 02:39:52	2026-03-13 02:39:52
922	66	278	fee	-14.00	USDT	68.00	Fee for buy option trade on XAUUSD	2026-03-13 02:39:52	2026-03-13 02:39:52
923	66	278	trade_win	784.00	USDT	852.00	Won buy trade on XAUUSD	2026-03-13 02:40:23	2026-03-13 02:40:23
924	60	279	trade_amount	-6000.00	USDT	600.00	Amount for buy option trade on BTCUSDT	2026-03-13 03:48:07	2026-03-13 03:48:07
925	60	279	fee	-120.00	USDT	480.00	Fee for buy option trade on BTCUSDT	2026-03-13 03:48:07	2026-03-13 03:48:07
926	60	279	trade_win	6720.00	USDT	7200.00	Won buy trade on BTCUSDT	2026-03-13 03:48:38	2026-03-13 03:48:38
927	53	280	trade_amount	-2000.00	USDT	128.00	Amount for buy option trade on BTCUSDT	2026-03-13 22:18:56	2026-03-13 22:18:56
928	53	280	fee	-40.00	USDT	88.00	Fee for buy option trade on BTCUSDT	2026-03-13 22:18:56	2026-03-13 22:18:56
929	53	280	trade_win	2240.00	USDT	2328.00	Won buy trade on BTCUSDT	2026-03-13 22:19:26	2026-03-13 22:19:26
930	60	281	trade_amount	-100.00	USDT	7100.00	Amount for buy option trade on BTCUSDT	2026-03-14 18:02:46	2026-03-14 18:02:46
931	60	281	fee	-2.00	USDT	7098.00	Fee for buy option trade on BTCUSDT	2026-03-14 18:02:46	2026-03-14 18:02:46
932	31	282	trade_amount	-42580.00	USDT	94254.80	Amount for buy option trade on BTCUSDT	2026-03-15 02:49:09	2026-03-15 02:49:09
933	31	282	fee	-851.60	USDT	93403.20	Fee for buy option trade on BTCUSDT	2026-03-15 02:49:09	2026-03-15 02:49:09
934	31	282	trade_win	50244.40	USDT	143647.60	Won buy trade on BTCUSDT	2026-03-15 02:50:39	2026-03-15 02:50:39
935	31	283	trade_amount	-57896.00	USDT	85751.60	Amount for buy option trade on BTCUSDT	2026-03-15 02:51:42	2026-03-15 02:51:42
936	31	283	fee	-1157.92	USDT	84593.68	Fee for buy option trade on BTCUSDT	2026-03-15 02:51:42	2026-03-15 02:51:42
937	31	283	trade_win	68317.28	USDT	152910.96	Won buy trade on BTCUSDT	2026-03-15 02:53:12	2026-03-15 02:53:12
938	50	284	trade_amount	-4000.00	USDT	344.00	Amount for buy option trade on BTCUSDT	2026-03-15 21:00:01	2026-03-15 21:00:01
939	50	284	fee	-80.00	USDT	264.00	Fee for buy option trade on BTCUSDT	2026-03-15 21:00:01	2026-03-15 21:00:01
940	50	284	trade_win	4480.00	USDT	4744.00	Won buy trade on BTCUSDT	2026-03-15 21:00:32	2026-03-15 21:00:32
941	50	285	trade_amount	-300.00	USDT	4444.00	Amount for buy option trade on BTCUSDT	2026-03-15 21:02:21	2026-03-15 21:02:21
942	50	285	fee	-6.00	USDT	4438.00	Fee for buy option trade on BTCUSDT	2026-03-15 21:02:21	2026-03-15 21:02:21
943	50	285	trade_win	336.00	USDT	4774.00	Won buy trade on BTCUSDT	2026-03-15 21:02:51	2026-03-15 21:02:51
944	57	286	trade_amount	-5000.00	USDT	370.00	Amount for buy option trade on ETHUSDT	2026-03-15 21:13:26	2026-03-15 21:13:26
945	57	286	fee	-100.00	USDT	270.00	Fee for buy option trade on ETHUSDT	2026-03-15 21:13:26	2026-03-15 21:13:26
946	57	286	trade_win	5600.00	USDT	5870.00	Won buy trade on ETHUSDT	2026-03-15 21:13:57	2026-03-15 21:13:57
947	41	287	trade_amount	-40000.00	USDT	474500.00	Amount for buy option trade on BTCUSDT	2026-03-15 21:59:22	2026-03-15 21:59:22
948	41	287	fee	-800.00	USDT	473700.00	Fee for buy option trade on BTCUSDT	2026-03-15 21:59:22	2026-03-15 21:59:22
949	41	287	trade_win	47200.00	USDT	520900.00	Won buy trade on BTCUSDT	2026-03-15 22:00:53	2026-03-15 22:00:53
950	51	288	trade_amount	-1600.00	USDT	81.00	Amount for buy option trade on BTCUSDT	2026-03-17 03:10:01	2026-03-17 03:10:01
951	51	288	fee	-32.00	USDT	49.00	Fee for buy option trade on BTCUSDT	2026-03-17 03:10:01	2026-03-17 03:10:01
952	51	288	trade_win	1792.00	USDT	1841.00	Won buy trade on BTCUSDT	2026-03-17 03:10:32	2026-03-17 03:10:32
953	66	289	trade_amount	-700.00	USDT	152.00	Amount for buy option trade on XAUUSD	2026-03-17 03:17:41	2026-03-17 03:17:41
954	66	289	fee	-14.00	USDT	138.00	Fee for buy option trade on XAUUSD	2026-03-17 03:17:41	2026-03-17 03:17:41
955	66	289	trade_win	784.00	USDT	922.00	Won buy trade on XAUUSD	2026-03-17 03:18:12	2026-03-17 03:18:12
956	51	290	trade_amount	-1600.00	USDT	241.00	Amount for buy option trade on BTCUSDT	2026-03-17 03:22:12	2026-03-17 03:22:12
957	51	290	fee	-32.00	USDT	209.00	Fee for buy option trade on BTCUSDT	2026-03-17 03:22:12	2026-03-17 03:22:12
958	51	290	trade_win	1792.00	USDT	2001.00	Won buy trade on BTCUSDT	2026-03-17 03:22:42	2026-03-17 03:22:42
959	51	291	trade_amount	-1600.00	USDT	401.00	Amount for buy option trade on BTCUSDT	2026-03-17 03:30:23	2026-03-17 03:30:23
960	51	291	fee	-32.00	USDT	369.00	Fee for buy option trade on BTCUSDT	2026-03-17 03:30:23	2026-03-17 03:30:23
961	51	291	trade_win	1792.00	USDT	2161.00	Won buy trade on BTCUSDT	2026-03-17 03:30:54	2026-03-17 03:30:54
962	25	292	trade_amount	-20000.00	USDT	614239.20	Amount for buy option trade on BTCUSDT	2026-03-17 03:34:51	2026-03-17 03:34:51
963	25	292	fee	-400.00	USDT	613839.20	Fee for buy option trade on BTCUSDT	2026-03-17 03:34:51	2026-03-17 03:34:51
964	25	292	trade_win	23000.00	USDT	636839.20	Won buy trade on BTCUSDT	2026-03-17 03:35:51	2026-03-17 03:35:51
965	51	293	trade_amount	-1700.00	USDT	461.00	Amount for buy option trade on BTCUSDT	2026-03-17 03:36:11	2026-03-17 03:36:11
966	51	293	fee	-34.00	USDT	427.00	Fee for buy option trade on BTCUSDT	2026-03-17 03:36:11	2026-03-17 03:36:11
967	51	293	trade_win	1904.00	USDT	2331.00	Won buy trade on BTCUSDT	2026-03-17 03:36:41	2026-03-17 03:36:41
968	47	294	trade_amount	-37000.00	USDT	1542.00	Amount for buy option trade on BTCUSDT	2026-03-17 16:17:43	2026-03-17 16:17:43
969	47	294	fee	-740.00	USDT	802.00	Fee for buy option trade on BTCUSDT	2026-03-17 16:17:43	2026-03-17 16:17:43
970	47	294	trade_win	43660.00	USDT	44462.00	Won buy trade on BTCUSDT	2026-03-17 16:19:14	2026-03-17 16:19:14
971	10	295	trade_amount	-70000.00	USDT	115594.07	Amount for buy option trade on BTCUSDT	2026-03-17 16:20:20	2026-03-17 16:20:20
972	10	295	fee	-1400.00	USDT	114194.07	Fee for buy option trade on BTCUSDT	2026-03-17 16:20:20	2026-03-17 16:20:20
973	10	296	trade_amount	-70000.00	USDT	44194.07	Amount for buy option trade on BTCUSDT	2026-03-17 16:20:48	2026-03-17 16:20:48
974	10	296	fee	-1400.00	USDT	42794.07	Fee for buy option trade on BTCUSDT	2026-03-17 16:20:48	2026-03-17 16:20:48
975	10	295	trade_win	82600.00	USDT	125394.07	Won buy trade on BTCUSDT	2026-03-17 16:21:51	2026-03-17 16:21:51
976	10	296	trade_win	82600.00	USDT	207994.07	Won buy trade on BTCUSDT	2026-03-17 16:22:19	2026-03-17 16:22:19
977	41	297	trade_amount	-60000.00	USDT	460900.00	Amount for sell option trade on XAUUSD	2026-03-19 20:28:58	2026-03-19 20:28:58
978	41	297	fee	-1200.00	USDT	459700.00	Fee for sell option trade on XAUUSD	2026-03-19 20:28:58	2026-03-19 20:28:58
979	41	297	trade_win	70800.00	USDT	530500.00	Won sell trade on XAUUSD	2026-03-19 20:30:28	2026-03-19 20:30:28
980	38	298	trade_amount	-55000.00	USDT	30262.00	Amount for buy option trade on XAUUSD	2026-03-20 00:35:36	2026-03-20 00:35:36
981	38	298	fee	-1100.00	USDT	29162.00	Fee for buy option trade on XAUUSD	2026-03-20 00:35:36	2026-03-20 00:35:36
982	38	298	trade_win	64900.00	USDT	94062.00	Won buy trade on XAUUSD	2026-03-20 00:37:06	2026-03-20 00:37:06
983	12	299	trade_amount	-60000.00	USDT	870668.76	Amount for buy option trade on XAUUSD	2026-03-20 01:08:32	2026-03-20 01:08:32
984	12	299	fee	-1200.00	USDT	869468.76	Fee for buy option trade on XAUUSD	2026-03-20 01:08:32	2026-03-20 01:08:32
985	12	299	trade_win	70800.00	USDT	940268.76	Won buy trade on XAUUSD	2026-03-20 01:10:02	2026-03-20 01:10:02
986	60	300	trade_amount	-6000.00	USDT	1098.00	Amount for buy option trade on BTCUSDT	2026-03-20 03:09:30	2026-03-20 03:09:30
987	60	300	fee	-120.00	USDT	978.00	Fee for buy option trade on BTCUSDT	2026-03-20 03:09:30	2026-03-20 03:09:30
988	60	300	trade_win	6720.00	USDT	7698.00	Won buy trade on BTCUSDT	2026-03-20 03:10:01	2026-03-20 03:10:01
989	60	301	trade_amount	-6000.00	USDT	2136.00	Amount for buy option trade on BTCUSDT	2026-03-20 04:46:35	2026-03-20 04:46:35
990	60	301	fee	-120.00	USDT	2016.00	Fee for buy option trade on BTCUSDT	2026-03-20 04:46:35	2026-03-20 04:46:35
991	60	301	trade_win	6720.00	USDT	8736.00	Won buy trade on BTCUSDT	2026-03-20 04:47:06	2026-03-20 04:47:06
992	75	302	trade_amount	-1700.00	USDT	142.00	Amount for buy option trade on BTCUSDT	2026-03-20 05:35:38	2026-03-20 05:35:38
993	75	302	fee	-34.00	USDT	108.00	Fee for buy option trade on BTCUSDT	2026-03-20 05:35:38	2026-03-20 05:35:38
994	75	302	trade_win	1904.00	USDT	2012.00	Won buy trade on BTCUSDT	2026-03-20 05:36:09	2026-03-20 05:36:09
995	10	303	trade_amount	-70000.00	USDT	137994.07	Amount for buy option trade on XAUUSD	2026-03-20 23:24:47	2026-03-20 23:24:47
996	10	303	fee	-1400.00	USDT	136594.07	Fee for buy option trade on XAUUSD	2026-03-20 23:24:47	2026-03-20 23:24:47
997	10	303	trade_win	82600.00	USDT	219194.07	Won buy trade on XAUUSD	2026-03-20 23:26:17	2026-03-20 23:26:17
998	17	304	trade_amount	-100.00	USDT	16765.00	Amount for buy contract trade on BTCUSDT with 10x leverage	2026-03-21 16:48:00	2026-03-21 16:48:00
999	17	304	fee	-2.00	USDT	16763.00	Fee for buy contract trade on BTCUSDT	2026-03-21 16:48:00	2026-03-21 16:48:00
1000	75	305	trade_amount	-1900.00	USDT	112.00	Amount for buy option trade on BTCUSDT	2026-03-24 02:50:50	2026-03-24 02:50:50
1001	75	305	fee	-38.00	USDT	74.00	Fee for buy option trade on BTCUSDT	2026-03-24 02:50:50	2026-03-24 02:50:50
1002	75	305	trade_win	2128.00	USDT	2202.00	Won buy trade on BTCUSDT	2026-03-24 02:51:20	2026-03-24 02:51:20
1003	47	306	trade_amount	-48000.00	USDT	1868.00	Amount for sell option trade on BTCUSDT	2026-03-24 16:52:37	2026-03-24 16:52:37
1004	47	306	fee	-960.00	USDT	908.00	Fee for sell option trade on BTCUSDT	2026-03-24 16:52:37	2026-03-24 16:52:37
1005	47	306	trade_win	56640.00	USDT	57548.00	Won sell trade on BTCUSDT	2026-03-24 16:54:07	2026-03-24 16:54:07
1006	50	307	trade_amount	-4000.00	USDT	774.00	Amount for buy option trade on BTCUSDT	2026-03-24 19:34:36	2026-03-24 19:34:36
1007	50	307	fee	-80.00	USDT	694.00	Fee for buy option trade on BTCUSDT	2026-03-24 19:34:36	2026-03-24 19:34:36
1008	50	307	trade_win	4480.00	USDT	5174.00	Won buy trade on BTCUSDT	2026-03-24 19:35:07	2026-03-24 19:35:07
1009	78	308	trade_amount	-400.00	USDT	97.00	Amount for buy option trade on XAUUSD	2026-03-25 01:34:14	2026-03-25 01:34:14
1010	78	308	fee	-8.00	USDT	89.00	Fee for buy option trade on XAUUSD	2026-03-25 01:34:14	2026-03-25 01:34:14
1011	12	309	trade_amount	-400.00	USDT	939868.76	Amount for buy option trade on XAUUSD	2026-03-25 01:34:19	2026-03-25 01:34:19
1012	12	309	fee	-8.00	USDT	939860.76	Fee for buy option trade on XAUUSD	2026-03-25 01:34:19	2026-03-25 01:34:19
1013	78	308	trade_win	448.00	USDT	537.00	Won buy trade on XAUUSD	2026-03-25 01:34:44	2026-03-25 01:34:44
1014	12	309	trade_win	448.00	USDT	940308.76	Won buy trade on XAUUSD	2026-03-25 01:34:49	2026-03-25 01:34:49
1015	78	\N	withdrawal	-250.00	USDT	284.75	Withdrawal of 250 USDT via TRC20 to 0xBbB5650dd65aD21beF5A2b9855d521fcaEF223b4	2026-03-25 01:51:45	2026-03-25 01:51:45
1016	78	\N	fee	-2.25	USDT	284.75	Fee for withdrawal of 250 USDT via TRC20	2026-03-25 01:51:45	2026-03-25 01:51:45
1017	78	\N	withdrawal	-10.00	USDT	273.75	Withdrawal of 10 USDT via TRC20 to 0xBbB5650dd65aD21beF5A2b9855d521fcaEF223b4	2026-03-25 01:52:12	2026-03-25 01:52:12
1018	78	\N	fee	-1.00	USDT	273.75	Fee for withdrawal of 10 USDT via TRC20	2026-03-25 01:52:12	2026-03-25 01:52:12
1019	66	310	trade_amount	-2000.00	USDT	187.00	Amount for buy option trade on XAUUSD	2026-03-25 04:08:39	2026-03-25 04:08:39
1020	66	310	fee	-40.00	USDT	147.00	Fee for buy option trade on XAUUSD	2026-03-25 04:08:39	2026-03-25 04:08:39
1021	66	310	trade_win	2240.00	USDT	2387.00	Won buy trade on XAUUSD	2026-03-25 04:09:10	2026-03-25 04:09:10
1022	53	311	trade_amount	-300.00	USDT	51.00	Amount for sell option trade on BTCUSDT	2026-03-25 05:13:31	2026-03-25 05:13:31
1023	53	311	fee	-6.00	USDT	45.00	Fee for sell option trade on BTCUSDT	2026-03-25 05:13:31	2026-03-25 05:13:31
1024	53	311	trade_win	336.00	USDT	381.00	Won sell trade on BTCUSDT	2026-03-25 05:14:02	2026-03-25 05:14:02
1025	53	312	trade_amount	-300.00	USDT	81.00	Amount for sell option trade on BTCUSDT	2026-03-25 05:27:55	2026-03-25 05:27:55
1026	53	312	fee	-6.00	USDT	75.00	Fee for sell option trade on BTCUSDT	2026-03-25 05:27:55	2026-03-25 05:27:55
1027	53	312	trade_win	336.00	USDT	411.00	Won sell trade on BTCUSDT	2026-03-25 05:28:26	2026-03-25 05:28:26
1028	10	313	trade_amount	-50000.00	USDT	169194.07	Amount for buy option trade on XAUUSD	2026-03-25 18:37:21	2026-03-25 18:37:21
1029	10	313	fee	-1000.00	USDT	168194.07	Fee for buy option trade on XAUUSD	2026-03-25 18:37:21	2026-03-25 18:37:21
1030	10	313	trade_win	59000.00	USDT	227194.07	Won buy trade on XAUUSD	2026-03-25 18:38:52	2026-03-25 18:38:52
1031	10	314	trade_amount	-110000.00	USDT	117194.07	Amount for buy option trade on XAUUSD	2026-03-25 18:39:50	2026-03-25 18:39:50
1032	10	314	fee	-2200.00	USDT	114994.07	Fee for buy option trade on XAUUSD	2026-03-25 18:39:50	2026-03-25 18:39:50
1033	10	314	trade_win	134200.00	USDT	249194.07	Won buy trade on XAUUSD	2026-03-25 18:42:50	2026-03-25 18:42:50
1034	12	\N	mining_purchase	-200000.00	USDT	740308.76	\N	2026-03-25 22:08:30	2026-03-25 22:08:30
1035	12	\N	mining_profit	106400.00	USDT	1246708.76	\N	2026-03-25 22:11:05	2026-03-25 22:11:05
1036	12	\N	mining_refund	234000.00	USDT	1480708.76	\N	2026-03-25 22:11:05	2026-03-25 22:11:05
1037	12	\N	mining_profit	28200.00	USDT	1608908.76	\N	2026-03-25 22:11:14	2026-03-25 22:11:14
1038	12	\N	mining_refund	45000.00	USDT	1653908.76	\N	2026-03-25 22:11:14	2026-03-25 22:11:14
1039	10	315	trade_amount	-20000.00	USDT	229194.07	Amount for buy option trade on BTCUSDT	2026-03-26 02:16:34	2026-03-26 02:16:34
1040	10	315	fee	-400.00	USDT	228794.07	Fee for buy option trade on BTCUSDT	2026-03-26 02:16:34	2026-03-26 02:16:34
1041	10	315	trade_win	23000.00	USDT	251794.07	Won buy trade on BTCUSDT	2026-03-26 02:17:34	2026-03-26 02:17:34
1042	10	316	trade_amount	-20000.00	USDT	231794.07	Amount for buy option trade on BTCUSDT	2026-03-26 02:19:01	2026-03-26 02:19:01
1043	10	316	fee	-400.00	USDT	231394.07	Fee for buy option trade on BTCUSDT	2026-03-26 02:19:01	2026-03-26 02:19:01
1044	10	316	trade_win	23000.00	USDT	254394.07	Won buy trade on BTCUSDT	2026-03-26 02:20:03	2026-03-26 02:20:03
1045	50	317	trade_amount	-4800.00	USDT	374.00	Amount for buy option trade on BTCUSDT	2026-03-26 21:24:56	2026-03-26 21:24:56
1046	50	317	fee	-96.00	USDT	278.00	Fee for buy option trade on BTCUSDT	2026-03-26 21:24:56	2026-03-26 21:24:56
1047	50	317	trade_win	5376.00	USDT	5654.00	Won buy trade on BTCUSDT	2026-03-26 21:25:27	2026-03-26 21:25:27
1048	41	318	trade_amount	-100000.00	USDT	430500.00	Amount for buy option trade on XAUUSD	2026-03-27 01:41:34	2026-03-27 01:41:34
1049	41	318	fee	-2000.00	USDT	428500.00	Fee for buy option trade on XAUUSD	2026-03-27 01:41:34	2026-03-27 01:41:34
1050	41	318	trade_win	122000.00	USDT	550500.00	Won buy trade on XAUUSD	2026-03-27 01:44:34	2026-03-27 01:44:34
1051	66	319	trade_amount	-2000.00	USDT	387.00	Amount for buy option trade on XAUUSD	2026-03-27 03:00:14	2026-03-27 03:00:14
1052	66	319	fee	-40.00	USDT	347.00	Fee for buy option trade on XAUUSD	2026-03-27 03:00:14	2026-03-27 03:00:14
1053	66	319	trade_win	2240.00	USDT	2587.00	Won buy trade on XAUUSD	2026-03-27 03:00:45	2026-03-27 03:00:45
1054	75	320	trade_amount	-5000.00	USDT	200.00	Amount for sell option trade on BTCUSDT	2026-03-27 05:18:11	2026-03-27 05:18:11
1055	75	320	fee	-100.00	USDT	100.00	Fee for sell option trade on BTCUSDT	2026-03-27 05:18:11	2026-03-27 05:18:11
1056	75	320	trade_win	5600.00	USDT	5700.00	Won sell trade on BTCUSDT	2026-03-27 05:18:42	2026-03-27 05:18:42
1057	31	321	trade_amount	-38269.00	USDT	114641.96	Amount for buy option trade on BTCUSDT	2026-03-27 19:20:21	2026-03-27 19:20:21
1058	31	321	fee	-765.38	USDT	113876.58	Fee for buy option trade on BTCUSDT	2026-03-27 19:20:21	2026-03-27 19:20:21
1059	31	321	trade_win	45157.42	USDT	159034.00	Won buy trade on BTCUSDT	2026-03-27 19:21:52	2026-03-27 19:21:52
1060	10	322	trade_amount	-1000.00	USDT	253394.07	Amount for sell option trade on BTCUSDT	2026-03-28 01:20:34	2026-03-28 01:20:34
1061	10	322	fee	-20.00	USDT	253374.07	Fee for sell option trade on BTCUSDT	2026-03-28 01:20:34	2026-03-28 01:20:34
1062	78	323	trade_amount	-1000.00	USDT	223.00	Amount for sell option trade on BTCUSDT	2026-03-28 01:20:46	2026-03-28 01:20:46
1063	78	323	fee	-20.00	USDT	203.00	Fee for sell option trade on BTCUSDT	2026-03-28 01:20:46	2026-03-28 01:20:46
1064	10	322	trade_win	1120.00	USDT	254494.07	Won sell trade on BTCUSDT	2026-03-28 01:21:05	2026-03-28 01:21:05
1065	78	323	trade_win	1120.00	USDT	1323.00	Won sell trade on BTCUSDT	2026-03-28 01:21:17	2026-03-28 01:21:17
1066	75	324	trade_amount	-5500.00	USDT	200.00	Amount for buy option trade on BTCUSDT	2026-03-28 04:14:10	2026-03-28 04:14:10
1067	75	324	fee	-110.00	USDT	90.00	Fee for buy option trade on BTCUSDT	2026-03-28 04:14:10	2026-03-28 04:14:10
1068	75	324	trade_win	6160.00	USDT	6250.00	Won buy trade on BTCUSDT	2026-03-28 04:14:41	2026-03-28 04:14:41
1069	60	325	trade_amount	-8000.00	USDT	1168.00	Amount for buy option trade on BTCUSDT	2026-03-30 01:57:57	2026-03-30 01:57:57
1070	60	325	fee	-160.00	USDT	1008.00	Fee for buy option trade on BTCUSDT	2026-03-30 01:57:57	2026-03-30 01:57:57
1071	60	325	trade_win	8960.00	USDT	9968.00	Won buy trade on BTCUSDT	2026-03-30 01:58:28	2026-03-30 01:58:28
1072	12	326	trade_amount	-10000.00	USDT	1643908.76	Amount for buy option trade on XAUUSD	2026-03-30 02:52:58	2026-03-30 02:52:58
1073	12	326	fee	-200.00	USDT	1643708.76	Fee for buy option trade on XAUUSD	2026-03-30 02:52:58	2026-03-30 02:52:58
1074	12	326	trade_win	11200.00	USDT	1654908.76	Won buy trade on XAUUSD	2026-03-30 02:53:28	2026-03-30 02:53:28
1075	81	327	trade_amount	-900.00	USDT	102.00	Amount for buy option trade on XAUUSD	2026-03-30 02:53:54	2026-03-30 02:53:54
1076	81	327	fee	-18.00	USDT	84.00	Fee for buy option trade on XAUUSD	2026-03-30 02:53:54	2026-03-30 02:53:54
1077	81	327	trade_win	1008.00	USDT	1092.00	Won buy trade on XAUUSD	2026-03-30 02:54:24	2026-03-30 02:54:24
1078	80	328	trade_amount	-900.00	USDT	100.00	Amount for buy option trade on BTCUSDT	2026-03-30 20:36:04	2026-03-30 20:36:04
1079	80	328	fee	-18.00	USDT	82.00	Fee for buy option trade on BTCUSDT	2026-03-30 20:36:04	2026-03-30 20:36:04
1080	80	328	trade_win	1008.00	USDT	1090.00	Won buy trade on BTCUSDT	2026-03-30 20:36:34	2026-03-30 20:36:34
1081	66	329	trade_amount	-2300.00	USDT	287.00	Amount for buy option trade on XAUUSD	2026-03-31 04:34:43	2026-03-31 04:34:43
1082	66	329	fee	-46.00	USDT	241.00	Fee for buy option trade on XAUUSD	2026-03-31 04:34:43	2026-03-31 04:34:43
1083	66	329	trade_win	2576.00	USDT	2817.00	Won buy trade on XAUUSD	2026-03-31 04:35:14	2026-03-31 04:35:14
1084	78	330	trade_amount	-11000.00	USDT	3301.00	Amount for buy option trade on XAUUSD	2026-04-01 01:36:08	2026-04-01 01:36:08
1085	78	330	fee	-220.00	USDT	3081.00	Fee for buy option trade on XAUUSD	2026-04-01 01:36:08	2026-04-01 01:36:08
1086	78	330	trade_win	12650.00	USDT	15731.00	Won buy trade on XAUUSD	2026-04-01 01:37:09	2026-04-01 01:37:09
1087	31	331	trade_amount	-46396.00	USDT	112638.00	Amount for buy option trade on BTCUSDT	2026-04-01 17:30:08	2026-04-01 17:30:08
1088	31	331	fee	-927.92	USDT	111710.08	Fee for buy option trade on BTCUSDT	2026-04-01 17:30:08	2026-04-01 17:30:08
1089	31	331	trade_win	54747.28	USDT	166457.36	Won buy trade on BTCUSDT	2026-04-01 17:31:38	2026-04-01 17:31:38
1090	80	332	trade_amount	-1000.00	USDT	90.00	Amount for buy option trade on BTCUSDT	2026-04-02 19:40:55	2026-04-02 19:40:55
1091	80	332	fee	-20.00	USDT	70.00	Fee for buy option trade on BTCUSDT	2026-04-02 19:40:55	2026-04-02 19:40:55
1092	80	332	trade_win	1120.00	USDT	1190.00	Won buy trade on BTCUSDT	2026-04-02 19:41:25	2026-04-02 19:41:25
1093	80	333	trade_amount	-1000.00	USDT	190.00	Amount for buy option trade on BTCUSDT	2026-04-02 19:44:42	2026-04-02 19:44:42
1094	80	333	fee	-20.00	USDT	170.00	Fee for buy option trade on BTCUSDT	2026-04-02 19:44:42	2026-04-02 19:44:42
1095	80	333	trade_win	1120.00	USDT	1290.00	Won buy trade on BTCUSDT	2026-04-02 19:45:13	2026-04-02 19:45:13
1096	66	334	trade_amount	-2300.00	USDT	517.00	Amount for buy option trade on XAUUSD	2026-04-03 03:49:42	2026-04-03 03:49:42
1097	66	334	fee	-46.00	USDT	471.00	Fee for buy option trade on XAUUSD	2026-04-03 03:49:42	2026-04-03 03:49:42
1098	66	334	trade_win	2576.00	USDT	3047.00	Won buy trade on XAUUSD	2026-04-03 03:50:13	2026-04-03 03:50:13
1099	78	335	trade_amount	-8000.00	USDT	7731.00	Amount for sell option trade on BTCUSDT	2026-04-03 23:34:32	2026-04-03 23:34:32
1100	78	335	fee	-160.00	USDT	7571.00	Fee for sell option trade on BTCUSDT	2026-04-03 23:34:32	2026-04-03 23:34:32
1101	78	335	trade_win	8960.00	USDT	16531.00	Won sell trade on BTCUSDT	2026-04-03 23:35:03	2026-04-03 23:35:03
1102	53	336	trade_amount	-2800.00	USDT	97.00	Amount for sell option trade on BTCUSDT	2026-04-04 01:13:16	2026-04-04 01:13:16
1103	53	336	fee	-56.00	USDT	41.00	Fee for sell option trade on BTCUSDT	2026-04-04 01:13:16	2026-04-04 01:13:16
1104	53	336	trade_win	3136.00	USDT	3177.00	Won sell trade on BTCUSDT	2026-04-04 01:13:46	2026-04-04 01:13:46
1105	76	337	trade_amount	-300.00	USDT	81893.00	Amount for buy option trade on ETHUSDT	2026-04-06 20:13:59	2026-04-06 20:13:59
1106	76	337	fee	-6.00	USDT	81887.00	Fee for buy option trade on ETHUSDT	2026-04-06 20:13:59	2026-04-06 20:13:59
1107	76	338	trade_amount	-10001.00	USDT	71886.00	Amount for buy option trade on ETHUSDT	2026-04-06 20:16:35	2026-04-06 20:16:35
1108	76	338	fee	-200.02	USDT	71685.98	Fee for buy option trade on ETHUSDT	2026-04-06 20:16:35	2026-04-06 20:16:35
1109	66	339	trade_amount	-14900.00	USDT	421.00	Amount for buy option trade on BTCUSDT	2026-04-07 04:13:46	2026-04-07 04:13:46
1110	66	339	fee	-298.00	USDT	123.00	Fee for buy option trade on BTCUSDT	2026-04-07 04:13:46	2026-04-07 04:13:46
1111	66	339	trade_win	17135.00	USDT	17258.00	Won buy trade on BTCUSDT	2026-04-07 04:14:47	2026-04-07 04:14:47
1112	31	340	trade_amount	-56375.00	USDT	110082.36	Amount for buy option trade on BTCUSDT	2026-04-08 02:44:43	2026-04-08 02:44:43
1113	31	340	fee	-1127.50	USDT	108954.86	Fee for buy option trade on BTCUSDT	2026-04-08 02:44:43	2026-04-08 02:44:43
1114	31	340	trade_win	66522.50	USDT	175477.36	Won buy trade on BTCUSDT	2026-04-08 02:46:13	2026-04-08 02:46:13
1115	78	341	trade_amount	-30000.00	USDT	1528.00	Amount for buy option trade on BTCUSDT	2026-04-09 01:00:43	2026-04-09 01:00:43
1116	78	341	fee	-600.00	USDT	928.00	Fee for buy option trade on BTCUSDT	2026-04-09 01:00:43	2026-04-09 01:00:43
1117	78	341	trade_win	34500.00	USDT	35428.00	Won buy trade on BTCUSDT	2026-04-09 01:01:44	2026-04-09 01:01:44
1118	10	\N	mining_profit	28200.00	USDT	332694.07	\N	2026-04-09 02:28:29	2026-04-09 02:28:29
1119	78	342	trade_amount	-38000.00	USDT	2428.00	Amount for buy option trade on BTCUSDT	2026-04-12 02:00:57	2026-04-12 02:00:57
1120	78	342	fee	-760.00	USDT	1668.00	Fee for buy option trade on BTCUSDT	2026-04-12 02:00:57	2026-04-12 02:00:57
1121	78	343	trade_amount	-15000.00	USDT	1668.00	Amount for sell option trade on BTCUSDT	2026-04-15 01:44:21	2026-04-15 01:44:21
1122	78	343	fee	-300.00	USDT	1368.00	Fee for sell option trade on BTCUSDT	2026-04-15 01:44:21	2026-04-15 01:44:21
1123	78	343	trade_win	17250.00	USDT	18618.00	Won sell trade on BTCUSDT	2026-04-15 01:45:22	2026-04-15 01:45:22
1124	10	344	trade_amount	-30000.00	USDT	302694.07	Amount for buy option trade on BTCUSDT	2026-04-15 01:46:26	2026-04-15 01:46:26
1125	10	344	fee	-600.00	USDT	302094.07	Fee for buy option trade on BTCUSDT	2026-04-15 01:46:26	2026-04-15 01:46:26
1126	10	345	trade_amount	-14000.00	USDT	288094.07	Amount for sell option trade on BTCUSDT	2026-04-15 01:47:19	2026-04-15 01:47:19
1127	10	345	fee	-280.00	USDT	287814.07	Fee for sell option trade on BTCUSDT	2026-04-15 01:47:19	2026-04-15 01:47:19
1128	10	344	trade_win	34500.00	USDT	322314.07	Won buy trade on BTCUSDT	2026-04-15 01:47:26	2026-04-15 01:47:26
1129	78	346	trade_amount	-14000.00	USDT	4618.00	Amount for sell option trade on BTCUSDT	2026-04-15 01:48:20	2026-04-15 01:48:20
1130	78	346	fee	-280.00	USDT	4338.00	Fee for sell option trade on BTCUSDT	2026-04-15 01:48:20	2026-04-15 01:48:20
1131	10	345	trade_win	16100.00	USDT	338414.07	Won sell trade on BTCUSDT	2026-04-15 01:48:20	2026-04-15 01:48:20
1132	78	346	trade_win	16100.00	USDT	20438.00	Won sell trade on BTCUSDT	2026-04-15 01:49:21	2026-04-15 01:49:21
1133	82	347	trade_amount	-900.00	USDT	100.00	Amount for buy option trade on BTCUSDT	2026-04-16 01:14:19	2026-04-16 01:14:19
1134	82	347	fee	-18.00	USDT	82.00	Fee for buy option trade on BTCUSDT	2026-04-16 01:14:19	2026-04-16 01:14:19
1135	82	347	trade_win	1008.00	USDT	1090.00	Won buy trade on BTCUSDT	2026-04-16 01:14:50	2026-04-16 01:14:50
1136	25	348	trade_amount	-30000.00	USDT	606839.20	Amount for buy option trade on BTCUSDT	2026-04-16 04:04:56	2026-04-16 04:04:56
1137	25	348	fee	-600.00	USDT	606239.20	Fee for buy option trade on BTCUSDT	2026-04-16 04:04:56	2026-04-16 04:04:56
1138	25	348	trade_win	34500.00	USDT	640739.20	Won buy trade on BTCUSDT	2026-04-16 04:05:57	2026-04-16 04:05:57
1139	66	349	trade_amount	-16000.00	USDT	1258.00	Amount for buy option trade on XAUUSD	2026-04-16 04:22:10	2026-04-16 04:22:10
1140	66	349	fee	-320.00	USDT	938.00	Fee for buy option trade on XAUUSD	2026-04-16 04:22:10	2026-04-16 04:22:10
1141	66	349	trade_win	18400.00	USDT	19338.00	Won buy trade on XAUUSD	2026-04-16 04:23:10	2026-04-16 04:23:10
1142	41	350	trade_amount	-70001.00	USDT	480499.00	Amount for buy option trade on XAUUSD	2026-04-16 18:35:28	2026-04-16 18:35:28
1143	41	350	fee	-1400.02	USDT	479098.98	Fee for buy option trade on XAUUSD	2026-04-16 18:35:28	2026-04-16 18:35:28
1144	41	350	trade_win	85401.22	USDT	564500.20	Won buy trade on XAUUSD	2026-04-16 18:38:29	2026-04-16 18:38:29
1145	41	351	trade_amount	-70001.00	USDT	494499.20	Amount for buy option trade on XAUUSD	2026-04-16 18:40:47	2026-04-16 18:40:47
1146	41	351	fee	-1400.02	USDT	493099.18	Fee for buy option trade on XAUUSD	2026-04-16 18:40:47	2026-04-16 18:40:47
1147	41	351	trade_win	85401.22	USDT	578500.40	Won buy trade on XAUUSD	2026-04-16 18:43:47	2026-04-16 18:43:47
1148	83	352	trade_amount	-1000.00	USDT	100.00	Amount for buy option trade on BTCUSDT	2026-04-17 00:48:13	2026-04-17 00:48:13
1149	83	352	fee	-20.00	USDT	80.00	Fee for buy option trade on BTCUSDT	2026-04-17 00:48:13	2026-04-17 00:48:13
1150	83	352	trade_win	1120.00	USDT	1200.00	Won buy trade on BTCUSDT	2026-04-17 00:48:43	2026-04-17 00:48:43
1151	10	353	trade_amount	-40000.00	USDT	298414.07	Amount for buy option trade on BTCUSDT	2026-04-17 03:17:46	2026-04-17 03:17:46
1152	10	353	fee	-800.00	USDT	297614.07	Fee for buy option trade on BTCUSDT	2026-04-17 03:17:46	2026-04-17 03:17:46
1153	10	353	trade_win	47200.00	USDT	344814.07	Won buy trade on BTCUSDT	2026-04-17 03:19:16	2026-04-17 03:19:16
1154	78	354	trade_amount	-17000.00	USDT	3438.00	Amount for buy option trade on BTCUSDT	2026-04-17 21:02:46	2026-04-17 21:02:46
1155	78	354	fee	-340.00	USDT	3098.00	Fee for buy option trade on BTCUSDT	2026-04-17 21:02:46	2026-04-17 21:02:46
1156	78	354	trade_win	19550.00	USDT	22648.00	Won buy trade on BTCUSDT	2026-04-17 21:03:47	2026-04-17 21:03:47
1157	82	355	trade_amount	-3400.00	USDT	130.00	Amount for buy option trade on BTCUSDT	2026-04-18 02:04:26	2026-04-18 02:04:26
1158	82	355	fee	-68.00	USDT	62.00	Fee for buy option trade on BTCUSDT	2026-04-18 02:04:26	2026-04-18 02:04:26
1159	82	355	trade_win	3808.00	USDT	3870.00	Won buy trade on BTCUSDT	2026-04-18 02:04:56	2026-04-18 02:04:56
1160	82	356	trade_amount	-3700.00	USDT	170.00	Amount for sell option trade on XAUUSD	2026-04-18 02:12:59	2026-04-18 02:12:59
1161	82	356	fee	-74.00	USDT	96.00	Fee for sell option trade on XAUUSD	2026-04-18 02:12:59	2026-04-18 02:12:59
1162	82	356	trade_win	4144.00	USDT	4240.00	Won sell trade on XAUUSD	2026-04-18 02:13:30	2026-04-18 02:13:30
1163	10	\N	mining_profit	304000.00	USDT	1048814.07	\N	2026-04-19 01:53:02	2026-04-19 01:53:02
1164	10	\N	mining_profit	304000.00	USDT	1752814.07	\N	2026-04-19 02:43:38	2026-04-19 02:43:38
1165	60	357	trade_amount	-10001.00	USDT	367.00	Amount for buy option trade on BTCUSDT	2026-04-19 04:36:30	2026-04-19 04:36:30
1166	60	357	fee	-200.02	USDT	166.98	Fee for buy option trade on BTCUSDT	2026-04-19 04:36:30	2026-04-19 04:36:30
1167	60	357	trade_win	11501.15	USDT	11668.13	Won buy trade on BTCUSDT	2026-04-19 04:37:31	2026-04-19 04:37:31
1168	9	\N	mining_profit	304000.00	USDT	993097.20	\N	2026-04-20 01:35:45	2026-04-20 01:35:45
1169	78	358	trade_amount	-30000.00	USDT	2753.00	Amount for buy option trade on BTCUSDT	2026-04-21 02:00:46	2026-04-21 02:00:46
1170	78	358	fee	-600.00	USDT	2153.00	Fee for buy option trade on BTCUSDT	2026-04-21 02:00:46	2026-04-21 02:00:46
1171	78	358	trade_win	34500.00	USDT	36653.00	Won buy trade on BTCUSDT	2026-04-21 02:01:47	2026-04-21 02:01:47
1172	84	359	trade_amount	-7000.00	USDT	602.00	Amount for sell option trade on BTCUSDT	2026-04-22 00:59:17	2026-04-22 00:59:17
1173	84	359	fee	-140.00	USDT	462.00	Fee for sell option trade on BTCUSDT	2026-04-22 00:59:17	2026-04-22 00:59:17
1174	84	359	trade_win	7840.00	USDT	8302.00	Won sell trade on BTCUSDT	2026-04-22 00:59:48	2026-04-22 00:59:48
1175	10	360	trade_amount	-30001.00	USDT	1722813.07	Amount for buy option trade on BTCUSDT	2026-04-22 01:05:06	2026-04-22 01:05:06
1176	10	360	fee	-600.02	USDT	1722213.05	Fee for buy option trade on BTCUSDT	2026-04-22 01:05:06	2026-04-22 01:05:06
1177	10	360	trade_win	35401.18	USDT	1757614.23	Won buy trade on BTCUSDT	2026-04-22 01:06:37	2026-04-22 01:06:37
1178	10	361	trade_amount	-30001.00	USDT	1727613.23	Amount for buy option trade on BTCUSDT	2026-04-22 01:07:02	2026-04-22 01:07:02
1179	10	361	fee	-600.02	USDT	1727013.21	Fee for buy option trade on BTCUSDT	2026-04-22 01:07:02	2026-04-22 01:07:02
1180	10	361	trade_win	35401.18	USDT	1762414.39	Won buy trade on BTCUSDT	2026-04-22 01:08:33	2026-04-22 01:08:33
1181	82	362	trade_amount	-4000.00	USDT	240.00	Amount for buy option trade on BTCUSDT	2026-04-22 02:15:57	2026-04-22 02:15:57
1182	82	362	fee	-80.00	USDT	160.00	Fee for buy option trade on BTCUSDT	2026-04-22 02:15:57	2026-04-22 02:15:57
1183	82	362	trade_win	4480.00	USDT	4640.00	Won buy trade on BTCUSDT	2026-04-22 02:16:27	2026-04-22 02:16:27
1184	66	363	trade_amount	-18000.00	USDT	1338.00	Amount for buy option trade on BTCUSDT	2026-04-22 04:16:09	2026-04-22 04:16:09
1185	66	363	fee	-360.00	USDT	978.00	Fee for buy option trade on BTCUSDT	2026-04-22 04:16:09	2026-04-22 04:16:09
1186	66	363	trade_win	20700.00	USDT	21678.00	Won buy trade on BTCUSDT	2026-04-22 04:17:10	2026-04-22 04:17:10
1187	78	364	trade_amount	-33000.00	USDT	3653.00	Amount for buy option trade on BTCUSDT	2026-04-24 00:30:29	2026-04-24 00:30:29
1188	78	364	fee	-660.00	USDT	2993.00	Fee for buy option trade on BTCUSDT	2026-04-24 00:30:29	2026-04-24 00:30:29
1189	78	364	trade_win	38940.00	USDT	41933.00	Won buy trade on BTCUSDT	2026-04-24 00:32:00	2026-04-24 00:32:00
1190	82	365	trade_amount	-100.00	USDT	5720.00	Amount for buy option trade on BTCUSDT	2026-04-24 01:31:10	2026-04-24 01:31:10
1191	82	365	fee	-2.00	USDT	5718.00	Fee for buy option trade on BTCUSDT	2026-04-24 01:31:10	2026-04-24 01:31:10
1192	82	365	trade_win	112.00	USDT	5830.00	Won buy trade on BTCUSDT	2026-04-24 01:31:40	2026-04-24 01:31:40
1193	82	366	trade_amount	-5600.00	USDT	230.00	Amount for buy option trade on BTCUSDT	2026-04-24 01:33:45	2026-04-24 01:33:45
1194	82	366	fee	-112.00	USDT	118.00	Fee for buy option trade on BTCUSDT	2026-04-24 01:33:45	2026-04-24 01:33:45
1195	82	366	trade_win	6272.00	USDT	6390.00	Won buy trade on BTCUSDT	2026-04-24 01:34:16	2026-04-24 01:34:16
1196	10	367	trade_amount	-36500.00	USDT	1725914.39	Amount for buy option trade on BTCUSDT	2026-04-24 02:17:44	2026-04-24 02:17:44
1197	10	367	fee	-730.00	USDT	1725184.39	Fee for buy option trade on BTCUSDT	2026-04-24 02:17:44	2026-04-24 02:17:44
1198	10	368	trade_amount	-35000.00	USDT	1690184.39	Amount for buy option trade on BTCUSDT	2026-04-24 02:18:20	2026-04-24 02:18:20
1199	10	368	fee	-700.00	USDT	1689484.39	Fee for buy option trade on BTCUSDT	2026-04-24 02:18:20	2026-04-24 02:18:20
1200	10	367	trade_win	43070.00	USDT	1732554.39	Won buy trade on BTCUSDT	2026-04-24 02:19:15	2026-04-24 02:19:15
1201	10	368	trade_win	41300.00	USDT	1773854.39	Won buy trade on BTCUSDT	2026-04-24 02:19:50	2026-04-24 02:19:50
1202	10	369	trade_amount	-65000.00	USDT	1708854.39	Amount for buy option trade on BTCUSDT	2026-04-24 03:50:08	2026-04-24 03:50:08
1203	10	369	fee	-1300.00	USDT	1707554.39	Fee for buy option trade on BTCUSDT	2026-04-24 03:50:08	2026-04-24 03:50:08
1204	10	369	trade_win	76700.00	USDT	1784254.39	Won buy trade on BTCUSDT	2026-04-24 03:51:39	2026-04-24 03:51:39
1205	78	370	trade_amount	-35000.00	USDT	6933.00	Amount for sell option trade on BTCUSDT	2026-04-25 16:23:03	2026-04-25 16:23:03
1206	78	370	fee	-700.00	USDT	6233.00	Fee for sell option trade on BTCUSDT	2026-04-25 16:23:03	2026-04-25 16:23:03
1207	78	370	trade_win	41300.00	USDT	47533.00	Won sell trade on BTCUSDT	2026-04-25 16:24:34	2026-04-25 16:24:34
1208	41	371	trade_amount	-60000.00	USDT	518500.40	Amount for sell option trade on XAUUSD	2026-04-26 23:38:42	2026-04-26 23:38:42
1209	41	371	fee	-1200.00	USDT	517300.40	Fee for sell option trade on XAUUSD	2026-04-26 23:38:42	2026-04-26 23:38:42
1210	41	371	trade_win	70800.00	USDT	588100.40	Won sell trade on XAUUSD	2026-04-26 23:40:12	2026-04-26 23:40:12
1211	60	372	trade_amount	-10001.00	USDT	1667.13	Amount for buy option trade on BTCUSDT	2026-04-27 01:48:40	2026-04-27 01:48:40
1212	60	372	fee	-200.02	USDT	1467.11	Fee for buy option trade on BTCUSDT	2026-04-27 01:48:40	2026-04-27 01:48:40
1213	60	372	trade_win	11501.15	USDT	12968.26	Won buy trade on BTCUSDT	2026-04-27 01:49:41	2026-04-27 01:49:41
1214	38	373	trade_amount	-100000.00	USDT	4062.00	Amount for buy option trade on BTCUSDT	2026-04-29 18:26:00	2026-04-29 18:26:00
1215	38	373	fee	-2000.00	USDT	2062.00	Fee for buy option trade on BTCUSDT	2026-04-29 18:26:00	2026-04-29 18:26:00
1216	38	373	trade_win	122000.00	USDT	124062.00	Won buy trade on BTCUSDT	2026-04-29 18:29:00	2026-04-29 18:29:00
1217	82	374	trade_amount	-10100.00	USDT	221.00	Amount for buy option trade on BTCUSDT	2026-05-02 02:20:37	2026-05-02 02:20:37
1218	82	374	fee	-202.00	USDT	19.00	Fee for buy option trade on BTCUSDT	2026-05-02 02:20:37	2026-05-02 02:20:37
1219	82	374	trade_win	11615.00	USDT	11634.00	Won buy trade on BTCUSDT	2026-05-02 02:21:38	2026-05-02 02:21:38
1220	78	\N	arbitrage_purchase	-7999.00	USDT	45534.00	\N	2026-05-02 13:31:01	2026-05-02 13:31:01
1221	12	\N	mining_profit	152000.00	USDT	2006908.76	\N	2026-05-04 22:08:32	2026-05-04 22:08:32
1222	78	375	trade_amount	-40000.00	USDT	10534.00	Amount for buy option trade on BTCUSDT	2026-05-05 01:30:04	2026-05-05 01:30:04
1223	78	375	fee	-800.00	USDT	9734.00	Fee for buy option trade on BTCUSDT	2026-05-05 01:30:04	2026-05-05 01:30:04
1224	78	375	trade_win	47200.00	USDT	56934.00	Won buy trade on BTCUSDT	2026-05-05 01:31:35	2026-05-05 01:31:35
1225	10	376	trade_amount	-80000.00	USDT	1704254.39	Amount for buy option trade on BTCUSDT	2026-05-05 04:08:33	2026-05-05 04:08:33
1226	10	376	fee	-1600.00	USDT	1702654.39	Fee for buy option trade on BTCUSDT	2026-05-05 04:08:33	2026-05-05 04:08:33
1227	10	376	trade_win	97600.00	USDT	1800254.39	Won buy trade on BTCUSDT	2026-05-05 04:11:34	2026-05-05 04:11:34
1228	78	\N	arbitrage_profit	208.77	USDT	65141.77	\N	2026-05-05 13:31:01	2026-05-05 13:31:01
1229	78	377	trade_amount	-55000.00	USDT	15141.77	Amount for buy option trade on BTCUSDT	2026-05-08 01:30:05	2026-05-08 01:30:05
1230	78	377	fee	-1100.00	USDT	14041.77	Fee for buy option trade on BTCUSDT	2026-05-08 01:30:05	2026-05-08 01:30:05
1231	78	377	trade_win	64900.00	USDT	78941.77	Won buy trade on BTCUSDT	2026-05-08 01:31:35	2026-05-08 01:31:35
1232	78	\N	arbitrage_purchase	-2999.00	USDT	75942.77	\N	2026-05-08 01:37:48	2026-05-08 01:37:48
1233	78	\N	arbitrage_purchase	-2999.00	USDT	73918.77	\N	2026-05-08 18:01:24	2026-05-08 18:01:24
1234	60	378	trade_amount	-10001.00	USDT	2967.26	Amount for sell option trade on BTCUSDT	2026-05-08 23:38:17	2026-05-08 23:38:17
1235	60	378	fee	-200.02	USDT	2767.24	Fee for sell option trade on BTCUSDT	2026-05-08 23:38:17	2026-05-08 23:38:17
1236	60	378	trade_win	11501.15	USDT	14268.39	Won sell trade on BTCUSDT	2026-05-08 23:39:18	2026-05-08 23:39:18
1237	82	379	trade_amount	-15000.00	USDT	534.00	Amount for sell option trade on BTCUSDT	2026-05-09 01:01:46	2026-05-09 01:01:46
1238	82	379	fee	-300.00	USDT	234.00	Fee for sell option trade on BTCUSDT	2026-05-09 01:01:46	2026-05-09 01:01:46
1240	82	380	trade_amount	-17000.00	USDT	484.00	Amount for sell option trade on BTCUSDT	2026-05-09 01:05:33	2026-05-09 01:05:33
1241	82	380	fee	-340.00	USDT	144.00	Fee for sell option trade on BTCUSDT	2026-05-09 01:05:33	2026-05-09 01:05:33
1243	78	\N	arbitrage_profit	15.00	USDT	76932.77	\N	2026-05-09 01:37:48	2026-05-09 01:37:48
1246	88	381	trade_win	1008.00	USDT	1070.00	Won buy trade on BTCUSDT	2026-05-09 14:36:02	2026-05-09 14:36:02
1247	88	382	trade_amount	-950.00	USDT	120.00	Amount for buy option trade on BTCUSDT	2026-05-09 14:38:41	2026-05-09 14:38:41
1248	88	382	fee	-19.00	USDT	101.00	Fee for buy option trade on BTCUSDT	2026-05-09 14:38:41	2026-05-09 14:38:41
1252	88	383	trade_win	1008.00	USDT	1255.00	Won buy trade on BTCUSDT	2026-05-09 14:41:40	2026-05-09 14:41:40
1254	88	384	trade_amount	-100.00	USDT	1155.00	Amount for buy option trade on BTCUSDT	2026-05-10 19:25:50	2026-05-10 19:25:50
1255	88	384	fee	-2.00	USDT	1153.00	Fee for buy option trade on BTCUSDT	2026-05-10 19:25:50	2026-05-10 19:25:50
1258	78	385	trade_win	76700.00	USDT	90346.77	Won sell trade on BTCUSDT	2026-05-12 01:01:37	2026-05-12 01:01:37
1261	60	386	trade_win	16100.00	USDT	16605.00	Won buy trade on BTCUSDT	2026-05-12 01:22:02	2026-05-12 01:22:02
1264	41	387	trade_win	64900.00	USDT	596900.40	Won buy trade on XAUUSD	2026-05-12 02:22:19	2026-05-12 02:22:19
1267	25	388	trade_win	6720.00	USDT	641339.20	Won buy trade on BTCUSDT	2026-05-12 07:11:42	2026-05-12 07:11:42
1269	47	389	trade_amount	-65000.00	USDT	2958.00	Amount for buy option trade on BTCUSDT	2026-05-12 15:54:21	2026-05-12 15:54:21
1270	47	389	fee	-1300.00	USDT	1658.00	Fee for buy option trade on BTCUSDT	2026-05-12 15:54:21	2026-05-12 15:54:21
1272	41	390	trade_amount	-115000.00	USDT	481900.40	Amount for buy option trade on XAUUSD	2026-05-13 02:32:03	2026-05-13 02:32:03
1273	41	390	fee	-2300.00	USDT	479600.40	Fee for buy option trade on XAUUSD	2026-05-13 02:32:03	2026-05-13 02:32:03
1274	41	390	trade_win	140300.00	USDT	619900.40	Won buy trade on XAUUSD	2026-05-13 02:35:03	2026-05-13 02:35:03
1277	41	391	trade_win	82600.00	USDT	631100.40	Won buy trade on XAUUSD	2026-05-14 19:05:20	2026-05-14 19:05:20
1279	82	392	trade_amount	-19000.00	USDT	694.00	Amount for buy option trade on BTCUSDT	2026-05-16 03:07:33	2026-05-16 03:07:33
1280	82	392	fee	-380.00	USDT	314.00	Fee for buy option trade on BTCUSDT	2026-05-16 03:07:33	2026-05-16 03:07:33
1282	88	393	trade_amount	-1500.00	USDT	153.00	Amount for buy option trade on BTCUSDT	2026-05-17 15:15:13	2026-05-17 15:15:13
1283	88	393	fee	-30.00	USDT	123.00	Fee for buy option trade on BTCUSDT	2026-05-17 15:15:13	2026-05-17 15:15:13
1284	88	393	trade_win	1680.00	USDT	1803.00	Won buy trade on BTCUSDT	2026-05-17 15:15:44	2026-05-17 15:15:44
1285	88	394	trade_amount	-1700.00	USDT	103.00	Amount for buy option trade on BTCUSDT	2026-05-17 15:17:39	2026-05-17 15:17:39
1286	88	394	fee	-34.00	USDT	69.00	Fee for buy option trade on BTCUSDT	2026-05-17 15:17:39	2026-05-17 15:17:39
1287	88	394	trade_win	1904.00	USDT	1973.00	Won buy trade on BTCUSDT	2026-05-17 15:18:10	2026-05-17 15:18:10
1288	10	395	trade_amount	-30000.00	USDT	1770254.39	Amount for buy option trade on BTCUSDT	2026-05-17 15:20:53	2026-05-17 15:20:53
1289	10	395	fee	-600.00	USDT	1769654.39	Fee for buy option trade on BTCUSDT	2026-05-17 15:20:53	2026-05-17 15:20:53
1290	10	395	trade_win	34500.00	USDT	1804154.39	Won buy trade on BTCUSDT	2026-05-17 15:21:54	2026-05-17 15:21:54
1291	10	396	trade_amount	-60000.00	USDT	1744154.39	Amount for buy option trade on BTCUSDT	2026-05-17 15:21:57	2026-05-17 15:21:57
1292	10	396	fee	-1200.00	USDT	1742954.39	Fee for buy option trade on BTCUSDT	2026-05-17 15:21:57	2026-05-17 15:21:57
1293	10	396	trade_win	70800.00	USDT	1813754.39	Won buy trade on BTCUSDT	2026-05-17 15:23:28	2026-05-17 15:23:28
1294	31	397	trade_amount	-46780.00	USDT	128697.36	Amount for buy option trade on BTCUSDT	2026-05-18 03:48:47	2026-05-18 03:48:47
1295	31	397	fee	-935.60	USDT	127761.76	Fee for buy option trade on BTCUSDT	2026-05-18 03:48:47	2026-05-18 03:48:47
1296	31	397	trade_win	55200.40	USDT	182962.16	Won buy trade on BTCUSDT	2026-05-18 03:50:18	2026-05-18 03:50:18
1297	78	398	trade_amount	-120000.00	USDT	5555.54	Amount for sell option trade on BTCUSDT	2026-05-19 02:00:04	2026-05-19 02:00:04
1298	78	398	fee	-2400.00	USDT	3155.54	Fee for sell option trade on BTCUSDT	2026-05-19 02:00:04	2026-05-19 02:00:04
1299	78	398	trade_win	146400.00	USDT	149555.54	Won sell trade on BTCUSDT	2026-05-19 02:03:05	2026-05-19 02:03:05
1300	78	399	trade_amount	-120000.00	USDT	29555.54	Amount for sell option trade on BTCUSDT	2026-05-21 18:00:03	2026-05-21 18:00:03
1301	78	399	fee	-2400.00	USDT	27155.54	Fee for sell option trade on BTCUSDT	2026-05-21 18:00:03	2026-05-21 18:00:03
1302	78	399	trade_win	146400.00	USDT	173555.54	Won sell trade on BTCUSDT	2026-05-21 18:03:04	2026-05-21 18:03:04
1303	60	400	trade_amount	-1100.00	USDT	15505.00	Amount for buy option trade on BTCUSDT	2026-05-22 03:14:47	2026-05-22 03:14:47
1304	60	400	fee	-22.00	USDT	15483.00	Fee for buy option trade on BTCUSDT	2026-05-22 03:14:47	2026-05-22 03:14:47
1305	60	400	trade_win	1232.00	USDT	16715.00	Won buy trade on BTCUSDT	2026-05-22 03:15:17	2026-05-22 03:15:17
1306	82	401	trade_amount	-26500.00	USDT	1000.00	Amount for buy option trade on XAUUSD	2026-05-23 01:56:06	2026-05-23 01:56:06
1307	82	401	fee	-530.00	USDT	470.00	Fee for buy option trade on XAUUSD	2026-05-23 01:56:06	2026-05-23 01:56:06
1308	82	401	trade_win	30475.00	USDT	30945.00	Won buy trade on XAUUSD	2026-05-23 01:57:07	2026-05-23 01:57:07
1309	51	402	trade_amount	-500.00	USDT	2285.00	Amount for sell contract trade on BTCUSDT with 10x leverage	2026-05-24 21:46:50	2026-05-24 21:46:50
1310	51	402	fee	-10.00	USDT	2275.00	Fee for sell contract trade on BTCUSDT	2026-05-24 21:46:50	2026-05-24 21:46:50
1311	41	403	trade_amount	-100000.00	USDT	531100.40	Amount for buy option trade on XAUUSD	2026-05-25 12:11:47	2026-05-25 12:11:47
1312	41	403	fee	-2000.00	USDT	529100.40	Fee for buy option trade on XAUUSD	2026-05-25 12:11:47	2026-05-25 12:11:47
1313	41	403	trade_win	122000.00	USDT	651100.40	Won buy trade on XAUUSD	2026-05-25 12:14:47	2026-05-25 12:14:47
1314	78	404	trade_amount	-30000.00	USDT	143555.54	Amount for buy option trade on BTCUSDT	2026-05-26 00:30:14	2026-05-26 00:30:14
1315	78	404	fee	-600.00	USDT	142955.54	Fee for buy option trade on BTCUSDT	2026-05-26 00:30:14	2026-05-26 00:30:14
1316	78	404	trade_win	34500.00	USDT	177455.54	Won buy trade on BTCUSDT	2026-05-26 00:31:15	2026-05-26 00:31:15
1317	78	\N	arbitrage_purchase	-19999.00	USDT	157456.54	\N	2026-05-26 02:22:04	2026-05-26 02:22:04
1318	41	405	trade_amount	-50000.00	USDT	601100.40	Amount for buy option trade on XAUUSD	2026-05-29 01:13:54	2026-05-29 01:13:54
1319	41	405	fee	-1000.00	USDT	600100.40	Fee for buy option trade on XAUUSD	2026-05-29 01:13:54	2026-05-29 01:13:54
1320	41	405	trade_win	59000.00	USDT	659100.40	Won buy trade on XAUUSD	2026-05-29 01:15:24	2026-05-29 01:15:24
1321	10	406	trade_amount	-70001.00	USDT	1743753.39	Amount for buy option trade on BTCUSDT	2026-05-29 03:47:41	2026-05-29 03:47:41
1322	10	406	fee	-1400.02	USDT	1742353.37	Fee for buy option trade on BTCUSDT	2026-05-29 03:47:41	2026-05-29 03:47:41
1323	10	406	trade_win	85401.22	USDT	1827754.59	Won buy trade on BTCUSDT	2026-05-29 03:50:42	2026-05-29 03:50:42
1324	10	\N	mining_purchase	-1813754.39	USDT	14000.20	\N	2026-05-29 03:55:27	2026-05-29 03:55:27
1325	78	407	trade_amount	-69000.00	USDT	88456.54	Amount for buy option trade on BTCUSDT	2026-05-30 01:00:02	2026-05-30 01:00:02
1326	78	407	fee	-1380.00	USDT	87076.54	Fee for buy option trade on BTCUSDT	2026-05-30 01:00:02	2026-05-30 01:00:02
1327	78	407	trade_win	81420.00	USDT	168496.54	Won buy trade on BTCUSDT	2026-05-30 01:01:33	2026-05-30 01:01:33
1328	78	\N	arbitrage_purchase	-50001.00	USDT	118495.54	\N	2026-05-30 01:10:28	2026-05-30 01:10:28
1329	82	408	trade_amount	-30000.00	USDT	945.00	Amount for buy option trade on XAUUSD	2026-05-30 01:31:54	2026-05-30 01:31:54
1330	82	408	fee	-600.00	USDT	345.00	Fee for buy option trade on XAUUSD	2026-05-30 01:31:54	2026-05-30 01:31:54
1331	82	408	trade_win	34500.00	USDT	34845.00	Won buy trade on XAUUSD	2026-05-30 01:32:55	2026-05-30 01:32:55
1332	60	409	trade_amount	-11000.00	USDT	5715.00	Amount for buy option trade on BTCUSDT	2026-06-01 03:20:08	2026-06-01 03:20:08
1333	60	409	fee	-220.00	USDT	5495.00	Fee for buy option trade on BTCUSDT	2026-06-01 03:20:08	2026-06-01 03:20:08
1334	60	409	trade_win	12650.00	USDT	18145.00	Won buy trade on BTCUSDT	2026-06-01 03:21:09	2026-06-01 03:21:09
1335	31	410	trade_amount	-58620.00	USDT	124342.16	Amount for buy option trade on XAUUSD	2026-06-01 16:43:49	2026-06-01 16:43:49
1336	31	410	fee	-1172.40	USDT	123169.76	Fee for buy option trade on XAUUSD	2026-06-01 16:43:49	2026-06-01 16:43:49
1337	38	411	trade_amount	-40000.00	USDT	114062.00	Amount for sell option trade on XAUUSD	2026-06-01 16:44:18	2026-06-01 16:44:18
1338	38	411	fee	-800.00	USDT	113262.00	Fee for sell option trade on XAUUSD	2026-06-01 16:44:18	2026-06-01 16:44:18
1339	31	410	trade_win	69171.60	USDT	192341.36	Won buy trade on XAUUSD	2026-06-01 16:45:20	2026-06-01 16:45:20
1340	38	411	trade_win	47200.00	USDT	160462.00	Won sell trade on XAUUSD	2026-06-01 16:45:48	2026-06-01 16:45:48
1341	41	412	trade_amount	-70000.00	USDT	589100.40	Amount for buy option trade on XAUUSD	2026-06-01 16:59:28	2026-06-01 16:59:28
1342	41	412	fee	-1400.00	USDT	587700.40	Fee for buy option trade on XAUUSD	2026-06-01 16:59:28	2026-06-01 16:59:28
1343	41	412	trade_win	82600.00	USDT	670300.40	Won buy trade on XAUUSD	2026-06-01 17:00:59	2026-06-01 17:00:59
1344	82	413	trade_amount	-35000.00	USDT	845.00	Amount for buy option trade on XAUUSD	2026-06-02 01:38:23	2026-06-02 01:38:23
1345	82	413	fee	-700.00	USDT	145.00	Fee for buy option trade on XAUUSD	2026-06-02 01:38:23	2026-06-02 01:38:23
1346	82	413	trade_win	41300.00	USDT	41445.00	Won buy trade on XAUUSD	2026-06-02 01:39:53	2026-06-02 01:39:53
1347	10	\N	mining_profit	108825.26	USDT	1936579.85	\N	2026-06-02 01:51:42	2026-06-02 01:51:42
1348	10	\N	mining_refund	1523553.69	USDT	3460133.54	\N	2026-06-02 01:51:42	2026-06-02 01:51:42
1349	78	\N	arbitrage_profit	1385.93	USDT	139880.47	\N	2026-06-02 02:22:04	2026-06-02 02:22:04
1350	88	414	trade_amount	-100.00	USDT	5373.00	Amount for buy option trade on BTCUSDT	2026-06-03 03:12:19	2026-06-03 03:12:19
1351	88	414	fee	-2.00	USDT	5371.00	Fee for buy option trade on BTCUSDT	2026-06-03 03:12:19	2026-06-03 03:12:19
1352	88	414	trade_win	112.00	USDT	5483.00	Won buy trade on BTCUSDT	2026-06-03 03:12:50	2026-06-03 03:12:50
1353	88	415	trade_amount	-5200.00	USDT	283.00	Amount for buy option trade on XAUUSD	2026-06-03 03:14:57	2026-06-03 03:14:57
1354	88	415	fee	-104.00	USDT	179.00	Fee for buy option trade on XAUUSD	2026-06-03 03:14:57	2026-06-03 03:14:57
1355	88	415	trade_win	5824.00	USDT	6003.00	Won buy trade on XAUUSD	2026-06-03 03:15:27	2026-06-03 03:15:27
1356	31	416	trade_amount	-45768.00	USDT	146573.36	Amount for sell option trade on XAUUSD	2026-06-03 05:28:42	2026-06-03 05:28:42
1357	31	416	fee	-915.36	USDT	145658.00	Fee for sell option trade on XAUUSD	2026-06-03 05:28:42	2026-06-03 05:28:42
1358	31	416	trade_win	54006.24	USDT	199664.24	Won sell trade on XAUUSD	2026-06-03 05:30:13	2026-06-03 05:30:13
1359	78	417	trade_amount	-69900.00	USDT	69980.47	Amount for buy option trade on BTCUSDT	2026-06-03 17:10:55	2026-06-03 17:10:55
1360	78	417	fee	-1398.00	USDT	68582.47	Fee for buy option trade on BTCUSDT	2026-06-03 17:10:55	2026-06-03 17:10:55
1361	78	417	trade_win	82482.00	USDT	151064.47	Won buy trade on BTCUSDT	2026-06-03 17:12:26	2026-06-03 17:12:26
1362	78	418	trade_amount	-69000.00	USDT	82064.47	Amount for buy option trade on BTCUSDT	2026-06-03 17:16:52	2026-06-03 17:16:52
1363	78	418	fee	-1380.00	USDT	80684.47	Fee for buy option trade on BTCUSDT	2026-06-03 17:16:52	2026-06-03 17:16:52
1364	78	418	trade_win	81420.00	USDT	162104.47	Won buy trade on BTCUSDT	2026-06-03 17:18:23	2026-06-03 17:18:23
1365	82	419	trade_amount	-55000.00	USDT	1445.00	Amount for buy option trade on XAUUSD	2026-06-04 01:06:31	2026-06-04 01:06:31
1366	82	419	fee	-1100.00	USDT	345.00	Fee for buy option trade on XAUUSD	2026-06-04 01:06:31	2026-06-04 01:06:31
1367	82	420	trade_amount	-55000.00	USDT	2000.00	Amount for buy option trade on XAUUSD	2026-06-04 01:32:50	2026-06-04 01:32:50
1368	82	420	fee	-1100.00	USDT	900.00	Fee for buy option trade on XAUUSD	2026-06-04 01:32:50	2026-06-04 01:32:50
1369	82	420	trade_win	64900.00	USDT	65800.00	Won buy trade on XAUUSD	2026-06-04 01:34:20	2026-06-04 01:34:20
1370	10	421	trade_amount	-10000.00	USDT	3450133.54	Amount for buy option trade on XAUUSD	2026-06-04 03:46:20	2026-06-04 03:46:20
1371	10	421	fee	-200.00	USDT	3449933.54	Fee for buy option trade on XAUUSD	2026-06-04 03:46:20	2026-06-04 03:46:20
1372	10	421	trade_win	11200.00	USDT	3461133.54	Won buy trade on XAUUSD	2026-06-04 03:46:50	2026-06-04 03:46:50
1373	10	422	trade_amount	-10000.00	USDT	3451133.54	Amount for buy option trade on XAUUSD	2026-06-04 03:47:44	2026-06-04 03:47:44
1374	10	422	fee	-200.00	USDT	3450933.54	Fee for buy option trade on XAUUSD	2026-06-04 03:47:44	2026-06-04 03:47:44
1375	10	422	trade_win	11200.00	USDT	3462133.54	Won buy trade on XAUUSD	2026-06-04 03:48:14	2026-06-04 03:48:14
1376	10	423	trade_amount	-30000.00	USDT	3432133.54	Amount for buy option trade on XAUUSD	2026-06-04 03:52:31	2026-06-04 03:52:31
1377	10	423	fee	-600.00	USDT	3431533.54	Fee for buy option trade on XAUUSD	2026-06-04 03:52:31	2026-06-04 03:52:31
1378	10	423	trade_win	34500.00	USDT	3466033.54	Won buy trade on XAUUSD	2026-06-04 03:53:32	2026-06-04 03:53:32
1379	31	424	trade_amount	-42863.00	USDT	156801.24	Amount for buy option trade on XAUUSD	2026-06-05 03:47:15	2026-06-05 03:47:15
1380	31	424	fee	-857.26	USDT	155943.98	Fee for buy option trade on XAUUSD	2026-06-05 03:47:15	2026-06-05 03:47:15
1381	31	424	trade_win	50578.34	USDT	206522.32	Won buy trade on XAUUSD	2026-06-05 03:48:45	2026-06-05 03:48:45
1382	57	425	trade_amount	-100.00	USDT	5770.00	Amount for buy option trade on BTCUSDT	2026-06-05 21:11:28	2026-06-05 21:11:28
1383	57	425	fee	-2.00	USDT	5768.00	Fee for buy option trade on BTCUSDT	2026-06-05 21:11:28	2026-06-05 21:11:28
1384	78	\N	arbitrage_profit	4200.08	USDT	216305.55	\N	2026-06-06 01:10:29	2026-06-06 01:10:29
1385	78	\N	arbitrage_purchase	-99999.00	USDT	116306.55	\N	2026-06-07 00:46:11	2026-06-07 00:46:11
1386	31	426	trade_amount	-52430.00	USDT	154092.32	Amount for buy option trade on XAUUSD	2026-06-08 18:00:26	2026-06-08 18:00:26
1387	31	426	fee	-1048.60	USDT	153043.72	Fee for buy option trade on XAUUSD	2026-06-08 18:00:26	2026-06-08 18:00:26
1388	31	426	trade_win	61867.40	USDT	214911.12	Won buy trade on XAUUSD	2026-06-08 18:01:56	2026-06-08 18:01:56
1389	41	427	trade_amount	-60000.00	USDT	610300.40	Amount for buy option trade on XAUUSD	2026-06-09 19:57:02	2026-06-09 19:57:02
1390	41	427	fee	-1200.00	USDT	609100.40	Fee for buy option trade on XAUUSD	2026-06-09 19:57:02	2026-06-09 19:57:02
1391	41	427	trade_win	70800.00	USDT	679900.40	Won buy trade on XAUUSD	2026-06-09 19:58:32	2026-06-09 19:58:32
1392	41	428	trade_amount	-100000.00	USDT	579900.40	Amount for buy option trade on XAUUSD	2026-06-10 19:07:13	2026-06-10 19:07:13
1393	41	428	fee	-2000.00	USDT	577900.40	Fee for buy option trade on XAUUSD	2026-06-10 19:07:13	2026-06-10 19:07:13
1394	41	428	trade_win	122000.00	USDT	699900.40	Won buy trade on XAUUSD	2026-06-10 19:10:13	2026-06-10 19:10:13
1395	31	429	trade_amount	-62490.00	USDT	152421.12	Amount for buy option trade on XAUUSD	2026-06-11 15:14:32	2026-06-11 15:14:32
1396	31	429	fee	-1249.80	USDT	151171.32	Fee for buy option trade on XAUUSD	2026-06-11 15:14:32	2026-06-11 15:14:32
1397	31	429	trade_win	73738.20	USDT	224909.52	Won buy trade on XAUUSD	2026-06-11 15:16:03	2026-06-11 15:16:03
1398	31	430	trade_amount	-63490.00	USDT	161419.52	Amount for buy option trade on XAUUSD	2026-06-11 15:17:37	2026-06-11 15:17:37
1399	31	430	fee	-1269.80	USDT	160149.72	Fee for buy option trade on XAUUSD	2026-06-11 15:17:37	2026-06-11 15:17:37
1400	31	430	trade_win	74918.20	USDT	235067.92	Won buy trade on XAUUSD	2026-06-11 15:19:08	2026-06-11 15:19:08
1401	60	431	trade_amount	-18000.00	USDT	563.00	Amount for sell option trade on BTCUSDT	2026-06-12 01:44:59	2026-06-12 01:44:59
1402	60	431	fee	-360.00	USDT	203.00	Fee for sell option trade on BTCUSDT	2026-06-12 01:44:59	2026-06-12 01:44:59
1403	60	431	trade_win	20700.00	USDT	20903.00	Won sell trade on BTCUSDT	2026-06-12 01:46:00	2026-06-12 01:46:00
1404	91	432	trade_amount	-190.00	USDT	8.00	Amount for sell option trade on BTCUSDT	2026-06-14 01:45:59	2026-06-14 01:45:59
1405	91	432	fee	-3.80	USDT	4.20	Fee for sell option trade on BTCUSDT	2026-06-14 01:45:59	2026-06-14 01:45:59
1406	91	432	trade_win	212.80	USDT	217.00	Won sell trade on BTCUSDT	2026-06-14 01:46:30	2026-06-14 01:46:30
1407	78	\N	arbitrage_purchase	-50001.00	USDT	66305.55	\N	2026-06-14 02:12:53	2026-06-14 02:12:53
1408	31	433	trade_amount	-58496.00	USDT	176571.92	Amount for buy option trade on XAUUSD	2026-06-15 15:38:17	2026-06-15 15:38:17
1409	31	433	fee	-1169.92	USDT	175402.00	Fee for buy option trade on XAUUSD	2026-06-15 15:38:17	2026-06-15 15:38:17
1410	31	433	trade_win	69025.28	USDT	244427.28	Won buy trade on XAUUSD	2026-06-15 15:39:47	2026-06-15 15:39:47
1411	91	434	trade_amount	-190.00	USDT	27.00	Amount for buy option trade on BTCUSDT	2026-06-16 15:41:47	2026-06-16 15:41:47
1412	91	434	fee	-3.80	USDT	23.20	Fee for buy option trade on BTCUSDT	2026-06-16 15:41:47	2026-06-16 15:41:47
1413	91	434	trade_win	212.80	USDT	236.00	Won buy trade on BTCUSDT	2026-06-16 15:42:17	2026-06-16 15:42:17
1414	60	435	trade_amount	-20000.00	USDT	903.00	Amount for buy option trade on BTCUSDT	2026-06-17 00:32:50	2026-06-17 00:32:50
1415	60	435	fee	-400.00	USDT	503.00	Fee for buy option trade on BTCUSDT	2026-06-17 00:32:50	2026-06-17 00:32:50
1416	60	435	trade_win	23000.00	USDT	23503.00	Won buy trade on BTCUSDT	2026-06-17 00:33:51	2026-06-17 00:33:51
1417	82	436	trade_amount	-30000.00	USDT	35800.00	Amount for buy option trade on BTCUSDT	2026-06-17 02:09:26	2026-06-17 02:09:26
1418	82	436	fee	-600.00	USDT	35200.00	Fee for buy option trade on BTCUSDT	2026-06-17 02:09:26	2026-06-17 02:09:26
1419	82	436	trade_win	34500.00	USDT	69700.00	Won buy trade on BTCUSDT	2026-06-17 02:10:26	2026-06-17 02:10:26
1420	78	\N	arbitrage_purchase	-7999.00	USDT	58306.55	\N	2026-06-17 22:40:41	2026-06-17 22:40:41
1421	41	437	trade_amount	-60000.00	USDT	639900.40	Amount for sell option trade on XAUUSD	2026-06-19 00:34:10	2026-06-19 00:34:10
1422	41	437	fee	-1200.00	USDT	638700.40	Fee for sell option trade on XAUUSD	2026-06-19 00:34:10	2026-06-19 00:34:10
1423	41	437	trade_win	70800.00	USDT	709500.40	Won sell trade on XAUUSD	2026-06-19 00:35:40	2026-06-19 00:35:40
1424	38	438	trade_amount	-15500.00	USDT	144962.00	Amount for sell option trade on XAUUSD	2026-06-19 18:20:30	2026-06-19 18:20:30
1425	38	438	fee	-310.00	USDT	144652.00	Fee for sell option trade on XAUUSD	2026-06-19 18:20:30	2026-06-19 18:20:30
1426	38	439	trade_amount	-140000.00	USDT	4652.00	Amount for sell option trade on XAUUSD	2026-06-19 18:20:50	2026-06-19 18:20:50
1427	38	439	fee	-2800.00	USDT	1852.00	Fee for sell option trade on XAUUSD	2026-06-19 18:20:50	2026-06-19 18:20:50
1428	88	440	trade_amount	-6200.00	USDT	203.00	Amount for buy option trade on XAUUSD	2026-06-20 02:48:19	2026-06-20 02:48:19
1429	88	440	fee	-124.00	USDT	79.00	Fee for buy option trade on XAUUSD	2026-06-20 02:48:19	2026-06-20 02:48:19
1430	88	440	trade_win	6944.00	USDT	7023.00	Won buy trade on XAUUSD	2026-06-20 02:48:49	2026-06-20 02:48:49
1431	88	441	trade_amount	-6800.00	USDT	223.00	Amount for sell option trade on XAGUSD	2026-06-20 02:50:10	2026-06-20 02:50:10
1432	88	441	fee	-136.00	USDT	87.00	Fee for sell option trade on XAGUSD	2026-06-20 02:50:10	2026-06-20 02:50:10
1433	88	441	trade_win	7616.00	USDT	7703.00	Won sell trade on XAGUSD	2026-06-20 02:50:40	2026-06-20 02:50:40
1434	88	442	trade_amount	-100.00	USDT	7603.00	Amount for buy option trade on BTCUSDT	2026-06-20 02:52:03	2026-06-20 02:52:03
1435	88	442	fee	-2.00	USDT	7601.00	Fee for buy option trade on BTCUSDT	2026-06-20 02:52:03	2026-06-20 02:52:03
1436	78	\N	arbitrage_profit	208.77	USDT	66514.32	\N	2026-06-20 22:40:42	2026-06-20 22:40:42
1437	78	\N	arbitrage_profit	19739.80	USDT	186253.12	\N	2026-06-21 00:46:11	2026-06-21 00:46:11
1438	78	\N	arbitrage_profit	4200.08	USDT	240454.20	\N	2026-06-21 02:12:53	2026-06-21 02:12:53
1439	41	443	trade_amount	-70000.00	USDT	639500.40	Amount for buy option trade on XAUUSD	2026-06-23 00:41:01	2026-06-23 00:41:01
1440	41	443	fee	-1400.00	USDT	638100.40	Fee for buy option trade on XAUUSD	2026-06-23 00:41:01	2026-06-23 00:41:01
1441	41	443	trade_win	82600.00	USDT	720700.40	Won buy trade on XAUUSD	2026-06-23 00:42:31	2026-06-23 00:42:31
1442	10	444	trade_amount	-50000.00	USDT	3416033.54	Amount for buy option trade on BTCUSDT	2026-06-23 02:55:48	2026-06-23 02:55:48
1443	10	444	fee	-1000.00	USDT	3415033.54	Fee for buy option trade on BTCUSDT	2026-06-23 02:55:48	2026-06-23 02:55:48
1444	10	444	trade_win	59000.00	USDT	3474033.54	Won buy trade on BTCUSDT	2026-06-23 02:57:19	2026-06-23 02:57:19
1445	91	445	trade_amount	-200.00	USDT	36.00	Amount for buy option trade on BTCUSDT	2026-06-23 14:36:46	2026-06-23 14:36:46
1446	91	445	fee	-4.00	USDT	32.00	Fee for buy option trade on BTCUSDT	2026-06-23 14:36:46	2026-06-23 14:36:46
1447	31	446	trade_amount	-54178.00	USDT	190249.28	Amount for sell option trade on XAUUSD	2026-06-23 14:51:09	2026-06-23 14:51:09
1448	31	446	fee	-1083.56	USDT	189165.72	Fee for sell option trade on XAUUSD	2026-06-23 14:51:09	2026-06-23 14:51:09
1449	31	446	trade_win	63930.04	USDT	253095.76	Won sell trade on XAUUSD	2026-06-23 14:52:39	2026-06-23 14:52:39
1450	41	447	trade_amount	-50000.00	USDT	670700.40	Amount for buy option trade on XAUUSD	2026-06-24 01:49:36	2026-06-24 01:49:36
1451	41	447	fee	-1000.00	USDT	669700.40	Fee for buy option trade on XAUUSD	2026-06-24 01:49:36	2026-06-24 01:49:36
1452	92	448	trade_amount	-250.00	USDT	50.00	Amount for buy option trade on XAUUSD	2026-06-24 01:49:51	2026-06-24 01:49:51
1453	92	448	fee	-5.00	USDT	45.00	Fee for buy option trade on XAUUSD	2026-06-24 01:49:51	2026-06-24 01:49:51
1454	92	448	trade_win	280.00	USDT	325.00	Won buy trade on XAUUSD	2026-06-24 01:50:21	2026-06-24 01:50:21
1455	41	447	trade_win	59000.00	USDT	728700.40	Won buy trade on XAUUSD	2026-06-24 01:51:06	2026-06-24 01:51:06
1456	31	449	trade_amount	-42000.00	USDT	211095.76	Amount for buy option trade on XAUUSD	2026-06-24 19:31:34	2026-06-24 19:31:34
1457	31	449	fee	-840.00	USDT	210255.76	Fee for buy option trade on XAUUSD	2026-06-24 19:31:34	2026-06-24 19:31:34
1458	31	449	trade_win	49560.00	USDT	259815.76	Won buy trade on XAUUSD	2026-06-24 19:33:04	2026-06-24 19:33:04
1459	60	450	trade_amount	-23000.00	USDT	503.00	Amount for sell option trade on BTCUSDT	2026-06-25 01:01:46	2026-06-25 01:01:46
1460	60	450	fee	-460.00	USDT	43.00	Fee for sell option trade on BTCUSDT	2026-06-25 01:01:46	2026-06-25 01:01:46
1461	60	450	trade_win	26450.00	USDT	26493.00	Won sell trade on BTCUSDT	2026-06-25 01:02:47	2026-06-25 01:02:47
1462	92	451	trade_amount	-300.00	USDT	25.00	Amount for buy option trade on XAUUSD	2026-06-25 23:51:21	2026-06-25 23:51:21
1463	92	451	fee	-6.00	USDT	19.00	Fee for buy option trade on XAUUSD	2026-06-25 23:51:21	2026-06-25 23:51:21
1464	41	452	trade_amount	-50000.00	USDT	678700.40	Amount for buy option trade on XAUUSD	2026-06-25 23:51:48	2026-06-25 23:51:48
1465	41	452	fee	-1000.00	USDT	677700.40	Fee for buy option trade on XAUUSD	2026-06-25 23:51:48	2026-06-25 23:51:48
1466	92	451	trade_win	336.00	USDT	355.00	Won buy trade on XAUUSD	2026-06-25 23:51:51	2026-06-25 23:51:51
1467	41	452	trade_win	59000.00	USDT	736700.40	Won buy trade on XAUUSD	2026-06-25 23:53:18	2026-06-25 23:53:18
1468	41	453	trade_amount	-50000.00	USDT	686700.40	Amount for buy option trade on BTCUSDT	2026-06-27 01:15:25	2026-06-27 01:15:25
1469	41	453	fee	-1000.00	USDT	685700.40	Fee for buy option trade on BTCUSDT	2026-06-27 01:15:25	2026-06-27 01:15:25
1470	41	453	trade_win	59000.00	USDT	744700.40	Won buy trade on BTCUSDT	2026-06-27 01:16:56	2026-06-27 01:16:56
1471	91	454	trade_amount	-1200.00	USDT	332.00	Amount for sell option trade on BTCUSDT	2026-06-27 14:01:22	2026-06-27 14:01:22
1472	91	454	fee	-24.00	USDT	308.00	Fee for sell option trade on BTCUSDT	2026-06-27 14:01:22	2026-06-27 14:01:22
1473	91	454	trade_win	1344.00	USDT	1652.00	Won sell trade on BTCUSDT	2026-06-27 14:01:53	2026-06-27 14:01:53
1474	91	455	trade_amount	-1600.00	USDT	52.00	Amount for buy option trade on BTCUSDT	2026-06-29 14:21:58	2026-06-29 14:21:58
1475	91	455	fee	-32.00	USDT	20.00	Fee for buy option trade on BTCUSDT	2026-06-29 14:21:58	2026-06-29 14:21:58
1476	91	455	trade_win	1792.00	USDT	1812.00	Won buy trade on BTCUSDT	2026-06-29 14:22:28	2026-06-29 14:22:28
1477	41	456	trade_amount	-50000.00	USDT	694700.40	Amount for sell option trade on XAUUSD	2026-06-30 00:59:01	2026-06-30 00:59:01
1478	41	456	fee	-1000.00	USDT	693700.40	Fee for sell option trade on XAUUSD	2026-06-30 00:59:01	2026-06-30 00:59:01
1479	92	457	trade_amount	-325.00	USDT	30.00	Amount for buy option trade on XAUUSD	2026-06-30 00:59:04	2026-06-30 00:59:04
1480	92	457	fee	-6.50	USDT	23.50	Fee for buy option trade on XAUUSD	2026-06-30 00:59:04	2026-06-30 00:59:04
1481	92	457	trade_win	364.00	USDT	387.50	Won buy trade on XAUUSD	2026-06-30 00:59:35	2026-06-30 00:59:35
1482	41	456	trade_win	59000.00	USDT	752700.40	Won sell trade on XAUUSD	2026-06-30 01:00:31	2026-06-30 01:00:31
1483	31	458	trade_amount	-45259.00	USDT	214556.76	Amount for buy option trade on XAUUSD	2026-07-02 16:44:57	2026-07-02 16:44:57
1484	31	458	fee	-905.18	USDT	213651.58	Fee for buy option trade on XAUUSD	2026-07-02 16:44:57	2026-07-02 16:44:57
1485	31	458	trade_win	53405.62	USDT	267057.20	Won buy trade on XAUUSD	2026-07-02 16:46:27	2026-07-02 16:46:27
1486	88	459	trade_amount	-7800.00	USDT	201.00	Amount for buy option trade on BTCUSDT	2026-07-04 03:03:52	2026-07-04 03:03:52
1487	88	459	fee	-156.00	USDT	45.00	Fee for buy option trade on BTCUSDT	2026-07-04 03:03:52	2026-07-04 03:03:52
1488	88	459	trade_win	8736.00	USDT	8781.00	Won buy trade on BTCUSDT	2026-07-04 03:04:23	2026-07-04 03:04:23
1489	88	460	trade_amount	-10500.00	USDT	481.00	Amount for buy option trade on BTCUSDT	2026-07-11 03:11:24	2026-07-11 03:11:24
1490	88	460	fee	-210.00	USDT	271.00	Fee for buy option trade on BTCUSDT	2026-07-11 03:11:24	2026-07-11 03:11:24
1491	88	460	trade_win	12075.00	USDT	12346.00	Won buy trade on BTCUSDT	2026-07-11 03:12:24	2026-07-11 03:12:24
1492	60	461	trade_amount	-26000.00	USDT	830.00	Amount for sell option trade on BTCUSDT	2026-07-11 03:38:15	2026-07-11 03:38:15
1493	60	461	fee	-520.00	USDT	310.00	Fee for sell option trade on BTCUSDT	2026-07-11 03:38:15	2026-07-11 03:38:15
1494	60	461	trade_win	29900.00	USDT	30210.00	Won sell trade on BTCUSDT	2026-07-11 03:39:16	2026-07-11 03:39:16
1495	4	462	trade_amount	-1000.00	USDT	114059.50	Amount for buy option trade on BTCUSDT	2026-07-11 04:27:44	2026-07-11 04:27:44
1496	4	462	fee	-20.00	USDT	114039.50	Fee for buy option trade on BTCUSDT	2026-07-11 04:27:44	2026-07-11 04:27:44
1497	31	463	trade_amount	-35846.00	USDT	231211.20	Amount for buy option trade on BTCUSDT	2026-07-11 15:34:39	2026-07-11 15:34:39
1498	31	463	fee	-716.92	USDT	230494.28	Fee for buy option trade on BTCUSDT	2026-07-11 15:34:39	2026-07-11 15:34:39
1499	31	463	trade_win	42298.28	USDT	272792.56	Won buy trade on BTCUSDT	2026-07-11 15:36:09	2026-07-11 15:36:09
1500	12	\N	loan_disbursement	20000.00	USDT	2026908.76	Loan approved #18	2026-07-13 17:13:38	2026-07-13 17:13:38
1501	31	464	trade_amount	-42637.00	USDT	230155.56	Amount for buy option trade on BTCUSDT	2026-07-14 03:20:36	2026-07-14 03:20:36
1502	31	464	fee	-852.74	USDT	229302.82	Fee for buy option trade on BTCUSDT	2026-07-14 03:20:36	2026-07-14 03:20:36
1503	31	464	trade_win	50311.66	USDT	279614.48	Won buy trade on BTCUSDT	2026-07-14 03:22:07	2026-07-14 03:22:07
1504	41	465	trade_amount	-10000.00	USDT	742700.40	Amount for buy option trade on BTCUSDT	2026-07-14 15:32:53	2026-07-14 15:32:53
1505	41	465	fee	-200.00	USDT	742500.40	Fee for buy option trade on BTCUSDT	2026-07-14 15:32:53	2026-07-14 15:32:53
1506	41	465	trade_win	11200.00	USDT	753700.40	Won buy trade on BTCUSDT	2026-07-14 15:33:23	2026-07-14 15:33:23
1507	41	466	trade_amount	-60000.00	USDT	693700.40	Amount for buy option trade on BTCUSDT	2026-07-14 15:41:49	2026-07-14 15:41:49
1508	41	466	fee	-1200.00	USDT	692500.40	Fee for buy option trade on BTCUSDT	2026-07-14 15:41:49	2026-07-14 15:41:49
1509	92	467	trade_amount	-100.00	USDT	287.50	Amount for buy option trade on BTCUSDT	2026-07-14 15:43:06	2026-07-14 15:43:06
1510	92	467	fee	-2.00	USDT	285.50	Fee for buy option trade on BTCUSDT	2026-07-14 15:43:06	2026-07-14 15:43:06
1511	41	466	trade_win	70800.00	USDT	763300.40	Won buy trade on BTCUSDT	2026-07-14 15:43:20	2026-07-14 15:43:20
1512	91	468	trade_amount	-10000.00	USDT	352.00	Amount for buy option trade on BTCUSDT	2026-07-15 14:44:50	2026-07-15 14:44:50
1513	91	468	fee	-200.00	USDT	152.00	Fee for buy option trade on BTCUSDT	2026-07-15 14:44:50	2026-07-15 14:44:50
1514	91	468	trade_win	11200.00	USDT	11352.00	Won buy trade on BTCUSDT	2026-07-15 14:45:21	2026-07-15 14:45:21
1515	10	469	trade_amount	-70000.00	USDT	3404033.54	Amount for buy option trade on BTCUSDT	2026-07-16 05:17:55	2026-07-16 05:17:55
1516	10	469	fee	-1400.00	USDT	3402633.54	Fee for buy option trade on BTCUSDT	2026-07-16 05:17:55	2026-07-16 05:17:55
1517	10	469	trade_win	82600.00	USDT	3485233.54	Won buy trade on BTCUSDT	2026-07-16 05:19:25	2026-07-16 05:19:25
1518	96	470	trade_amount	-950.00	USDT	31.00	Amount for buy option trade on BTCUSDT	2026-07-16 05:20:55	2026-07-16 05:20:55
1519	96	470	fee	-19.00	USDT	12.00	Fee for buy option trade on BTCUSDT	2026-07-16 05:20:55	2026-07-16 05:20:55
1520	96	470	trade_win	1064.00	USDT	1076.00	Won buy trade on BTCUSDT	2026-07-16 05:21:25	2026-07-16 05:21:25
1521	91	471	trade_amount	-11000.00	USDT	352.00	Amount for sell option trade on BTCUSDT	2026-07-17 15:15:54	2026-07-17 15:15:54
1522	91	471	fee	-220.00	USDT	132.00	Fee for sell option trade on BTCUSDT	2026-07-17 15:15:54	2026-07-17 15:15:54
1523	91	471	trade_win	12650.00	USDT	12782.00	Won sell trade on BTCUSDT	2026-07-17 15:16:55	2026-07-17 15:16:55
1524	96	472	trade_amount	-900.00	USDT	176.00	Amount for sell option trade on BTCUSDT	2026-07-18 02:05:12	2026-07-18 02:05:12
1525	96	472	fee	-18.00	USDT	158.00	Fee for sell option trade on BTCUSDT	2026-07-18 02:05:12	2026-07-18 02:05:12
1526	96	472	trade_win	1008.00	USDT	1166.00	Won sell trade on BTCUSDT	2026-07-18 02:05:42	2026-07-18 02:05:42
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, phone, email_verified_at, password, role, status, remember_token, created_at, updated_at, balance) FROM stdin;
1	Test User	bruk@upholdtrading.com	\N	\N	$2b$10$zS7MpT1FIpB2e2C//uos7.OskF.weihTylHOsyKXN6x2uNxGOtInC	user	active	\N	\N	\N	0.00
37	Lulit	lulittesfaye419@gmail.com	\N	\N	$2b$10$9UIrD3g7a7ERV8DhQT5/c.vxan08ljOrrFa37fohOdHdNFx7lKzC2	user	active	\N	2026-01-19 17:44:26	2026-01-19 17:44:26	0.00
29	menu	eyob@gmail.com	\N	\N	$2b$10$qMZtgLnoBv38s58DK9o3ruz/c1Z/pqVKJ5/ocUQaARJXxg4dgL/2q	user	active	\N	2026-01-14 10:36:38	2026-01-14 10:36:38	0.00
38	Amanuel Teshome	Amanuel1512@gmail.com	\N	\N	$2b$10$6ybMbC6eomxmhEX40hDc1eUgEepdGxZXU.4Xh285vzFCWAVNVPc4u	user	active	\N	2026-01-21 22:56:35	2026-06-19 18:20:50	1852.00
41	Chai	jj6434793@gmail.com	\N	\N	$2b$10$QZyskjhBvzAE65.2eSh7h.QTxqcc2ovPUZKduJv3gRn6M0ncTSteu	user	active	\N	2026-01-23 21:09:05	2026-07-14 15:43:20	763300.40
22	FIRDU KASSAYE	abc@gmail.com	+17788463470	\N	$2b$10$ZeIzYAG9IqJOkpBCJ/J.M./67pZ1S4ZASKhBZIJGbsucTg1z14MPy	user	active	\N	2025-12-25 08:52:40	2025-12-26 08:43:34	16163.13
19	Emnet ab	ayalewemneteab@gmail.com	\N	\N	$2b$10$rOGZ/Xm9g1t.Ip2AfJQjeuHZlQwHFojw375Smk3LwRDoGm3B1Iw5.	user	active	\N	2025-12-18 13:55:43	2025-12-18 13:55:43	0.00
20	Seble  Woubshet	emodish1@yahoo.com	\N	\N	$2b$10$iLkQDchlztejHWpGsOdd2OGcq8WKRDvXgPse9GzuyqZQn2apXXaqC	user	active	\N	2025-12-19 04:04:44	2026-01-29 01:04:02	6289.25
21	wewew	steel-gather-15@inboxkitten.com	\N	\N	$2b$10$Y9/as.5sXO1Bc5ggH5XRpeYRXF3zTh85bZoTTt1caofqFg7wHOhOK	user	active	\N	2025-12-23 00:48:03	2025-12-23 00:52:33	4167.00
6	Yab	yab@gmail.com	\N	\N	$2b$10$bAygHFV9WqUg6LjA0p7ZjurWg5LJjCodjw8NpYXAteeanqzlFb4NC	user	active	\N	2025-12-06 20:00:18	2026-06-12 12:38:35	5044500.00
13	RUBEN	laicai1124@163.com	\N	\N	$2b$10$r65owbN7lge2Os3SHa1X9.cwFcyKTO095FAvWO6xlDi086CqApebS	user	active	\N	2025-12-13 02:31:47	2025-12-13 02:31:47	0.00
14	xinren chushui	hexin20131495@gmail.com	\N	\N	$2b$10$69aauqW8mMFQdywuIG2pyuDS0DBvcr2w3vMmTwf1pG/XFBVnmvgV.	user	active	\N	2025-12-13 02:37:55	2025-12-13 02:37:55	0.00
31	Hawi Tufa	hawitufa2062@gmail.com	\N	\N	$2b$10$oINetwUbEsjF16l9R.dxseRzvwzX0Mf4m1ChhaW8/7eTjJfoaixtu	user	active	\N	2026-01-15 02:48:09	2026-07-14 03:22:07	279614.48
2	Super Admin User	superadmin@upholdtrading.com	\N	\N	$2b$10$gfN43LCfKBNCmvtv8ueEGOVQXCnY4UGdwsL37sJxxkvbVrb92pNMS	admin	active	\N	\N	2025-12-31 12:07:35	0.00
16	Melku	sardulmardul@gmail.com	\N	\N	$2b$10$7V8NEUPZWm0w7iFvTjHG7ux.plFpIUyCvv4qYmxOWvuPTH31j4xfS	user	active	\N	2025-12-17 00:31:19	2025-12-31 14:40:54	45628.00
43	chu shui xin ren	chushuixinren@gmail.com	\N	\N	$2b$10$g4lwTE2WNi2dhJbb5ThLcuLePBkKpyzp4Wc5pQmpOLgDQSZPRAbQu	user	active	\N	2026-01-26 09:10:59	2026-01-26 09:10:59	0.00
15	Mersha Alemayehu 	mersha@live.co.uk	\N	\N	$2b$10$a1oZMkyFrdplsrAvBmQ.c.dmHbA4..65F7z6k/41hn/PbCyZsgSyW	user	active	\N	2025-12-14 20:59:45	2025-12-14 20:59:45	0.00
7	Solomon kebede	solomonanajina@gmail.com	0989872748	\N	$2b$10$VsYb0XKr3tJwHsl.E5KriO67g4AwSRc09Jk08K3XkWKFnmRlRBlcK	user	active	\N	2025-12-06 21:30:32	2025-12-09 16:22:52	4640.00
30	abebe	yb@gmail.com	\N	\N	$2b$10$PECFKV547t24fdqI3wB.QuS7uEzrLK1qdTuPtZDtKw1re8m45TYry	user	active	\N	2026-01-14 16:05:23	2026-01-14 16:05:23	0.00
3	Admin User	admin@upholdtrading.com	\N	\N	$2b$10$YRgIfkWZn9wH8lGhHYejwuhN1FQlVYZy2PBpoCMWzWwH5bSDpjYjG	admin	active	\N	\N	2026-01-10 04:50:05	0.00
44	Seble Techane	sebletechane27@gmail.com	\N	\N	$2b$10$caNqs5IK0xBYpf6/rO5HjO9zHZw7vW4Qs3k/WP2i36IJNuKSmUroC	user	active	\N	2026-01-28 17:50:03	2026-02-07 22:20:39	3563.00
45	Rahel	belachewrahel07@gmail.com	\N	\N	$2b$10$vaI37rE2dFYTyG9ZkiOKR.8qHHiXekk8CfJvMQHX6CzPDBcUPSz7q	user	active	\N	2026-01-29 02:38:10	2026-01-29 02:38:10	0.00
34	yyy	Tokentradesnet@gmail.com	\N	\N	$2b$10$d8lQ0MxlF.tq/37R6JYBTOmZ5CLbQJDx5aWvnco5wQKz/WD5UeO8G	user	active	\N	2026-01-17 18:33:55	2026-01-26 19:45:07	349999.00
47	Mario Dieter Matthes	mario_matthes@web.de	\N	\N	$2b$10$GvTN4WqujJfTjUsUrikM4OBIm.2hVo0p3DvnKjrOko3VebVgomrZy	user	active	\N	2026-02-03 18:49:49	2026-06-13 07:30:39	210358.00
17	Zegeye Mekasha Kidane	zegeye1476@gmail.com	\N	\N	$2b$10$vMmGUYemuD6llIpQhwsl.eawfXKA0ZMcJHujSC3ViyGwrORDT8Z2q	user	active	\N	2025-12-17 03:26:21	2026-03-21 16:48:00	16763.00
18	Girma Gebresenbet	Girma56.gg@gmail.com	\N	\N	$2b$10$Fr14VHS1jwBDRS54zbXnKuwf3F/GYo6NjKQseU8D099D0hgKAfkWW	user	active	\N	2025-12-17 20:18:46	2026-01-10 06:42:04	1516.00
26	RUBEN	gq230928@163.com	\N	\N	$2b$10$bnBRB4s.7LtM/8JQzPsvj.oq1W40oYb5AnNmEq11qZeA.vjZcjlPO	user	active	\N	2026-01-12 12:51:42	2026-01-12 12:51:42	0.00
25	shpp199841@gmail.com	shpp199841@gmail.com	\N	\N	$2b$10$6qxXMYuqv/VTohbV60Voe.2rlb77ezXAwWw.p0kIcu4DhyLB4D2XW	user	active	\N	2026-01-01 04:10:59	2026-05-12 07:11:42	641339.20
4	Bruh	bruhtesfazelealem436@gmail.com	\N	\N	$2b$10$u.nzKGZL7b5wbMXTxM4PuOSwu9HWdmNUw6EJ0XbiEiDNIMTtU91a2	user	active	\N	2025-12-06 14:37:45	2026-07-11 04:27:44	114039.50
5	Itisa Wagari	natamelanie410@gmail.com		\N	$2b$10$EapQnMIKifAZLnBu2FhRLOBb8Ox2YWwK3XxQH7nq5qoNxxVIDjX1S	user	active	\N	2025-12-06 19:58:18	2026-01-07 03:59:42	133484.00
33	Yonas Terefe	yonasterefegobena@yahoo.com	\N	\N	$2b$10$A.ZL5aaGSgIM5iSUj5eF.uOKhv68uOVJkzjesEPG/RLF4Ah2fxd5S	user	active	\N	2026-01-16 18:52:16	2026-01-17 05:40:17	17051.00
27	Kk	serudalax@gmail.com	\N	\N	$2b$10$HIWqBraZ.4tEswubqh8QneEqP1c4ZBTkeaR85BcqTRGzri1g4SfE6	user	active	\N	2026-01-12 21:17:55	2026-01-12 21:17:55	0.00
39	Tewodros Tariku	teddytariku1966@gmail.com	\N	\N	$2b$10$ubTWAf49AysYwZDHML4BjONXWbfxbNbUDk.L8RUibIYYfM0cY89ra	user	active	\N	2026-01-22 02:13:40	2026-01-22 02:13:40	0.00
40	Ybb	molang5230@gmail.com	\N	\N	$2b$10$D9O5Gijwqmx/GRoe/UjHT.TmK/WoFzKHBpcxUTM4wFdihNb3T2nU6	user	active	\N	2026-01-22 08:14:10	2026-01-22 08:14:10	0.00
24	Melku	melkuzyayine@gmail.com	\N	\N	$2b$10$QrMP4njEPz.Ww.V/knYK7.xyyt6el8qKrrfdbFUZK12xsjecwBALC	user	active	\N	2025-12-31 15:03:03	2026-03-06 15:32:50	98451.00
10	Katalina	sarimblaq8@gmail.com	+251	\N	$2b$10$rnsIkc.BMrX2B/ftszTx.uuIaHcMGiGwNHLAxNMm0Cl5srvB5foey	user	active	\N	2025-12-07 04:32:26	2026-07-16 05:19:25	3485233.54
35	Tedros tekabo	cidonatekabo@gmail.com	\N	\N	$2b$10$AINoJyO1.POOMCMHp3iqRO1WVJP2CYn9DTHvOT4cIxvWKsNJQBy8y	user	active	\N	2026-01-18 21:24:18	2026-02-11 03:24:27	639.00
23	Ashenafi Temesgen	babure880@gmail.com	\N	\N	$2b$10$Byx3q0niwuDkrg17kVhhn.sHrOoR/BYfjIwOiME/YHFtSW.7vi5Tu	user	active	\N	2025-12-28 04:15:57	2026-03-08 02:49:18	183922.16
42	woubshet humaso	woubnahe@yahoo.com	\N	\N	$2b$10$.Ary/MtfVaukoO/H.kFAiunp22d8j0xsU3gkllIagbSoUNLgB38G2	user	active	\N	2026-01-25 18:33:31	2026-01-26 03:51:16	406.00
36	John doe	John123@gmail.com	\N	\N	$2b$10$0MLgtD6JlLhFGsMeLmzFi.fM0uP5XeQeWPNKKmh/kUpKPt0KxHoru	user	active	\N	2026-01-19 14:49:45	2026-02-17 04:11:09	371838.64
32	Aklilu Mengistu	akliluabebe53@yahoo.com	\N	\N	$2b$10$8W5pDzUyv/OAI6fUqA1jfOaiwM1dzo9./w7kDqho4gG8DDnEZJpo6	user	active	\N	2026-01-15 16:04:39	2026-01-31 17:47:22	14407.00
46	Ezzedin Ibrahim 	ezzedin.ibrahim@outlook.com	\N	\N	$2b$10$GHs/P.D5xONqJt0V5eerYufHEY1csUmfF4ADFvmSqK7XY.Y60BrA.	user	active	\N	2026-02-03 04:01:47	2026-02-03 04:01:47	0.00
28	Teklegiorgis Daniel	kesis1968@yahoo.com	\N	\N	$2b$10$QqGxgenVgUjwmHPoN3O2lOYsizqYczQan8lh0XU7EEA2nxn0wI6a6	user	active	\N	2026-01-14 04:46:13	2026-03-16 19:28:29	636.00
65	Muluye  B Fanta 	muluyebezabeh@yahoo.com	\N	\N	$2b$10$DQrhZP4D30k0VGuvHssMZ.Y6ImtlpAYSYBkcEKcHwjUVhS/NB/9Ba	user	active	\N	2026-03-01 17:10:19	2026-03-04 05:17:54	81.80
75	Firhiwot sime	firhiwotsime1@yahoo.com	\N	\N	$2b$10$HpKBXZlNb5xm21IYWvQByOme1IHheoNzpaAWupC41WZ1d5pDvSPSm	user	active	\N	2026-03-16 05:28:47	2026-03-28 04:14:41	6250.00
49	Sosina Endeshaw	nicebraidsdallas@gmail.com	\N	\N	$2b$10$yb0eYvPhm/y0hrUYDpht0u/1Q3veQ46GNM2Jhq/EMjRNJlcOh24Tq	user	active	\N	2026-02-04 21:37:38	2026-02-05 18:28:35	1212.00
76	fxum T Gebrekidan 	fxumGebrekidan@gmail.com	\N	\N	$2b$10$DuuarnE.VwjGOZ/zoyE8vuiRW9bNOnjb/qy1bboYMFklM4Zc8E926	user	active	\N	2026-03-16 18:16:10	2026-04-06 20:16:35	71685.98
62	Tsion	nunutesfaye32@gmai.com	\N	\N	$2b$10$SgtAmPR6dGQjYxQxh2szBe7LVbyHzE3Q4bO0pBSTXpzcdwrExd1ZO	user	active	\N	2026-02-27 20:03:03	2026-03-06 21:39:19	1281.00
51	Tesfaye Zewdu Shibeshi	tesfaye.shibeshi4@gmail.com	\N	\N	$2b$10$2Nxz3rpQWJKf0rz7di5bF.OdfHotkx8DSH4YAmTh7l0uzs2fZ.l92	user	active	\N	2026-02-07 06:19:32	2026-05-24 21:46:50	2275.00
59	Squadwerk Innovations	ephremayf@gmail.com	\N	\N	$2b$10$FBCTts.n1HMO2Rt3FtHkLuDKHEaS2k2mXjKv9N60F7UszuulaOuKO	user	active	\N	2026-02-26 02:04:19	2026-02-26 02:04:19	0.00
79	Samuel kidanemariam	samuelkidanemariam159@gmail.com	\N	\N	$2b$10$a/IflidEB8JDiazgXZDXSeAWYUTKMzZTIS2PTBgZSufSd75CVLNYC	user	active	\N	2026-03-29 03:18:32	2026-03-29 03:21:16	500.00
61	Abc	abcd@gmail.com	\N	\N	$2b$10$sNhUWTmy2JaZPjQCvTqbpuqsrq7CO9qCzV0cOwnS8kXWMaRxoT3ci	user	active	\N	2026-02-26 07:49:21	2026-02-26 07:49:21	0.00
77	Mulugeta Michael 	mlgtmichael@gmail.com	\N	\N	$2b$10$U.oA6Wvg4m5yN2.ZfeErCecrcGDpChDzym1FEtK2d3/n8e.ear9yC	user	active	\N	2026-03-23 15:14:06	2026-03-26 14:49:01	20929.00
48	Chan wing 	chan.wing@gmail.com	\N	\N	$2b$10$YV26RAC3129g.kQyd7QEPeRol4RNdWuroh3Un0Nm8rrcwjxZ6yZ62	user	active	\N	2026-02-03 19:28:33	2026-03-06 22:51:57	268598.00
12	Iris Wilson	Selam@gmail.com	\N	\N	$2b$10$vZFkzyl9JVQGE58uhZacBuyJfPD84tSkLBsjlTsaEm835gTWJKCIi	user	active	\N	2025-12-08 05:45:40	2026-07-13 17:13:38	2026908.76
92	Bruk Araya	\N	+12026178301	\N	$2b$10$C.GsaXqvVegDy06mMpZe5.ACVLdIBdBA/oCkHMxEFvWndIpdZ4zna	user	active	\N	2026-06-23 12:40:58	2026-07-14 15:43:06	285.50
72	Tsion tesfaye 	nunutesfaye32@gmail.com	\N	\N	$2b$10$5JN/RfriiCFRkY4Ui8bNJ.S7Xw3xsuKnv12ZfMXPfFEztat5aFNqy	user	active	\N	2026-03-12 23:36:28	2026-03-12 23:36:28	0.00
82	Meseret Kebede	D4jz06p@gmail.com	\N	\N	$2b$10$M/ceywtzBilUWYFrK.8Y6eYAxGjUIWbsSguAAAzUOvGx257cjUIQG	user	active	\N	2026-04-16 00:37:11	2026-06-17 02:10:26	69700.00
54	Teklegiorgis Daniel	teklegiorgisdaniel@gmail.com	\N	\N	$2b$10$y4e.dKLcdeHmy5/QHX7xROoZ/o5N2NnlQfrsgD3P/anW53UGb4P9W	user	active	\N	2026-02-13 21:49:10	2026-03-16 19:23:45	740.00
68	Tolesa Jilcha	\N	+61493243163	\N	$2b$10$3j1BzWQBG6Qc73KhxJ9G7OOn1nNQi9QpPT5YnmqTdtTuHHKyikK0e	user	active	\N	2026-03-08 07:57:35	2026-03-08 07:57:35	0.00
84	Dereje gebere 	derejegebere419@gmail.com	\N	\N	$2b$10$PvQa5fXkBfVILVcSj9G48ueFba/LhaHqTqVb8kUQlry0ZDZEWpnGO	user	active	\N	2026-04-21 02:22:40	2026-04-22 00:59:48	8302.00
63	Samrawit	samrawittariku90@gmail.com	\N	\N	$2b$10$gdCQ62SRERj1z0o8To7os.06beBWK7r9Y7UA2Gw8Sky25GTJlWTni	user	active	\N	2026-02-27 23:07:53	2026-02-27 23:07:53	0.00
69	Abiy 	atg4abiy@yahoo.ca	\N	\N	$2b$10$Ceeu0GswuKNqHGKAgUVXJuuVbXH2Fq6sTxWXLfK0vfJFpkc4ZsJOm	user	active	\N	2026-03-10 01:45:19	2026-03-10 01:45:19	0.00
70	Abiy 	atg4abiy@yshoo.ca	\N	\N	$2b$10$mF3wgAyZkYsftNoFayoM3.9cpAwtOavA8cfv7/IbFAdp.uk9kybca	user	active	\N	2026-03-10 02:24:05	2026-03-10 02:24:05	0.00
81	Konjet  D Wolde-Yohannes 	konniewolde@gmail.com	\N	\N	$2b$10$mktUTaqJsN3NubPLnoIyEuRyEthdiuoY61O.3Rd4qz96BlhKs.Q96	user	active	\N	2026-03-30 02:31:37	2026-03-30 02:54:24	1092.00
71	Adam Smith	kebrutamirat1@gmail.com	\N	\N	$2b$10$.TOJD7DLDLjEpYxHQp7mk.aJPQ7arCj8zHWveR6ZCK7I8D5kp3a9W	user	active	\N	2026-03-10 16:04:38	2026-03-10 16:04:38	0.00
83	Tegist Abdosh 	Aber4128@yahoo.com	\N	\N	$2b$10$v0wnCo3GsJOLUGR.Q4p5KuDS4q7RLNYrG7hLqcU8meS40a6B4dMky	user	active	\N	2026-04-17 00:22:02	2026-04-17 00:48:43	1200.00
73	X man 	diyasharma5052@gmail.com	\N	\N	$2b$10$7j7RSl2VK/l51Et./uIiOeelv4TjstEvZ6BbsO8gIY3lTIi1FiIqq	user	active	\N	2026-03-15 14:24:49	2026-03-15 14:24:49	0.00
85	spamon	abdigemechu83@gmail.com	\N	\N	$2b$10$2aEwv44HBXZfLbHFOMYVduljAOtXVZhQemoWa3LwnpRUtPXzAhFEm	user	active	\N	2026-04-25 14:27:55	2026-04-29 14:15:05	0.00
64	Rahel   Negash 	rameharis@yahoo.com	\N	\N	$2b$10$2Xbr8E4iRXPhufuEOjKVAOnjuMXCB5BA./2FfjPo4P8vUGKLEOsQa	user	active	\N	2026-02-28 00:37:19	2026-03-10 20:22:47	2097.00
74	fxum	fustumtekle19@gmail.com	\N	\N	$2b$10$Mx5SyY9pInIFGT5Igts3UeYqiVFNgGGi3gD.h5RgrmhQmaSytTzlm	user	active	\N	2026-03-15 20:58:09	2026-03-15 20:58:09	0.00
50	Selamawit Andarge	Selamawit15@outlook.com	+12063066807	\N	$2b$10$9jWSOCxqar70WyBauOAQy.IHyUKmVTdO4lbaAgrIaVJCUUB68i1Zq	user	active	\N	2026-02-07 02:47:53	2026-03-26 21:25:27	5654.00
87	Antony Smith	antonys@gmail.com	\N	\N	$2b$10$vx7ICt3fSKK4nYD89uUSJOiIiLJW0UhPfEWBHwXTytdYTqmsJm1T6	user	active	\N	2026-05-03 04:31:15	2026-05-03 04:31:15	0.00
80	Wubayehu Hailu	wubaye@hotmail.com	\N	\N	$2b$10$PzjmFCz9YGK42sw1mwMVM.lEwCBm/uHOxvLr04YJeI.Stw1BJgq2q	user	active	\N	2026-03-29 18:03:56	2026-04-02 19:45:13	1290.00
60	Awel Yasin Mohammed 	yawel463@gmail.com	\N	\N	$2b$10$xM4Pt2JwKsPT67p9UEyGNuigsiPgCnhZwOXsi3ql//l45VB2BugXu	user	active	\N	2026-02-26 03:15:35	2026-07-11 03:39:16	30210.00
58	Eshetu Abate 	eshetuabate056@gmail.com	\N	\N	$2b$10$BIqYzoCMR.d64948YimvC.nfo9VQO2sILys0oQxsHZoqhYQKBlGF2	user	active	\N	2026-02-24 00:19:15	2026-04-03 00:06:59	6666.00
67	Super admin	yanshun12@gmail.com	\N	\N	$2b$10$1Ix5ZheVvIANPR4i6LCUkOFjYQaycqgGw0/PenUpAGHz9SX4tzU1C	admin	active	\N	2026-03-07 02:49:51	2026-05-18 12:10:39	0.00
89	Juh	juhhood@gmail.com	\N	\N	$2b$10$B1biQHekddQ53yYfCIGJ5uqKM3AG94z8q2VWc0run.KJ5rFJf7lOK	user	active	\N	2026-06-04 03:14:48	2026-06-04 03:14:48	0.00
9	Yet D	Hoyahoye@gmail.com	1	\N	$2b$10$8RZq8XTJt/FLt3Qnqdp8D.7WhXOYxQhsS8WVUGfYYWSkxkwzmJFxi	user	active	\N	2025-12-07 00:30:26	2026-05-09 15:47:40	993097.20
57	Roman Enyew Tesfaw 	romantesfaw@yahoo.com	\N	\N	$2b$10$gZHenLey4CE5rHGkRzV1yeIL/zf9ZYWeRhhviIGwJU7rio8WqO.6e	user	active	\N	2026-02-23 21:07:37	2026-06-05 21:11:28	5768.00
66	Tigist  kumsia 	tigistkumsia12@gmail.com	\N	\N	$2b$10$u.doNJqs9qMxGfEOJBwfXuW8eSooYe6gsH3yJXW.3YdAh7vekW6k2	user	active	\N	2026-03-06 03:23:54	2026-05-26 14:11:55	28147.00
90	Addisalem Redae	addisalem2011@gmail.com	\N	\N	$2b$10$WL8SziZOv2NmUYLVzIjnueRtYWWPhmHL0Zm9wj22F9.mcZ9ADLfp6	user	active	\N	2026-06-11 03:45:17	2026-06-11 03:45:17	0.00
91	Nuralem Eshetu	addiskuche@yahoo.com	\N	\N	$2b$10$TQfBqxn.lpWZsinVQG1ZFuqJTLTH.YQe7tzpERWjoUQ2OZ2Fn/qY2	user	active	\N	2026-06-12 16:58:00	2026-07-17 15:16:55	12782.00
93	Joe	bety63761@gmail.com	\N	\N	$2b$10$oSQCy9XUaSBkw5h/cfckCukQf8/UH66eLzpAmRrhnJPBNA1Z6i2Sm	user	active	\N	2026-06-23 21:13:46	2026-06-23 21:13:46	0.00
78	Terefe Koyra	terefekorkisa@gmail.com	\N	\N	$2b$10$4XBmLGgWyq5gZkq4ONHs5OtLq321hybdIrVFa5nHbOA8B.BMc3moO	user	active	\N	2026-03-24 01:46:23	2026-06-21 02:12:53	240454.20
88	Mekdes Feleke	Mekdesfeleke31@yahoo.com	+12064128831	\N	$2b$10$fPIv30qSyHbtdyV3tU4nU.CbSt/pKwadFVuxKKkWa4jChkJRNMEwy	user	active	\N	2026-05-08 01:31:32	2026-07-11 03:12:24	12346.00
94	Mahlet Tesfaye 	mahlettadesse2019@gmail.com	\N	\N	$2b$10$X1SZ8Op7YcnVwjecAecTfOxpPvHWF6YmD4PjAL8lxWB5iOqZWxt02	user	active	\N	2026-07-01 04:21:24	2026-07-01 04:21:24	0.00
53	Esayas Hailu Gobeze	hailu_esayas@yahoo.com	\N	\N	$2b$10$j6nD3nwVNLKS1sJC8qN3b.nanvyuSlQwgBlrnks.OYJdvy2IMBXk6	user	active	\N	2026-02-13 04:30:25	2026-07-02 03:47:28	5177.00
95	Kassa Yirdaw	kassayirdaw@gmail.com	\N	\N	$2b$10$lhtB7fLi5sm37QpIdFQpPONDQrOvCb6IPWTZU.1HdauMAL81baJ1O	user	active	\N	2026-07-02 04:24:44	2026-07-02 04:24:44	0.00
97	Meseret 	meseret@gmail.com	\N	\N	$2b$10$HEm8z.SsaQ5H.cBo5stW3.7PZuLZ1oVdC4v8w3oOhe0cnXQwzhBe2	user	active	\N	2026-07-15 15:57:49	2026-07-15 15:57:49	0.00
98	as	laeth12@gmail.cim	\N	\N	$2b$10$GXdfXsWzu2Xw1fjT6DkiQ.KKdrDT1ZxenpZiL8mFGeY4WNAq8e0W6	user	active	\N	2026-07-16 09:12:23	2026-07-16 09:12:23	0.00
99	Mr wendwesen sebseba	wendeyee@yahoo.co.uk	\N	\N	$2b$10$3/7AfhlLxVWZY6NXJG0muuQXORQ9mUV6.VJwmDXIezTqs/Iv32eQK	user	active	\N	2026-07-17 15:52:03	2026-07-17 15:56:36	38592.00
96	Afework 	Afeworkkoyra@gmail.com	\N	\N	$2b$10$iDOnkbuxcPtFWxJpx/w5UudxelSTJJ3udGnzBjKTG.4Ai/uXoatyC	user	active	\N	2026-07-15 03:20:31	2026-07-18 02:05:42	1166.00
\.


--
-- Data for Name: withdrawals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.withdrawals (id, user_id, currency, amount, fee, transaction_id, wallet_address, network, bank_details, description, status, rejection_reason, processed_by, processed_at, created_at, updated_at) FROM stdin;
2	12	USDT	75000.00	20.00000000	\N	0xA46873e4236199fE24cb1Ea2D8716674E5C99Ae3	TRC20	\N	\N	approved	\N	3	2025-12-08 06:31:34	2025-12-08 06:27:48	2025-12-08 06:31:34
1	12	USDT	18000.00	20.00000000	\N	0xA46873e4236199fE24cb1Ea2D8716674E5C99Ae3	TRC20	\N	\N	approved	\N	3	2025-12-08 06:31:43	2025-12-08 06:27:30	2025-12-08 06:31:43
3	12	USDT	40000.00	20.00000000	\N	0xA46873e4236199fE24cb1Ea2D8716674E5C99Ae3	ERC20	\N	\N	approved	\N	3	2025-12-08 06:32:37	2025-12-08 06:32:20	2025-12-08 06:32:37
4	12	USDT	500.00	7.50000000	\N	0xA46873e4236199fE24cb1Ea2D8716674E5C99Ae3	ERC20	\N	\N	approved	\N	3	2025-12-09 20:26:06	2025-12-09 15:40:05	2025-12-09 20:26:06
5	4	USDT	10.00	1.00000000	\N	dsgthukiufkl	TRC20	\N	\N	rejected	Withdrawal request rejected due to security concerns	3	2025-12-14 03:34:11	2025-12-13 14:41:53	2025-12-14 03:34:11
6	4	USDT	10.00	1.00000000	\N	aadfsdfhrerteg	TRC20	\N	\N	rejected	Withdrawal request rejected due to security concerns	2	2025-12-14 09:45:29	2025-12-13 14:43:40	2025-12-14 09:45:29
7	4	USDT	500.00	3.50000000	\N	0xA46873e4236199fE24cb1Ea2D8716674E5C99Ae3	TRC20	\N	\N	approved	\N	2	2025-12-14 09:47:49	2025-12-14 09:47:18	2025-12-14 09:47:49
8	4	USDT	10.00	1.00000000	\N	asfaegaegeg	TRC20	\N	\N	pending	\N	\N	\N	2025-12-18 18:49:48	2025-12-18 18:49:48
9	16	USDT	20000.00	20.00000000	\N	0xcbacdageyiouklm	TRC20	\N	\N	approved	\N	3	2025-12-22 20:14:22	2025-12-22 20:14:08	2025-12-22 20:14:22
10	16	USDT	3000.00	16.00000000	\N	08xcbgtklm2746	TRC20	\N	\N	rejected	Dear Customer,\n\nPlease be informed that a 10% tax is required on your total balance in order to proceed with the withdrawal.\n\nTax amount: $7,700 (10%)\n\nOnce the tax payment is completed, the remaining balance will be released for withdrawal.\n\nIf you have any questions or need assistance, please feel free to contact us.\n\nThank you for your cooperation.\n\nKind regards,\nCustomer Support Team	3	2025-12-22 20:19:08	2025-12-22 20:18:12	2025-12-22 20:19:08
11	12	USDT	10.00	1.00000000	\N	0xA46873e4236199fE24cb1Ea2D8716674E5C99Ae3	TRC20	\N	\N	rejected	Withdrawal request rejected due to security concerns	3	2025-12-22 20:24:48	2025-12-22 20:24:34	2025-12-22 20:24:48
12	21	USDT	600.00	4.00000000	\N	TY2DJJzUB6yS9v1CZ7XQNL5MMySCrVQmjD	TRC20	\N	\N	approved	\N	2	2025-12-23 00:52:33	2025-12-23 00:52:16	2025-12-23 00:52:33
13	17	USDT	200.00	6.00000000	\N	0x5a7490a9a17382161a0bc1dad738e691d811dd7d	ERC20	\N	\N	rejected	Withdrawal request rejected due to security concerns	3	2025-12-23 19:14:49	2025-12-23 18:58:08	2025-12-23 19:14:49
15	16	USDT	45000.00	20.00000000	\N	5088081205	TRC20	\N	\N	rejected	Withdrawal request rejected due to security concerns	3	2025-12-23 19:58:56	2025-12-23 19:51:56	2025-12-23 19:58:56
14	12	USDT	10.00	1.00000000	\N	0000000	TRC20	\N	\N	rejected	Withdrawal request rejected due to security concerns	3	2025-12-23 19:59:05	2025-12-23 19:48:10	2025-12-23 19:59:05
16	5	USDT	1000.00	6.00000000	\N	TCTnsLKmpDcSv5tHn5KTmQS3TPVM3ubdp2	TRC20	\N	\N	approved	\N	2	2025-12-25 03:29:04	2025-12-25 03:28:29	2025-12-25 03:29:04
18	12	USDT	2000.00	11.00000000	\N	TJiQB5XeLkykYFxM2HBzWUudpTzLU5Ujm6	TRC20	\N	\N	approved	\N	3	2025-12-25 15:11:00	2025-12-25 15:10:45	2025-12-25 15:11:00
19	12	USDT	12000.00	20.00000000	\N	TJiQB5XeLkykYFxM2HBzWUudpTzLU5Ujm6	TRC20	\N	\N	rejected	Withdrawal request rejected due to security concerns	2	2025-12-26 20:16:03	2025-12-25 15:23:11	2025-12-26 20:16:03
20	16	USDT	15000.00	20.00000000	\N	TJiQB5XeLkykYFxM2HBzWUudpTzLU5Ujm6	TRC20	\N	\N	rejected	Withdrawal request rejected due to security concerns	2	2025-12-30 15:09:55	2025-12-27 19:12:55	2025-12-30 15:09:55
21	23	USDT	200.00	6.00000000	\N	0x7E2ae1741206D98A8565988cEED0d3c85C7AeDA9	ERC20	\N	\N	approved	\N	2	2026-01-06 15:28:22	2026-01-06 04:02:29	2026-01-06 15:28:22
17	5	USDT	10000.00	20.00000000	\N	TCTnsLKmpDcSv5tHn5KTmQS3TPVM3ubdp2	TRC20	\N	\N	approved	\N	2	2026-01-07 03:59:42	2025-12-25 03:31:46	2026-01-07 03:59:42
22	23	USDT	200.00	2.00000000	\N	0x7E2ae1741206D98A8565988cEED0d3c85C7AeDA9	TRC20	\N	\N	approved	\N	3	2026-01-13 14:47:57	2026-01-13 04:09:17	2026-01-13 14:47:57
23	20	USDT	150.00	5.75000000	\N	0x37D9F7BD2Ce54AaF440F5E7499751090E44Cfc2C	ERC20	\N	\N	approved	\N	3	2026-01-15 05:13:42	2026-01-15 05:11:07	2026-01-15 05:13:42
24	32	USDT	3000.00	16.00000000	\N	0x7746B982F598005f0A9a8C6be611Ec21258Aa17a	TRC20	\N	\N	rejected	Dear customer your account have been frozen please make a deposit to activate your account thank you \n	3	2026-01-15 19:38:25	2026-01-15 19:35:39	2026-01-15 19:38:25
25	31	USDT	50000.00	20.00000000	\N	Oxafdrvfhh	TRC20	\N	\N	approved	\N	3	2026-01-15 20:27:40	2026-01-15 20:27:26	2026-01-15 20:27:40
26	25	USDT	100.00	1.00000000	\N	0xc86254799b594d6e0104b52d9acf9614acea3712	TRC20	\N	\N	approved	\N	3	2026-01-26 13:58:47	2026-01-20 16:48:39	2026-01-26 13:58:47
27	44	USDT	100.00	1.00000000	\N	0xa3D7A06026F2B02d21Aab9f8823a4e9B62CB3494	TRC20	\N	\N	approved	\N	3	2026-02-07 22:20:39	2026-02-07 22:14:04	2026-02-07 22:20:39
29	31	USDT	17000.00	20.00000000	\N	Dtyyy	TRC20	\N	\N	approved	\N	3	2026-02-08 21:54:58	2026-02-08 21:54:32	2026-02-08 21:54:58
28	44	USDT	3500.00	18.50000000	\N	0xa3D7A06026F2B02d21Aab9f8823a4e9B62CB3494	TRC20	\N	\N	rejected	Withdrawal request rejected due to security concerns	3	2026-02-09 18:30:35	2026-02-07 22:40:07	2026-02-09 18:30:35
33	54	USDT	10.00	1.00000000	\N	0x224E0A425342CAC9bF01774F72B2dc96fdDA1ABF	TRC20	\N	\N	approved	\N	3	2026-02-18 18:44:25	2026-02-18 18:27:04	2026-02-18 18:44:25
34	54	USDT	10.00	1.00000000	\N	0x224E0A425342CAC9bF01774F72B2dc96fdDA1ABF	TRC20	\N	\N	rejected	Withdrawal request rejected due to security concerns	3	2026-02-18 23:35:01	2026-02-18 18:31:15	2026-02-18 23:35:01
35	57	USDT	900.00	5.50000000	\N	010674	TRC20	\N	\N	pending	\N	\N	\N	2026-02-25 12:55:36	2026-02-25 12:55:36
36	57	USDT	10.00	1.00000000	\N	18 Larpool clos	TRC20	\N	\N	pending	\N	\N	\N	2026-02-25 12:57:03	2026-02-25 12:57:03
37	53	USDT	100.00	1.00000000	\N	0x107357ea1B134AC835ddd7185F27fd2e0c075288	TRC20	\N	\N	pending	\N	\N	\N	2026-02-26 03:03:34	2026-02-26 03:03:34
38	38	USDT	10.00	1.00000000	\N	0xe05290b4724A5913010956625e1F928635A9bf72	TRC20	\N	\N	approved	\N	3	2026-02-28 02:52:29	2026-02-27 23:33:38	2026-02-28 02:52:29
39	23	USDT	184000.00	20.00000000	\N	0x294867fa71f5889e6C90dc7B3E984FDf21b3bBfd	TRC20	\N	\N	rejected	Dear Customer\n\nYour withdrawal request has been canceled because the required verification steps have not yet been completed.\n\nPlease note that withdrawals can only be processed once the verification process is successfully finalized, in accordance with our compliance and anti-money laundering policies.\n\nKindly complete the outstanding verification requirements at your earliest convenience. Once verified, you will be able to submit a new withdrawal request without issue.\n\nIf you need any assistance, please feel free to contact us.	3	2026-03-02 05:42:49	2026-03-02 05:37:44	2026-03-02 05:42:49
40	23	USDT	25000.00	20.00000000	\N	0x7E2ae1741206D98A8565988cEED0d3c85C7AeDA9	TRC20	\N	\N	rejected	Withdrawal request rejected due to security concerns	3	2026-03-02 21:08:45	2026-03-02 13:51:02	2026-03-02 21:08:45
41	65	USDT	20.00	1.00000000	\N	0×3A802E09523A595Ac9696E7B9d3f C09c7DE40c03	TRC20	\N	\N	approved	\N	3	2026-03-04 01:07:46	2026-03-04 00:30:17	2026-03-04 01:07:46
43	62	USDT	10.00	1.00000000	\N	0xC8d5C0dF295e3E9212B5f3dBa2514742E77059e0	TRC20	\N	\N	pending	\N	\N	\N	2026-03-04 17:00:04	2026-03-04 17:00:04
42	58	USDT	10.00	1.00000000	\N	0x5604dd0Dd8Ea41D8e2c772c7c3d9d4b9A0bb26c7	TRC20	\N	\N	approved	\N	3	2026-03-04 17:05:23	2026-03-04 12:19:04	2026-03-04 17:05:23
44	62	USDT	10.00	1.00000000	\N	0xC8d5C0dF295e3E9212B5f3dBa2514742E77059e0	TRC20	\N	\N	approved	\N	3	2026-03-04 17:07:00	2026-03-04 17:01:35	2026-03-04 17:07:00
45	9	USDT	110000.00	20.00000000	\N	0xe6D95966a8d93C1Bb1D69bF2FBeE20b701f90384	TRC20	\N	\N	rejected	Dear Customer,\n\n\nWe are contacting you regarding your recent withdrawal request. Please be advised that per your loan agreement, all outstanding penalties must be settled before funds can be released.\n\nWhile the principal loan amount has been repaid, there is a remaining balance for late payment fees. Based on a daily rate of 1.5\\% on the 100,000 balance over 18 days, the total penalty due is 27,000.\n\nPlease submit a screenshot of your payment confirmation once completed. Once verified, we will immediately process your withdrawal. If you have any questions, please contact our support team.	2	2026-03-24 20:35:41	2026-03-24 20:24:07	2026-03-24 20:35:41
47	78	USDT	250.00	2.25000000	\N	0xBbB5650dd65aD21beF5A2b9855d521fcaEF223b4	TRC20	\N	\N	approved	\N	3	2026-03-25 01:51:45	2026-03-25 01:50:42	2026-03-25 01:51:45
46	78	USDT	10.00	1.00000000	\N	0xBbB5650dd65aD21beF5A2b9855d521fcaEF223b4	TRC20	\N	\N	approved	\N	3	2026-03-25 01:52:12	2026-03-25 01:48:56	2026-03-25 01:52:12
48	50	USDT	10.00	1.00000000	\N	0x2cF415D896B518eAb526E2138d35d3273088bAe0	TRC20	\N	\N	rejected	Withdrawal request rejected due to security concerns	3	2026-04-21 02:20:11	2026-04-17 04:33:24	2026-04-21 02:20:11
49	78	USDT	10.00	1.00000000	\N	0xBbB5650dd65aD21beF5A2b9855d521fcaEF223b4	TRC20	\N	\N	pending	\N	\N	\N	2026-06-07 23:05:11	2026-06-07 23:05:11
50	92	USDT	282.00	2.41000000	\N	bc1qtdgf30jk0eu5w9nuceq52t0w8a8d6k26yl5kz8	TRC20	\N	\N	pending	\N	\N	\N	2026-07-15 20:32:00	2026-07-15 20:32:00
51	88	USDT	1000.00	6.00000000	\N	bc1qls5sjp5n4ywseqmz60dqx08rr96pfjcssrv6lr	TRC20	\N	\N	pending	\N	\N	\N	2026-07-19 04:28:47	2026-07-19 04:28:47
\.


--
-- Name: arbitrage_hostings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.arbitrage_hostings_id_seq', 15, true);


--
-- Name: arbitrage_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.arbitrage_products_id_seq', 10, true);


--
-- Name: assets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.assets_id_seq', 1, true);


--
-- Name: crypto_addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.crypto_addresses_id_seq', 14, true);


--
-- Name: deposits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.deposits_id_seq', 49, true);


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- Name: kyc_submissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kyc_submissions_id_seq', 31, true);


--
-- Name: loan_repayments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.loan_repayments_id_seq', 25, true);


--
-- Name: loans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.loans_id_seq', 19, true);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 1, false);


--
-- Name: mining_hostings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mining_hostings_id_seq', 11, true);


--
-- Name: mining_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mining_products_id_seq', 3, true);


--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 1, false);


--
-- Name: profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.profiles_id_seq', 95, true);


--
-- Name: support_ticket_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.support_ticket_messages_id_seq', 219, true);


--
-- Name: support_tickets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.support_tickets_id_seq', 25, true);


--
-- Name: trade_contracts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.trade_contracts_id_seq', 6, true);


--
-- Name: trade_options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.trade_options_id_seq', 465, true);


--
-- Name: trade_spots_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.trade_spots_id_seq', 1, true);


--
-- Name: trades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.trades_id_seq', 472, true);


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_id_seq', 1526, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 99, true);


--
-- Name: withdrawals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.withdrawals_id_seq', 51, true);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: arbitrage_hostings arbitrage_hostings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arbitrage_hostings
    ADD CONSTRAINT arbitrage_hostings_pkey PRIMARY KEY (id);


--
-- Name: arbitrage_products arbitrage_products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arbitrage_products
    ADD CONSTRAINT arbitrage_products_pkey PRIMARY KEY (id);


--
-- Name: assets assets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_pkey PRIMARY KEY (id);


--
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- Name: crypto_addresses crypto_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crypto_addresses
    ADD CONSTRAINT crypto_addresses_pkey PRIMARY KEY (id);


--
-- Name: deposits deposits_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deposits
    ADD CONSTRAINT deposits_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: kyc_submissions kyc_submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kyc_submissions
    ADD CONSTRAINT kyc_submissions_pkey PRIMARY KEY (id);


--
-- Name: loan_repayments loan_repayments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loan_repayments
    ADD CONSTRAINT loan_repayments_pkey PRIMARY KEY (id);


--
-- Name: loans loans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loans
    ADD CONSTRAINT loans_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: mining_hostings mining_hostings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mining_hostings
    ADD CONSTRAINT mining_hostings_pkey PRIMARY KEY (id);


--
-- Name: mining_products mining_products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mining_products
    ADD CONSTRAINT mining_products_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: support_ticket_messages support_ticket_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.support_ticket_messages
    ADD CONSTRAINT support_ticket_messages_pkey PRIMARY KEY (id);


--
-- Name: support_tickets support_tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.support_tickets
    ADD CONSTRAINT support_tickets_pkey PRIMARY KEY (id);


--
-- Name: trade_contracts trade_contracts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trade_contracts
    ADD CONSTRAINT trade_contracts_pkey PRIMARY KEY (id);


--
-- Name: trade_options trade_options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trade_options
    ADD CONSTRAINT trade_options_pkey PRIMARY KEY (id);


--
-- Name: trade_spots trade_spots_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trade_spots
    ADD CONSTRAINT trade_spots_pkey PRIMARY KEY (id);


--
-- Name: trades trades_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trades
    ADD CONSTRAINT trades_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: withdrawals withdrawals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.withdrawals
    ADD CONSTRAINT withdrawals_pkey PRIMARY KEY (id);


--
-- Name: arbitrage_hostings_product_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX arbitrage_hostings_product_id_idx ON public.arbitrage_hostings USING btree (product_id);


--
-- Name: arbitrage_hostings_user_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX arbitrage_hostings_user_id_idx ON public.arbitrage_hostings USING btree (user_id);


--
-- Name: assets_symbol_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX assets_symbol_idx ON public.assets USING btree (symbol);


--
-- Name: assets_user_id_symbol_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX assets_user_id_symbol_key ON public.assets USING btree (user_id, symbol);


--
-- Name: crypto_addresses_created_by_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX crypto_addresses_created_by_idx ON public.crypto_addresses USING btree (created_by);


--
-- Name: crypto_addresses_currency_network_is_active_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX crypto_addresses_currency_network_is_active_key ON public.crypto_addresses USING btree (currency, network, is_active);


--
-- Name: crypto_addresses_updated_by_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX crypto_addresses_updated_by_idx ON public.crypto_addresses USING btree (updated_by);


--
-- Name: deposits_processed_by_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX deposits_processed_by_idx ON public.deposits USING btree (processed_by);


--
-- Name: deposits_user_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX deposits_user_id_idx ON public.deposits USING btree (user_id);


--
-- Name: failed_jobs_uuid_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX failed_jobs_uuid_unique ON public.failed_jobs USING btree (uuid);


--
-- Name: jobs_queue_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX jobs_queue_idx ON public.jobs USING btree (queue);


--
-- Name: kyc_submissions_processed_by_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX kyc_submissions_processed_by_idx ON public.kyc_submissions USING btree (processed_by);


--
-- Name: kyc_submissions_user_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX kyc_submissions_user_id_idx ON public.kyc_submissions USING btree (user_id);


--
-- Name: loan_repayments_loan_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX loan_repayments_loan_id_idx ON public.loan_repayments USING btree (loan_id);


--
-- Name: loan_repayments_processed_by_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX loan_repayments_processed_by_idx ON public.loan_repayments USING btree (processed_by);


--
-- Name: loans_processed_by_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX loans_processed_by_idx ON public.loans USING btree (processed_by);


--
-- Name: loans_user_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX loans_user_id_idx ON public.loans USING btree (user_id);


--
-- Name: mining_hostings_product_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mining_hostings_product_id_idx ON public.mining_hostings USING btree (product_id);


--
-- Name: mining_hostings_user_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mining_hostings_user_id_idx ON public.mining_hostings USING btree (user_id);


--
-- Name: personal_access_tokens_token_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX personal_access_tokens_token_unique ON public.personal_access_tokens USING btree (token);


--
-- Name: personal_access_tokens_tokenable_type_tokenable_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_idx ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- Name: profiles_invite_code_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX profiles_invite_code_unique ON public.profiles USING btree (invite_code);


--
-- Name: profiles_user_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX profiles_user_id_idx ON public.profiles USING btree (user_id);


--
-- Name: profiles_uuid_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX profiles_uuid_unique ON public.profiles USING btree (uuid);


--
-- Name: sessions_last_activity_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_last_activity_idx ON public.sessions USING btree (last_activity);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_user_id_idx ON public.sessions USING btree (user_id);


--
-- Name: support_ticket_messages_admin_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX support_ticket_messages_admin_id_idx ON public.support_ticket_messages USING btree (admin_id);


--
-- Name: support_ticket_messages_ticket_id_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX support_ticket_messages_ticket_id_created_at_idx ON public.support_ticket_messages USING btree (ticket_id, created_at);


--
-- Name: support_ticket_messages_user_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX support_ticket_messages_user_id_idx ON public.support_ticket_messages USING btree (user_id);


--
-- Name: support_tickets_user_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX support_tickets_user_id_idx ON public.support_tickets USING btree (user_id);


--
-- Name: trade_contracts_trade_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX trade_contracts_trade_id_idx ON public.trade_contracts USING btree (trade_id);


--
-- Name: trade_options_trade_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX trade_options_trade_id_idx ON public.trade_options USING btree (trade_id);


--
-- Name: trade_spots_trade_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX trade_spots_trade_id_idx ON public.trade_spots USING btree (trade_id);


--
-- Name: trades_closed_by_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX trades_closed_by_idx ON public.trades USING btree (closed_by);


--
-- Name: trades_user_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX trades_user_id_idx ON public.trades USING btree (user_id);


--
-- Name: transactions_trade_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX transactions_trade_id_idx ON public.transactions USING btree (trade_id);


--
-- Name: transactions_user_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX transactions_user_id_idx ON public.transactions USING btree (user_id);


--
-- Name: users_email_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_email_unique ON public.users USING btree (email);


--
-- Name: users_phone_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_phone_unique ON public.users USING btree (phone);


--
-- Name: withdrawals_processed_by_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX withdrawals_processed_by_idx ON public.withdrawals USING btree (processed_by);


--
-- Name: withdrawals_user_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX withdrawals_user_id_idx ON public.withdrawals USING btree (user_id);


--
-- Name: arbitrage_hostings arbitrage_hostings_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arbitrage_hostings
    ADD CONSTRAINT arbitrage_hostings_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.arbitrage_products(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: arbitrage_hostings arbitrage_hostings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arbitrage_hostings
    ADD CONSTRAINT arbitrage_hostings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: assets assets_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: crypto_addresses crypto_addresses_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crypto_addresses
    ADD CONSTRAINT crypto_addresses_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- Name: crypto_addresses crypto_addresses_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crypto_addresses
    ADD CONSTRAINT crypto_addresses_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- Name: deposits deposits_processed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deposits
    ADD CONSTRAINT deposits_processed_by_fkey FOREIGN KEY (processed_by) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- Name: deposits deposits_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deposits
    ADD CONSTRAINT deposits_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: kyc_submissions kyc_submissions_processed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kyc_submissions
    ADD CONSTRAINT kyc_submissions_processed_by_fkey FOREIGN KEY (processed_by) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- Name: kyc_submissions kyc_submissions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kyc_submissions
    ADD CONSTRAINT kyc_submissions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: loan_repayments loan_repayments_loan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loan_repayments
    ADD CONSTRAINT loan_repayments_loan_id_fkey FOREIGN KEY (loan_id) REFERENCES public.loans(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: loan_repayments loan_repayments_processed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loan_repayments
    ADD CONSTRAINT loan_repayments_processed_by_fkey FOREIGN KEY (processed_by) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- Name: loans loans_processed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loans
    ADD CONSTRAINT loans_processed_by_fkey FOREIGN KEY (processed_by) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- Name: loans loans_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loans
    ADD CONSTRAINT loans_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: mining_hostings mining_hostings_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mining_hostings
    ADD CONSTRAINT mining_hostings_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.mining_products(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: mining_hostings mining_hostings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mining_hostings
    ADD CONSTRAINT mining_hostings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: profiles profiles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: support_ticket_messages support_ticket_messages_admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.support_ticket_messages
    ADD CONSTRAINT support_ticket_messages_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- Name: support_ticket_messages support_ticket_messages_ticket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.support_ticket_messages
    ADD CONSTRAINT support_ticket_messages_ticket_id_fkey FOREIGN KEY (ticket_id) REFERENCES public.support_tickets(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: support_ticket_messages support_ticket_messages_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.support_ticket_messages
    ADD CONSTRAINT support_ticket_messages_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- Name: support_tickets support_tickets_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.support_tickets
    ADD CONSTRAINT support_tickets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: trade_contracts trade_contracts_trade_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trade_contracts
    ADD CONSTRAINT trade_contracts_trade_id_fkey FOREIGN KEY (trade_id) REFERENCES public.trades(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: trade_options trade_options_trade_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trade_options
    ADD CONSTRAINT trade_options_trade_id_fkey FOREIGN KEY (trade_id) REFERENCES public.trades(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: trade_spots trade_spots_trade_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trade_spots
    ADD CONSTRAINT trade_spots_trade_id_fkey FOREIGN KEY (trade_id) REFERENCES public.trades(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: trades trades_closed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trades
    ADD CONSTRAINT trades_closed_by_fkey FOREIGN KEY (closed_by) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: trades trades_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trades
    ADD CONSTRAINT trades_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: transactions transactions_trade_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_trade_id_fkey FOREIGN KEY (trade_id) REFERENCES public.trades(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- Name: transactions transactions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: withdrawals withdrawals_processed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.withdrawals
    ADD CONSTRAINT withdrawals_processed_by_fkey FOREIGN KEY (processed_by) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- Name: withdrawals withdrawals_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.withdrawals
    ADD CONSTRAINT withdrawals_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict PhCJ2eAfuRmfMGVahj4E7zDV1xvcZknfOnRLU0L2Xm3JfnmJmcSqyXhVSW1tkgC

