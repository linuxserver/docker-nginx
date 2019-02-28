[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)](https://linuxserver.io)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring :-

 * regular and timely application updates
 * easy user mappings (PGID, PUID)
 * custom base image with s6 overlay
 * weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
 * regular security updates

Find us at:
* [Discord](https://discord.gg/YWrKVTn) - realtime support / chat with the community and the team.
* [IRC](https://irc.linuxserver.io) - on freenode at `#linuxserver.io`. Our primary support channel is Discord.
* [Blog](https://blog.linuxserver.io) - all the things you can do with our containers including How-To guides, opinions and much more!
* [Podcast](https://anchor.fm/linuxserverio) - on hiatus. Coming back soon (late 2018).

# [linuxserver/nginx](https://github.com/linuxserver/docker-nginx)
[![](https://img.shields.io/discord/354974912613449730.svg?logo=discord&label=LSIO%20Discord&style=flat-square)](https://discord.gg/YWrKVTn)
[![](https://images.microbadger.com/badges/version/linuxserver/nginx.svg)](https://microbadger.com/images/linuxserver/nginx "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/linuxserver/nginx.svg)](https://microbadger.com/images/linuxserver/nginx "Get your own version badge on microbadger.com")
![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/nginx.svg)
![Docker Stars](https://img.shields.io/docker/stars/linuxserver/nginx.svg)
[![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Pipeline-Builders/docker-nginx/master)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-nginx/job/master/)
[![](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/nginx/latest/badge.svg)](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/nginx/latest/index.html)

[Nginx](https://nginx.org/) is a simple webserver with php support. The config files reside in `/config` for easy user customization.

[![nginx](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/nginx-banner.png)](https://nginx.org/)

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list) and our announcement [here](https://blog.linuxserver.io/2019/02/21/the-lsio-pipeline-project/). 

Simply pulling `linuxserver/nginx` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v6-latest |


## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=nginx \
  -e PUID=1001 \
  -e PGID=1001 \
  -e TZ=Europe/London \
  -p 80:80 \
  -p 443:443 \
  -v </path/to/appdata/config>:/config \
  --restart unless-stopped \
  linuxserver/nginx
```


### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  nginx:
    image: linuxserver/nginx
    container_name: nginx
    environment:
      - PUID=1001
      - PGID=1001
      - TZ=Europe/London
    volumes:
      - </path/to/appdata/config>:/config
    ports:
      - 80:80
      - 443:443
    mem_limit: 4096m
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 80` | http |
| `-p 443` | https |
| `-e PUID=1001` | for UserID - see below for explanation |
| `-e PGID=1001` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London |
| `-v /config` | Contains your www content and all relevant configuration files. |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1001` and `PGID=1001`, to find yours use `id user` as below:

```
  $ id username
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```


&nbsp;
## Application Setup

Add your web files to `/config/www` for hosting.  
Modify the nginx, php and site config files under `/config` as needed  
*Protip: This container is best combined with a sql server, e.g. [mariadb](https://hub.docker.com/r/linuxserver/mariadb/)*



## Support Info

* Shell access whilst the container is running: `docker exec -it nginx /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f nginx`
* container version number 
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' nginx`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/nginx`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.  
  
Below are the instructions for updating containers:  
  
### Via Docker Run/Create
* Update the image: `docker pull linuxserver/nginx`
* Stop the running container: `docker stop nginx`
* Delete the container: `docker rm nginx`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start nginx`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update the image: `docker-compose pull linuxserver/nginx`
* Let compose update containers as necessary: `docker-compose up -d`
* You can also remove the old dangling images: `docker image prune`

## Versions

* **28.02.19:** - Add php7-opcache, remove memcached service due to issues on aarch64 (let us know if you need to enable it).
* **22.02.19:** - Rebasing to alpine 3.9.
* **18.11.18:** - Attempt to upgrade packages during build.
* **28.09.18:** - Multi-arch image.
* **17.08.18:** - Rebase to alpine 3.8, inherit nginx.conf from nginx baseimage.
* **11.05.18:** - Add php pgsql support.
* **19.04.18:** - Bind memcached to localhost only, add php7-sqlite3.
* **05.01.18:** - Rebase to alpine 3.7.
* **08.11.17:** - Add php7 soap module.
* **31.10.17:** - Add php7 exif and xmlreader modules.
* **30.09.17:** - Copy additional root files into image.
* **24.09.17:** - Add memcached service.
* **31.08.17:** - Add php7-phar.
* **14.07.17:** - Enable modules dynamically in nginx.conf.
* **22.06.17:** - Add various nginx modules and enable all modules in the default nginx.conf.
* **05.06.17:** - Add php7-bz2.
* **25.05.17:** - Rebase to alpine 3.6.
* **18.04.17:** - Add php7-sockets.
* **27.02.17:** - Rebase to alpine 3.5, update to nginx 1.10.2 and php7.
* **14.10.16:** - Add version layer information.
* **10.09.16:** - Add badges to README.
* **05.12.15:** - Intial Release.
