# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-alpine-nginx:3.19

# set version label
ARG BUILD_DATE
ARG VERSION
ARG NGINX_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="nemchik"


# install packages
RUN \
  if [ -z ${NGINX_VERSION+x} ]; then \
    NGINX_VERSION=$(curl -sL "http://dl-cdn.alpinelinux.org/alpine/v3.19/main/x86_64/APKINDEX.tar.gz" | tar -xz -C /tmp \
    && awk '/^P:nginx$/,/V:/' /tmp/APKINDEX | sed -n 2p | sed 's/^V://'); \
  fi && \
  apk add --no-cache \
    memcached \
    nginx==${NGINX_VERSION} \
    nginx-mod-http-brotli==${NGINX_VERSION} \
    nginx-mod-http-dav-ext==${NGINX_VERSION} \
    nginx-mod-http-echo==${NGINX_VERSION} \
    nginx-mod-http-fancyindex==${NGINX_VERSION} \
    nginx-mod-http-geoip==${NGINX_VERSION} \
    nginx-mod-http-geoip2==${NGINX_VERSION} \
    nginx-mod-http-headers-more==${NGINX_VERSION} \
    nginx-mod-http-image-filter==${NGINX_VERSION} \
    nginx-mod-http-perl==${NGINX_VERSION} \
    nginx-mod-http-redis2==${NGINX_VERSION} \
    nginx-mod-http-set-misc==${NGINX_VERSION} \
    nginx-mod-http-upload-progress==${NGINX_VERSION} \
    nginx-mod-http-xslt-filter==${NGINX_VERSION} \
    nginx-mod-mail==${NGINX_VERSION} \
    nginx-mod-rtmp==${NGINX_VERSION} \
    nginx-mod-stream==${NGINX_VERSION} \
    nginx-mod-stream-geoip==${NGINX_VERSION} \
    nginx-mod-stream-geoip2==${NGINX_VERSION} \
    nginx-vim==${NGINX_VERSION} \
    php83-bcmath \
    php83-bz2 \
    php83-dom \
    php83-exif \
    php83-ftp \
    php83-gd \
    php83-gmp \
    php83-imap \
    php83-intl \
    php83-ldap \
    php83-mysqli \
    php83-mysqlnd \
    php83-opcache \
    php83-pdo_mysql \
    php83-pdo_odbc \
    php83-pdo_pgsql \
    php83-pdo_sqlite \
    php83-pear \
    php83-pecl-apcu \
    php83-pecl-memcached \
    php83-pecl-redis \
    php83-pgsql \
    php83-posix \
    php83-soap \
    php83-sockets \
    php83-sodium \
    php83-sqlite3 \
    php83-tokenizer \
    php83-xmlreader \
    php83-xsl && \
  apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community \
    php83-pecl-mcrypt && \
  rm -f /etc/nginx/conf.d/stream.conf

# ports and volumes
EXPOSE 80 443

VOLUME /config
