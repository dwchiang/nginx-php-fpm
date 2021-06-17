#!/opt/homebrew/bin/zsh
# vim:sw=4:ts=4:et

echo "-----------------------------------------------------------------------------------------------"
echo "\n"
date
pwd

export BUILD_CMD=pushtodockerhub

set -e

### ----------------------------------------------------------
### Please copy from file named: buildOnGitHubActions.sh 
### and paste below.
### ----------------------------------------------------------

export VERSION_OS=alpine3.12

export VERSION_PHP_FPM=8.0.6
export VERSION_NGINX=1.18.0
export VERSION_LARAVEL=8.5.5
export IS_LATEST=false

make $BUILD_CMD

echo "Good job!"
date
echo "-----------------------------------------------------------------------------------------------"