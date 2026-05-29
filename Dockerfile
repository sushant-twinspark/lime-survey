FROM martialblog/limesurvey:6-apache

# netcat — used by wrapper to probe DB port before handing off
RUN apt-get update \
    && apt-get install -y --no-install-recommends netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

# Copy retry wrapper and make executable
COPY entrypoint-wrapper.sh /entrypoint-wrapper.sh
RUN chmod +x /entrypoint-wrapper.sh

# All defaults baked in — override only what changes via .env at runtime
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

# Apache inside this image always binds 8080
# Platform maps externally: 3000 → 8080 via Traefik or -p 3000:8080 standalone
EXPOSE 8080

ENTRYPOINT ["/entrypoint-wrapper.sh"]
CMD ["apache2-foreground"]
