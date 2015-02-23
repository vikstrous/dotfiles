##### DO NOT RUN THIS; ONLY USE AS EXAMPLE #####

### make installer usable
loadkeys /usr/share/kbd//keymaps/i386/colemak/colemak.map.gz

### partition stuff

gdisk /dev/sda
# sda1 = 2M, EF02 - GRUB GPT hack
# sda2 = 200M, 8300 - /boot
# sda3 = remaining space, 8E00 - LVM
cryptsetup luksFormat /dev/sda3
cryptsetup luksOpen /dev/sda3 lvm
pvcreate /dev/mapper/lvm
vgcreate HiNSA /dev/mapper/lvm
lvcreate -L 15G HiNSA -n rootvol 119-15 = 104
lvcreate -L 35G HiNSA -n homevol
lvcreate -L 200G HiNSA -n mediavol
lvcreate -C y -L 6G HiNSA -n swapvol
mkfs.ext4 /dev/mapper/HiNSA-rootvol
mkfs.ext4 /dev/mapper/HiNSA-homevol
mkfs.ext4 /dev/mapper/HiNSA-mediavol
mkfs.ext4 /dev/sda2
mkswap /dev/mapper/HiNSA-swapvol


### prepare to go in

mount /dev/HiNSA/rootvol /mnt
mkdir /mnt/home
mount /dev/HiNSA/homevol /mnt/home
mkdir /mnt/boot
mount /dev/sda2 /mnt/boot
swapon /dev/mapper/HiNSA-swapvol
# optionally, mount the media folder

### install
pacstrap /mnt base
genfstab -U -p /mnt >> /mnt/etc/fstab


### go in

arch-chroot /mnt


### basics

echo linusputinmusk > /etc/hostname
ln -s /usr/share/zoneinfo/Canada/Eastern /etc/localtime
echo 'LANG="en_CA.UTF-8"' > /etc/locale.conf
echo 'en_CA.UTF-8 UTF-8' >> /etc/locale.gen

# in case of colemak only

#Section "InputClass"
#        Identifier "system-keyboard"
#        MatchIsKeyboard "on"
#        Option "XkbLayout" "us"
#        Option "XkbModel" "pc104"
#        Option "XkbVariant" "colemak"
#        Option "XkbOptions" "grp:caps_toggle"
#EndSection
# into /etc/X11/xorg.conf.d/10-keyboarg.conf

# KEYMAP=/usr/share/kbd/keymaps/i386/colemak/colemak.map.gz into /etc/vconsole.conf
locale-gen
passwd


### make it boot

pacman -S grub
modprobe dm-mod
# keymap is outdated I think
# encrypt needed only if encrypted I think
# lvm2 needed only if lvm used
# edit /etc/mkinitcpio.conf HOOKS=" ... keymap encrypt lvm2 filesystems ... "
mkinitcpio -p linux
# edit /etc/default/grub GRUB_CMDLINE_LINUX="cryptdevice=/dev/sda3:HiNSA"
grub-install --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

### post-install

pacman -S iw macchanger ifplugd
# laptop only
pacman -S wpa_supplicant network-manager-applet
# configs:
# wpa_passphrase Internets PASSWORD > /etc/wpa_supplicant/internets.conf
# install configs/systemd/macspoof@.service to /etc/systemd/system/macspoof@.service
# systemctl enable macspoof@enp3s0
systemctl enable dhcpcd
# laptop only
systemctl enable NetworkManager
systemctl enable ifplugd@enp0s25
pacman -S sudo fish
useradd -m -s /usr/bin/fish v
passwd v
gpasswd -a v video
# edit /etc/sudoers file and add v


### nice to have
pacman -S htop iftop alsa-utils vim ntfs-3g bc ntp
systemctl enable ntpd
systemctl start ntpd


### drivers (laptop)
pacman -S xf86-input-synaptics


### graphical, desktop
pacman -S xf86-video-vesa # compatible open source video driver as fallback
pacman -S nvidia # for proprietary graphics
pacman -S ttf-dejavu ttf-freefont terminus-font # fonts
pacman -S xorg-server i3 dmenu rxvt-unicode xorg-xinput xorg-xmodmap xorg-xset xorg-xsetroot feh xcompmgr
# If window manager desired
# systemctl enable lxdm

# add `exec i3` to ~/.xinitrc

### AUR
pacman -S base-devel # how did this get here? yajl
curl https://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz > package-query.tar.gz
tar xvzf package-query.tar.gz
cd package-query
makepkg
sudo pacman -U package-query-1.2-2-x86_64.pkg.tar.xz
cd ..

curl https://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz > yaourt.tar.gz
tar xvzf yaourt.tar.gz
cd yaourt
makepkg
sudo pacman -U yaourt-1.3-1-any.pkg.tar.xz
cd ..

yaourt urxvt-clipboard
yaourt ttf-font-awesome
yaourt cope-git


### user stuff
pacman -S openssh firefox chromium flashplugin git fakeroot xdiskusage xorg-xev acpi ripperx python xscreensaver xorg-xrandr numlockx transmission-cli unzip ack pidgin mlocate gnome-themes-standard nautilus privoxy xorg-xbacklight keychain
# other extra useful things
pacman -S cdparanoia httpie the_silver_searcher ack
ssh-keygen # for git
systemctl enable transmission

pacman -S iptables

pacman -S openvpn

#pacman -S networkmanager-openvpn
