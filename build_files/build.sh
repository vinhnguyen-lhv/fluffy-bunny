#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
# dnf5 install -y tmux 

RELEASEVER=$(grep '^VERSION_ID=' /etc/os-release | cut -d'=' -f2)
rpm --import https://fcitx5-lotus.pages.dev/pubkey.gpg
rpm --import https://pkg.cloudflareclient.com/pubkey.gpg

curl -fsSl https://pkg.cloudflareclient.com/cloudflare-warp-ascii.repo | sudo tee /etc/yum.repos.d/cloudflare-warp.repo
dnf config-manager addrepo --from-repofile=https://fcitx5-lotus.pages.dev/rpm/fedora/fcitx5-lotus-$RELEASEVER.repo

dnf5 install -y fcitx5-lotus krusader

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

# systemctl enable podman.socket
