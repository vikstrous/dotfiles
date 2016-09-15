Instructions for setting up NixOS

Used on XPS 13 2016 laptop

Based on https://gist.github.com/martijnvermaat/76f2e24d0239470dd71050358b4d5134
and https://nixos.org/nixos/manual/index.html#sec-installation

First written: Sept 14, 2014



Load colemak key map (I don't know the right way, but this hack works)

```
loadkeys $(find / | grep colemak | head -n 2 | tail -n 1)
```

Partition

I'll assume the disk is at /dev/sda

```
gdisk /dev/sda
```

* o
* n -> 512M EF00 (we'll refer to this as /dev/sda1)
* n -> rest of the space 8300 (we'll refer to this as /dev/sda2)
* w

Run this and make sure you type YES in all caps at the prompt
```
cryptsetup luksFormat /dev/sda2
cryptsetup open /dev/sda2 lvm
```

Create an encrypted swap as well as the main data partition
```
pvcreate /dev/mapper/lvm
vgcreate vg /dev/mapper/lvm
lvcreate -L 8G -n swap vg
lvcreate -l '100%FREE' -n nixos vg
```

Format everything
```
mkfs.fat /dev/sda1
mkswap -L swap /dev/vg/swap
mkfs.ext4 -L nixos /dev/vg/nixos
```

Mount the filesystems and set up the boot partition
```
mount /dev/vg/nixos /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
swapon /dev/vg/swap
```

Optional: install over wifi. If you do this, you might want to later remove this
file and use the declerative wifi password definitions in the nixos config
```
wpa_passphrase your_ssid your_password > /etc/wpa_supplicant.conf
systemctl start wpa_supplicant
cp /etc/wpa_supplicant.conf /mnt/etc/wpa_supplicant.conf
```

Create a basic config
```
nixos-generate-config --root /mnt
```

Get a real text editor
```
nix-env -i vim
```

Verify the mount config
```
vim /mnt/etc/nixos/hardware-configuration.nix
```

Edit the system config
```
vim /mnt/etc/nixos/configuration.nix
```
