#!/bin/bash

echo "::group:: ===$(basename "$0")==="

set -eoux pipefail

# Enable nullglob for all glob operations to prevent failures on empty matches
shopt -s nullglob

echo "::group:: Install TailScale"

# Add the tailscale repository
curl https://pkgs.tailscale.com/stable/fedora/tailscale.repo -o /etc/yum.repos.d/tailscale.repo

# Install Tailscale
dnf5 -y install tailscale

# Enable and start tailscaled
systemctl enable tailscaled

# Tailscale docs say this is where you would start Tailscale with `tailscale up`.
# But systemd is not actually running at this point, and so neither is tailscaled.
# I don't want to embed a auth-key in the image, so the safest way to get this joined
#  to the tailnet is to authenticate it manually on first boot.

# Clean up repo file (required - repos don't work at runtime in bootc images)
rm -f /etc/yum.repos.d/tailscale.repo

echo "Tailscale installed successfully"

echo "::endgroup::"

# Restore default glob behavior
shopt -u nullglob

echo "::endgroup:: ===$(basename "$0")==="
