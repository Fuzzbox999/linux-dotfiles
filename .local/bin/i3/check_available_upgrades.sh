
#!/bin/bash

# Script run each minute by a crontab in order to fill the pkg-status file,
# which is sourced in i3status_custom_bar script.
# In order to work, the pacman packages list needs to be updated.
# On my machine this is done every 15 minutes by a root crontab
# */15 * * * * /usr/bin/pacman -Sy >> /dev/null 2>&1
# This is DANGEROUS because it can lead to partial upgrades of the system if a package is installed afterwards by only using 
# "pacman -S packagename". That's why I ALWAYS use pacman -Syu packaganame to install a new package.
# I could use 'checkupdates', but it does not update the packages list, and it annoys me for several reasons.

installed=$(pacman -Q|wc -l)
#upgrade=$(checkupdates|wc -l)
upgrade=$(pacman -Qu|wc -l)

if [ ! -e $HOME/.local/etc/pkg-status ]; then
	touch $HOME/.local/etc/pkg-status
fi

echo "#!/bin/bash" > $HOME/.local/etc/pkg-status
echo "installed='$installed'" >> $HOME/.local/etc/pkg-status
echo "upgradeable='$upgrade'" >> $HOME/.local/etc/pkg-status
