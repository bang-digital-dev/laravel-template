ARG LARAVEL_PHP_IMAGE=bangdig.gitlab.yandexcloud.net:5050/bang-digital/devops/images/laravel/php:latest
FROM $LARAVEL_PHP_IMAGE as deps
WORKDIR /app
COPY composer.* .
COPY packages ./packages
COPY nova-components ./nova-components
RUN composer i --ignore-platform-reqs --no-scripts

FROM deps
COPY . .
RUN chown www-data:www-data -R storage bootstrap

ENV APP_KEY='somesecretkey' \
    APP_NAME="Laravel" \
    APP_ENV="local" \
    APP_DEBUG="true"  \
    APP_URL="http://localhost:8080" \
    FILESYSTEM_DISK="public" \
    LOG_LEVEL="debug" \
    QUEUE_CONNECTION="redis" \
    SESSION_DRIVER="database" \
    DB_HOST="mysql" \
    DB_DATABASE="testdb" \
    DB_USERNAME="testuser" \
    DB_PASSWORD="mysqlpassword1" \
    REDIS_HOST="redis" \
    MAIL_MAILER="smtp" \
    MAIL_HOST="mailhog" \
    MAIL_PORT="1025" \
    MAIL_ENCRYPTION="null" \
    MAIL_FROM_ADDRESS="no-reply@example.com"
