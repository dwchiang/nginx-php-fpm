#!/opt/homebrew/bin/zsh
# vim:sw=4:ts=4:et

echo "-----------------------------------------------------------------------------------------------"
echo "Hihi starts releasing"
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
# export BUILD_CMD=releaseDockerHub

set -e



export VERSION_OS=bullseye
export VERSION_NGINX=1.24.0
export VERSION_PHP=8.2.5
export IS_LATEST=true
make $BUILD_CMD
