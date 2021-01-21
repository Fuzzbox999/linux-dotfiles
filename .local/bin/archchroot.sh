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

echo "Install microcode"
pacman -S intel-ucode

echo "Update Grub config"
grub-mkconfig -o /boot/grub/grub.cfg

echo "Add user fuzzbox"
useradd --create-home fuzzbox

echo "Set fuzzbox password"
passwd fuzzbox

echo "Add user fuzzbox to video and wheel groups"
gpasswd -a fuzzbox video
gpasswd -a fuzzbox wheel

echo "Add fuzzbox to sudoers"
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

echo "Edit mouse config"
echo "
Section \"InputClass\"
	Identifier \"touchpad catchall\"
		Driver \"synaptics\"
		MatchIsTouchpad \"on\"
		MatchDevicePath \"/dev/input/event*\"
			Option \"TapButton1\" \"1\"
			Option \"TapButton2\" \"2\"
			Option \"TapButton3\" \"3\"
EndSection" > /etc/X11/xorg.conf/10-synaptics.conf

echo "Edit keyoard config" 
echo "
Section \"InputClass\"
	Identifier \"system-keyboard\"
	MatchIsKeyboard \"on\"
	Option \"XkbLayout\" \"fr\"
	Option \"XkbModel\" \"pc105\"
	Option \"XkbOptions\" \"terminate:ctrl_alt_bksp\"
EndSection" > /etc/X11/xorg.conf/00-keyboard.conf

echo "Edit udev backlight rules"
echo "
ACTION==\"add\", SUBSYSTEM==\"backlight\", KERNEL==\"intel_backlight\", RUN+=\"/bin/chgrp video /sys/class/backlight/%k/brightness\"
ACTION==\"add\", SUBSYSTEM==\"backlight\", KERNEL==\"intel_backlight\", RUN+=\"/bin/chmod g+w /sys/class/backlight/%k/brightness\" " > /etc/udev/rules.d/backlight.rules

echo "Configuring tty1 auto-login"
echo "
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin fuzzbox --noclear %I $TERM" > /etc/systemd/system/getty@tty1.service.d/override.conf

echo "Add fuzzbox crontab"
 echo "*/1 * * * * /home/fuzzbox/.local/bin/check_upgrades\n*/2 * * * * /home/fuzzbox/.local/bin/low_bat_notify\n*/2 * * * * /home/fuzzbox/.local/bin/low_internal_bat_notify" |tee -a /var/spool/cron/fuzzbox

echo "Add root crontab"
echo "*/15 * * * * /usr/bin/pacman -Sy >> /dev/null 2>&1" |tee -a /var/spool/cron/root

echo "Configure pam for fingerprint"
echo "auth sufficient pam_fprintd.so" >> /etc/pam.d/system-auth
echo "auth sufficient pam_fprintd.so" >> /etc/pam.d/system-login
echo "auth sufficient pam_fprintd.so" >> /etc/pam.d/system-local-login
echo "auth sufficient pam_fprintd.so" >> /etc/pam.d/sudo

echo "Exit chroot"
exit

