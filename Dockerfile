# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-alpine-nginx:3.22

# set version label
ARG BUILD_DATE
ARG VERSION
ARG NGINX_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="nemchik"


# install packages
RUN \
  if [ -z ${NGINX_VERSION+x} ]; then \
    NGINX_VERSION=$(curl -sL "http://dl-cdn.alpinelinux.org/alpine/v3.22/main/x86_64/APKINDEX.tar.gz" | tar -xz -C /tmp \
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
    php84-bcmath \
    php84-bz2 \
    php84-dom \
    php84-exif \
    php84-ftp \
    php84-gd \
    php84-gmp \
    php84-imap \
    php84-intl \
    php84-ldap \
    php84-mysqli \
    php84-mysqlnd \
    php84-opcache \
    php84-pdo_mysql \
    php84-pdo_odbc \
    php84-pdo_pgsql \
    php84-pdo_sqlite \
    php84-pear \
    php84-pecl-apcu \
    php84-pecl-memcached \
    php84-pecl-redis \
    php84-pgsql \
    php84-posix \
    php84-soap \
    php84-sockets \
    php84-sodium \
    php84-sqlite3 \
    php84-tokenizer \
    php84-xmlreader \
    php84-xsl && \
  printf "Linuxserver.io version: ${VERSION}\nBuild-date: ${BUILD_DATE}" > /build_version && \
  rm -f /etc/nginx/conf.d/stream.conf

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 80 443

VOLUME /config
