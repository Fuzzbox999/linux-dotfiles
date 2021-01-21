#!/bin/sh

echo "Sett timezone"
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime

echo "Synchro time"
hwclock --systohc

echo "Edit locale.gen"
sed -i -e 's/#en_US.UTF-8/en_US.UTF-8/g' -e 's/#fr_FR.UTF-8/fr_FR.UTF-8/g' locale.gen

echo "Genere locales"
locale-gen

echo "Set language"
echo "LANG=fr_FR.UTF-8" > /etc/locale.conf

echo "Set keyboard"
echo "KEYMAP=fr" > /etc/vconsole.conf

echo "Set hostname"
echo "thinkpad" > /etc/hostname

echo "Set hosts"
echo "
127.0.0.1       localhost    
::1             localhost    
127.0.1.1       thinkpad.localdomain  thinkpad" > /etc/hosts

echo "Set root password"
passwd

echo "Install Grub"
pacman -S grub efibootmgr

# grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
grub-install --target=i386-pc /dev/sda

grub-mkconfig -o /boot/grub/grub.cfg

echo "Install the network manager"
pacman -S networkmanager dhclient wpa_supplicant

echo "Exit chroot"
exit

