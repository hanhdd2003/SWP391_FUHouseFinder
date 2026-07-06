#!/usr/bin/env bash
set -euo pipefail

DB_HOST="${DB_HOST:-db}"
DB_PORT="${DB_PORT:-1433}"
SA_USER="${SA_USER:-sa}"
SA_PASSWORD="${SA_PASSWORD:?SA_PASSWORD is required}"
DB_NAME="${DB_NAME:-FUHF2}"
SQLCMD="/opt/mssql-tools18/bin/sqlcmd"

echo "Waiting for SQL Server at ${DB_HOST},${DB_PORT}..."
until "${SQLCMD}" -S "${DB_HOST},${DB_PORT}" -U "${SA_USER}" -P "${SA_PASSWORD}" -C -Q "SELECT 1" -b -l 5 >/dev/null 2>&1; do
  sleep 5
done

echo "Checking whether database ${DB_NAME} already exists..."
if "${SQLCMD}" -S "${DB_HOST},${DB_PORT}" -U "${SA_USER}" -P "${SA_PASSWORD}" -C -Q "SET NOCOUNT ON; IF DB_ID(N'${DB_NAME}') IS NOT NULL SELECT 1 ELSE SELECT 0" -h -1 -W | grep -qx "1"; then
  echo "Database ${DB_NAME} already exists, skipping seed import."
  exit 0
fi

echo "Importing schema and seed data into ${DB_NAME}..."
"${SQLCMD}" -S "${DB_HOST},${DB_PORT}" -U "${SA_USER}" -P "${SA_PASSWORD}" -C -i /scripts/fuhf-sqlserver.sql -b

echo "Database import complete."
