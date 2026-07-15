-- =====================================================================
-- Snowflake SQL Sampling Examples
-- Use these patterns to pull a representative sample of data locally 
-- for validation and testing before running queries on full datasets.
-- =====================================================================

-- Pattern 1: Bernoulli (Row-based) Sampling
-- Good for fast, random sampling of large tables.
-- Percentage-based: returns roughly 1% of the total rows.
SELECT 
  C_CUSTKEY,
  C_NAME,
  C_MKTSEGMENT,
  C_ACCTBAL
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER SAMPLE (1 PERCENT);

-- Pattern 2: System (Block-based) Sampling
-- More efficient on extremely large tables as it samples data blocks,
-- but less random than Bernoulli.
SELECT 
  O_ORDERKEY,
  O_CUSTKEY,
  O_TOTALPRICE,
  O_ORDERDATE
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS SAMPLE SYSTEM (10 PERCENT);

-- Pattern 3: Fixed Row Count Sampling
-- Snowflake returns exactly 1,000 random rows from the table.
SELECT 
  L_ORDERKEY,
  L_PARTKEY,
  L_QUANTITY,
  L_EXTENDEDPRICE
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.LINEITEM SAMPLE (1000 ROWS);

-- Pattern 4: Date Partition Filtering with Limit (Recommended for Time-Series)
-- When data is naturally partitioned by date (e.g. event tracking or behavioral logs),
-- filtering for a single day and using LIMIT is the best way to get a natural slice of data.
SELECT 
  O_ORDERKEY,
  O_CUSTKEY,
  O_ORDERDATE,
  O_TOTALPRICE
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS
WHERE O_ORDERDATE = '1998-08-01'
LIMIT 5000;
