#!/bin/sh

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

echo "Install more programs"

pacman -S links git xorg ranger rxvt-unicode urxvt-perls openssh htop feh xorg-xinit wget firefox papirus-icon-theme picom ttf-font-awesome scrot neofetch lxapearance python-pywal xdotool dunst xclip pulseaudio pavucontrol udisks2 udiskie mplayer cheese blueman zsh zsh-autosuggestions zsh-completions zsh-lovers zsh-syntax-highlighting zsh-theme-powerlevel10k zathura xdotool xdg-user-dirs tlp tlp-rdw thunar neomutt neovim mpv mpc mopidy hdparm gnome-font-viewer fprintd dunst blueman bluez xf86-input-synaptics jq sassc ncmpcpp cronie gimp firefox-i18n-fr imagemagick net-tools curl redshift

echo "Install AUR helper"
cd /home/fuzzbox

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd

echo "Install more packages from AUR"
yay -S colorz getmail gtk-theme-flat-color-git i3lock-color-git mopidy-mpd mopidy-spotify nerd-fonts-meslo oh-my-zsh-git sc-im ttf-iosevka ttf-iosevka-term ttf-meslo ttf-meslo-nerd-font-powerlevel10k tty-clock urlview wpgtk-git cava clipit python-colorthief  

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

echo "Become fuzzbox"
su - fuzzbox

echo "Swithcing to zsh shell"
chsh -s /usr/bin/zsh

echo "Install Rxvt plugins"
mkdir /home/fuzzbox/.urxvt/etc
git clone https://github.com/simmel/urxvt-resize-font.git
cp urxvt-resize-font/resize-font /home/fuzzbox/.urxvt/etc/
rm -rf urxvt-resize-font

echo "Install ranger plugins"
git clone https://github.com/alexanderjeurissen/ranger_devicons /home/fuzzbox/.config/ranger/plugins/ranger_devicons

echo "Install zsh theme"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# get my dotfiles

echo "Get dotfiles back in"
echo "$HOME/.local/dotfiles/" >> .gitignore
git clone --bare https://github.com/Fuzzbox999/dotfiles.git $HOME/.local/dotfiles/
function config {
	/usr/bin/git --git-dir=$HOME/.local/dotfiles/ --work-tree=$HOME $@
}
mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
	echo "Checked out config.";
else
	echo "Backing up pre-existing dot files.";
	config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no

# colorscheme

echo "Generate colorscheme"
wal -i /home/fuzzbox/.local/dotfiles/Images/screenshots/dwm.jpg

# Install suckless tools

echo "Prepare for suckless tools build"
mkdir /home/fuzzbox/.dwm/
cp -r /home/.local/dotfiles/.dwm/dwm/ /home/fuzzbox/.dwm/
cp -r /home/.local/dotfiles/.dwm/dwmblocks/ /home/fuzzbox/.dwm/
cp -r /home/.local/dotfiles/.local/builds/perso/dmenu-5.0-patched /home/fuzzbox/.dwm/

cd /home/.dwm/
mv dmenu-5.0-patched dmenu

echo "Build dwm"
cd dwm/
make
echo "Build dwmblocks"
cd ../dwmblocks
make
echo "Build dmenu"
cd ..//dmenu
make

echo "Create symlinks in ~/.local/bin/ for suckless tools"
cd /home/fuzzbox/.local/bin
ln -s /home/fuzzbox/.dwm/dwm/dwm dwm
ln -s /home/fuzzbox/.dwm/dwmblocks dwmblocks
ln -s /home/fuzzbox/.dwm/dmenu/dmenu dmenu
ln -s /home/fuzzbox/.dwm/dmenu/dmenu_run dmenu_run
ln -s /home/fuzzbox/.dwm/dmenu/dmenu_path dmenu_path

echo "Done, now reboot..."

