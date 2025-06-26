#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

#  install packages from fedora repos
dnf install -y dnf5-plugins \
nextcloud-client \
darktable \
wofi \
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

#  COPR:
#niri
dnf5 -y copr enable yalter/niri
dnf5 -y install niri
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable yalter/niri 
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
#for ghostty
dnf5 -y copr enable xeriab/ghostty
dnf5 -y install ghostty
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable xeriab/ghostty
#for swww
dnf5 -y copr enable alebastr/sway-extras
dnf5 -y install swww
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable alebastr/sway-extras
 
#change pretty name
sed -i "s|^PRETTY_NAME=.*|PRETTY_NAME=\"blue-niri (FROM bluefin-dx:latest)\"|" /usr/lib/os-release

