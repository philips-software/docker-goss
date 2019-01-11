#!/usr/bin/env bash

trap 'exit ${?}' ERR

while getopts ":r:i:t:u:p:h" opt; do
  case $opt in
    r)
      export DOCKER_REGISTRY=${OPTARG:-${DOCKER_REGISTRY}}
      ;;
    i)
      export DOCKER_IMAGE=${OPTARG:-${DOCKER_IMAGE}}
      ;;
    t)
      export DOCKER_TAG=${OPTARG:-${DOCKER_TAG}}
      ;;
    u)
      export DOCKER_USERNAME=${OPTARG:-${DOCKER_USERNAME}}
      ;;
    p)
      export DOCKER_PASSWORD=${OPTARG:-${DOCKER__PASSWORD}}
      ;;
    h)
      usage
      ;;
  esac
done
shift $((OPTIND-1))

if  [[ -z $DOCKER_USERNAME  ]] ; then
    export DOCKER_USERNAME=gitlab-ci-token
fi

if  [[ -z $DOCKER_PASSWORD  ]] ; then
    export DOCKER_PASSWORD=$CI_BUILD_TOKEN
fi

if  [[ -z $DOCKER_REGISTRY  ]] ; then
    export DOCKER_REGISTRY=registry.hub.docker.com
fi

export GOSS_FILES_PATH=.

# Docker login
# docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD} ${DOCKER_REGISTRY}

# Run dgoss tests
dgoss run -e DEBUG=true -e PROFILE=docker-container-test -e SERVER_PORT=8080 "${DOCKER_REGISTRY}/${DOCKER_IMAGE}:${DOCKER_TAG}"
