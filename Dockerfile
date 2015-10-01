FROM linuxserver/baseimage.nginx
MAINTAINER Stian Larsen <lonix@linuxserver.io>
ENV APTLIST="php5-mysql php5-mcrypt php5-curl php5-gd php5-cgi php5-pgsql php5-memcached php5-sqlite memcached"

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



