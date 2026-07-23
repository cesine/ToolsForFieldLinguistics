-- =====================================================================
-- Snowflake Join Key Validation
-- Run these queries before executing joins to check for:
-- 1. Key Uniqueness (preventing Cartesian product row amplification)
-- 2. Null Keys (avoiding lost records)
-- 3. Overlap / Mismatch rate (checking if keys actually match between tables)
--
-- REFERENCE DATASET (TPC-H Benchmark):
-- This query references the standard Snowflake TPC-H sample dataset:
-- https://docs.snowflake.com/en/user-guide/sample-data-tpch
--
-- To set up this shared database in your Snowflake account:
--   CREATE DATABASE SNOWFLAKE_SAMPLE_DATA FROM SHARE SFC_SAMPLES.SAMPLE_DATA;
--   GRANT IMPORTED PRIVILEGES ON DATABASE SNOWFLAKE_SAMPLE_DATA TO ROLE PUBLIC;
-- =====================================================================

-- Table A: CUSTOMER (proposed join key: C_CUSTKEY)
-- Table B: ORDERS (proposed join key: O_CUSTKEY)

-- Check 1: Validate Table A's candidate primary key (should be unique and non-null)
SELECT 
  COUNT(*) as total_rows,
  COUNT(C_CUSTKEY) as non_null_keys,
  COUNT(DISTINCT C_CUSTKEY) as unique_keys,
  (total_rows - non_null_keys) as null_key_count,
  (total_rows - unique_keys) as duplicate_key_count,
  -- calculate percentage of rows with duplicates
  (1 - (COUNT(DISTINCT C_CUSTKEY) / COUNT(*))) * 100 as duplicate_key_percentage
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER;

-- Check 2: Audit overlap / mismatch rates between Table A and Table B
-- Find how many orders reference customers that do not exist (orphaned foreign keys)
-- and how many customers have zero orders.
WITH join_audit AS (
  SELECT 
    o.O_CUSTKEY as order_custkey,
    c.C_CUSTKEY as customer_custkey
  FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS o
  FULL OUTER JOIN SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER c ON o.O_CUSTKEY = c.C_CUSTKEY
)
SELECT
  COUNT(*) as total_joined_rows,
  -- Orders with NO matching customer (orphaned records)
  COUNT(CASE WHEN order_custkey IS NOT NULL AND customer_custkey IS NULL THEN 1 END) as orphaned_orders,
  -- Customers with NO matching orders (inactive customers)
  COUNT(CASE WHEN customer_custkey IS NOT NULL AND order_custkey IS NULL THEN 1 END) as customers_without_orders,
  -- Perfectly matched orders
  COUNT(CASE WHEN order_custkey IS NOT NULL AND customer_custkey IS NOT NULL THEN 1 END) as matched_orders_count
FROM join_audit;
