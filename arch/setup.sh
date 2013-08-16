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
passwd


### make it boot

pacman -S grub
modprobe dm-mod
# edit /etc/mkinitcpio.conf HOOKS=" ... keymap encrypt lvm2 filesystems ... "
mkinitcpio -p linux
# edit /etc/default/grub GRUB_CMDLINE_LINUX="cryptdevice=/dev/sda3:HiNSA"
grub-install --recheck /dev/sda


### post-install

pacman -S iw macchanger
# configs:
# wpa_passphrase Internets PASSWORD > /etc/wpa_supplicant/internets.conf
# /etc/systemd/system/network@.service
# /etc/systemd/macchanger/network@.service
mkdir /etc/conf.d/
touch /etc/conf.d/network
systemctl enable network@wlp2s0.service
systemctl enable macchanger@wlp2s0.service
systemctl enable macchanger@enp3s0.service

pacman -S sudo fish
useradd -m -s /usr/bin/fish v
passwd v
# edit sudoers file


### nice to have
pacman -S htop alsa-utils vim


### drivers
pacman -S xf86-input-synaptics


### graphical, desktop
pacman -S xf86-video-vesa # compatible open source video driver as fallback
pacman -S nvidia # for proprietary graphics
pacman -S ttf-dejavu # fonts
pacman -S slim xmonad xmonad-contrib dmenu dzen2 rxvt-unicode conky cabal-install xorg-xmodmap
# I haven't decided between xmobar and dzen+conky
cabal update
cabal install xmobar
# dmenu is what lets you launch programs
# rxvt-unicode is better than xterm IMO
# Add this to .xinitrc
#xsetroot -cursor_name left_ptr
#exec xmonad
systemctl enable slim
# to start slim, `systemctl enable slim`, maybe also ctrl+f7


### user stuff
pacman -S openssh chromium firefox git fakeroot
git config --global core.editor vim
git config --global color.ui true
ssh-keygen
# chrome:
# https://aur.archlinux.org/packages/google-chrome/
# tar -zxvf <chrome>
# cd chrome
# makepkg -s
# sudo pacman -U <chrome>.tar

