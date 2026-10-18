#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

# Helper scripts must be executable no matter what file modes git recorded
chmod 755 /usr/libexec/muse-firstboot.sh /usr/bin/muse-join-tailscale /usr/bin/muse-join-launcher
chmod 644 /etc/ssh/authorized_keys

# Remote access wiring:
# - sshd: enabled. Key auth via the system-level /etc/ssh/authorized_keys
#   (see system_files/etc/ssh/sshd_config.d/60-muse-access.conf), so it works
#   for whichever local user is created at install time.
# - tailscaled: enabled. No auth key is baked into this image; the tailnet
#   join happens interactively at first login (muse-join-tailscale).
# - muse-firstboot: armed until the join completes.
systemctl enable sshd.service
systemctl enable tailscaled.service
systemctl enable muse-firstboot.service
