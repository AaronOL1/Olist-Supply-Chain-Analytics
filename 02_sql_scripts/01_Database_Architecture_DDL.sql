/*
PROJECT: OLIST SUPPLY CHAIN & E-COMMERCE ANALYTICS
   SCRIPT: 01_Database_Architecture_DDL.sql
   AUTHOR: Aaron Olmedo 
   DESCRIPTION: 
   This script initializes the relational database architecture for the Olist 
   dataset. It builds a Star Schema model by first creating the Dimensional 
   tables (edges) and then the Fact/Transactional tables (center).
*/

CREATE DATABASE olist_supply_chain
GO

USE olist_supply_chain
GO

ALTER AUTHORIZATION ON DATABASE::olist_supply_chain TO sa;
GO

-- CLEAN SLATE
DROP TABLE IF EXISTS olist_order_reviews_dataset;
DROP TABLE IF EXISTS olist_order_payments_dataset;
DROP TABLE IF EXISTS olist_order_items_dataset;
DROP TABLE IF EXISTS olist_orders_dataset;
DROP TABLE IF EXISTS product_category_name_translation;
DROP TABLE IF EXISTS olist_products_dataset;
DROP TABLE IF EXISTS olist_sellers_dataset;
DROP TABLE IF EXISTS olist_geolocation_dataset;
DROP TABLE IF EXISTS olist_customers_dataset;
GO

-- DIMENSION TABLES
	-- CUSTOMERS DIMENSION: Stores customer geographical information.

CREATE TABLE olist_customers_dataset (
    customer_id NVARCHAR(50) NOT NULL PRIMARY KEY,
    customer_unique_id NVARCHAR(50),
    customer_zip_code_prefix NVARCHAR(10),
    customer_city NVARCHAR(100),
    customer_state NVARCHAR(5)
);

    -- GEOLOCATION DIMENSION: Stores geospatial coordinates for zip codes.
CREATE TABLE olist_geolocation_dataset (
    geolocation_zip_code_prefix NVARCHAR(10),
    geolocation_lat FLOAT,
    geolocation_lng FLOAT,
    geolocation_city NVARCHAR(100),
    geolocation_state NVARCHAR(5)
);

    --SELLERS DIMENSION: Stores seller geographical information.
CREATE TABLE olist_sellers_dataset (
    seller_id NVARCHAR(50) NOT NULL PRIMARY KEY,
    seller_zip_code_prefix NVARCHAR(10),
    seller_city NVARCHAR(100),
    seller_state NVARCHAR(5)
);

    -- PRODUCTS DIMENSION: Stores product information.
CREATE TABLE olist_products_dataset (
    product_id NVARCHAR(50) NOT NULL PRIMARY KEY,
    product_category_name NVARCHAR(100),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);

    --CATEGORY TRANSLATION: Helper table to translate Portuguese categories to English
CREATE TABLE product_category_name_translation (
    product_category_name NVARCHAR(100),
    product_category_name_english NVARCHAR(100)
);


-- ORDERSFACT TABLE: Stores all core order timestamps for logistical analysis

CREATE TABLE olist_orders_dataset (
	order_id NVARCHAR(50) NOT NULL PRIMARY KEY,
	customer_id NVARCHAR(50) NOT NULL,
	order_status NVARCHAR(50) NOT NULL,
	order_purchase_timestamp DATETIME NOT NULL,
	order_approved_at DATETIME,
	order_delivered_carrier_date DATETIME,
	order_delivered_customer_date DATETIME,
	order_estimated_delivery_date DATETIME
);

-- TRANSACTIONAL TABLES
    -- ORDER ITEMS: Details which products and sellers are associated with each order
CREATE TABLE olist_order_items_dataset (
    order_id NVARCHAR(50) NOT NULL,
    order_item_id INT NOT NULL,
    product_id NVARCHAR(50) NOT NULL,
    seller_id NVARCHAR(50) NOT NULL,
    shipping_limit_date DATETIME,
    price FLOAT,
    freight_value FLOAT
);

    -- ORDER PAYMENTS: Contains payment information for each order
CREATE TABLE olist_order_payments_dataset (
    order_id NVARCHAR(50) NOT NULL,
    payment_sequential INT,
    payment_type NVARCHAR(50),
    payment_installments INT,
    payment_value FLOAT
);

    -- ORDER REVIEWS: Contains customer reviews and ratings for each order 
CREATE TABLE olist_order_reviews_dataset (
    review_id NVARCHAR(50),
    order_id NVARCHAR(50),
    review_score INT,
    review_comment_title NVARCHAR(MAX),
    review_comment_message NVARCHAR(MAX), 
    review_creation_date DATETIME,
    review_answer_timestamp DATETIME
);

