#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# X session auto start

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then 
	exec startx -- vt1 &> /dev/null
fi


