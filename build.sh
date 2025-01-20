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
dnf config-manager --add-repo "https://copr.fedorainfracloud.org/coprs/yalter/niri-git/repo/fedora-${MAJOR_VERSION}/yalter-niri-git-${MAJOR_VERSION}.repo"
dnf config-manager --set-disabled copr:copr.fedorainfracloud.org:yalter:niri-git
dnf -y --enablerepo copr:copr.fedorainfracloud.org:yalter:niri-git install \
	niri
dnf config-manager --add-repo "https://copr.fedorainfracloud.org/coprs/ulysg/xwayland-satellite/repo/fedora-${MAJOR_VERSION}/ulysg-xwayland-satellite-${MAJOR_VERSION}.repo"
dnf config-manager --set-disabled copr:copr.fedorainfracloud.org:ulysg:xwayland-satellite
dnf -y --enablerepo copr:copr.fedorainfracloud.org:ulysg:dnf -y --enablerepo copr:copr.fedorainfracloud.org:ulysg:xwayland-satellite install \
	install \
	xwayland-satellite

dnf config-manager --add-repo "https://copr.fedorainfracloud.org/coprs/celestelove/SwayOSD/repo/fedora-${MAJOR_VERSION}/celestelove-SwayOSD-${MAJOR_VERSION}.repo"
dnf config-manager --set-disabled copr:copr.fedorainfracloud.org:celestelove:SwayOSD
dnf -y --enablerepo copr:copr.fedorainfracloud.org:celestelove:SwayOSD install \
swayosd

dnf config-manager --add-repo "https://copr.fedorainfracloud.org/coprs/che/nerd-fonts/repo/fedora-${MAJOR_VERSION}/che-nerd-fonts-${MAJOR_VERSION}.repo"
dnf config-manager --set-disabled copr:copr.fedorainfracloud.org:che:nerd-fonts
dnf -y --enablerepo copr:copr.fedorainfracloud.org:che:nerd-fonts install \
nerd-fonts

#### Example for enabling a System Unit File

systemctl enable greetd

#disable vscode repo, so it's not enabled on the final system
sed -i 's@enabled=1@enabled=0@g' "/etc/yum.repos.d/vscode.repo"
