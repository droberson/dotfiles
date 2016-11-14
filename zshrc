# Set up the prompt

autoload -Uz promptinit zcalc
promptinit
prompt adam1 black

setopt histignorealldups sharehistory

export EDITOR="emacsclient -nw"
# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
if [ `uname` = "Darwin" ]; then
	export CLICOLOR=1
	zstyle ':completion:*:default' list-colors ''
else
	eval "$(dircolors -b)"
fi

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


# This allows MIME extensions so you can "execute" files
zstyle :mime: mailcap ~/.mailcap /etc/mailcap
autoload -U zsh-mime-setup
zsh-mime-setup

# History setup
setopt append_history
setopt extended_history

# Function to see if a program exists.
program_exists () {
    type "$1" >/dev/null ;
}

# Checks if we have GNU grep
have_gnu_grep () {
    grep -V 2>&1 |grep GNU >/dev/null ;
    return $?
}

# Check if we have GNU ls
have_gnu_ls () {
    ls --help >/dev/null 2>/dev/null ;
    return $?
}

# Control+X inserts "sudo" at start of line
# insert_sudo () {
#     [[ -z $BUFFER ]] && zle up-history
#     if [[ $BUFFER != sudo\ * ]]; then
# 	zle beginning-of-line;
# 	zle -U "sudo "
#     fi
# }
# zle -N insert-sudo insert_sudo
# bindkey "^X" insert-sudo

# Here are some quick calculators that output in integer
# hexadecimal, decimal, and binary.
#zcalc ()  { print $(( ans = ${@:-ans} )) }
#zcalch () { print $(( [#16] ans = ${@:-ans} )) }   
#zcalcd () { print $(( [#10] ans = ${@:-ans} )) }
#zcalco () { print $(( [#8] ans = ${@:-ans} )) }
#zcalcb () { print $(( [#2] ans = ${@:-ans} )) }

# I like colorful grep/ls!
# OpenBSD doesn't have GNU grep or ls by default, so had to add checks
if have_gnu_ls; then
    alias ls="ls -F --color"
else
    alias ls="ls -F"
fi

if have_gnu_grep; then
    alias grep="grep --color"
    alias lgrep="lgrep --color"
    alias fgrep="fgrep --color"
    alias rgrep="rgrep --color"
fi

# Surfraw aliases!
if program_exists sr; then
    alias google="sr google"
    alias imdb="sr imdb"
    alias youtube="sr youtube"
    alias define="sr webster"
    alias wikipedia="sr wikipedia"
    alias acronym="sr acronym"
    alias thesaurus="sr thesaurus"
fi

# Text converters
alias unix2win="sed 's/$/`echo \\\r`/'"
alias win2unix="sed 's/\r//'"

# use sudo to reboot/halt computer if not root
if [ $EUID -ne 0 ]; then
    alias reboot="sudo /sbin/reboot"
    alias halt="sudo /sbin/halt"
    alias shutdown="sudo /sbin/shutdown"
fi

# Strip comments
alias nocomment="sed '/^\s*#/d'"

# Teamviewer if it exists.
if [ -x "/opt/teamviewer9/tv_bin/TeamViewer" ]; then
    alias teamviewer="/opt/teamviewer9/tv_bin/TeamViewer"
fi

# "backup" alias.. copies a file and appends time+date to its original name
backup() {
    cp -rp $1{,.backup.$(date +%m-%d-%g_%H-%M-%S)}
}

# Start a quick webserver to serve up cwd
alias serve="python -m SimpleHTTPServer"

# Send myself an email/text reminder.
# usage: remind <militarytime> <email/sms> <message>
# TODO: check if <militarytime> is actualy a military time
# TODO: check if email is valid for arg2
# TODO: address book
remind() {
    if [ $# -lt 3 ]; then
	echo "usage: $0 <militarytime> <702xxxxxx@vmobl.com> <message>"
	echo " ex: $0 2000 7025555555@vmobl.com remember to buy milk"
	echo " -- schedules a text to myself at 8PM to remember the milk!"

	return 1
    fi

    # Build string to send
    count=0
    unset MSG
    for word in $* ; do
	count=$(($count + 1))

	if [ $count -gt 2 ]; then
	    MSG="$MSG $word"
	fi
    done

    # Schedule with 'at'
    echo "echo $MSG | mail $2" | at $1 2> /dev/null
    if [ $? -eq 1 ]; then
	echo "$0 failed. Check syntax and try again."
	return 1
    fi

    echo "Message scheduled for delivery. Type 'atq' to view queue."
    return 0
}

# Miscellany
alias pubip="curl ifconfig.me"
alias ipinfo="curl ipinfo.io"
if [ `uname` != "Darwin" ]; then
	alias ack="ack-grep"
fi
alias ret="echo $?"
alias ipinfo="curl ipinfo.io"
alias header="curl -I"

# Fuck capslock
setxkbmap -option ctrl:nocaps
#setxkbmap -option

# .zsh.d directory
if [ -d $HOME/.zsh.d ]; then
  for file in $HOME/.zsh.d/*.zsh; do
    source $file
  done
fi
