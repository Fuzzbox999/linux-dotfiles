#!/bin/sh

echo "Load french keyboard"
loadkeys fr

echo "Set timedatectl"
timedatectl set-ntp true

echo "Partition the drive"
fdisk /dev/sda

echo "Create filesystems"

#mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda1

mkfs.ext4 /dev/sda3

mkswap /dev/sda2

swapon /dev/sda2

mount /dev/sda3 /mnt

#mkdir /mnt/efi
mkdir /mnt/boot

#mount /dev/sda1 /mnt/efi
mount /dev/sda1 /mnt/boot

echo "Install Arch Linux"
pacstrap /mnt base base-devel linux linux-firmware vim sed

echo "Generate fstab"
genfstab -U /mnt >> /mnt/etc/fstab

echo "Chrooting"
curl https://raw.githubusercontent.com/Fuzzbox999/dotfiles/master/.local/bin/archchroot.sh.test > /mnt/archchroot.sh && arch-chroot /mnt bash archchroot.sh && rm /mnt/archchroot.sh 

umount -R /mnt

echo "Done, now reboot..."

