#
# ~/.bashrc
#

# Pywal stuff
(cat ~/.cache/wal/sequences &)
source ~/.cache/wal/colors-tty.sh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ls='ls --color=auto'
alias ll='ls -lh'
alias lla='ls -alh'
alias la='ls -A'
alias l='ls -CF'

# Custom aliases
alias neo='echo "" && neofetch --ascii_distro linux --color_blocks off && i3 -v|cut -d" " -f -6'
alias ccl='cd && clear'
alias bh='$HOME/.local/bin/dmenu/dmenu-search-bash-history'
alias pac='sudo pacman'
alias mirrors='sudo reflector --country France --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist'
alias autoremove='pac -Rns $(pacman -Qtdq)'

# alias for my dotfiles in a bare Git repository
alias config='/usr/bin/git --git-dir=$HOME/.local/dotfiles/ --work-tree=$HOME'

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
	PS1='\[\033[01;33m\]\u@\h \[\033[00m\]\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    	PS1='$\u@\h:\w\$ '
fi

unset color_prompt force_color_prompt

# Vim/neovim stuff

function vim() {
  args=()
  for i in $@; do
    if [[ -h $i ]]; then
      args+=`readlink $i`
    else
      args+=$i
    fi
  done

  /usr/bin/vim -p "${args[@]}"
}

function nvim() {
  args=()
  for i in $@; do
    if [[ -h $i ]]; then
      args+=`readlink $i`
    else
      args+=$i
    fi
  done

  /usr/bin/nvim -p "${args[@]}"
}

