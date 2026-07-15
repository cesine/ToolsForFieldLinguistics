#!/usr/bin/env bash
# =====================================================================
# Snowflake Query Executor
# Fetch sample TPC-H orders data using the date-partitioned query
# and save the results locally to gen/customer_orders_happy.csv.
# =====================================================================
set -e

# Resolve paths
ENV_FILE="$HOME/.env"
OUTPUT_FILE="gen/customer_orders_happy.csv"
SNOW_EXEC="/Users/gchiodo/.local/bin/snow"

# Load environment variables from ~/.env if it exists
if [ -f "$ENV_FILE" ]; then
  set -o allexport
  source "$ENV_FILE"
  set +o allexport
else
  echo "Error: Credentials file not found at $ENV_FILE"
  echo "Please set up your Snowflake credentials in ~/.env first."
  exit 1
fi

# Fallback to PATH search if the absolute bin path doesn't exist
if [ ! -f "$SNOW_EXEC" ]; then
  SNOW_EXEC="snow"
fi

# Ensure output directory exists
mkdir -p gen

echo "Connecting to Snowflake and running date-filtered query..."
echo "Account: $SNOWFLAKE_ACCOUNT"
echo "Warehouse: $SNOWFLAKE_WAREHOUSE"
echo "Database: $SNOWFLAKE_DATABASE"
echo "Schema: $SNOWFLAKE_SCHEMA"

# Execute query using snow CLI with CSV formatting
# Uses O_ORDERDATE as the partition pruning key for the cheapest query execution
"$SNOW_EXEC" sql \
  --format CSV \
  --temporary-connection \
  --account "$SNOWFLAKE_ACCOUNT" \
  --user "$SNOWFLAKE_USER" \
  --password "$SNOWFLAKE_PASSWORD" \
  --warehouse "$SNOWFLAKE_WAREHOUSE" \
  --database "$SNOWFLAKE_DATABASE" \
  --schema "$SNOWFLAKE_SCHEMA" \
  --query "
SELECT 
  O_ORDERKEY,
  O_CUSTKEY,
  O_ORDERSTATUS,
  O_TOTALPRICE,
  O_ORDERDATE,
  O_ORDERPRIORITY,
  O_CLERK
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS
WHERE O_ORDERDATE = '1998-08-01'
LIMIT 5000;
" > "$OUTPUT_FILE"

echo "Success! Snowflake query results saved to $OUTPUT_FILE"
