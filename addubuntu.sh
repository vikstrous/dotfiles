sudo lvcreate -L 30G HiNSA -n ubunturoot
sudo mkfs.ext4 /dev/mapper/HiNSA-ubunturoot
