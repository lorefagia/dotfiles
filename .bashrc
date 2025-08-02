#
# ~/.bashrc
#
# My bash config.

##########
# Export #
##########
export EDITOR='sem'
export VISUAL='nano'
export HISTCONTROL=ignoreboth:erasedups
export PAGER='most'

export PATH=$PATH:/home/lori/.spicetify

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

PS1='[\u@\h \W]\$ '

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.emacs.d/bin" ] ;
  then PATH="$HOME/.emacs.d/bin:$PATH"
fi

if [ -d "$HOME/Applications" ] ;
  then PATH="$HOME/Applications:$PATH"
fi

if [ -d "/var/lib/flatpak/exports/bin/" ] ;
  then PATH="/var/lib/flatpak/exports/bin/:$PATH"
fi

if [ -d "$HOME/.config/emacs/bin/" ] ;
  then PATH="$HOME/.config/emacs/bin/:$PATH"
fi

# Ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

#############
# Functions #
#############
function ex {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: ex <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.cbr|*.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -id < ./"$n"  ;;
            *.cba|*.ace)      unace x ./"$n"      ;;
            *)
                         echo "ex: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}


function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

############################
# Emacs configuration files #
############################
alias sbash="$EDITOR ~/.bashrc"
alias si3="$EDITOR ~/.config/i3/config"
alias sfastfetch="$EDITOR ~/.config/fastfetch/config.jsonc"
alias skitty="$EDITOR ~/.config/kitty/kitty.conf"

###########
# Aliases #
###########

# Listing
alias ls="ls --color=auto"
alias la="ls -a"
alias ll="ls -alFh"
alias lx="ll -BX"                   # sort by extension
alias lz="ll -rS"                   # sort by size
alias lt="ll -rt"                   # sort by date
alias l="ls"
alias l.="ls -A | egrep '^\.'"
alias listdir="ls -d */ > list"

# Pacman
alias sps='sudo pacman -S'
alias spr='sudo pacman -R'
alias sprs='sudo pacman -Rs'
alias sprdd='sudo pacman -Rdd'
alias spqo='sudo pacman -Qo'
alias spsii='sudo pacman -Sii'

# Software managment
# pacman or pm
alias pacman='sudo pacman --color auto'
alias update='sudo pacman -Syyu'
alias upd='sudo pacman -Syyu'
alias fupdate='flatpak update'

# paru as aur helper - updates everything
alias pksyua="paru -Syu --noconfirm"
alias upall="paru -Syu --noconfirm"
alias upa="paru -Syu --noconfirm"

# Error tolerance
alias cd..='cd ..'
alias pdw='pwd'
alias udpate='sudo pacman -Syyu'
alias upate='sudo pacman -Syyu'
alias updte='sudo pacman -Syyu'
alias updqte='sudo pacman -Syyu'
alias upqll='paru -Syu --noconfirm'
alias upal='paru -Syu --noconfirm'

# Safety
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -I --preserve-root"
alias ln="ln -i"
alias chown="chown --preserve-root"
alias chmod="chmod --preserve-root"
alias chgrp="chgrp --preserve-root"

# Grub update
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"

# Which graphical card is working
alias whichvga="/usr/local/bin/arcolinux-which-vga"

# Mount
alias mount="mount | column -t"

# Free
alias free="free -mt"

# Continue download
alias wget="wget -c"

# Userlist
alias userlist="cut -d: -f1 /etc/passwd | sort"

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

# History commands
alias h="history"
alias h1="history 10"
alias h2="history 20"
alias h3="history 30"
alias hgrep='history | grep'

# Ping commands
alias pg="ping google.com -c 5"
alias pt="ping facebook.com -c 5"
alias ping="ping -c 5"

# Colorize the grep command output for ease of use (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Hardware info
alias hw="hwinfo --short"

# Fastfetch
alias ff="fastfetch"

# Merge Xresources
alias merge="xrdb -merge ~/.Xresources"

# Cpu
alias cpu="cpuid -i | grep uarch | head -n 1"

# Get fastest mirrors in your neighborhood
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 30 --number 10 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 30 --number 10 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 30 --number 10 --sort age --save /etc/pacman.d/mirrorlist"

# Git --bare repositories
alias idots='/usr/bin/git --git-dir=/home/lori/Documents/Github/dotfiles --work-tree=/home/lori'
alias edots='/usr/bin/git --git-dir=/home/lori/Documents/Github/emacs-dots --work-tree=/home/lori/.config/emacs/'

#########
# Emacs #
#########

# start emacs daemon
sem_start(){
    local sem_echo=$(emacsclient -a false -e 't' 2>/dev/null)
    if [[ $sem_echo != "t" ]]; then
		# start emacs daemon
		$(emacs --daemon)
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
. "$HOME/.cargo/env"
