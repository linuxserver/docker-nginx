FROM linuxserver/baseimage.nginx
MAINTAINER Stian Larsen, sparklyballs

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# copy sources.list
COPY sources.list /etc/apt/

ENV APTLIST="php5-mysqlnd php5-mcrypt php5-curl php5-gd php5-cgi php5-pgsql php5-memcached php5-sqlite memcached"

#Applying stuff from apt
RUN apt-get update -q && \
apt-get install -qy $APTLIST && \
apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*


#Adding Custom files
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run

# Volumes and Ports
VOLUME /config
EXPOSE 80 443



