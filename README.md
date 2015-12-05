![http://linuxserver.io](http://www.linuxserver.io/wp-content/uploads/2015/06/linuxserver_medium.png)

The [LinuxServer.io](http://linuxserver.io) team brings you another quality container release featuring auto-update on startup, easy user mapping and community support. Be sure to checkout our [forums](http://forum.linuxserver.io) or for real-time support our [IRC](http://www.linuxserver.io/index.php/irc/) on freenode at `#linuxserver.io`.

# linuxserver/nginx

This Container is a simple nginx webserver configured with default and ssl, and all relevant config files moved out the user via /config for ultimate control. it contains some of the basic php-packages. and is built on our internal baseimage-nginx, which there is much work at.  

## Usage

```
docker create --name=nginx -v /etc/localtime:/etc/localtime:ro -v <path to data>:/config -e PGID=<gid> -e PUID=<uid>  -p 80:80 -p 443:443 linuxserver/nginxweb
```

**Parameters**

* `-p 80` - The web-services.
* `-p 443` - The SSL-Based Webservice
* `-v /etc/localhost` for timesync - *optional*
* `-v /config` - Contains you www content and all relevant configuration files.
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation

It is based on phusion-baseimage with ssh removed, for shell access whilst the container is running do `docker exec -it nginx /bin/bash`.

### User / Group Identifiers

**TL;DR** - The `PGID` and `PUID` values set the user / group you'd like your container to 'run as' to the host OS. This can be a user you've created or even root (not recommended).

Part of what makes our containers work so well is by allowing you to specify your own `PUID` and `PGID`. This avoids nasty permissions errors with relation to data volumes (`-v` flags). When an application is installed on the host OS it is normally added to the common group called users, Docker apps due to the nature of the technology can't be added to this group. So we added this feature to let you easily choose when running your containers.

## Setting up the application 

Add your web files to /config/www for hosting. 

*Protip: This container is best combined with a sql server, e.g. [mariadb](https://hub.docker.com/r/linuxserver/mariadb/)* 


## Updates

* Upgrade to the latest version simply `docker restart nginx`.
* To monitor the logs of the container in realtime `docker logs -f nginx`.


## Versions

+ **05.12.2015:** The intial Release. 