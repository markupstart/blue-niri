#!/bin/bash

set -ouex pipefail

# VSCode because it's still better for a lot of things
tee /etc/yum.repos.d/vscode.repo <<'EOF'
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

#  install packages from fedora repos
dnf install -y darktable \
nextcloud-client \
fuzzel \
mate-polkit \
dunst \
swaybg \
swayidle \
swaylock \
pavucontrol \
waybar \
thunar \
thunar-volman \
thunar-media-tags-plugin \
thunar-vcs-plugin \
thunar-archive-plugin \
gvfs-fuse \
gvfs-nfs \
gvfs-smb \
gvfs-gphoto2 \
gvfs-goa \
gvfs-afp \
engrampa \
tumbler \
adobe-source-code-pro-fonts \
cascadia-code-fonts \
docker-compose \
podman-docker \
edk2-ovmf \
flatpak-builder \
google-droid-sans-mono-fonts \
libvirt \
mozilla-fira-mono-fonts \
google-noto-emoji-fonts \
osbuild-selinux \
p7zip-plugins \
p7zip \
podman-compose \
podman-machine \
podman-tui \
podmansh \
powerline-fonts \
qemu \
rocm-hip \
rocm-opencl \
rocm-smi \
virt-install \
virt-v2v \
ydotool \
ptyxis \
fastfetch \
chafa \
greetd \
xdg-desktop-portal-gtk \
xdg-desktop-portal-gnome \
tuigreet \
code

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

dnf5 -y copr enable ublue-os/staging
dnf5 -y install bluefin-backgrounds \
bluefin-plymouth \
bluefin-faces \
bluefin-cli-logos \
bluefin-logos \
ublue-bling \
ublue-brew \
ublue-motd \
uupd
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable ublue-os/staging

dnf5 -y copr enable che/nerd-fonts
dnf5 -y install nerd-fonts
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable che/nerd-fonts

#### Example for enabling a System Unit File

systemctl enable greetd

#disable vscode repo, so it's not enabled on the final system
sed -i 's@enabled=1@enabled=0@g' "/etc/yum.repos.d/vscode.repo"
sed -i "s|^PRETTY_NAME=.*|PRETTY_NAME=\"blue-niri $(rpm -E %fedora) (FROM Fedora Linux 41)\"|" /usr/lib/os-release
