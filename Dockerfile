FROM martialblog/limesurvey:6-apache

# No apt-get — /dev/tcp is pure bash, zero dependencies
COPY entrypoint-wrapper.sh /entrypoint-wrapper.sh
RUN chmod +x /entrypoint-wrapper.sh

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
