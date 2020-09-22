# dwchiang/nginx-php-fpm

A Docker image (Dockerfile) that integrates nginx and php-fpm into one bite.

---

# Supported tags and respective Dockerfile links

- `7.4.10-fpm-1.18.0-nginx-alpine3.12`
- `7.4.10-fpm-1.18.0-nginx-buster`

---

# Quick reference

- **Maintained by**: [Ernest Chiang](https://www.ernestchiang.com/)
- **Where to file issues**: [https://github.com/dwchiang/nginx-php-fpm/issues](https://github.com/dwchiang/nginx-php-fpm/issues)
- **Source**: [https://github.com/dwchiang/nginx-php-fpm](https://github.com/dwchiang/nginx-php-fpm)

---

# Features

- EXPOSE 80.
- Using [supervisord](http://supervisord.org/) to manage the processes of nginx and php-fpm.
- Load minimized PHP Extensions.
- Run scripts in `/docker-entrypoint.d/`

---

# Original Intention

I love PHP since PHP3 and I'm very happy to run more PHP applications and services in a cloud native way. I mainly tunes it to run on [AWS Fargate](https://www.ernestchiang.com/en/notes/aws/ecs/), but you can run on any platforms or local machines.

This Docker image is designed to run all kinds of PHP applications by decoupling into 2 parts: 

1. Base image,
2. PHP extension installation & PHP application and configuration.

These two parts are separated Dockerfiles. This project repository will maintain the Part 1: base images, and having some reference examples for Part 2. You can find a Dockerfile of Part 2 as reference, and modify it for fitting into your project by adding some PHP extensions and maybe a few extra scripts.

## Part 1: Base image

The base image is basically merged from official [php-fpm](https://hub.docker.com/_/php) and [nginx](https://hub.docker.com/_/nginx) Dockerfiles. Plus [supervisord](http://supervisord.org/) to manage the processes of nginx and php-fpm. Plus configuration files for nginx.

Here list some useful pathes you may want to modify at Part 2:

- `/usr/share/nginx/html`: Place your **static** files here.
- `/var/www/html`: Place your **PHP application** files here.
- `/etc/nginx/conf.d/*.conf`: If you have some other extra **nginx** conf files, place here.
- `/etc/supervisor/conf.d/*.conf`: If you have some other extra **supervisor** conf files, place here.
- `/docker-entrypoint.d/*.sh`: If you have some other extra shell scripts, place here. Filename format `{number}-{customName}.sh`. Remember to` `chmod +x` on these script files.

You can find the base image Dockerfiles in these folders:

- `alpine3.12`
- `buster`

These base images will be uploaded to [dwchiang/nginx-php-fpm](https://hub.docker.com/repository/docker/dwchiang/nginx-php-fpm) on Docker Hub.

## Part 2: PHP extension installation & PHP application and configuration

Part 2 is designed to be **flexible**. 

You can install minimized PHP extensions based on the needs of your PHP application.

You can get into your container and check the included PHP modules by using `php -m`.

You can find these Dockerfiles in the root folder of this repository. Such as:

- `Dockerfile-7.25.0-laravel-alpine3.12`: Running Laravel 7.25.0 based on latest [dwchiang/nginx-php-fpm](https://hub.docker.com/repository/docker/dwchiang/nginx-php-fpm) on Alpine 3.12
- `Dockerfile-7.25.0-laravel-buster`: Running Laravel 7.25.0 based on latest [dwchiang/nginx-php-fpm](https://hub.docker.com/repository/docker/dwchiang/nginx-php-fpm) on Buster (Debian 10)

This project will not upload the images of Part 2 on Docker Hub. Please kindly use Part 2 as your Dockerfile reference to build your own and enjoy the fun :)

---

# License

View license information of [nginx](http://nginx.org/LICENSE), [PHP](http://php.net/license/), [Laravel](https://github.com/laravel/laravel) for the software contained in this image.

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

Some additional license information which was able to be auto-detected might be found in [the `repo-info` repository's `nginx/` directory](https://github.com/docker-library/repo-info/tree/master/repos/nginx) and [the `repo-info` repository's `php/` directory](https://github.com/docker-library/repo-info/tree/master/repos/php).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.