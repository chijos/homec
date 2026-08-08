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
# We'll add a once-off systemd unit that runs this at first boot and joins the
#  machine to the tailnet.

# Clean up repo file (required - repos don't work at runtime in bootc images)
rm -f /etc/yum.repos.d/tailscale.repo

echo "Tailscale installed successfully"

echo "::endgroup::"

# Restore default glob behavior
shopt -u nullglob

echo "::endgroup:: ===$(basename "$0")==="
