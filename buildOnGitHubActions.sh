#!/bin/sh
# vim:sw=4:ts=4:et

export BUILD_CMD=buildongithubactions

set -e

### ----------------------------------------------------------
### Alpine 3.12
### ----------------------------------------------------------

export VERSION_OS=alpine3.12

### ----------------------------------------------------------
### PHP 7.4

export VERSION_PHP_FPM=7.4.12
export VERSION_NGINX=1.18.0
export VERSION_LARAVEL=7.25.0
export IS_LATEST=false

# make $BUILD_CMD

export VERSION_PHP_FPM=7.4.11
export VERSION_NGINX=1.18.0
export VERSION_LARAVEL=7.25.0
export IS_LATEST=false

# make $BUILD_CMD

export VERSION_PHP_FPM=7.4.10
export VERSION_NGINX=1.18.0
export VERSION_LARAVEL=7.25.0
export IS_LATEST=false

# make $BUILD_CMD

### ----------------------------------------------------------
### PHP 7.3

export VERSION_PHP_FPM=7.3.24
export VERSION_NGINX=1.18.0
export VERSION_LARAVEL=7.25.0
export IS_LATEST=false

# make $BUILD_CMD

export VERSION_PHP_FPM=7.3.23
export VERSION_NGINX=1.18.0
export VERSION_LARAVEL=7.25.0
export IS_LATEST=false

# make $BUILD_CMD

export VERSION_PHP_FPM=7.3.22
export VERSION_NGINX=1.18.0
export VERSION_LARAVEL=7.25.0
export IS_LATEST=false

# make $BUILD_CMD

### ----------------------------------------------------------
### Debian 10 (buster)
### ----------------------------------------------------------

export VERSION_OS=buster

### ----------------------------------------------------------
### PHP 7.4

export VERSION_PHP_FPM=7.4.12
export VERSION_NGINX=1.18.0
export VERSION_LARAVEL=7.25.0
export IS_LATEST=true

make $BUILD_CMD

export VERSION_PHP_FPM=7.4.11
export VERSION_NGINX=1.18.0
export VERSION_LARAVEL=7.25.0
export IS_LATEST=false

# make $BUILD_CMD

export VERSION_PHP_FPM=7.4.10
export VERSION_NGINX=1.18.0
export VERSION_LARAVEL=7.25.0
export IS_LATEST=false

# make $BUILD_CMD

### ----------------------------------------------------------
### PHP 7.3

export VERSION_PHP_FPM=7.3.24
export VERSION_NGINX=1.18.0
export VERSION_LARAVEL=7.25.0
export IS_LATEST=false

make $BUILD_CMD

export VERSION_PHP_FPM=7.3.23
export VERSION_NGINX=1.18.0
export VERSION_LARAVEL=7.25.0
export IS_LATEST=false

# make $BUILD_CMD

export VERSION_PHP_FPM=7.3.22
export VERSION_NGINX=1.18.0
export VERSION_LARAVEL=7.25.0
export IS_LATEST=false

# make $BUILD_CMD