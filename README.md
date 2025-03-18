# dwchiang/nginx-php-fpm

A Docker image (Dockerfile) that merged nginx & php-fpm into one bite on Debian/Alpine for 

- modern applications, 
- cloud native designs, 
- AWS Fargate, 
- Amazon ECS/EKS, 
- amd64/arm64 (e.g. AWS Graviton). 

Brought to you by Ernest Chiang (an [AWS Community Hero](https://www.ernestchiang.com/en/about/)), and Irvine Chang.

---

Latest Semver | ![Docker Image Version (latest semver)](https://img.shields.io/docker/v/dwchiang/nginx-php-fpm)
 | License | ![GitHub](https://img.shields.io/github/license/dwchiang/nginx-php-fpm)
 | Docker | ![Docker Pulls](https://img.shields.io/docker/pulls/dwchiang/nginx-php-fpm)
 | ![Docker Stars](https://img.shields.io/docker/stars/dwchiang/nginx-php-fpm)
 | GitHub | ![GitHub Repo stars](https://img.shields.io/github/stars/dwchiang/nginx-php-fpm)
 | ![GitHub forks](https://img.shields.io/github/forks/dwchiang/nginx-php-fpm)

---

- Designed for running Laravel framework and all other PHP-based application modernization on cloud native.
- Performance analysis report: 
  - [Laravel PHP8/PHP7 Debian/Alpine Container Performance Comparison](https://www.ernestchiang.com/en/posts/2021/benchmark-nginx-php-fpm-between-buster-alpine/)
    - e.g. Test Page: Default Homepage (More is Better)

        ![](https://www.ernestchiang.com/img/2021/2021-04-17-benchmark-nginx-php-fpm-between-buster-alpine/chart-laravel-8-49-1-homepage-2021-0706_hu26fe3bec41e8874ae3b32a12f7791390_13081_600x0_resize_box_3.png)
  - [nginx-php-fpm PHP Benchmark (2024Q3) - PHP8/PHP7 Debian/Alpine](https://www.ernestchiang.com/en/posts/2024/nginx-php-fpm-benchmark/)
    - Preview: RPS (phpinfo) Benchmark of nginx-php-fpm (More is Better)

        ![](https://www.ernestchiang.com/img/2024/2024-10-01-nginx-php-fpm-benchmark-2024-q3/nginx-php-fpm-01-phpinfo-rps-03-1-median-by-php-minor_hu1797304296480794470.png)
    - Preview: Latency RPS (phpinfo) Benchmark of nginx-php-fpm (Fewer is Better)

        ![](https://www.ernestchiang.com/img/2024/2024-10-01-nginx-php-fpm-benchmark-2024-q3/nginx-php-fpm-01-phpinfo-latency-02-dot-by-php-minor-color_hu8860910529677386963.png)
  - [nginx-php-fpm PHP Benchmark (2024Q1) - PHP8/PHP7 Debian/Alpine](https://www.ernestchiang.com/en/posts/2024/nginx-php-fpm-benchmark-2024-q1/)
    - Preview: RPS (phpinfo) Benchmark of nginx-php-fpm (More is Better)

        ![](https://www.ernestchiang.com/img/2024/2024-03-31-nginx-php-fpm-benchmark-2024-q1/nginx-php-fpm-01-phpinfo-rps-03-1-median-by-php-minor_hue6fe3b2f100ef95417a96698b46e9874_90820_800x0_resize_box_3.png)
    - Preview: Latency RPS (phpinfo) Benchmark of nginx-php-fpm (Fewer is Better)

        ![](https://www.ernestchiang.com/img/2024/2024-03-31-nginx-php-fpm-benchmark-2024-q1/_hu7aab1fd42c514b5335117d7e1ea2704e_90147_da2648393e90f351e1fdb48aae090f1d.png)

---

# Quick reference

- **Supported architectures**: Across `amd64` | `arm64`.
- **Supported PHP versions**: Across `8.4` | `8.3` | `8.2` | `8.1` | `8.0` | `7.4` | `7.3` | `7.2`
- **Supported OS versions**: Across `bookworm` | `bullseye` | `buster` | `alpine3.21` | `alpine3.20` | `alpine3.19` | `alpine3.18` | `alpine3.17` | `alpine3.16` | `alpine3.15` | `alpine3.14` | `alpine3.13`. (Based on PHP official image tags and Nginx official image OS version.)
- **Supported Nginx versions**: Across `1.27.4` | `1.27.1` | `1.27.0` | `1.26.2` | `1.26.0` | `1.25.4` | `1.25.3` | `1.25.2` | `1.24.0` | `1.22.1` | `1.21.6` | `1.21.1` | `1.20.2` | `1.20.1`
- **Maintained by**: [Ernest Chiang](https://www.ernestchiang.com/), Irvine Chang
- **Where to file issues**: [https://github.com/dwchiang/nginx-php-fpm/issues](https://github.com/dwchiang/nginx-php-fpm/issues)
- **Source**: [https://github.com/dwchiang/nginx-php-fpm](https://github.com/dwchiang/nginx-php-fpm)
- **Registry**: [AWS ECR Public](https://gallery.ecr.aws/dwchiang/nginx-php-fpm), and [Docker Hub](https://hub.docker.com/r/dwchiang/nginx-php-fpm).
- **Benchmark**: [Benchmark.md](https://github.com/dwchiang/nginx-php-fpm/blob/master/docs/Benchmark.md) and my [blog](https://www.ernestchiang.com/en/posts/2021/benchmark-nginx-php-fpm-between-buster-alpine/).
- **Maintenance**: [Maintenance.md](https://github.com/dwchiang/nginx-php-fpm/blob/master/docs/Maintenance.md)

---

# Why Support This Project?

Our open-source project, "dwchiang/nginx-php-fpm," provides a Docker image essential for running modern PHP applications in cloud-native ecosystems. Crafted with ❤️ by Ernest Chiang, an AWS Community Hero, and Irvine Chang, this project makes deploying Laravel and other PHP apps across various environments and architectures simpler.

Supporting us ensures continuous improvement, updates to the latest PHP and Nginx versions, and maintenance of this tool that many developers depend on for deploying PHP applications efficiently and securely on platforms like AWS Fargate and Amazon ECS/EKS. Your sponsorship will directly contribute to:

- 🔄 Regular updates and compatibility checks
- 🛠️ Ongoing maintenance and support
- 📚 Extensive documentation and community engagement

Whether by starring ⭐ our [GitHub repository](https://github.com/dwchiang/nginx-php-fpm) or [Docker Hub](https://hub.docker.com/r/dwchiang/nginx-php-fpm), [letting us know how you use it](https://forms.gle/yvEeR2D1voc7sJbaA), or offering financial support through "[Buy me a coffee](https://www.buymeacoffee.com/ernestchiang)," your support empowers us to keep building and maintaining this essential resource for developers worldwide.

Join us in making PHP application deployment better and more accessible for everyone. Thank you for your support and trust in our project!

---

# Supported Image Tags

- **Full tag list** (included older tags): [https://github.com/dwchiang/nginx-php-fpm/blob/master/docs/Tags.md](https://github.com/dwchiang/nginx-php-fpm/blob/master/docs/Tags.md)
- Starting from 2023-09-08, the project will build the last 5 PHP version of the same combination of PHP, OS and Nginx at the build moment to reduce the storage spending on AWS ECR Public.
- Starting from 2023-04-27, the project has decided to maintain the latest version of each PHP branch due to the increasing mixed results observed when combining different versions of PHP, OS, and Nginx.
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

---

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=dwchiang/nginx-php-fpm&type=Date)](https://star-history.com/#dwchiang/nginx-php-fpm&Date)
