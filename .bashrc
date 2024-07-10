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

# Aliases
# Launch commands
alias matlab="/usr/local/MATLAB/R2024a/bin/matlab"
alias config="/usr/bin/git --git-dir=$HOME/Documents/GitHub/dotfiles --work-tree=$HOME"

# Modified commands
alias mount="mount | column -t"
alias htop="top"

# New commands
alias ..="cd .."
## History commands
alias h="history"
alias h1="history 10"
alias h2="history 20"
alias h3="history 30"
alias hgrep='history | grep'
## Ping commands
alias pg="ping google.com -c 5"
alias pt="ping facebook.com -c 5"
alias ping="ping -c 5"

alias vi=vim
alias svi="sudo vim"
alias svim="sudo vim"
alias update="sudo dnf -y update && sudo dnf -y upgrade --refresh"
alias fupdate="flatpak update"
alias autoremove="sudo dnf autoremove"
alias i3="emacs ~/.config/i3/config"

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
