-- =====================================================================
-- Snowflake Query Performance Audits
-- Use these queries to analyze execution time, resource consumption, 
-- and find memory issues like partition spillage.
-- =====================================================================

-- Query 1: Get performance metrics for the last executed query in the session
SELECT 
  QUERY_ID,
  QUERY_TEXT,
  EXECUTION_STATUS,
  -- Time metrics (converted from milliseconds to seconds)
  (COMPILATION_TIME / 1000.0) as compilation_seconds,
  (EXECUTION_TIME / 1000.0) as execution_seconds,
  (TOTAL_ELAPSED_TIME / 1000.0) as total_elapsed_seconds,
  -- Data scanning metrics
  PARTITIONS_TOTAL,
  PARTITIONS_SCANNED,
  (PARTITIONS_SCANNED / NULLIF(PARTITIONS_TOTAL, 0)) * 100 as percentage_partitions_scanned,
  BYTES_SCANNED,
  (BYTES_SCANNED / 1024.0 / 1024.0) as megabytes_scanned,
  PERCENTAGE_FROM_CACHE * 100 as cache_hit_percentage,
  -- Spillage metrics (Critical performance indicators)
  -- Spilling indicates that the virtual warehouse memory was exceeded.
  BYTES_SPILLED_TO_LOCAL_STORAGE,
  (BYTES_SPILLED_TO_LOCAL_STORAGE / 1024.0 / 1024.0) as megabytes_spilled_local,
  BYTES_SPILLED_TO_REMOTE_STORAGE,
  (BYTES_SPILLED_TO_REMOTE_STORAGE / 1024.0 / 1024.0) as megabytes_spilled_remote
FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY())
WHERE QUERY_ID = LAST_QUERY_ID()
ORDER BY START_TIME DESC;

-- Query 2: Identify queries with local/remote spillage in the last 24 hours
-- This helps identify queries that are running out of memory (often due to huge joins/Cartesian products).
-- NOTE: We use QUERY_HISTORY_BY_USER(USER_NAME => CURRENT_USER()) to strictly limit analysis to your own queries.
SELECT 
  QUERY_ID,
  QUERY_TEXT,
  USER_NAME,
  WAREHOUSE_NAME,
  TOTAL_ELAPSED_TIME / 1000.0 as elapsed_seconds,
  BYTES_SPILLED_TO_LOCAL_STORAGE / 1024.0 / 1024.0 as spilled_local_mb,
  BYTES_SPILLED_TO_REMOTE_STORAGE / 1024.0 / 1024.0 as spilled_remote_mb
FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY_BY_USER(USER_NAME => CURRENT_USER()))
WHERE START_TIME >= DATEADD('day', -1, CURRENT_TIMESTAMP())
  AND (BYTES_SPILLED_TO_LOCAL_STORAGE > 0 OR BYTES_SPILLED_TO_REMOTE_STORAGE > 0)
ORDER BY (BYTES_SPILLED_TO_LOCAL_STORAGE + BYTES_SPILLED_TO_REMOTE_STORAGE) DESC
LIMIT 10;
