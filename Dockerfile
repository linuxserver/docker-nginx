# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-alpine-nginx:3.24

# set version label
ARG BUILD_DATE
ARG VERSION
ARG NGINX_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="nemchik"


# install packages
RUN \
  if [ -z ${NGINX_VERSION+x} ]; then \
    NGINX_VERSION=$(curl -sL "http://dl-cdn.alpinelinux.org/alpine/v3.24/main/x86_64/APKINDEX.tar.gz" | tar -xz -C /tmp \
    && awk '/^P:nginx$/,/V:/' /tmp/APKINDEX | sed -n 2p | sed 's/^V://'); \
  fi && \
  apk add --no-cache \
    inotify-tools \
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
    php85-bcmath \
    php85-bz2 \
    php85-dom \
    php85-exif \
    php85-ftp \
    php85-gd \
    php85-gmp \
    php85-imap \
    php85-intl \
    php85-ldap \
    php85-mysqli \
    php85-mysqlnd \
    php85-pdo_mysql \
    php85-pdo_odbc \
    php85-pdo_pgsql \
    php85-pdo_sqlite \
    php85-pear \
    php85-pecl-apcu \
    php85-pecl-memcached \
    php85-pecl-redis \
    php85-pgsql \
    php85-posix \
    php85-soap \
    php85-sockets \
    php85-sodium \
    php85-sqlite3 \
    php85-tokenizer \
    php85-xmlreader \
    php85-xsl && \
  printf "Linuxserver.io version: ${VERSION}\nBuild-date: ${BUILD_DATE}" > /build_version && \
  rm -f /etc/nginx/conf.d/stream.conf

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 80 443

VOLUME /config
