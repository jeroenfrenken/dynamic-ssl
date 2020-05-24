-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS domains_id_seq;

-- Table Definition
CREATE TABLE "public"."domains" (
    "id" int4 NOT NULL DEFAULT nextval('domains_id_seq'::regclass),
    "domain" varchar NOT NULL,
    "ssl_verified" bool NOT NULL DEFAULT false,
    "certificate" text,
    "private_key" text,
    PRIMARY KEY ("id")
);

INSERT INTO "public"."domains" ("id", "domain", "ssl_verified", "certificate", "private_key") VALUES
('1', 'localhost', 'f', NULL, NULL);
