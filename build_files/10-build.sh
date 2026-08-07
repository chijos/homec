#!/bin/bash

echo "::group:: ===$(basename "$0")==="

set -eoux pipefail

# Enable nullglob for all glob operations to prevent failures on empty matches
shopt -s nullglob

echo "::group:: Copy in system files"

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

# Set the hostname
echo "${HOST_NAME}" >/etc/hostname

echo "::endgroup::"

echo "::group:: Install packages"

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y tmux

echo "::endgroup::"

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

echo "::group:: Enable Systemd Units"

#### Example for enabling a System Unit File

systemctl enable podman.socket

echo "::endgroup::"

# Restore default glob behavior
shopt -u nullglob

echo "::endgroup:: ===$(basename "$0")==="
