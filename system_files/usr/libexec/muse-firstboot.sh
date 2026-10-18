#!/bin/bash
# First-boot helper: keep the remote-access services up until the
# interactive Tailscale join (muse-join-tailscale, autostarted at first
# graphical login) has completed. Idempotent.
set -u
mkdir -p /var/lib/muse
systemctl enable --now tailscaled.service 2>/dev/null || true
systemctl enable --now sshd.service 2>/dev/null || true
exit 0
