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
      export GITLAB_USERNAME=${OPTARG:-${GITLAB_USERNAME}}
      ;;
    p)
      export GITLAB_PASSWORD=${OPTARG:-${GITLAB_PASSWORD}}
      ;;
    h)
      usage
      ;;
  esac
done
shift $((OPTIND-1))

if  [[ -z $GITLAB_USERNAME  ]] ; then
    export GITLAB_USERNAME=gitlab-ci-token
fi

if  [[ -z $GITLAB_PASSWORD  ]] ; then
    export GITLAB_PASSWORD=$CI_BUILD_TOKEN
fi

printf "GITLAB USER:${GITLAB_USERNAME}";

export GOSS_FILES_PATH=.

# Docker login
docker login -u ${GITLAB_USERNAME} -p ${GITLAB_PASSWORD} ${DOCKER_REGISTRY}

# Run dgoss tests
dgoss run -e DEBUG=true -e PROFILE=docker-container-test -e SERVER_PORT=8080 "${DOCKER_REGISTRY}/${DOCKER_IMAGE}:${DOCKER_TAG}"
