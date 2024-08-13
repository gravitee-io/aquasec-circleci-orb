#!/bin/bash

# https://circleci.com/docs/orbs-best-practices/#accepting-parameters-as-strings-or-environment-variables
SCANNER_TOKEN="${!PARAM_SCANNER_TOKEN}"

if [ -z "${DOCKER_IMAGE_TO_SCAN}" ]; then
  while IFS="" read -r line || [ -n "$line" ]
  do
    docker run -v /var/run/docker.sock:/var/run/docker.sock registry.aquasec.com/scanner:latest-saas scan -H "${SCANNER_URL}" -A "${SCANNER_TOKEN}" --local "${line}" --socket docker
  done < "${BUILT_DOCKER_IMAGES_FILE}"
else
    docker run -v /var/run/docker.sock:/var/run/docker.sock registry.aquasec.com/scanner:latest-saas scan -H "${SCANNER_URL}" -A "${SCANNER_TOKEN}" --local "${DOCKER_IMAGE_TO_SCAN}" --socket docker
fi
