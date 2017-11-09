# Daniel Roberson's .zshrc

# cd to Linux home directory
uname -r | grep "Microsoft" > /dev/null
if [ $? -eq 0 ]; then
    export SHELL="/bin/zsh"
    cd
fi

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

# I like colorful grep/ls!
# OpenBSD doesn't have GNU grep or ls by default, so had to add checks
if have_gnu_ls; then
    alias ls="ls -F --color"
else
    alias ls="ls -F"
fi

# I like highlighting with grep
if have_gnu_grep; then
    alias grep="grep --color"
    alias lgrep="lgrep --color"
    alias fgrep="fgrep --color"
    alias rgrep="rgrep --color"
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
#setxkbmap -option ctrl:nocaps
#setxkbmap -option

# .zsh.d directory
if [ -d $HOME/.zsh.d ]; then
  for file in $HOME/.zsh.d/*.zsh; do
    source $file
  done
fi

