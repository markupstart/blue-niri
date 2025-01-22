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
dnf install -y dnf5-plugins \
darktable \
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
virt-manager \
ydotool \
ptyxis \
fastfetch \
chafa \
greetd \
xdg-desktop-portal-gtk \
xdg-desktop-portal-gnome \
tuigreet \
code \
just \
firefox \
eza \
fedora-repos-ostree \
gamemode \
ghostscript \
glibc-all-langpacks \
gnome-boxes \
google-noto-color-emoji-fonts \
google-noto-emoji-fonts \
google-noto-sans-cjk-fonts \
grub2-efi-ia32 \
grub2-tools-extra \
htop \
btop \
langpacks-core-en \
langpacks-en \
langpacks-fonts-en \
langtable \
zoxide \
xcb-util-cursor \
xcb-util \
xorg-x11-server-Xwayland \
xdg-user-dirs \
xdg-utils \
pipewire-utils \
zram-generator-defaults \
zip \
wl-clipboard \
wget2 \
nano \
samba-client \
plymouth \
plymouth-system-theme \
plymouth-theme-spinner \
ostree-grub2 \
ristretto \
cups \
cups-filters \
cups-browsed \
mousepad \
NetworkManager \
dhcp-client \
ghostscript

#  COPR:
#
dnf5 -y copr enable yalter/niri
dnf5 -y install niri
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable yalter/niri 

dnf5 -y copr enable markupstart/xwayland-satellite
dnf5 -y install xwayland-satellite
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable markupstart/xwayland-satellite

dnf5 -y copr enable markupstart/SwayOSD
dnf5 -y install swayosd
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable markupstart/SwayOSD

dnf5 -y copr enable ublue-os/staging
dnf5 -y install uupd
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable ublue-os/staging

dnf5 -y copr enable che/nerd-fonts
dnf5 -y install nerd-fonts
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable che/nerd-fonts

dnf5 -y copr enable markupstart/terminal-stuff
dnf5 -y install atuin \
starship \
lazygit \
topgrade
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable markupstart/terminal-stuff

dnf5 -y copr enable markupstart/ghostty
dnf5 -y install ghostty \
ghostty-bash-completion \
ghostty-bat-syntax \
ghostty-docs \
ghostty-fish-completion \
ghostty-shell-integration \
ghostty-terminfo \
ghostty-themes
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable markupstart/ghostty

#### Example for enabling a System Unit File
systemctl enable greetd

#change pretty name
sed -i "s|^PRETTY_NAME=.*|PRETTY_NAME=\"blue-niri $(rpm -E %fedora) (FROM Fedora Linux 41)\"|" /usr/lib/os-release

#disable vscode repo, so it's not enabled on the final system
sed -i 's@enabled=1@enabled=0@g' "/etc/yum.repos.d/vscode.repo"
