FROM php:7.3-fpm

RUN apt-get update \
    && apt-get install -y \
        libpq-dev \
        postgresql-client \
        telnet \
        iputils-ping

RUN docker-php-ext-configure pgsql --with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pdo pgsql pdo_pgsql

COPY --chmod=755 ./testpg /usr/local/bin/

ARG DB_HOST
ARG DB_PORT
ARG DB_DATABASE
ARG DB_USERNAME
ARG DB_PASSWORD

ENV DB_HOST ${DB_HOST}
ENV DB_PORT ${DB_PORT}
ENV DB_DATABASE ${DB_DATABASE}
ENV DB_USERNAME ${DB_USERNAME}
ENV DB_PASSWORD ${DB_PASSWORD}

ENTRYPOINT ["/usr/local/bin/testpg"]
