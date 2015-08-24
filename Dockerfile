FROM linuxserver/baseimage-nginx
MAINTAINER Stian Larsen <lonix@linuxserver.io>

#Applying stuff
RUN apt-get update -q && \
apt-get install php5-fpm php5-mysql php5-mcrypt php5-curl php5-gd php5-cgi php5-pgsql php5-sqlite && \
apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*


#Adding Custom files
RUN mkdir /defaults 

# Volumes and Ports
VOLUME /config
EXPOSE 80 443