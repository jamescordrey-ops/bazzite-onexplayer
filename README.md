# bazzite-onexplayer

Custom [Bazzite](https://bazzite.gg) Deck image for a Ryzen 7 6800U handheld
(ONEXPLAYER 2), built with the Universal Blue
[image-template](https://github.com/ublue-os/image-template). Based on
`ghcr.io/ublue-os/bazzite-deck:stable`.

## What is different from stock Bazzite

Kept deliberately small:

- **sshd enabled**, key-only. Muse's public key is authorized through a
  system-level path (`/etc/ssh/authorized_keys`, see
  `system_files/etc/ssh/sshd_config.d/60-muse-access.conf`), so it works for
  whichever local user is created at install time. No password SSH logins.
- **tailscaled enabled.** No Tailscale auth key is baked into the image. At
  first graphical login a terminal opens (`muse-join-tailscale`) and asks for
  the auth key, then runs `tailscale up --ssh --hostname=handheld`.
- **Decky Loader** is installed by that same first-login script (official
  installer), which also reports whether Handheld Daemon (HHD) is active.
- Bazzite already ships the Tailscale binaries and HHD; nothing is duplicated.

No personal information (names, addresses, emails, network names) is stored
in this repository or in the built image.

## Switch a Bazzite install to this image

Install stock Bazzite Deck first, then:

```bash
sudo bootc switch ghcr.io/jamescordrey-ops/bazzite-onexplayer:stable
sudo systemctl reboot
```

After the first successful build, the GHCR package must be set to **public**
(package settings on GitHub) so the switch works without a registry login.

## Signing

Builds sign the image with cosign. The private key lives only in the
repository's `SIGNING_SECRET` Actions secret; `cosign.pub` in this repo is
the matching public key. Builds fail at the signing step until that secret
exists.
