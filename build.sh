#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

#  install packages from fedora repos
dnf install -y darktable \
nextcloud-client \
fuzzel \
lxpolkit \
dunst \
swaybg \
swayidle \
swaylock \
pavucontrol \
waybar

#  COPR:
#
dnf5 -y copr enable yalter/niri
dnf5 -y install niri
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable yalter/niri 

dnf5 -y copr enable ulysg/xwayland-satellite
dnf5 -y install xwayland-satellite
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable ulysg/xwayland-satellite

dnf5 -y copr enable celestelove/SwayOSD
dnf5 -y install swayosd
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable celestelove/SwayOSD



#### Example for enabling a System Unit File

#systemctl enable podman.socket
