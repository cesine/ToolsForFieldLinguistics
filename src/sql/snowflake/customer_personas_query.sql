-- =====================================================================
-- Snowflake Customer Persona Query
-- This query joins customer, order, region, and line-item aggregates 
-- to build a multi-feature dataset for multivariate persona analysis.
--
-- REFERENCE DATASET (TPC-H Benchmark):
-- https://docs.snowflake.com/en/user-guide/sample-data-tpch
-- =====================================================================
SELECT 
  o.O_ORDERKEY,
  o.O_CUSTKEY,
  o.O_ORDERSTATUS,
  o.O_TOTALPRICE,
  o.O_ORDERDATE,
  o.O_ORDERPRIORITY,
  c.C_MKTSEGMENT,
  c.C_ACCTBAL,
  r.R_NAME as C_REGION,
  l.TOTAL_QUANTITY,
  l.AVG_DISCOUNT,
  l.TOTAL_DISCOUNT_VALUE,
  l.ITEM_COUNT,
  l.MAX_SHIP_DELAY
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS o
JOIN SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER c ON o.O_CUSTKEY = c.C_CUSTKEY
JOIN SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.NATION n ON c.C_NATIONKEY = n.N_NATIONKEY
JOIN SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.REGION r ON n.N_REGIONKEY = r.R_REGIONKEY
JOIN (
  SELECT 
    L_ORDERKEY,
    SUM(L_QUANTITY) as TOTAL_QUANTITY,
    AVG(L_DISCOUNT) as AVG_DISCOUNT,
    SUM(L_EXTENDEDPRICE * L_DISCOUNT) as TOTAL_DISCOUNT_VALUE,
    COUNT(L_LINENUMBER) as ITEM_COUNT,
    MAX(DATEDIFF('day', L_SHIPDATE, L_RECEIPTDATE)) as MAX_SHIP_DELAY
  FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.LINEITEM
  GROUP BY L_ORDERKEY
) l ON o.O_ORDERKEY = l.L_ORDERKEY
WHERE o.O_ORDERDATE = '1998-08-01'
LIMIT 5000;
