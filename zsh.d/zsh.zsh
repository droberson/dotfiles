# Set up the prompt:
autoload -Uz promptinit zcalc
promptinit
prompt adam1 black

setopt histignorealldups sharehistory

export EDITOR="emacs"
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

# Purple is easier to read against black backgrounds than dark blue
export LS_COLORS=$LS_COLORS:'di=0;35:'

# add ~/bin to $PATH if it exists
if [ -d ~/bin ]; then
	PATH=$PATH:~/bin
	export PATH
fi

