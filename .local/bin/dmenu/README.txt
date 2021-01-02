My dmenu installation is based on dmenu 5.0 patched with center, lineheight, xyz and border patches.

I also use morc_menu : git clone https://github.com/Boruch-Baum/morc_menu.git , which provides a classic "ala blackbox" menu, and dmenu-clipmenu.

I use the some scripts along with dmenu :

* dmenu-show-opened-windows provides a list to switch between opened windows (requires xdotool).

* _wrapper scripts are used to start dmenu in different styles, positions (based on the size of my monitors) and colors. They currently use Pywal. Pywal colors are set in the dmenu-theme-config file.

* dmenu-morc_menu_wrapper is called by /usr/bin/morc_menu as specified in $HOME/.config/morc_menu/morc_menu_v1.conf
* dmenu-run_wrapper is called by i3wm from its config file. It applies theme and position before calling the default /usr/bin/dmenu_run
* dmenu-show-opened-windows_wrapper is called by dmenu-show-opened-windows

In the i3/config file you can add for instance :

# Original dmenu :
bindsym $mod+t exec $HOME/.local/bin/dmenu/dmenu-run_wrapper

# List of running windows :
bindsym $mod+w exec $HOME/.local/bin/dmenu/dmenu-show-opened-windows

# Morc menu :
bindsym $mod+Shift+d exec morc_menu

