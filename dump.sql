BEGIN;

-- Schema migrations
CREATE TABLE IF NOT EXISTS "schema_migrations" (
    "version" varchar NOT NULL PRIMARY KEY
);
INSERT INTO schema_migrations VALUES ('20240827071105');
INSERT INTO schema_migrations VALUES ('20240827074014');

-- Metadata table
CREATE TABLE IF NOT EXISTS "ar_internal_metadata" (
    "key" varchar NOT NULL PRIMARY KEY,
    "value" varchar,
    "created_at" timestamp NOT NULL,
    "updated_at" timestamp NOT NULL
);
INSERT INTO ar_internal_metadata VALUES ('environment', 'development', '2024-11-14 21:11:59.940678', '2024-11-14 21:11:59.940685');

-- Admins table
CREATE TABLE IF NOT EXISTS "admins" (
    "id" SERIAL PRIMARY KEY,
    "email" varchar NOT NULL DEFAULT '',
    "encrypted_password" varchar NOT NULL DEFAULT '',
    "reset_password_token" varchar,
    "reset_password_sent_at" timestamp,
    "remember_created_at" timestamp,
    "created_at" timestamp NOT NULL,
    "updated_at" timestamp NOT NULL
);
INSERT INTO admins (id, email, encrypted_password, created_at, updated_at)
VALUES (1, 'admin123@gmail.com', '$2a$12$.uS4d7qoMIgmGGiUcack6uY/xB6VMHUVkkIKOph7wq5tT7V7tD6na', '2024-11-18 17:15:07.733343', '2024-11-18 17:15:07.733343');

-- Colors table
CREATE TABLE IF NOT EXISTS "colors" (
    "id" SERIAL PRIMARY KEY,
    "name" varchar NOT NULL,
    "created_at" timestamp NOT NULL,
    "updated_at" timestamp NOT NULL
);

-- Products table
CREATE TABLE IF NOT EXISTS "products" (
    "id" SERIAL PRIMARY KEY,
    "name" varchar NOT NULL,
    "price" decimal NOT NULL,
    "created_at" timestamp NOT NULL,
    "updated_at" timestamp NOT NULL
);

-- Paint colors table
CREATE TABLE IF NOT EXISTS "paint_colors" (
    "id" SERIAL PRIMARY KEY,
    "name" varchar NOT NULL,
    "hex_code" varchar NOT NULL,
    "created_at" timestamp NOT NULL,
    "updated_at" timestamp NOT NULL
);

-- Primary colors table
CREATE TABLE IF NOT EXISTS "primary_colors" (
    "id" SERIAL PRIMARY KEY,
    "name" varchar NOT NULL,
    "hex_code" varchar NOT NULL,
    "created_at" timestamp NOT NULL,
    "updated_at" timestamp NOT NULL
);

-- Orders table
CREATE TABLE IF NOT EXISTS "orders" (
    "id" SERIAL PRIMARY KEY,
    "customer_email" varchar,
    "fulfilled" boolean,
    "total" integer,
    "address" varchar,
    "created_at" timestamp NOT NULL,
    "updated_at" timestamp NOT NULL,
    "reference_number" varchar,
    "date_of_retrieval" timestamp,
    "color_id" integer REFERENCES "colors" ("id"),
    "product_id" integer REFERENCES "products" ("id"),
    "paint_color_id" integer REFERENCES "paint_colors" ("id"),
    "primary_color_id" integer REFERENCES "primary_colors" ("id")
);

-- Stocks table
CREATE TABLE IF NOT EXISTS "stocks" (
    "id" SERIAL PRIMARY KEY,
    "size" varchar,
    "amount" integer,
    "paint_color_id" integer NOT NULL REFERENCES "paint_colors" ("id"),
    "created_at" timestamp NOT NULL,
    "updated_at" timestamp NOT NULL,
    "price" decimal
);

-- Order Paint Colors table
CREATE TABLE IF NOT EXISTS "order_paint_colors" (
    "id" SERIAL PRIMARY KEY,
    "paint_color_id" integer NOT NULL REFERENCES "paint_colors" ("id"),
    "order_id" integer NOT NULL REFERENCES "orders" ("id"),
    "size" varchar,
    "quantity" integer,
    "created_at" timestamp NOT NULL,
    "updated_at" timestamp NOT NULL
);

-- Active storage blobs
CREATE TABLE IF NOT EXISTS "active_storage_blobs" (
    "id" SERIAL PRIMARY KEY,
    "key" varchar NOT NULL,
    "filename" varchar NOT NULL,
    "content_type" varchar,
    "metadata" jsonb,
    "service_name" varchar NOT NULL,
    "byte_size" bigint NOT NULL,
    "checksum" varchar,
    "created_at" timestamp NOT NULL
);

-- Active storage attachments
CREATE TABLE IF NOT EXISTS "active_storage_attachments" (
    "id" SERIAL PRIMARY KEY,
    "name" varchar NOT NULL,
    "record_type" varchar NOT NULL,
    "record_id" bigint NOT NULL,
    "blob_id" bigint NOT NULL REFERENCES "active_storage_blobs" ("id"),
    "created_at" timestamp NOT NULL
);

COMMIT;
