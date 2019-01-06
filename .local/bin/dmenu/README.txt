My dmenu installation is based on :

* dmenu 4.8 :
git clone https://git.suckless.org/dmenu

* patched to accept x/y positioning and width arguments :
git clone https://aur.archlinux.org/dmenu-mouse-geometry.git

* (manually) patched to accept line height argument :
wget https://tools.suckless.org/dmenu/patches/dmenu-lineheight-4.7.diff

* morc_menu :
git clone https://github.com/Boruch-Baum/morc_menu.git
which provides a classic "ala blackbox" menu.

* dmenu-extended :
git clone https://github.com/MarkHedleyJones/dmenu-extended.git
which provides an extended dmenu with recent applications, web search and package management plugins.

* dmenu-show-opened-windows provides a list to switch between opened windows (requires xdotool).

* _wrapper scripts are used to start dmenu in different styles, positions (based on the size of my monitors) and colors. They currently use Pywal. Pywal colors are set in the dmenu-theme-config file.

* dmenu-extended_wrapper is called by dmenu_extended_run through its $HOME/.config/dmenu-extended/config/dmenuExtended_preferences
* dmenu-morc_menu_wrapper is called by /usr/bin/morc_menu as specified in $HOME/.config/morc_menu/morc_menu_v1.conf
* dmenu-run_wrapper is called by i3wm from its config file. It applies theme and position before calling the default /usr/bin/dmenu_run
* dmenu-show-opened-windows_wrapper is called by dmenu-show-opened-windows

In the i3/config file you can add for instance :

# Original dmenu :
bindsym $mod+t exec $HOME/.bin/dmenu/dmenu-run_wrapper

# i3 dmenu == localised applications names :
bindsym $mod+Shift+t exec i3-dmenu-desktop --dmenu='$HOME/.bin/dmenu/dmenu-extended_wrapper -i'

# List of running windows :
bindsym $mod+w exec $HOME/.bin/dmenu/dmenu-show-opened-windows

# Morc menu :
bindsym $mod+Shift+d exec morc_menu

# Extended dmenu :
bindsym $mod+d exec dmenu_extended_run
