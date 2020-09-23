.PHONY: help version build buildlaravel pushtodockerhub pushtoawsecr test down

VERSION_PHP_FPM        := $(VERSION_PHP_FPM)
VERSION_PHP_FPM_MINOR  := $(shell cut -d '.' -f 1 <<< $(VERSION_PHP_FPM)).$(shell cut -d '.' -f 2 <<< $(VERSION_PHP_FPM))
VERSION_PHP_FPM_MAJOR  := $(shell cut -d '.' -f 1 <<< $(VERSION_PHP_FPM))
VERSION_NGINX          := $(VERSION_NGINX)
VERSION_OS             := $(VERSION_OS)
VERSION                := $(VERSION_PHP_FPM)-fpm-$(VERSION_NGINX)-nginx-$(VERSION_OS)
VERSION_PHP_FPM_MINOR  := $(VERSION_PHP_FPM_MINOR)-fpm-$(VERSION_NGINX)-nginx-$(VERSION_OS)

GIT_COMMIT_HASH  := $(shell git rev-parse --short HEAD)
AWS_REGION       := $(AWS_REGION)
AWS_ACCOUNT_ID   := $(AWS_ACCOUNT_ID)

NAME_VENDOR      := dwchiang
NAME_PROJECT     := nginx-php-fpm
NAME_IMAGE_REPO  := $(NAME_VENDOR)/$(NAME_PROJECT)
TAG_REPO_URI_AWS := $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/$(NAME_IMAGE_REPO)


VERSION_LARAVEL      := $(VERSION_LARAVEL)
NAME_PROJECT_LARAVEL := laravel-$(VERSION_LARAVEL)

help:
	@ echo 'Welcome to Makefile of dwchiang/nginx-php-fpm'
	@ echo
	@ echo 'Usage: make [command]'
	@ echo
	@ echo 'Available Commands:'
	@ echo '  version          check version info'
	@ echo '  build            build base docker image'
	@ echo '  pushtodockerhub  build and push base docker image to Docker Hub'
	@ echo '  pushtoawsecr     build and push base docker image to AWS ECR'
	@ echo '  test             test using docker-compose up'
	@ echo '  down     	       docker-compose down'
	@ echo

version:
	@ echo '{'
	@ echo '  "GIT_COMMIT_HASH": "$(GIT_COMMIT_HASH)",'
	@ echo '  "VERSION_PHP_FPM": "$(VERSION_PHP_FPM)"'
	@ echo '  "VERSION_PHP_FPM_MINOR": "$(VERSION_PHP_FPM_MINOR)"'
	@ echo '  "VERSION_PHP_FPM_MAJOR": "$(VERSION_PHP_FPM_MAJOR)"'
	@ echo '  "VERSION_NGINX": "$(VERSION_NGINX)"'
	@ echo '  "VERSION_OS": "$(VERSION_OS)"'
	@ echo '  "VERSION": "$(VERSION)"'
	@ echo '  "NAME_IMAGE_REPO": "$(NAME_IMAGE_REPO)"'
	@ echo '  "TAG_REPO_URI_AWS": "$(TAG_REPO_URI_AWS)"'
	@ echo '  "VERSION_LARAVEL": "$(VERSION_LARAVEL)"'
	@ echo '  "NAME_PROJECT_LARAVEL": "$(NAME_PROJECT_LARAVEL)"'
	@ echo '}'

build: version
	@ echo '[] Building base image...'

	time docker build \
	-f $(VERSION_OS)/Dockerfile-$(VERSION) \
	-t $(NAME_PROJECT):latest .

	docker tag $(NAME_PROJECT):latest $(NAME_PROJECT):$(VERSION)
	docker tag $(NAME_PROJECT):latest $(NAME_IMAGE_REPO):latest
	docker tag $(NAME_PROJECT):latest $(NAME_IMAGE_REPO):$(VERSION)

	docker images

buildlaravel:
	@ echo '[] Building laravel image...'
	time docker build -f Dockerfile-$(VERSION_LARAVEL)-laravel-$(VERSION_OS) -t $(NAME_PROJECT_LARAVEL):latest .
	docker tag $(NAME_PROJECT_LARAVEL):latest $(NAME_PROJECT_LARAVEL):$(VERSION)

	docker images

pushtodockerhub:
	@ echo '[] Building and pushing to Docker Hub ...'
	# docker push $(NAME_IMAGE_REPO):$(VERSION)

	docker version
	docker buildx ls
	docker buildx create --name buildnginxphpfpm
	docker buildx use buildnginxphpfpm

	time docker buildx build \
	--push \
	--platform=linux/amd64,linux/arm64 \
	-f $(VERSION_OS)/Dockerfile-$(VERSION) \
	-t $(NAME_IMAGE_REPO):$(VERSION) .	

	docker images

pushtoawsecr: build
	@ echo '[] Login AWS ECR ...'
	# Phased out AWS CLI v1
	# aws ecr get-login --no-include-email --region $(AWS_REGION) | /bin/bash

	# Required: AWS CLI v2
	aws ecr get-login-password --region $(AWS_REGION) | docker login --username AWS --password-stdin $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com

	# docker tag $(NAME_IMAGE_REPO):latest $(TAG_REPO_URI_AWS):latest
	# docker tag $(NAME_IMAGE_REPO):latest $(TAG_REPO_URI_AWS):$(VERSION)

	@ echo '[] Pushing to AWS ECR ...'
	# docker push $(TAG_REPO_URI_AWS):$(VERSION)

test:
	docker-compose -f docker-compose-7.25.0-laravel.yml up -d database cache app

	@ echo 'Ready!'
	@ echo ''
	@ echo 'MySQL: expose port:'
	@ echo '  localhost:33062'
	@ echo ''
	@ echo 'Redis: expose port:'
	@ echo '  localhost:63792'
	@ echo ''
	@ echo 'Open your browser and test at: '
	@ echo '  +----------------------------------------------------------+'
	@ echo '  |  http://localhost:8082/                                  |'
	@ echo '  +----------------------------------------------------------+'
	@ echo ''

down:
	docker-compose -f docker-compose-7.25.0-laravel.yml down