#!/opt/homebrew/bin/zsh
# vim:sw=4:ts=4:et

echo "-----------------------------------------------------------------------------------------------"
echo "\n"
date
pwd

export AWS_DEFAULT_PROFILE=ernest-global

if docker buildx ls | grep -q buildnginxphpfpm; then
    echo 'found'
    docker buildx rm buildnginxphpfpm
    echo 'buildnginxphpfpm removed'
else
    echo 'not found'
fi

export BUILD_CMD=release

set -e



export VERSION_OS=buster
export VERSION_NGINX=1.21.1
export VERSION_PHP=8.0.10
export IS_LATEST=true
make $BUILD_CMD
