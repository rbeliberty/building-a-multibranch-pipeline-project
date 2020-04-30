DROP TABLE IF EXISTS "associations";
DROP SEQUENCE IF EXISTS associations_id_seq;
CREATE SEQUENCE associations_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."associations" (
    "id" integer DEFAULT nextval('associations_id_seq') NOT NULL,
    "snapshot_id" character varying,
    "clone_id" character varying,
    "change_author" character varying,
    "branch_name" character varying,
    "change_target" character varying,
    "change_branch" character varying,
    "created_at" date,
    "repo_name" character varying,
    "port" smallint,
    CONSTRAINT "associations_id_uindex" UNIQUE ("id"),
    CONSTRAINT "associations_pk" PRIMARY KEY ("id")
) WITH (oids = false);

TRUNCATE "associations";