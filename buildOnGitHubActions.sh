#!/bin/sh
# vim:sw=4:ts=4:et

export BUILD_CMD=buildongithubactions

set -e

### --------------------------------------------------------------------
### Debian 10 (buster)
### --------------------------------------------------------------------

export VERSION_OS=buster

### ---------------------------------------------------------------
### Nginx 1.20.1
### ---------------------------------------------------------------

export VERSION_NGINX=1.20.1

### ----------------------------------------------------------
### PHP 8.0

export VERSION_PHP_FPM=8.0.7
export VERSION_LARAVEL=8.5.5
export IS_LATEST=true
make $BUILD_CMD

export VERSION_PHP_FPM=8.0.6
export VERSION_LARAVEL=8.5.5
export IS_LATEST=false
make $BUILD_CMD

### ----------------------------------------------------------
### PHP 7.4

export VERSION_PHP_FPM=7.4.20
export VERSION_LARAVEL=8.5.5
export IS_LATEST=false
make $BUILD_CMD

### ----------------------------------------------------------
### PHP 7.3

export VERSION_PHP_FPM=7.3.28
export VERSION_LARAVEL=8.5.5
export IS_LATEST=false
make $BUILD_CMD

### ---------------------------------------------------------------
### Nginx 1.18.0
### ---------------------------------------------------------------

export VERSION_NGINX=1.18.0

### ----------------------------------------------------------
### PHP 8.0

# export VERSION_PHP_FPM=8.0.6
# export VERSION_LARAVEL=8.5.5
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=8.0.5
# export VERSION_LARAVEL=8.5.5
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=8.0.3
# export VERSION_LARAVEL=8.5.5
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=8.0.2
# export VERSION_LARAVEL=8.5.5
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=8.0.1
# export VERSION_LARAVEL=8.5.5
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=8.0.0
# export VERSION_LARAVEL=8.5.5
# export IS_LATEST=false
# make $BUILD_CMD

### ----------------------------------------------------------
### PHP 7.4

# export VERSION_PHP_FPM=7.4.19
# export VERSION_LARAVEL=8.5.5
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=7.4.18
# export VERSION_LARAVEL=7.30.0
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=7.4.16
# export VERSION_LARAVEL=7.30.0
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=7.4.15
# export VERSION_LARAVEL=7.30.0
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=7.4.14
# export VERSION_LARAVEL=7.30.0
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=7.4.13
# export VERSION_LARAVEL=7.30.0
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=7.4.12
# export VERSION_LARAVEL=7.25.0
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=7.4.11
# export VERSION_LARAVEL=7.25.0
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=7.4.10
# export VERSION_LARAVEL=7.25.0
# export IS_LATEST=false
# make $BUILD_CMD

### ----------------------------------------------------------
### PHP 7.3

# export VERSION_PHP_FPM=7.3.27
# export VERSION_LARAVEL=8.5.5
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=7.3.26
# export VERSION_LARAVEL=7.30.0
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=7.3.25
# export VERSION_LARAVEL=7.30.0
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=7.3.24
# export VERSION_LARAVEL=7.25.0
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=7.3.23
# export VERSION_LARAVEL=7.25.0
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=7.3.22
# export VERSION_LARAVEL=7.25.0
# export IS_LATEST=false
# make $BUILD_CMD

# =============================================================================
# =============================================================================

### --------------------------------------------------------------------
### Alpine 3.13
### --------------------------------------------------------------------

export VERSION_OS=alpine3.13

### ---------------------------------------------------------------
### Nginx 1.20.1
### ---------------------------------------------------------------

export VERSION_NGINX=1.20.1

### ----------------------------------------------------------
### PHP 8.0

export VERSION_PHP_FPM=8.0.7
export VERSION_LARAVEL=8.5.5
export IS_LATEST=false
make $BUILD_CMD

export VERSION_PHP_FPM=8.0.6
export VERSION_LARAVEL=8.5.5
export IS_LATEST=false
make $BUILD_CMD

### ----------------------------------------------------------
### PHP 7.4

export VERSION_PHP_FPM=7.4.20
export VERSION_LARAVEL=8.5.5
export IS_LATEST=false
make $BUILD_CMD

### ----------------------------------------------------------
### PHP 7.3

export VERSION_PHP_FPM=7.3.28
export VERSION_LARAVEL=8.5.5
export IS_LATEST=false
make $BUILD_CMD

### ---------------------------------------------------------------
### Nginx 1.18.0
### ---------------------------------------------------------------

export VERSION_NGINX=1.18.0

### ----------------------------------------------------------
### PHP 8.0

export VERSION_PHP_FPM=8.0.6
export VERSION_LARAVEL=8.5.5
export IS_LATEST=false
make $BUILD_CMD

# =============================================================================
# =============================================================================

### --------------------------------------------------------------------
### Alpine 3.12
### --------------------------------------------------------------------

export VERSION_OS=alpine3.12

### ---------------------------------------------------------------
### Nginx 1.18.0
### ---------------------------------------------------------------

export VERSION_NGINX=1.18.0

### ----------------------------------------------------------
### PHP 8.0

# export VERSION_PHP_FPM=8.0.6
# export VERSION_LARAVEL=8.5.5
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=8.0.5
# export VERSION_LARAVEL=8.5.5
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=8.0.3
# export VERSION_LARAVEL=8.5.5
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=8.0.2
# export VERSION_LARAVEL=8.5.5
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=8.0.1
# export VERSION_LARAVEL=8.5.5
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=8.0.0
# export VERSION_LARAVEL=8.5.5
# export IS_LATEST=false
# make $BUILD_CMD

### ----------------------------------------------------------
### PHP 7.4

# export VERSION_PHP_FPM=7.4.19
# export VERSION_LARAVEL=8.5.5
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=7.4.18
# export VERSION_LARAVEL=7.30.0
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=7.4.16
# export VERSION_LARAVEL=7.30.0
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=7.4.15
# export VERSION_LARAVEL=7.30.0
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=7.4.14
# export VERSION_LARAVEL=7.30.0
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=7.4.13
# export VERSION_LARAVEL=7.30.0
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=7.4.12
# export VERSION_LARAVEL=7.25.0
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=7.4.11
# export VERSION_LARAVEL=7.25.0
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=7.4.10
# export VERSION_LARAVEL=7.25.0
# export IS_LATEST=false
# make $BUILD_CMD

### ----------------------------------------------------------
### PHP 7.3

# export VERSION_PHP_FPM=7.3.27
# export VERSION_LARAVEL=8.5.5
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=7.3.26
# export VERSION_LARAVEL=7.30.0
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=7.3.25
# export VERSION_LARAVEL=7.30.0
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=7.3.24
# export VERSION_LARAVEL=7.25.0
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=7.3.23
# export VERSION_LARAVEL=7.25.0
# export IS_LATEST=false
# make $BUILD_CMD

# export VERSION_PHP_FPM=7.3.22
# export VERSION_LARAVEL=7.25.0
# export IS_LATEST=false
# make $BUILD_CMD
