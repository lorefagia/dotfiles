# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

# start emacs daemon
sem_start(){
    local sem_echo=$(emacsclient -a false -e 't' 2>/dev/null)
    if [[ $sem_echo != "t" ]]; then
		# start emacs daemon
		$(emacs-lucid --daemon)
		local sem_initialized=1
    fi
    if [ -z $sem_initialized ]; then
		if [[ $# -eq 0 ]] ; then
			echo "serving"
		fi
	fi
}

# start emacs daemon and open filename if argument is provided
sem(){
	if [[ $# -eq 0 ]] ; then
		sem_start
	else
		sem_start "silence"
		emacsclient -c $1 & disown
	fi
}

# start emacs daemon and open filename in the terminal window if argument is provided
semt(){
	if [[ $# -eq 0 ]] ; then
		sem_start
	else
		sem_start "silence"
		emacsclient -nw $1
	fi
}

# kill emacs daemon
kem(){
	emacsclient -e "(kill-emacs)"
}

# Aliases
# Launch commands
alias matlab="cd ~/Documents/MATLAB/Tesi && /usr/local/MATLAB/R2024a/bin/matlab -softwareopengl"
alias dots="/usr/bin/git --git-dir=$HOME/Documents/GitHub/dotfiles --work-tree=$HOME"
alias emacsconf="/usr/bin/git --git-dir=$HOME/Documents/GitHub/emacs-dots --work-tree=$HOME/.config/emacs/"

# Modified commands
alias mount="mount | column -t"

# New commands
alias ..="cd .."

## History commands
alias h="history"
alias h1="history 10"
alias h2="history 20"
alias h3="history 30"
alias hgrep='history | grep'

## TLP commands
alias tlpb="sudo tlp-stat -b"
alias tlpp="sudo tlp-stat -p"

## Ping commands
alias pg="ping google.com -c 5"
alias pt="ping facebook.com -c 5"
alias ping="ping -c 5"

alias update="sudo dnf update && sudo dnf upgrade --refresh"
alias fupdate="flatpak update"
alias autoremove="sudo dnf autoremove"
alias i3="sem ~/.config/i3/config"

# Privileged acces
if (( UID != 0 )); then
    alias sudo="sudo"
    alias scat="sudo cat"
    alias svim="sudoedit"
    alias root="sudo -i"
    alias reboot="sudo /sbin/reboot"
    alias restart="sudo /sbin/reboot"
    alias poweroff="sudo /sbin/poweroff"
    alias shutdown="sudo /sbin/shutdown"
fi

# List sources
alias ll="ls -al"
alias ls="ls -hF --color=auto"
alias la="ls -a"
alias lx="ll -BX"                   # sort by extension
alias lz="ll -rS"                   # sort by size
alias lt="ll -rt"                   # sort by date

# Error tolerance
alias cd..="cd .."

# Safety
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -I --preserve-root"
alias ln="ln -i"
alias chown="chown --preserve-root"
alias chmod="chmod --preserve-root"
alias chgrp="chgrp --preserve-root"

export PATH=$PATH:/home/lorenzo/.spicetify

eval "$(direnv hook bash)"

PATH=/usr/local/texlive/2024/bin/x86_64-linux:$PATH; export PATH 
MANPATH=/usr/local/texlive/2024/texmf-dist/doc/man:$MANPATH; export MANPATH 
INFOPATH=/usr/local/texlive/2024/texmf-dist/doc/info:$INFOPATH; export INFOPATH
