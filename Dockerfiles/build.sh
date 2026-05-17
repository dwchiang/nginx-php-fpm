#!/usr/bin/env zsh
# vim:sw=4:ts=4:et

echo "\n"
echo "-----------------------------------------------------------------------------------------------"
echo "Hihi starts releasing"
echo "-----------------------------------------------------------------------------------------------"
echo "\n"
date
pwd
echo "-----------------------------------------------------------------------------------------------"

export AWS_DEFAULT_PROFILE=ernest-global

if docker buildx ls | grep -q buildnginxphpfpm; then
    echo '[v] found buildnginxphpfpm'
    docker buildx rm buildnginxphpfpm
    echo '[v] buildnginxphpfpm removed'
else
    echo '[v] not found buildnginxphpfpm. clean to continue.'
fi

export BUILD_CMD=release
# export BUILD_CMD=releaseDockerHub

set -e



export VERSION_OS=trixie
export VERSION_NGINX=1.31.0
export VERSION_PHP=8.5.6
export IS_LATEST=true
make $BUILD_CMD
