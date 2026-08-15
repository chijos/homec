#!/bin/bash

echo "::group:: ===$(basename "$0")==="

set -eoux pipefail

# Enable nullglob for all glob operations to prevent failures on empty matches
shopt -s nullglob

echo "::group:: install cloud-init"

dnf5 -y install cloud-init

mkdir -p /etc/cloud/cloud.cfg.d
cat <<EOF >/etc/cloud/cloud.cfg.d/10_datasource.cfg
datasource:
  NoCloud:
    seedfrom: "${CLOUD_INIT_DATASOURCE_URL}"
EOF

echo "::endgroup::"

# Restore default glob behavior
shopt -u nullglob

echo "::endgroup:: ===$(basename "$0")==="
