
#!/bin/bash

# Script run each minute by a crontab in order to fill the dpkg-status file,
# which is used by i3status_custom_bar* scripts.

installed=$(pacman -Q|wc -l)
upgrade=$(checkupdates|wc -l)

if [ ! -e $HOME/.local/etc/pkg-status ]; then
	touch $HOME/.local/etc/pkg-status
fi

echo "#!/bin/bash" > $HOME/.local/etc/pkg-status
echo "installed='$installed'" >> $HOME/.local/etc/pkg-status
echo "upgradeable='$upgrade'" >> $HOME/.local/etc/pkg-status
