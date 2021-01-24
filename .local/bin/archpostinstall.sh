#!/bin/sh

echo "Install more programs"

sudo pacman -S links git xorg ranger rxvt-unicode urxvt-perls openssh htop feh xorg-xinit wget firefox papirus-icon-theme picom ttf-font-awesome scrot neofetch python-pywal xdotool dunst xclip pulseaudio pavucontrol udisks2 udiskie mplayer cheese blueman zsh zsh-autosuggestions zsh-completions zsh-lovers zsh-syntax-highlighting zsh-theme-powerlevel10k zathura xdotool xdg-user-dirs tlp tlp-rdw thunar neomutt neovim mpv mpc mopidy hdparm gnome-font-viewer fprintd dunst blueman bluez xf86-input-synaptics jq sassc ncmpcpp cronie gimp firefox-i18n-fr imagemagick net-tools curl redshift vim-airline vim-airline-themes awesome-terminal-fonts powerline-fonts

echo "Install AUR helper"

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd

echo "Install more packages from AUR"
yay -S colorz getmail gtk-theme-flat-color-git i3lock-color-git mopidy-mpd mopidy-spotify nerd-fonts-meslo oh-my-zsh-git sc-im ttf-meslo ttf-meslo-nerd-font-powerlevel10k tty-clock urlview wpgtk-git cava clipit python-colorthief  

echo "Swithcing to zsh shell"
chsh -s /usr/bin/zsh

echo "Install Rxvt plugins"
mkdir -p /home/fuzzbox/.urxvt/etc
git clone https://github.com/simmel/urxvt-resize-font.git
cp urxvt-resize-font/resize-font /home/fuzzbox/.urxvt/etc/
rm -rf urxvt-resize-font

echo "Install ranger plugins"
mkdir -p /home/fuzzbox/.config/ranger/plugins/
git clone https://github.com/alexanderjeurissen/ranger_devicons /home/fuzzbox/.config/ranger/plugins/ranger_devicons

zsh

echo "Install zsh theme"
sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# get my dotfiles

mkdir -p /home/fuzzbox/.local/bin
cd /home/fuzzbox/.local/

git clone https://github.com/Fuzzbox999/dotfiles.git

cd /home/fuzzbox/.local/dotfiles/

echo "Prepare for suckless tools build"

mkdir -p /home/fuzzbox/.suckless/
cd /home/fuzzbox/.local/dotfiles/
cp -r .suckless/* /home/fuzzbox/.suckless/

cp -r .local/bin/* /home/fuzzbox/.local/bin/
cp -r .config/* /home/fuzzbox/.config/
cp .muttrc .p10k.zsh .urlview .Xresources .zprofile .zshrc .xinitrc /home/fuzzbox/
mkdir -p /home/fuzzbox/Images/Wallpapers
cp -r Images/Screenshots/dwm.jpg /home/fuzzbox/Images/Wallpapers/
cp -r .ncmpcpp /home/fuzzbox/
cp -r .startpage /home/fuzzbox/

cd

# colorscheme

echo "Generate colorscheme"
wal -i /home/fuzzbox/Images/Wallpapers/dwm.jpg

# Install suckless tools

echo "Prepare for suckless tools build"

echo "Build dwm"
cd /home/fuzzbox/.suckless/dwm/
make
echo "Build dwmblocks"
cd /home/fuzzbox/.suckless/dwmblocks
make
echo "Build dmenu"
cd /home/fuzzbox/.suckless/dmenu
make

echo "Create symlinks in ~/.local/bin/ for suckless tools"
cd /home/fuzzbox/.local/bin
ln -s /home/fuzzbox/.suckless/dwm/dwm dwm
ln -s /home/fuzzbox/.suckless/dwmblocks dwmblocks
ln -s /home/fuzzbox/.suckless/dmenu/dmenu dmenu
ln -s /home/fuzzbox/.suckless/dmenu/dmenu_run dmenu_run
ln -s /home/fuzzbox/.suckless/dmenu/dmenu_path dmenu_path
mkdir -p /home/fuzzbox/.dwm
cd /home/fuzzbox/.dwm
ln -s /home/fuzzbox/.suckless/autostart.sh autostart.sh

echo "Now run archendinstall.sh as root du finish the installation"

echo "Done"

