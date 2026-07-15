-- =====================================================================
-- Snowflake SQL Sampling Examples
-- Use these patterns to pull a representative sample of data locally 
-- for validation and testing before running queries on full datasets.
-- =====================================================================

-- Pattern 1: Date Partition Filtering with Limit (Cheapest & Recommended)
-- When data is naturally partitioned by date (e.g. event tracking or behavioral logs),
-- filtering for a single day and using LIMIT is the best, cheapest way to get a natural slice of data.
-- Snowflake performs query pruning to only read that day's partitions, saving CPU and cost.
SELECT 
  O_ORDERKEY,
  O_CUSTKEY,
  O_ORDERDATE,
  O_TOTALPRICE
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS
WHERE O_ORDERDATE = '1998-08-01'
LIMIT 5000;

-- Pattern 2: Bernoulli (Row-based) Random Sampling
-- Good for random sampling of large tables.
-- Percentage-based: returns roughly 1% of the total rows.
-- Note: Requires scanning partitions to gather rows.
SELECT 
  C_CUSTKEY,
  C_NAME,
  C_MKTSEGMENT,
  C_ACCTBAL
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER SAMPLE (1 PERCENT);

-- Pattern 3: System (Block-based) Sampling
-- More efficient on extremely large tables than Bernoulli as it samples blocks,
-- but less random.
SELECT 
  O_ORDERKEY,
  O_CUSTKEY,
  O_TOTALPRICE,
  O_ORDERDATE
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS SAMPLE SYSTEM (10 PERCENT);

-- Pattern 4: Fixed Row Count Sampling
-- Snowflake returns exactly 1,000 random rows from the table.
SELECT 
  L_ORDERKEY,
  L_PARTKEY,
  L_QUANTITY,
  L_EXTENDEDPRICE
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.LINEITEM SAMPLE (1000 ROWS);
