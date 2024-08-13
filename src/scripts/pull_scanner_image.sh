#!/bin/bash

echo "${!PARAM_AQUA_PASSWORD}" | docker login registry.aquasec.com -u "${!PARAM_AQUA_USERNAME}" --password-stdin
docker pull registry.aquasec.com/scanner:latest-saas
