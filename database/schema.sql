--
-- PostgreSQL database dump
--

\restrict 4R3Nm5whJqaXyTI1JCJXsx5yAWp9DewcyHu9a7dcl23YCsGFLIQliSogSigbCIS

-- Dumped from database version 16.14
-- Dumped by pg_dump version 16.14

-- Started on 2026-06-27 02:55:49

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
-- TOC entry 224 (class 1259 OID 16616)
-- Name: churn_prediction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.churn_prediction (
    churn_id integer NOT NULL,
    investor_id integer NOT NULL,
    age integer NOT NULL,
    risk_profile character varying(20),
    aum numeric(15,2) NOT NULL,
    inactive_days integer NOT NULL,
    churn_probability numeric(5,2),
    churn_status character varying(15),
    CONSTRAINT churn_prediction_aum_check CHECK ((aum >= (0)::numeric)),
    CONSTRAINT churn_prediction_churn_probability_check CHECK (((churn_probability >= (0)::numeric) AND (churn_probability <= (100)::numeric))),
    CONSTRAINT churn_prediction_churn_status_check CHECK (((churn_status)::text = ANY ((ARRAY['LOW'::character varying, 'MEDIUM'::character varying, 'HIGH'::character varying])::text[]))),
    CONSTRAINT churn_prediction_inactive_days_check CHECK ((inactive_days >= 0)),
    CONSTRAINT churn_prediction_risk_profile_check CHECK (((risk_profile)::text = ANY ((ARRAY['Low'::character varying, 'Medium'::character varying, 'High'::character varying])::text[])))
);


ALTER TABLE public.churn_prediction OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16615)
-- Name: churn_prediction_churn_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.churn_prediction_churn_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.churn_prediction_churn_id_seq OWNER TO postgres;

--
-- TOC entry 4934 (class 0 OID 0)
-- Dependencies: 223
-- Name: churn_prediction_churn_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.churn_prediction_churn_id_seq OWNED BY public.churn_prediction.churn_id;


--
-- TOC entry 218 (class 1259 OID 16523)
-- Name: fund_performance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fund_performance (
    performance_id integer NOT NULL,
    fund_id integer NOT NULL,
    as_of_date date NOT NULL,
    return_6m numeric(6,2),
    return_9m numeric(6,2),
    return_12m numeric(6,2),
    benchmark_6m numeric(6,2),
    benchmark_9m numeric(6,2),
    benchmark_12m numeric(6,2),
    diff_6m numeric(6,2),
    diff_9m numeric(6,2),
    diff_12m numeric(6,2)
);


ALTER TABLE public.fund_performance OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16522)
-- Name: fund_performance_performance_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fund_performance_performance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fund_performance_performance_id_seq OWNER TO postgres;

--
-- TOC entry 4935 (class 0 OID 0)
-- Dependencies: 217
-- Name: fund_performance_performance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fund_performance_performance_id_seq OWNED BY public.fund_performance.performance_id;


--
-- TOC entry 216 (class 1259 OID 16484)
-- Name: funds; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.funds (
    fund_id integer NOT NULL,
    scheme_code bigint,
    scheme_name text,
    amc text,
    scheme_type text,
    scheme_category text,
    scheme_nav_name text,
    scheme_min_amt text,
    nav text,
    latest_nav_date text,
    average_aum_cr text,
    aaum_quarter text,
    isin_div_growth text,
    isin_div_reinvestment text,
    isin_combined text,
    launch_date text,
    closure_date text,
    investment_mode character varying(20)
);


ALTER TABLE public.funds OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16483)
-- Name: funds_fund_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.funds_fund_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.funds_fund_id_seq OWNER TO postgres;

--
-- TOC entry 4936 (class 0 OID 0)
-- Dependencies: 215
-- Name: funds_fund_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.funds_fund_id_seq OWNED BY public.funds.fund_id;


--
-- TOC entry 220 (class 1259 OID 16585)
-- Name: investors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.investors (
    investor_id integer NOT NULL,
    name character varying(100),
    age integer,
    age_group character varying(20),
    city character varying(50),
    state_region character varying(50),
    risk_profile character varying(20),
    join_date date DEFAULT CURRENT_DATE,
    annual_income numeric(12,2),
    occupation character varying(100),
    total_invested numeric(12,2) DEFAULT 0
);


ALTER TABLE public.investors OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16584)
-- Name: investors_investor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.investors_investor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.investors_investor_id_seq OWNER TO postgres;

--
-- TOC entry 4937 (class 0 OID 0)
-- Dependencies: 219
-- Name: investors_investor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.investors_investor_id_seq OWNED BY public.investors.investor_id;


--
-- TOC entry 222 (class 1259 OID 16593)
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    transaction_id integer NOT NULL,
    investor_id integer NOT NULL,
    fund_id integer NOT NULL,
    transaction_type character varying(15) NOT NULL,
    amount numeric(15,2) NOT NULL,
    units numeric(15,4) NOT NULL,
    nav_at_transaction numeric(10,4) NOT NULL,
    transaction_date date NOT NULL,
    transaction_status character varying(15) DEFAULT 'COMPLETED'::character varying,
    payment_mode character varying(20),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    sip_due_date date,
    CONSTRAINT transactions_payment_mode_check CHECK (((payment_mode)::text = ANY ((ARRAY['UPI'::character varying, 'NET_BANKING'::character varying, 'DEBIT_CARD'::character varying, 'CREDIT_CARD'::character varying, 'CHEQUE'::character varying, 'NEFT'::character varying, 'RTGS'::character varying])::text[]))),
    CONSTRAINT transactions_transaction_status_check CHECK (((transaction_status)::text = ANY ((ARRAY['PENDING'::character varying, 'COMPLETED'::character varying, 'FAILED'::character varying, 'CANCELLED'::character varying])::text[]))),
    CONSTRAINT transactions_transaction_type_check CHECK (((transaction_type)::text = ANY ((ARRAY['BUY'::character varying, 'SELL'::character varying, 'SIP'::character varying, 'LUMPSUM'::character varying, 'REDEEM'::character varying])::text[])))
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16592)
-- Name: transactions_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transactions_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transactions_transaction_id_seq OWNER TO postgres;

--
-- TOC entry 4938 (class 0 OID 0)
-- Dependencies: 221
-- Name: transactions_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transactions_transaction_id_seq OWNED BY public.transactions.transaction_id;


--
-- TOC entry 4763 (class 2604 OID 16619)
-- Name: churn_prediction churn_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.churn_prediction ALTER COLUMN churn_id SET DEFAULT nextval('public.churn_prediction_churn_id_seq'::regclass);


--
-- TOC entry 4756 (class 2604 OID 16526)
-- Name: fund_performance performance_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fund_performance ALTER COLUMN performance_id SET DEFAULT nextval('public.fund_performance_performance_id_seq'::regclass);


--
-- TOC entry 4755 (class 2604 OID 16487)
-- Name: funds fund_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funds ALTER COLUMN fund_id SET DEFAULT nextval('public.funds_fund_id_seq'::regclass);


--
-- TOC entry 4757 (class 2604 OID 16588)
-- Name: investors investor_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.investors ALTER COLUMN investor_id SET DEFAULT nextval('public.investors_investor_id_seq'::regclass);


--
-- TOC entry 4760 (class 2604 OID 16596)
-- Name: transactions transaction_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions ALTER COLUMN transaction_id SET DEFAULT nextval('public.transactions_transaction_id_seq'::regclass);


--
-- TOC entry 4781 (class 2606 OID 16626)
-- Name: churn_prediction churn_prediction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.churn_prediction
    ADD CONSTRAINT churn_prediction_pkey PRIMARY KEY (churn_id);


--
-- TOC entry 4775 (class 2606 OID 16528)
-- Name: fund_performance fund_performance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fund_performance
    ADD CONSTRAINT fund_performance_pkey PRIMARY KEY (performance_id);


--
-- TOC entry 4773 (class 2606 OID 16491)
-- Name: funds funds_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funds
    ADD CONSTRAINT funds_pkey PRIMARY KEY (fund_id);


--
-- TOC entry 4777 (class 2606 OID 16591)
-- Name: investors investors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.investors
    ADD CONSTRAINT investors_pkey PRIMARY KEY (investor_id);


--
-- TOC entry 4779 (class 2606 OID 16603)
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (transaction_id);


--
-- TOC entry 4785 (class 2606 OID 16627)
-- Name: churn_prediction churn_prediction_investor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.churn_prediction
    ADD CONSTRAINT churn_prediction_investor_id_fkey FOREIGN KEY (investor_id) REFERENCES public.investors(investor_id);


--
-- TOC entry 4782 (class 2606 OID 16529)
-- Name: fund_performance fund_performance_fund_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fund_performance
    ADD CONSTRAINT fund_performance_fund_id_fkey FOREIGN KEY (fund_id) REFERENCES public.funds(fund_id);


--
-- TOC entry 4783 (class 2606 OID 16609)
-- Name: transactions transactions_fund_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_fund_id_fkey FOREIGN KEY (fund_id) REFERENCES public.funds(fund_id);


--
-- TOC entry 4784 (class 2606 OID 16604)
-- Name: transactions transactions_investor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_investor_id_fkey FOREIGN KEY (investor_id) REFERENCES public.investors(investor_id);


-- Completed on 2026-06-27 02:55:49

--
-- PostgreSQL database dump complete
--

\unrestrict 4R3Nm5whJqaXyTI1JCJXsx5yAWp9DewcyHu9a7dcl23YCsGFLIQliSogSigbCIS

