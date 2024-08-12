#!/bin/bash

cd /tmp
curl -sLo install.sh download.codesec.aquasec.com/billy/install.sh
curl -sLo install.sh.checksum https://github.com/argonsecurity/releases/releases/latest/download/install.sh.checksum
if ! cat install.sh.checksum | sha256sum --check; then
  echo "install.sh checksum failed"
  exit 1
fi

# https://circleci.com/docs/orbs-best-practices/#accepting-parameters-as-strings-or-environment-variables
BINDIR=$(circleci env subst "${BIN_DIR}") sh install.sh
rm install.sh install.sh.checksum
