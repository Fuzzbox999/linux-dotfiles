I manage Pywal theming by using keyboard shortcuts in Ranger's rc.conf file.

The principle is :
- you select a wallpaper
- 'w' calls pywal
- then 'd' o 'l' selects if the theme must be dark or light
- then '1', '2', '3', '4' or '5' selects the backend to run (Wal, colorz, haishoku, colorthief or schemer2). 

These backends of course have to be installed.

To generate the Gtk theme, I use wpg, which has to be installed too... 
To use this theme after its creation, I use the flatcolor Gtk theme with the Flattrcolor icon theme.

A custom script wal_wpgtk (in .local/bin) modifies $HOME/.config/wpg/wpg.conf, so wpg knows which backend to use, and if it has to be dark or light theme.

#!/bin/sh
sed -i"" \
        -e "s/backend = .*/backend = $1/" \
        -e "s/light_theme = .*/light_theme = $2/" \
        "$HOME/.config/wpg/wpg.conf"

Once you have typed your shortcut on the selected wallpaper, ranger will run a shell command.
This is what this command looks like, for instance, in ranger's rc.conf :

map wd1 shell wal -i %f && wal_wpgtk wal false && wpg -a %f && wpg --backend -n -s %f && wal -R && cp %f ~/Images/Current/wall.jpg && sassc /home/fuzzbox/.startpage/scss/style.scss /home/fuzzbox/.startpage/style.css && wal_dunst

This command will :
- call pywal with the desired backend
- call the script to modify wpg.conf
- call wpg to generate the gtk theme
- reload pywal
- make a copy of the current wallpaper in a specific directory
- run sassc (which has to be installed) to update the startpage css style from pywal colors
- run a script (.local/bin/wal_dunst) which will update $HOME/.config/dunst/dunstrc dunst config file using pywal colors, and reload it.

#!/bin/sh
. "${HOME}/.cache/wal/colors.sh"
sed -i"" --follow-symlinks \
        -e "s/frame_color = .*/frame_color = \"${color7:-#FFFFFF}\"/" \
        -e "s/foreground = .*/foreground = \"${color7:-#FFFFFF}\"/" \
        -e "s/background = .*/background = \"${color0:-#FFFFFF}\"/" \
        "${HOME}/.config/dunst/dunstrc"
pkill dunst
dunst -config ~/.config/dunst/dunstrc &

