##### DO NOT RUN THIS; ONLY USE AS EXAMPLE #####

### partition stuff

gdisk /dev/sda
# sda1 = 2M, EF02 - GRUB GPT hack
# sda2 = 200M, 8300 - /boot
# sda3 = remaining space, 8E00 - LVM
cryptsetup luksFormat /dev/sda3
cryptsetup luksOpen /dev/sda3 lvm
pvcreate /dev/mapper/lvm
vgcreate HiNSA /dev/mapperlvm
lvcreate -L 15G HiNSA -n rootvol
lvcreate -L 35G HiNSA -n homevol
lvcreate -L 200G HiNSA -n mediavol
lvcreate -C y -L 6G HiNSA -n swapvol
mkfs.ex4 /dev/mapper/HiNSA-rootvol
mkfs.ex4 /dev/mapper/HiNSA-homevol
mkfs.ex4 /dev/mapper/HiNSA-mediavol
mkfs.ex4 /dev/sda2
mkswap /dev/mapper/HiNSA-swapvol


### prepare to go in

mount /dev/HiNSA/rootvol /mnt
mkdir /mnt/home
mount /dev/HiNSA/homevil /mnt/home
mkdir /mnt/boot
mount /dev/sda2 /mnt/boot
swapon /dev/mapper/HiNSA-swapvol
# optionally, mount the media folder

### install
pacstrap /mnt base
genfstab -p /mnt > /mnt/etc/fstab


### go in

arch-chroot /mnt


### basics

echo linusputinmusk > /etc/hostname
ln -s /usr/share/zoneinfo/Canada/Eastern /etc/localtime
echo 'LANG="en_CA.UTF-8"' > /etc/locale.conf
locale-gen
passwd


### make it boot

pacman -S grub
modprobe dm-mod
# edit /etc/mkinitcpio.conf HOOKS=" ... keymap encrypt lvm2 filesystems ... "
mkinitcpio -p linux
# edit /etc/default/grub GRUB_CMDLINE_LINUX="cryptdevice=/dev/sda3:HiNSA"
grub-install --recheck /dev/sda


### post-install

pacman -S iw macchanger #TODO: make the syatemd script reliable
# configs:
# wpa_passphrase Internets PASSWORD > /etc/wpa_supplicant/internets.conf
# /etc/systemd/system/network@.service
# /etc/systemd/macchanger/network@.service
mkdir /etc/conf.d/
touch /etc/conf.d/network
systemctl enable network@wlp2s0.service
systemctl enable macchanger@wlp2s0.service
systemctl enable macchanger@enp3s0.service
systemctl enable dhcpd
systemctl enable ifplugd@enp3s0
pacman -S sudo fish
useradd -m -s /usr/bin/fish v
passwd v
# edit sudoers file and add v


### nice to have
pacman -S htop iftop alsa-utils vim ntfs-3g bc ntpd ttf-dejavu
systemctl enable ntpd
systemctl start ntpd


### drivers
pacman -S xf86-input-synaptics


### graphical, desktop
pacman -S xf86-video-vesa # compatible open source video driver as fallback
pacman -S nvidia # for proprietary graphics
pacman -S ttf-dejavu # fonts
pacman -S slim xmonad xmonad-contrib dmenu dzen2 rxvt-unicode conky cabal-install xorg-xmodmap xorg-xset xorg-xsetroot feh
# TODO: I haven't decided between xmobar and dzen+conky
cabal update
cabal install xmobar
systemctl enable slim
# to start slim, `systemctl enable slim`, maybe also ctrl+f7


### AUR
pacman -S base-devel yajl
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


### user stuff
pacman -S openssh firefox flashplugin git fakeroot xdiskusage xev acpi slim-themes cdparanoia ripperx python
ssh-keygen # for git
yaourt chrome
pacman -S weechat
