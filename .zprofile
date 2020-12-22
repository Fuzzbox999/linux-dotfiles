#
# ~/.bash_profile
#

[[ -f ~/.zshrc ]] && . ~/.zshrc

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then 
	exec startx -- vt1 &> /dev/null
fi


