﻿-- Script generated by Redgate Compare v1.23.0.23969
SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.bank_tags_tag_id_seq...';END$$;
CREATE SEQUENCE public.bank_tags_tag_id_seq
AS integer
INCREMENT BY 1
MINVALUE 1
MAXVALUE 2147483647
START 1
CACHE 1
NO CYCLE;
ALTER SEQUENCE public.bank_tags_tag_id_seq OWNER TO postgres;

SET check_function_bodies = true;
