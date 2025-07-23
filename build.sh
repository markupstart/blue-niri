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
wofi \
inotify-tools \
system-config-printer \
printer-driver-brlaser \
cups \
cups-browsed \
cups-filters \
cups-pdf \
mate-polkit \
mako \
thunar \
thunar-volman \
thunar-media-tags-plugin \
thunar-vcs-plugin \
thunar-archive-plugin \
tumbler \
copyq \
swaybg \
swaylock \
swayidle \
pavucontrol \
waybar \
cargo \
pamixer \
libreoffice \
swayimg \
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
#swayosd
dnf5 -y copr enable markupstart/SwayOSD
dnf5 -y install swayosd
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable markupstart/SwayOSD
#for swww
dnf5 -y copr enable alebastr/sway-extras
dnf5 -y install swww
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable alebastr/sway-extras
#for bottom process monitor
dnf5 -y copr enable atim/bottom
dnf5 -y install bottom
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable atim/bottom
#change pretty name
sed -i "s|^PRETTY_NAME=.*|PRETTY_NAME=\"blue-niri\"|" /usr/lib/os-release
chmod +x /usr/bin/xwayland-satellite

