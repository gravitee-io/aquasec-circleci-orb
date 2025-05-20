#!/bin/bash

RegisterArtifact() {
  if [ -z "$1" ]; then
    echo "No artifact to register."
  else
    if [ "${DEBUG}" == "1" ]; then
      set -x

      # shellcheck disable=SC2086
      /tmp/billy health -v --aqua-key ${AQUA_KEY} --aqua-secret ${AQUA_SECRET} --access-token ${GITHUB_TOKEN} --artifact-path $1
    fi

    COMMAND="/tmp/billy generate -v --aqua-key ${AQUA_KEY} --aqua-secret ${AQUA_SECRET} --access-token ${GITHUB_TOKEN} --artifact-path $1"
    if [ "${DRY_RUN}" == "1" ]; then
      echo "DRY_RUN: Running command: ${COMMAND}"
    else
      eval "${COMMAND}"
    fi
  fi
}

if [ -z "${ARTIFACT_TO_REGISTER}" ]; then
  while IFS="" read -r line || [ -n "$line" ]
  do
    RegisterArtifact "${line}"
  done < "${BUILT_DOCKER_IMAGES_FILE}"
else
  RegisterArtifact "${ARTIFACT_TO_REGISTER}"
fi
