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

# shellcheck disable=SC2086
trivy fs $OPTIONS --scanners $SCANNERS .
