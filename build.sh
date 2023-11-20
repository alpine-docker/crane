#!/usr/bin/env bash

# Prerequisite
# Make sure you set secret enviroment variables in CI
# DOCKER_USERNAME
# DOCKER_PASSWORD

# set -ex

set -e

install_jq() {
  # jq 1.6
  DEBIAN_FRONTEND=noninteractive
  #sudo apt-get update && sudo apt-get -q -y install jq
  curl -sL https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -o jq
  sudo mv jq /usr/bin/jq
  sudo chmod +x /usr/bin/jq
}

build() {
  platform="linux/arm/v7,linux/arm64/v8,linux/arm/v6,linux/amd64,linux/ppc64le,linux/s390x"

  if [[ "$CIRCLE_BRANCH" == "master" ]]; then
    docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
    docker buildx create --use
    docker buildx build --no-cache --push \
      --platform=${platform} \
      --build-arg VERSION=v${tag} \
      -t ${image}:latest \
      -t ${image}:${tag} .
  fi
}

image="alpine/crane"

install_jq

# Get the latest release version.
tag=$(curl -s "https://api.github.com/repos/google/go-containerregistry/releases/latest" | jq -r '.tag_name' |sed 's/v//')
echo "latest versions: ${tag}"

status=$(curl -sL https://hub.docker.com/v2/repositories/${image}/tags/${tag})
echo $status
if [[ ( "${status}" =~ "not found" ) ||( ${REBUILD} == "true" ) ]]; then
   echo "build image for ${tag}"
   build
fi
