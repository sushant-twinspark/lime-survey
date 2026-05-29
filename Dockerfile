FROM martialblog/limesurvey:6-apache

# Switch to root so we can write files — base image runs as non-root
USER root

COPY entrypoint-wrapper.sh /usr/local/bin/entrypoint-wrapper.sh
RUN chmod +x /usr/local/bin/entrypoint-wrapper.sh

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

ENTRYPOINT ["/usr/local/bin/entrypoint-wrapper.sh"]
CMD ["apache2-foreground"]
