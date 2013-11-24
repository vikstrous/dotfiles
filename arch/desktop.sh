cd /dev
gdisk sda

cryptsetup luksFormat /dev/sda3
cryptsetup luksOpen /dev/sda3 lvm

pvcreate /dev/mapper/lvm
vgcreate HiNSA /dev/mapper/lvm
lvcreate -L 15G HiNSA -n rootvol
lvcreate -L 104G HiNSA -n homevol

mkfs.ext4 /dev/mapper/HiNSA-rootvol
mkfs.ext4 /dev/mapper/HiNSA-homevol
mkfs.ext4 /dev/sda2

mount /dev/HiNSA/rootvol /mnt
mkdir /mnt/home
mount /dev/HiNSA/homevol /mnt/home
mkdir /mnt/boot
mount /dev/sda2 /mnt/boot

pacstrap /mnt base
genfstab -p /mnt > /mnt/etc/fstab
