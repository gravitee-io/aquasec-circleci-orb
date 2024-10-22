#!/bin/bash

OPTIONS=""

if [ "${DEBUG}" == "1" ]; then
  export
  set -x

  OPTIONS="$OPTIONS --debug"
fi

if [ "${SAST}" == "1" ]; then
  export
  set -x

  OPTIONS="$OPTIONS --sast"
fi

if [ "${REACHABILITY}" == "1" ]; then
  export
  set -x

  OPTIONS="$OPTIONS --reachability"
fi

# Use the workflow id as the build id
export OVERRIDE_BUILD_ID=${CIRCLE_WORKFLOW_ID}
export CIRCLE_BUILD_NUM=${CIRCLE_WORKFLOW_ID}

# shellcheck disable=SC2086
trivy fs $OPTIONS --scanners $SCANNERS .
