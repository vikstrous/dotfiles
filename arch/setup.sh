##### DO NOT RUN THIS; ONLY USE AS EXAMPLE #####

### make installer usable
loadkeys /usr/share/kbd//keymaps/i386/colemak/colemak.map.gz

### partition stuff

gdisk /dev/sda # or nvme0n1
# sda1 = 2M, EF02 - GRUB GPT hack (only if not using UEFI or if using legacy boot mode)
# sda2 = 512M, 8300 - /boot
# sda3 = remaining space, 8E00 - LVM or 8300 if no LVM
cryptsetup luksFormat /dev/sda3 # or nvme0n1p2 # REMEMBER UPPERCASE YES

# hard mode
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

# easy mode
#TODO: try open instead of luksOpen
cryptsetup luksOpen /dev/sda3 HiNSA
mkfs.ext4 /dev/mapper/HiNSA
mkfs.ext4 /dev/sda2

# efi easy mode (don't make a hack partition and make the first partition EF00)
#TODO: try open instead of luksOpen
cryptsetup luksOpen /dev/sda3 HiNSA
mkfs.ext4 /dev/mapper/HiNSA
mkfs.fat -F32 /dev/sda1

### prepare to go in

# hard mode
mount /dev/HiNSA/rootvol /mnt
mkdir /mnt/home
mount /dev/HiNSA/homevol /mnt/home
mkdir /mnt/boot
mount /dev/sda2 /mnt/boot
swapon /dev/mapper/HiNSA-swapvol
# optionally, mount the media folder

# easy mode
mount /dev/mapper/HiNSA /mnt
mkdir /mnt/boot
mount /dev/sda2 /mnt/boot


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
# KEYMAP=/usr/share/kbd/keymaps/i386/colemak/colemak.map.gz into /etc/vconsole.conf

locale-gen
passwd


### make it boot

modprobe dm-mod
# encrypt needed only if encrypted I think
# lvm2 needed only if lvm used
# edit /etc/mkinitcpio.conf HOOKS=" ... keymap encrypt lvm2 filesystems ... "
# TLDR: add `keymap encrypt` before `filesystems`
mkinitcpio -p linux

#### the grub way

pacman -S grub
# edit /etc/default/grub GRUB_CMDLINE_LINUX="cryptdevice=/dev/sda3:HiNSA"  AND if on XPS before linux 4.2, add i915.enable_ips=0
# also in that file turn off uuid config option
# non-uefi: grub-install --recheck /dev/sda
grub-install --efi-directory=/boot/efi --recheck /dev/sda
#TODO: figure out the 
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub --recheck
grub-mkconfig -o /boot/grub/grub.cfg

#### the systemd way

sudo bootctl install
# Write to /boot/loader/loader.conf:
# default arch
# Write to /boot/loader/entries/arch.conf:
# title       Arch Linux
# linux       /vmlinuz-linux
# initrd      /initramfs-linux.img
# options root=/dev/mapper/HiNSA rw cryptdevice=/dev/sda2:HiNSA quiet
sudo bootctl update

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
pacman -S htop iftop alsa-utils gvim ntfs-3g bc ntp
systemctl enable ntpd
systemctl start ntpd


### drivers (laptop)
pacman -S xf86-input-synaptics


### graphical, desktop
pacman -S xf86-video-vesa # compatible open source video driver as fallback
pacman -S nvidia # for proprietary graphics
pacman -S ttf-dejavu ttf-freefont terminus-font # fonts
pacman -S xorg-server i3 dmenu rxvt-unicode xsel urxvt-perls xorg-xinput xorg-xmodmap xorg-xset xorg-xsetroot feh xcompmgr xorg-xinit

# in case of colemak only

#Section "InputClass"
#        Identifier "system-keyboard"
#        MatchIsKeyboard "on"
#        Option "XkbLayout" "us"
#        Option "XkbModel" "pc104"
#        Option "XkbVariant" "colemak"
#        Option "XkbOptions" "grp:caps_toggle"
#EndSection
# into /etc/X11/xorg.conf.d/10-keyboard.conf

# add `exec i3` to ~/.xinitrc

### AUR
pacman -S base-devel
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

# urxvt terminal pimping
yaourt urxvt-font-size-git
yaourt ttf-input
yaourt ttf-font-awesome
yaourt cope-git
yaourt dmenu-xft

# i3 window manager pimping
#yaourt i3blocks
#pacman -S acpi lm_sensors sysstat

### user stuff
pacman -S openssh firefox chromium xautolock dunst redshift flashplugin git fakeroot xdiskusage xorg-xev ripperx python xorg-xrandr numlockx transmission-cli unzip ack pidgin mlocate gnome-themes-standard nautilus privoxy xorg-xbacklight keychain

# copy scripts/suspend@.service to /etc/systemd/system/suspend@.service
sudo systemctl enable suspend@v

# other extra useful things
pacman -S cdparanoia httpie the_silver_searcher ack tree pidgin pidgin-otr thunderbird net-tools bind-tools
ssh-keygen # for git
systemctl enable transmission

pacman -S iptables

pacman -S openvpn
pacman -S sycthing
systemctl enable syncthing@v
systemctl start syncthing@v
yourt chromium-pepper-flash

#pacman -S networkmanager-openvpn

chmod -w /home/v/.config/chromium/Default/History

#pacman -S bluez bluez-utils
#systemstl start bluetooth
#bluetoothctl
#gpasswd -a v lp #for tethering

pacman -S wqy-microhei wqy-zenhei
cd /etc/fonts/conf.d
rm 65-wqy-zenhei.conf
ln -s ../conf.avail/43-wqy-zenhei-sharp.conf .

# for virtualbox put vboxdrv, vboxnetadp, vboxnetflt, and vboxpci in /etc/modules-load.d/virtualbox.conf


########## xps13

# wifi
yaourt broadcom-wl
# slack
#yaourt scudcloud
yaourt slack-chat
# mic?
#yaourt linux-xps13-alt

#Section "Device"
#  Identifier "Intel Graphics"
#  Driver "intel"
#  Option "DRI" "False"
#EndSection
# into /etc/X11/xorg.conf.d/20-intel.conf

# for 1.5 scaling:
#
#Section "Monitor"
#  Identifier  "<default monitor>"
#  DisplaySize 560 314
#EndSection
# into /etc/X11/xorg.conf.d/90-monitor.conf

# fixing some monitor issues:
# i915.enable_ips=0 into /etc/default/grub GRUB_CMDLINE_LINUX

# for sound
pacman -S pulseaudio pulpulseaudio-alsa
# remember to have something call pulseaudio --start on boot; for example, i3


########### wayland

# use nouveau???
yaourt -S sway-git
pacman -S xwayland
