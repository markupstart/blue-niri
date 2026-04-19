#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

#  install packages from fedora repos
dnf install -y dnf5-plugins \
rocminfo \
rocm-hip \
rocm-device-libs \
rocm-opencl \
nextcloud-client \
darktable \
DankMaterialShell \
inotify-tools \
system-config-printer \
printer-driver-brlaser \
cups \
cups-browsed \
cups-filters \
cups-pdf \
mate-polkit \
thunar \
thunar-volman \
thunar-media-tags-plugin \
thunar-vcs-plugin \
thunar-archive-plugin \
tumbler \
pavucontrol \
cargo \
pamixer \
libreoffice \
swappy \
kitty \
foot \
libsixel \
xwayland-satellite \
niri \

#  COPR:
#nwg-look
dnf5 -y copr enable markupstart/nwg-shell
dnf5 -y install nwg-look
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable markupstart/nwg-shell
#for bottom process monitor
dnf5 -y copr enable atim/bottom
dnf5 -y install bottom
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable atim/bottom
#change pretty name
sed -i "s|^PRETTY_NAME=.*|PRETTY_NAME=\"blue-niri\"|" /usr/lib/os-release
chmod +x /usr/bin/xwayland-satellite

