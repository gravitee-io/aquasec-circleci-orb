#!/bin/bash

if [ -z "${ARTIFACT_TO_REGISTER}" ]; then
  DOCKER_ARTIFACT=$(awk '{for(i=1; i<=NF; i++) printf "--artifact-path " $i " "}' < "${BUILT_DOCKER_IMAGES_FILE}")
else
  DOCKER_ARTIFACT="--artifact-path ${ARTIFACT_TO_REGISTER}"
fi

if [ "${DEBUG}" == "1" ]; then
  export
  set -x

  # shellcheck disable=SC2086
  /tmp/billy health -v --aqua-key ${AQUA_KEY} --aqua-secret ${AQUA_SECRET} --access-token ${GITHUB_TOKEN} ${DOCKER_ARTIFACT}
fi

if [ -z "${DOCKER_ARTIFACT}" ]; then
  echo "No artifact to register."
else
  COMMAND="/tmp/billy generate -v --aqua-key ${AQUA_KEY} --aqua-secret ${AQUA_SECRET} --access-token ${GITHUB_TOKEN} ${DOCKER_ARTIFACT}"

  if [ "${DRY_RUN}" == "1" ]; then
    echo "DRY_RUN: Running command: ${COMMAND}"
  else
    eval "${COMMAND}"
  fi
fi
