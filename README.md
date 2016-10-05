[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/index.php/irc/
[podcasturl]: https://www.linuxserver.io/index.php/category/podcast/

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/nginx
[![](https://images.microbadger.com/badges/image/linuxserver/nginx.svg)](http://microbadger.com/images/linuxserver/nginx "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/nginx.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/nginx.svg)][hub][![Build Status](http://jenkins.linuxserver.io:8080/buildStatus/icon?job=Dockers/LinuxServer.io/linuxserver-nginx)](http://jenkins.linuxserver.io:8080/job/Dockers/job/LinuxServer.io/job/linuxserver-nginx/)
[hub]: https://hub.docker.com/r/linuxserver/nginx/

This Container is a simple nginx webserver configured with default and ssl, and all relevant config files moved out the user via /config for ultimate control. it contains some of the basic php-packages. and is built on our internal nginx baseimage.

[![nginx](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/nginx-banner.png)][nginxurl]
[nginxurl]: https://nginx.org/

## Usage

```
docker create \
--name=nginx \
-v /etc/localtime:/etc/localtime:ro \
-v <path to data>:/config \
-e PGID=<gid> -e PUID=<uid>  \
-p 80:80 -p 443:443 \
linuxserver/nginx
```

**Parameters**

* `-p 80` - The web-services.
* `-p 443` - The SSL-Based Webservice
* `-v /etc/localtime` for timesync - *optional*
* `-v /config` - Contains you www content and all relevant configuration files.
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation

It is based on phusion-baseimage with ssh removed, for shell access whilst the container is running do `docker exec -it nginx /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application 

Add your web files to /config/www for hosting. 

*Protip: This container is best combined with a sql server, e.g. [mariadb](https://hub.docker.com/r/linuxserver/mariadb/)* 


## Updates

* Upgrade to the latest version simply `docker restart nginx`.
* To monitor the logs of the container in realtime `docker logs -f nginx`.

## Versions

+ **10.09.16:** Add badges to README. 
+ **05.12.15:** Intial Release.
