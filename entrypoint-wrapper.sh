#!/bin/bash
set -e

MAX_RETRIES=30
RETRY_INTERVAL=5

echo "[Init] Waiting for MySQL at ${DB_HOST}:${DB_PORT}..."

for i in $(seq 1 $MAX_RETRIES); do
    if nc -z "${DB_HOST}" "${DB_PORT}" 2>/dev/null; then
        echo "[Init] MySQL reachable after ${i} attempt(s). Starting LimeSurvey..."
        break
    fi

    if [ "$i" -eq "$MAX_RETRIES" ]; then
        echo "[Init] FATAL: MySQL at ${DB_HOST}:${DB_PORT} not available after ${MAX_RETRIES} retries."
        exit 1
    fi

    echo "[Init] Attempt ${i}/${MAX_RETRIES} — not ready, retrying in ${RETRY_INTERVAL}s..."
    sleep "${RETRY_INTERVAL}"
done

# Hand off to the original LimeSurvey entrypoint
exec /entrypoint.sh "$@"
