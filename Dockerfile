uFROM martialblog/limesurvey:6-apache

# Write the retry wrapper inline — no separate file to commit
RUN printf '#!/bin/bash\nset -e\n\nMAX_RETRIES=30\nRETRY_INTERVAL=5\n\necho "[Init] Waiting for MySQL at ${DB_HOST}:${DB_PORT}..."\n\nfor i in $(seq 1 $MAX_RETRIES); do\n    if (echo > /dev/tcp/${DB_HOST}/${DB_PORT}) 2>/dev/null; then\n        echo "[Init] MySQL reachable after ${i} attempt(s). Starting LimeSurvey..."\n        break\n    fi\n    if [ "$i" -eq "$MAX_RETRIES" ]; then\n        echo "[Init] FATAL: Cannot reach DB after $MAX_RETRIES attempts. Exiting."\n        exit 1\n    fi\n    echo "[Init] Attempt ${i}/$MAX_RETRIES - not ready, retrying in ${RETRY_INTERVAL}s..."\n    sleep "${RETRY_INTERVAL}"\ndone\n\nexec /entrypoint.sh "$@"\n' > /entrypoint-wrapper.sh \
    && chmod +x /entrypoint-wrapper.sh

ENV DB_TYPE=mysql \
    DB_HOST=your-db-host \
    DB_PORT=3306 \
    DB_NAME=limesurvey \
    DB_USER=limesurvey \
    DB_PASSWORD=StrongPass123 \
    ADMIN_USER=admin \
    ADMIN_NAME=Administrator \
    ADMIN_EMAIL=admin@example.com \
    ADMIN_PASSWORD=AdminPass123

EXPOSE 8080

ENTRYPOINT ["/entrypoint-wrapper.sh"]
CMD ["apache2-foreground"]
