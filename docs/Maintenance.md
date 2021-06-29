# Maintenance

# Step 1: Check upstream

To see if there is any new version and changes in Dockerfile.

## 1.1 Check upstream: php

- [Check php-fpm version](https://github.com/docker-library/docs/blob/master/php/README.md#supported-tags-and-respective-dockerfile-links)
- [Check php-fpm Dockerfile](https://github.com/docker-library/php)


### alpine3.12 --> alpine3.13 (2021-0629)

- Created `alpine3.13` folder

## 1.2 Check upstream: nginx

- [Check nginx Dockerfile](https://github.com/nginxinc/docker-nginx)

### nginx 1.18.0 --> 1.20.1 (2021-0629)

- Changed from `STOPSIGNAL SIGTERM` (1.18.0) to `STOPSIGNAL SIGQUIT` (1.20.1)
- Added `buster/scripts/30-tune-worker-processes.sh`
- Added `alpine3.13/scripts/30-tune-worker-processes.sh`


---

# Step 2: Build Base Image

## 2.1 Duplicate a Dockerfile

Goal: Dupicate a Dockerfile to match latest version codes of php-fpm and nginx, based on the existing Dockerfile of this project under `./buster/` and/or `./alpine3.12`.

Method: Execute below in shell:

```
# Operation System version
export VERSION_OS=alpine3.13
# or
export VERSION_OS=buster

# PHP FPM version
export VERSION_PHP_FPM_EXISTING=8.0.6
export VERSION_PHP_FPM=8.0.7

# Nginx version
export VERSION_NGINX_EXISTING=1.20.1
export VERSION_NGINX=1.20.1

# Laravel version
export VERSION_LARAVEL=8.5.5

# Dockerfile filenames
export PFN_DOCKERFILENAME_EXISTING=${VERSION_OS}/Dockerfile-${VERSION_PHP_FPM_EXISTING}-fpm-${VERSION_NGINX_EXISTING}-nginx-${VERSION_OS}
export PFN_DOCKERFILENAME=${VERSION_OS}/Dockerfile-${VERSION_PHP_FPM}-fpm-${VERSION_NGINX}-nginx-${VERSION_OS}

# Duplicate
cp $PFN_DOCKERFILENAME_EXISTING $PFN_DOCKERFILENAME

# Replace version string in the Dockerfile
sed -i '' "s|${VERSION_PHP_FPM_EXISTING}|${VERSION_PHP_FPM}|g" $PFN_DOCKERFILENAME
sed -i '' "s|${VERSION_NGINX_EXISTING}|${VERSION_NGINX}|g" $PFN_DOCKERFILENAME
```

## 2.2 Build

```
# Double check version info
make version

# Build
make build
```


---

# Step 3: Test with Laravel

## 3.1 Prepare a folder with Laravel source

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

## 3.2 Build docker image with this Laravel source folder

```
# Assign versions
export VERSION_OS=alpine3.12
# or
export VERSION_OS=buster

export VERSION_PHP_FPM=8.0.1
export VERSION_NGINX=1.18.0
export VERSION_LARAVEL=8.5.5

# Double check version info
make version

# Build
make buildlaravel

# Test
make test

# Finish the Test
make down
```

---

# Step 4: Update Build Scripts

- Type Golden (GitHubActions): `buildOnGitHubActions.sh` is using `buildongithubactions` as build command. 
    - It's designed to run on **GitHub Actions** and push into Docker Hub and AWS ECR Public.

```
vim buildOnGitHubActions.sh
```

- Type Local: `build.sh` and `buildOnLocal.sh` is using `pushtodockerhub` as build command. 
    - There is only one line different between these build files. I usually update `buildOnGitHubActions.sh` as the golden sample.
    - It's designed to run on **local machine** and push into Docker Hub and AWS ECR Public.

```
vim build.sh
```

---

# Step 5: Update README.md

- Update Tags.