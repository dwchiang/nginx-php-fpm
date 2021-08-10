# dwchiang/nginx-php-fpm

A Docker image (Dockerfile) that merged nginx & php-fpm into one bite on Debian/Alpine for 

- modern applications, 
- cloud native designs, 
- AWS Fargate, 
- Amazon ECS, 
- amd64/arm64. 

Brought to you by Ernest Chiang, an [AWS Community Hero](https://aws.amazon.com/developer/community/heroes/ernest-chiang/).

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/dwchiang/nginx-php-fpm/Build) ![Docker Pulls](https://img.shields.io/docker/pulls/dwchiang/nginx-php-fpm)

- Designed for running Laravel framework and all other PHP-based application modernization on cloud native.
- Performance analysis report: [Laravel PHP8/PHP7 Debian/Alpine Container Performance Comparison](https://www.ernestchiang.com/en/posts/2021/benchmark-nginx-php-fpm-between-buster-alpine/)

---

# Quick reference

- **Supported architectures**: `amd64`, `arm64`.
- **Supported PHP versions**: `8.1`, `8.0`, `7.4`, `7.3`
- **Supported OS versions**: Across `buster`, `alpine3.14`, `alpine3.13`. (Based on PHP official image tags and Nginx official image OS version.)
- **Supported Nginx versions**: `1.21.1`, `1.20.1`
- **Maintained by**: [Ernest Chiang](https://www.ernestchiang.com/)
- **Where to file issues**: [https://github.com/dwchiang/nginx-php-fpm/issues](https://github.com/dwchiang/nginx-php-fpm/issues)
- **Source**: [https://github.com/dwchiang/nginx-php-fpm](https://github.com/dwchiang/nginx-php-fpm)
- **Registry**: [AWS ECR Public](https://gallery.ecr.aws/dwchiang/nginx-php-fpm), and [Docker Hub](https://hub.docker.com/r/dwchiang/nginx-php-fpm).
- **Benchmark**: [Benchmark.md](https://github.com/dwchiang/nginx-php-fpm/blob/master/docs/Benchmark.md) and my [blog](https://www.ernestchiang.com/en/posts/2021/benchmark-nginx-php-fpm-between-buster-alpine/).
- **Maintenance**: [Maintenance.md](https://github.com/dwchiang/nginx-php-fpm/blob/master/docs/Maintenance.md)

---

# Supported Image Tags

- **Full tag list** (included older tags): [https://github.com/dwchiang/nginx-php-fpm/blob/master/docs/Tags.md](https://github.com/dwchiang/nginx-php-fpm/blob/master/docs/Tags.md)
- Changed tag naming rule on 2021-07-25. More details please refer to this [docs](https://github.com/dwchiang/nginx-php-fpm/blob/master/docs/Tags.md).

---

# Features

- EXPOSE 80.
- Using [supervisord](http://supervisord.org/) to manage the processes of nginx and php-fpm.
- Load **minimized** PHP Extensions. (so that you gain the flexibility to load corresponding extensions you need)
- Run scripts in `/docker-entrypoint.d/`

---

# Quick Start

Create a Dockerfile like this to copy your application and PHP scrips locates at `your_app/` folder into the container.

```
FROM dwchiang/nginx-php-fpm:latest

COPY your_app /var/www/html/public
```

- Your application may require to install some more PHP extensions. Please refer to Part 2 description below.
- More detailed usage please refer to the exmaple Dockerfiles of Part 2 below.

---

# Hands-On

- [Workshops: Running Laravel on AWS ECS](https://github.com/dwchiang/laravel-on-aws-ecs-workshops)

---

# Original Intention

I love PHP since PHP3 (1997) and I'm very happy to run more PHP applications and services in a cloud native way. I mainly tunes it to run on [Amazon ECS](https://www.ernestchiang.com/en/notes/aws/ecs/), but you can run on any platforms or local machines.

---
# Introduction

This Docker image is designed to run all kinds of PHP applications by decoupling into 2 parts: 

- Part 1: Base image,
- Part 2: Your app + PHP extension installation + PHP.ini configuration.

These two parts are separated Dockerfiles. 

1. This project will maintain the Part 1 Dockerfiles (base images).

2. You will generate your own Part 2 Dockerfile (your app), but this project also includes some reference examples for you. 

You can find one of the Dockerfiles of Part 2 in this project as reference, and modify it for fitting into your project by adding some PHP extensions and maybe a few extra scripts.


---
# Part 1: Base image

The base image is basically merged from official [php-fpm](https://hub.docker.com/_/php) and [nginx](https://hub.docker.com/_/nginx) Dockerfiles. 

- Plus [supervisord](http://supervisord.org/) to manage the processes of nginx and php-fpm. 
- Plus configuration files for nginx.

Here list some useful pathes you may want to modify at Part 2:

- `/usr/share/nginx/html`: Place your **static** files here.
- `/var/www/html`: Place your **PHP application** files here.
- `/var/www/html/public`: Place your **index.php** here.

Configuration files:

- `/etc/nginx/conf.d/*.conf`: If you have some other extra **nginx** conf files, place here.
- `/etc/supervisor/conf.d/*.conf`: If you have some other extra **supervisor** conf files, place here.

Scripts:

- `/docker-entrypoint.d/*.sh`: If you have some other extra shell scripts, place here. Filename format `{number}-{customName}.sh`. Remember to` `chmod +x` on these script files.

You can find the base image Dockerfiles in these folders by OS versions:

- `Dockerfiles/buster`
- `Dockerfiles/alpine*`

These base images will be uploaded to [dwchiang/nginx-php-fpm](https://hub.docker.com/repository/docker/dwchiang/nginx-php-fpm) on Docker Hub, and also to [dwchiang/nginx-php-fpm](https://gallery.ecr.aws/dwchiang/nginx-php-fpm) on AWS ECR Public.


---

# Part 2: PHP extension installation & PHP application and configuration

Part 2 is designed to be **flexible**. 

Flexible means you can install minimized PHP extensions based on the needs of your PHP application. (Or any PHP extensions you wants.)

You can get into your container and check the included PHP modules by using `php -m`.

You can find these Dockerfiles in the `Testings` folder of this repository [dwchiang/nginx-php-fpm](https://github.com/dwchiang/nginx-php-fpm) on GitHub:

- `Dockerfile-8.5.23-laravel-buster`: Running Laravel 8.5.23 on Buster (Debian 10)
- `Dockerfile-8.5.23-laravel-alpine3.14`: Running Laravel 8.5.23 on Alpine 3.14
- `Dockerfile-8.5.23-laravel-alpine3.13`: Running Laravel 8.5.23 on Alpine 3.13

- `Dockerfile-8.5.23-phpinfo-buster`: Running phpinfo() on Buster (Debian 10)
- `Dockerfile-8.5.23-phpinfo-alpine3.14`: Running phpinfo() on Alpine 3.14
- `Dockerfile-8.5.23-phpinfo-alpine3.13`: Running phpinfo() on Alpine 3.13

This project will **not** upload the images of Part 2 on Docker Hub. 

Please kindly use Part 2 as your Dockerfile reference to build your own Dockerfile, and enjoy the fun :) 

You can also give a try to this [Workshops: Running Laravel on AWS ECS](https://github.com/dwchiang/laravel-on-aws-ecs-workshops).

---

# License

View license information of [nginx](http://nginx.org/LICENSE), [PHP](http://php.net/license/), [Laravel](https://github.com/laravel/laravel) for the software contained in this image.

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

Some additional license information which was able to be auto-detected might be found in [the `repo-info` repository's `nginx/` directory](https://github.com/docker-library/repo-info/tree/master/repos/nginx) and [the `repo-info` repository's `php/` directory](https://github.com/docker-library/repo-info/tree/master/repos/php).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.