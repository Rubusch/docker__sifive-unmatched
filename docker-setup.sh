#!/bin/sh -e

## base image
IMAGE="sandbox"

TAG="$(grep "ENV DOCKER_BASE_TAG" -r ./docker/build_context/Dockerfile | awk -F= '{ print $2 }')"
TAG="${TAG//\"}"

CONTAINER="$(docker images | grep "/${IMAGE}" | grep "${TAG}" | awk '{print $3}')"

if [ -z "${CONTAINER}" ]; then
	git clone "https://github.com/Rubusch/docker__${IMAGE}.git" "${IMAGE}"
	pushd ./"${IMAGE}" &> /dev/null
	echo "UID=$(id -u)" > .env
	echo "GID=$(id -g)" >> .env
	docker-compose up
	popd &> /dev/null
fi

## docker container
cd ./docker
echo "UID=$(id -u)" > .env
echo "GID=$(id -g)" >> .env
docker-compose up

echo "READY."

