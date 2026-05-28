FROM martialblog/limesurvey:6-apache

EXPOSE 8080

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
