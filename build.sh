#!/opt/homebrew/bin/zsh
# vim:sw=4:ts=4:et

echo "-----------------------------------------------------------------------------------------------"
echo "\n"
date
pwd

if docker buildx ls | grep -q buildnginxphpfpm; then
    echo 'found'
    docker buildx rm buildnginxphpfpm
    echo 'buildnginxphpfpm removed'
else
    echo 'not found'
fi

export BUILD_CMD=pushtodockerhub

set -e

### ----------------------------------------------------------
### Please copy from file named: buildOnGitHubActions.sh 
### and paste below.
### ----------------------------------------------------------

export VERSION_OS=buster

export VERSION_NGINX=1.20.1

export VERSION_PHP_FPM=8.0.7
export VERSION_LARAVEL=8.5.5
export IS_LATEST=true

make $BUILD_CMD

echo "Good job!\n"
date
echo "-----------------------------------------------------------------------------------------------"