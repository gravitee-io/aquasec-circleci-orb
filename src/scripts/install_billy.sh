#!/bin/bash

cd /tmp || exit

curl -sLo install.sh download.codesec.aquasec.com/billy/install.sh
curl -sLo install.sh.checksum https://github.com/argonsecurity/releases/releases/latest/download/install.sh.checksum
if ! sha256sum --check < install.sh.checksum; then
  echo "install.sh checksum failed"
  exit 1
fi

sh install.sh
rm install.sh install.sh.checksum
