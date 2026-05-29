FROM martialblog/limesurvey:6-apache

# Switch to root so we can write files — base image runs as non-root
USER root

COPY entrypoint-wrapper.sh /usr/local/bin/entrypoint-wrapper.sh
RUN chmod +x /usr/local/bin/entrypoint-wrapper.sh

# NOTE: martialblog/limesurvey uses DB_USERNAME (not DB_USER).
#       DB_HOST here is a placeholder — override at runtime via env vars
#       in your platform's service configuration (e.g. mysql-8 service alias).
#
# LISTEN_PORT controls which port Apache binds to.
# Set internalPort=8080 in your platform's LimeSurvey service config.
ENV DB_TYPE=mysql \
    DB_HOST=mysql-8 \
    DB_PORT=3306 \
    DB_NAME=limesurvey \
    DB_USERNAME=limesurvey \
    DB_PASSWORD=StrongPass123 \
    ADMIN_USER=admin \
    ADMIN_NAME=Administrator \
    ADMIN_EMAIL=admin@example.com \
    ADMIN_PASSWORD=AdminPass123 \
    LISTEN_PORT=8080

EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/entrypoint-wrapper.sh"]
CMD ["apache2-foreground"]