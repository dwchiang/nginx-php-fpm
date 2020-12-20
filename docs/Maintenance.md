# Maintenance

## Check upstream: php

- [Check php-fpm version](https://github.com/docker-library/docs/blob/master/php/README.md#supported-tags-and-respective-dockerfile-links)
- [Check php-fpm Dockerfile](https://github.com/docker-library/php)

## Check upstream: nginx

- [Check nginx Dockerfile](https://github.com/nginxinc/docker-nginx)

## Build Base Image

OS Variants

```
export VERSION_OS=alpine3.12
# or
export VERSION_OS=buster
```

Build:

```
# Assign versions
export VERSION_OS=alpine3.12
# or
export VERSION_OS=buster

export VERSION_PHP_FPM=7.4.10
export VERSION_NGINX=1.18.0
export VERSION_LARAVEL=7.25.0

# Double check version info
make version

# Build
make build
```

## Test with Laravel

### Prepare a folder with Laravel source

- Ref: [https://laravel.com/docs/master/installation](https://laravel.com/docs/master/installation)
- x.y.z = 
    - `7.25.0` to test with php `7.4.x`, `7.3.x`. In the beginning phase of this project.
    - `7.30.0` to test with php `8.0.x`, `7.4.x`, `7.3.x`. Since 2020-12-20.
    - `8.5.5` to test with php `8.0.x`, `7.4.x`, `7.3.x`. Since 2020-12-20.

Format:

```
composer create-project --prefer-dist laravel/laravel:x.y.z laravel-x.y.z
```

Example:

```
composer create-project --prefer-dist laravel/laravel:7.25.0 laravel-7.25.0

composer create-project --prefer-dist laravel/laravel:7.30.0 laravel-7.30.0

composer create-project --prefer-dist laravel/laravel:8.5.5 laravel-8.5.5
```

### Build docker image with this source folder

```
# Assign versions
export VERSION_OS=alpine3.12
# or
export VERSION_OS=buster

export VERSION_PHP_FPM=7.4.10
export VERSION_NGINX=1.18.0
export VERSION_LARAVEL=7.25.0

# Double check version info
make version

# Build
make buildlaravel

# Test
make test

# Finish the Test
make down
```
