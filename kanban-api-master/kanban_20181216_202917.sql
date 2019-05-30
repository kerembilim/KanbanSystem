--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5
-- Dumped by pg_dump version 11.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: getfile(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getfile(iid integer) RETURNS TABLE(keyy character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT "key" from "File" where id=iid;
END;
$$;


ALTER FUNCTION public.getfile(iid integer) OWNER TO postgres;

--
-- Name: getrole(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getrole(useridd integer) RETURNS TABLE(userid integer, roleid integer, projectid integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY select "public"."UserRole"."userId","public"."UserRole"."roleId","public"."UserRole"."projectId" from "public"."UserRole" where "public"."UserRole"."userId"=useridd;
END;
$$;


ALTER FUNCTION public.getrole(useridd integer) OWNER TO postgres;

--
-- Name: postrole(integer, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.postrole(id integer, useridd integer, roleid integer, projectid integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO "UserRole" VALUES (id,useridd, roleid, projectid);
    return true;
    
END;
$$;


ALTER FUNCTION public.postrole(id integer, useridd integer, roleid integer, projectid integer) OWNER TO postgres;

--
-- Name: returnscore(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.returnscore(userid integer) RETURNS TABLE(score integer, username character varying, projectname character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT   
         "public"."ScoreInProject"."score",
         "public"."User"."name",
         "public"."Project"."name"
         FROM     "public"."ScoreInProject"
         INNER JOIN "public"."User" ON "public"."ScoreInProject"."userId" = "public"."User"."id" 
         INNER JOIN "public"."Project"  ON "public"."ScoreInProject"."projectId" = "public"."Project"."id" where "public"."User"."id"=userid;
END;
$$;


ALTER FUNCTION public.returnscore(userid integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Comment" (
    id integer NOT NULL,
    "issueId" integer,
    "userId" integer,
    content character varying
);


ALTER TABLE public."Comment" OWNER TO postgres;

--
-- Name: Comment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Comment_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Comment_id_seq" OWNER TO postgres;

--
-- Name: Comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Comment_id_seq" OWNED BY public."Comment".id;


--
-- Name: File; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."File" (
    id integer NOT NULL,
    key character varying
);


ALTER TABLE public."File" OWNER TO postgres;

--
-- Name: FileIssue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."FileIssue" (
    id integer NOT NULL,
    "fileId" integer,
    "issueId" integer
);


ALTER TABLE public."FileIssue" OWNER TO postgres;

--
-- Name: FileIssue_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."FileIssue_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."FileIssue_id_seq" OWNER TO postgres;

--
-- Name: FileIssue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."FileIssue_id_seq" OWNED BY public."FileIssue".id;


--
-- Name: File_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."File_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."File_id_seq" OWNER TO postgres;

--
-- Name: File_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."File_id_seq" OWNED BY public."File".id;


--
-- Name: Issue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Issue" (
    id integer NOT NULL,
    title character varying,
    description character varying,
    "userId" integer,
    "priorityId" integer,
    "statuId" integer,
    deadline date,
    "listId" integer,
    "projectId" integer
);


ALTER TABLE public."Issue" OWNER TO postgres;

--
-- Name: IssueState; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."IssueState" (
    id integer NOT NULL,
    title character varying(40) NOT NULL
);


ALTER TABLE public."IssueState" OWNER TO postgres;

--
-- Name: IssueState_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."IssueState_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."IssueState_id_seq" OWNER TO postgres;

--
-- Name: IssueState_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."IssueState_id_seq" OWNED BY public."IssueState".id;


--
-- Name: Issue_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Issue_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Issue_id_seq" OWNER TO postgres;

--
-- Name: Issue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Issue_id_seq" OWNED BY public."Issue".id;


--
-- Name: List; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."List" (
    id integer NOT NULL,
    name character varying,
    "userId" integer
);


ALTER TABLE public."List" OWNER TO postgres;

--
-- Name: List_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."List_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."List_id_seq" OWNER TO postgres;

--
-- Name: List_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."List_id_seq" OWNED BY public."List".id;


--
-- Name: Priority; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Priority" (
    id integer NOT NULL
);


ALTER TABLE public."Priority" OWNER TO postgres;

--
-- Name: Priority_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Priority_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Priority_id_seq" OWNER TO postgres;

--
-- Name: Priority_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Priority_id_seq" OWNED BY public."Priority".id;


--
-- Name: Project; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Project" (
    id integer NOT NULL,
    name character varying,
    description character varying
);


ALTER TABLE public."Project" OWNER TO postgres;

--
-- Name: Project_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Project_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Project_id_seq" OWNER TO postgres;

--
-- Name: Project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Project_id_seq" OWNED BY public."Project".id;


--
-- Name: Role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Role" (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE public."Role" OWNER TO postgres;

--
-- Name: Role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Role_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Role_id_seq" OWNER TO postgres;

--
-- Name: Role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Role_id_seq" OWNED BY public."Role".id;


--
-- Name: ScoreInProject; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ScoreInProject" (
    id integer NOT NULL,
    "userId" integer,
    "projectId" integer,
    score integer NOT NULL
);


ALTER TABLE public."ScoreInProject" OWNER TO postgres;

--
-- Name: ScoreInProject_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ScoreInProject_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ScoreInProject_id_seq" OWNER TO postgres;

--
-- Name: ScoreInProject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ScoreInProject_id_seq" OWNED BY public."ScoreInProject".id;


--
-- Name: Statu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Statu" (
    id integer NOT NULL
);


ALTER TABLE public."Statu" OWNER TO postgres;

--
-- Name: Statu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Statu_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Statu_id_seq" OWNER TO postgres;

--
-- Name: Statu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Statu_id_seq" OWNED BY public."Statu".id;


--
-- Name: Team; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Team" (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE public."Team" OWNER TO postgres;

--
-- Name: TeamProject; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TeamProject" (
    id integer NOT NULL,
    "teamId" integer,
    "projectId" integer
);


ALTER TABLE public."TeamProject" OWNER TO postgres;

--
-- Name: TeamProject_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."TeamProject_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."TeamProject_id_seq" OWNER TO postgres;

--
-- Name: TeamProject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."TeamProject_id_seq" OWNED BY public."TeamProject".id;


--
-- Name: Team_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Team_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Team_id_seq" OWNER TO postgres;

--
-- Name: Team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Team_id_seq" OWNED BY public."Team".id;


--
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    id integer NOT NULL,
    name character varying NOT NULL,
    password character varying,
    "teamId" integer,
    "userPhotoId" integer
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- Name: UserRole; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserRole" (
    id integer NOT NULL,
    "userId" integer,
    "roleId" integer,
    "projectId" integer
);


ALTER TABLE public."UserRole" OWNER TO postgres;

--
-- Name: UserRole_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."UserRole_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."UserRole_id_seq" OWNER TO postgres;

--
-- Name: UserRole_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."UserRole_id_seq" OWNED BY public."UserRole".id;


--
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."User_id_seq" OWNER TO postgres;

--
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- Name: Comment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comment" ALTER COLUMN id SET DEFAULT nextval('public."Comment_id_seq"'::regclass);


--
-- Name: File id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."File" ALTER COLUMN id SET DEFAULT nextval('public."File_id_seq"'::regclass);


--
-- Name: FileIssue id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FileIssue" ALTER COLUMN id SET DEFAULT nextval('public."FileIssue_id_seq"'::regclass);


--
-- Name: Issue id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Issue" ALTER COLUMN id SET DEFAULT nextval('public."Issue_id_seq"'::regclass);


--
-- Name: IssueState id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."IssueState" ALTER COLUMN id SET DEFAULT nextval('public."IssueState_id_seq"'::regclass);


--
-- Name: List id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."List" ALTER COLUMN id SET DEFAULT nextval('public."List_id_seq"'::regclass);


--
-- Name: Priority id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Priority" ALTER COLUMN id SET DEFAULT nextval('public."Priority_id_seq"'::regclass);


--
-- Name: Project id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Project" ALTER COLUMN id SET DEFAULT nextval('public."Project_id_seq"'::regclass);


--
-- Name: Role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Role" ALTER COLUMN id SET DEFAULT nextval('public."Role_id_seq"'::regclass);


--
-- Name: ScoreInProject id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ScoreInProject" ALTER COLUMN id SET DEFAULT nextval('public."ScoreInProject_id_seq"'::regclass);


--
-- Name: Statu id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Statu" ALTER COLUMN id SET DEFAULT nextval('public."Statu_id_seq"'::regclass);


--
-- Name: Team id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Team" ALTER COLUMN id SET DEFAULT nextval('public."Team_id_seq"'::regclass);


--
-- Name: TeamProject id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TeamProject" ALTER COLUMN id SET DEFAULT nextval('public."TeamProject_id_seq"'::regclass);


--
-- Name: User id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- Name: UserRole id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRole" ALTER COLUMN id SET DEFAULT nextval('public."UserRole_id_seq"'::regclass);


--
-- Data for Name: Comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Comment" VALUES (5, 3, 1, 'yorum');


--
-- Data for Name: File; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."File" VALUES (1, 'www.wasd');


--
-- Data for Name: FileIssue; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Issue; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Issue" VALUES (3, 'asd', 'asd', 1, 1, 1, '2010-10-10', NULL, NULL);
INSERT INTO public."Issue" VALUES (4, 'title', 'description', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Issue" VALUES (5, 'title', 'description', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Issue" VALUES (6, 'title', 'description', 1, 1, 1, NULL, 1, NULL);
INSERT INTO public."Issue" VALUES (8, 'issuebaslik', 'description', 17, 1, 1, '2018-12-15', 1, NULL);
INSERT INTO public."Issue" VALUES (9, 'issuebaslik', 'description', 17, 1, 1, '2018-12-15', 1, NULL);
INSERT INTO public."Issue" VALUES (10, 'issuebaslik', 'description', 17, 1, 1, '2018-12-24', 1, NULL);
INSERT INTO public."Issue" VALUES (11, 'issuebaslik', 'description', 17, 1, 1, '2018-12-15', 1, NULL);
INSERT INTO public."Issue" VALUES (12, 'issuebaslik', 'description', 17, 1, 1, '2018-12-15', 1, NULL);
INSERT INTO public."Issue" VALUES (13, 'issuebaslik', 'description', 17, 1, 1, '2018-12-15', 1, NULL);
INSERT INTO public."Issue" VALUES (14, 'issuebaslik', 'description', 17, 1, 1, '2018-12-15', 1, NULL);
INSERT INTO public."Issue" VALUES (17, 'issuebaslik', 'description', 17, 1, 1, '2018-12-22', 1, NULL);
INSERT INTO public."Issue" VALUES (18, 'title', 'description', 1, 1, 1, '2018-12-23', 1, NULL);
INSERT INTO public."Issue" VALUES (15, 'issuebaslik', 'description', 17, 2, 1, '2018-12-17', 1, NULL);
INSERT INTO public."Issue" VALUES (16, 'issuebaslik', 'description', 17, 2, 1, '2018-12-16', 1, NULL);


--
-- Data for Name: IssueState; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."IssueState" VALUES (1, 'çok önemli');
INSERT INTO public."IssueState" VALUES (2, 'önemli');
INSERT INTO public."IssueState" VALUES (3, 'az önemli');
INSERT INTO public."IssueState" VALUES (4, 'önemli değil');
INSERT INTO public."IssueState" VALUES (5, 'todo');
INSERT INTO public."IssueState" VALUES (6, 'progress');
INSERT INTO public."IssueState" VALUES (7, 'done');


--
-- Data for Name: List; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."List" VALUES (1, 'progress', 1);


--
-- Data for Name: Priority; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Priority" VALUES (1);
INSERT INTO public."Priority" VALUES (2);
INSERT INTO public."Priority" VALUES (3);


--
-- Data for Name: Project; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Project" VALUES (1, 'project1', 'guzel proje he');
INSERT INTO public."Project" VALUES (4, NULL, NULL);
INSERT INTO public."Project" VALUES (6, NULL, NULL);
INSERT INTO public."Project" VALUES (7, 'project1', 'guzel proje he');
INSERT INTO public."Project" VALUES (5, 'project1', 'guzel proje he');


--
-- Data for Name: Role; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Role" VALUES (1, 'admin');


--
-- Data for Name: ScoreInProject; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."ScoreInProject" VALUES (1, 17, 5, 5);


--
-- Data for Name: Statu; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Statu" VALUES (5);
INSERT INTO public."Statu" VALUES (6);
INSERT INTO public."Statu" VALUES (7);


--
-- Data for Name: Team; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Team" VALUES (2, 'teamb');
INSERT INTO public."Team" VALUES (3, 'abc');
INSERT INTO public."Team" VALUES (4, 'new team');


--
-- Data for Name: TeamProject; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."TeamProject" VALUES (1, 2, 5);


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."User" VALUES (17, 'keremb', '1234567', 2, NULL);
INSERT INTO public."User" VALUES (19, 'kerem.bilim-68cb4b', '123456', 2, NULL);
INSERT INTO public."User" VALUES (20, 'kerem.bilim-68cb4', '123456', 2, NULL);
INSERT INTO public."User" VALUES (22, 'keremmm', '213123123', 2, NULL);
INSERT INTO public."User" VALUES (25, 'keremm', '213123123', 2, NULL);
INSERT INTO public."User" VALUES (27, 'keremmmmmmmm', '213123123', 2, NULL);
INSERT INTO public."User" VALUES (29, 'keremmmmmmmmmm', '213123123', 2, NULL);
INSERT INTO public."User" VALUES (30, 'keremmmmmmmmmmmm', '213123123', 2, NULL);
INSERT INTO public."User" VALUES (32, 'keremmmmmmmmmmmmm', '213123123', 2, NULL);
INSERT INTO public."User" VALUES (33, 'keremmmmmmmmmmmmmm', '213123123', 2, NULL);
INSERT INTO public."User" VALUES (34, 'keremmmmmmmmmmmmmmm', '213123123', 2, 1);
INSERT INTO public."User" VALUES (1, 'kerembilim', '123456', 3, NULL);


--
-- Data for Name: UserRole; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."UserRole" VALUES (1, 34, 1, 1);
INSERT INTO public."UserRole" VALUES (2, 1, 1, NULL);
INSERT INTO public."UserRole" VALUES (3, 17, 1, 1);
INSERT INTO public."UserRole" VALUES (4, 34, 1, 1);
INSERT INTO public."UserRole" VALUES (5, 34, 1, 1);
INSERT INTO public."UserRole" VALUES (6, 34, 1, 1);


--
-- Name: Comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Comment_id_seq"', 5, true);


--
-- Name: FileIssue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."FileIssue_id_seq"', 1, false);


--
-- Name: File_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."File_id_seq"', 1, true);


--
-- Name: IssueState_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."IssueState_id_seq"', 1, true);


--
-- Name: Issue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Issue_id_seq"', 18, true);


--
-- Name: List_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."List_id_seq"', 1, true);


--
-- Name: Priority_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Priority_id_seq"', 1, false);


--
-- Name: Project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Project_id_seq"', 7, true);


--
-- Name: Role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Role_id_seq"', 1, true);


--
-- Name: ScoreInProject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ScoreInProject_id_seq"', 1, true);


--
-- Name: Statu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Statu_id_seq"', 1, false);


--
-- Name: TeamProject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."TeamProject_id_seq"', 1, true);


--
-- Name: Team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Team_id_seq"', 4, true);


--
-- Name: UserRole_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."UserRole_id_seq"', 1, true);


--
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."User_id_seq"', 34, true);


--
-- Name: FileIssue FileIssuePK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FileIssue"
    ADD CONSTRAINT "FileIssuePK" PRIMARY KEY (id);


--
-- Name: File FilePK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."File"
    ADD CONSTRAINT "FilePK" PRIMARY KEY (id);


--
-- Name: Issue IssuePK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Issue"
    ADD CONSTRAINT "IssuePK" PRIMARY KEY (id);


--
-- Name: IssueState IssueState1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."IssueState"
    ADD CONSTRAINT "IssueState1" PRIMARY KEY (id);


--
-- Name: List ListPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."List"
    ADD CONSTRAINT "ListPK" PRIMARY KEY (id);


--
-- Name: Comment ListPK1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comment"
    ADD CONSTRAINT "ListPK1" PRIMARY KEY (id);


--
-- Name: Priority PriorityPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Priority"
    ADD CONSTRAINT "PriorityPK" PRIMARY KEY (id);


--
-- Name: Project ProjectPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Project"
    ADD CONSTRAINT "ProjectPK" PRIMARY KEY (id);


--
-- Name: Role ROLEPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Role"
    ADD CONSTRAINT "ROLEPK" PRIMARY KEY (id);


--
-- Name: ScoreInProject ScoreInProjectPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ScoreInProject"
    ADD CONSTRAINT "ScoreInProjectPK" PRIMARY KEY (id);


--
-- Name: Statu StatuPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Statu"
    ADD CONSTRAINT "StatuPK" PRIMARY KEY (id);


--
-- Name: Team TeamPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Team"
    ADD CONSTRAINT "TeamPK" PRIMARY KEY (id);


--
-- Name: TeamProject TeamProjectPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TeamProject"
    ADD CONSTRAINT "TeamProjectPK" PRIMARY KEY (id);


--
-- Name: User UserPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "UserPK" PRIMARY KEY (id);


--
-- Name: UserRole UserRolePK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRolePK" PRIMARY KEY (id);


--
-- Name: User unique_User_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "unique_User_name" UNIQUE (name);


--
-- Name: FileIssue FileIssueFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FileIssue"
    ADD CONSTRAINT "FileIssueFK" FOREIGN KEY ("fileId") REFERENCES public."File"(id);


--
-- Name: FileIssue FileIssueFK1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FileIssue"
    ADD CONSTRAINT "FileIssueFK1" FOREIGN KEY ("issueId") REFERENCES public."Issue"(id);


--
-- Name: Issue IssueFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Issue"
    ADD CONSTRAINT "IssueFK" FOREIGN KEY ("userId") REFERENCES public."User"(id);


--
-- Name: Issue IssueFK3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Issue"
    ADD CONSTRAINT "IssueFK3" FOREIGN KEY ("listId") REFERENCES public."List"(id);


--
-- Name: List ListFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."List"
    ADD CONSTRAINT "ListFK" FOREIGN KEY ("userId") REFERENCES public."User"(id);


--
-- Name: Comment ListFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comment"
    ADD CONSTRAINT "ListFK" FOREIGN KEY ("userId") REFERENCES public."User"(id);


--
-- Name: Comment ListFK2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comment"
    ADD CONSTRAINT "ListFK2" FOREIGN KEY ("issueId") REFERENCES public."Issue"(id);


--
-- Name: ScoreInProject ScoreInProjectFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ScoreInProject"
    ADD CONSTRAINT "ScoreInProjectFK" FOREIGN KEY ("userId") REFERENCES public."User"(id);


--
-- Name: ScoreInProject ScoreInProjectFK1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ScoreInProject"
    ADD CONSTRAINT "ScoreInProjectFK1" FOREIGN KEY ("projectId") REFERENCES public."Project"(id);


--
-- Name: Priority StatuIssue; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Priority"
    ADD CONSTRAINT "StatuIssue" FOREIGN KEY (id) REFERENCES public."IssueState"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Statu StatuIssue; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Statu"
    ADD CONSTRAINT "StatuIssue" FOREIGN KEY (id) REFERENCES public."IssueState"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: TeamProject TeamProjectFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TeamProject"
    ADD CONSTRAINT "TeamProjectFK" FOREIGN KEY ("teamId") REFERENCES public."Team"(id);


--
-- Name: TeamProject TeamProjectFK1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TeamProject"
    ADD CONSTRAINT "TeamProjectFK1" FOREIGN KEY ("projectId") REFERENCES public."Project"(id);


--
-- Name: User UserFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "UserFK" FOREIGN KEY ("teamId") REFERENCES public."Team"(id);


--
-- Name: User UserFK1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "UserFK1" FOREIGN KEY ("userPhotoId") REFERENCES public."File"(id);


--
-- Name: UserRole UserRoleFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRoleFK" FOREIGN KEY ("userId") REFERENCES public."User"(id);


--
-- Name: UserRole UserRoleFK1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRoleFK1" FOREIGN KEY ("roleId") REFERENCES public."Role"(id);


--
-- Name: UserRole UserRoleFK2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRoleFK2" FOREIGN KEY ("projectId") REFERENCES public."Project"(id);


--
-- Name: Issue issueFK2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Issue"
    ADD CONSTRAINT "issueFK2" FOREIGN KEY ("projectId") REFERENCES public."Project"(id);


--
-- PostgreSQL database dump complete
--

