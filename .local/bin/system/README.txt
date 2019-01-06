* create_env_vars.sh is run on i3 startup. It creates the environment variables required for notifications sent by a crontab to work.
* low_bat_notify.sh is run by a crontab and sends notifications when the battery level is low.
* setvolume.sh is used to set the volume using the multimedia keys, binded in i3/config.
* thinkpad-backlight.sh changes backlight level. Binded in i3/config.
* wal_dunst is run by ranger when I change the wallpaper; it updates the config file of dunst using Pywal generated colors.
* zenity_askpass ends in /usr/local/bin; it's a password prommpt used by dmenu-extended when an app is run using sudo.
