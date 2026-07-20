#!/usr/bin/env bash
# =====================================================================
# Snowflake Query Executor
# Fetch sample TPC-H orders data using the date-partitioned query
# and save the results locally to gen/customer_orders_happy.csv.
#
# Setup Instructions:
# 1. Install the Snowflake CLI (snow):
#    https://docs.snowflake.com/en/developer-guide/snowflake-cli/installation/installation
#    (Typically installed at /Users/gchiodo/.local/bin/snow or available on PATH)
# 2. Configure credentials in your ~/.env file:
#    SNOWFLAKE_ACCOUNT="xdwsima-gp91834"
#    SNOWFLAKE_USER="<your_username>"
#    SNOWFLAKE_PASSWORD="<your_password>"
#    SNOWFLAKE_WAREHOUSE="COMPUTE_WH"
#    SNOWFLAKE_DATABASE="SNOWFLAKE_SAMPLE_DATA"
#    SNOWFLAKE_SCHEMA="TPCH_SF1"
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

# Execute query using snow CLI loading SQL from file
"$SNOW_EXEC" sql \
  --format CSV \
  --temporary-connection \
  --account "$SNOWFLAKE_ACCOUNT" \
  --user "$SNOWFLAKE_USER" \
  --password "$SNOWFLAKE_PASSWORD" \
  --warehouse "$SNOWFLAKE_WAREHOUSE" \
  --database "$SNOWFLAKE_DATABASE" \
  --schema "$SNOWFLAKE_SCHEMA" \
  -f "src/sql/snowflake/customer_personas_query.sql" > "$OUTPUT_FILE"

echo "Success! Snowflake query results saved to $OUTPUT_FILE"
