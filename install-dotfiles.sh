#!/bin/sh

# install-dotfiles.sh -- Creates symlinks to dotfiles contained in
#                     -- this repo. Additionally backs up old ones
#                     -- if they are present.
# By Daniel Roberson
#

OLDDIR="$HOME/.dotfiles-backup"
DOTFILES="profile fvwmrc mailcap mime.types zshrc kshrc emacs muttrc vimrc xbindkeysrc Xresources gdbinit screenrc"

echo "Installing Daniel Roberson's dotfiles."
echo

# Create backup directory if it does not exist.
echo -n "Checking if $OLDDIR is exists.. "
if [ -d "$OLDDIR" ]; then
    echo "yes."

    echo -n "Checking if $OLDDIR is writable.. "
    if [ -w "$OLDDIR" ]; then
	echo "yes."
    else
	echo "no."
	echo "Failure. Ensure that $OLDDIR is writable and try again."
	exit 1
    fi
else
    # Backup directory does not exist. Attempt to create it.
    echo "no.. Attempting to create."

    mkdir $OLDDIR
    if [ $? -eq 1 ]; then
	echo "Failure. Ensure that $OLDDIR is a suitable location."
	exit 1
    fi

    echo "Success."
fi

# Back up old dotfiles and install symbolic links
for file in $DOTFILES; do
    if [ -f $HOME/.$file ]; then
	# Dotfile exists. make a backup.
	if [ -h $HOME/.$file ]; then
	    echo $HOME/.$file is a symbolic link. Skipping.
	else
	    echo "Backing up $file.."
	    mv $HOME/.$file $OLDDIR/$file
	    echo $HOME/.$file $OLDDIR
	    echo "Installing symbolic link for $file"
	    ln -s $PWD/$file $HOME/.$file
	fi
    else
	# Symbolic link and dotfile do not exist, Create link.
	echo "Installing symbolic link for $file"
	ln -s $PWD/$file $HOME/.$file
    fi
done

# Create .zsh.d directory
echo -n "Checking if $HOME/.zsh.d exists.. "
if [ -d $HOME/.zsh.d ]; then
    echo "yes."
else
    echo "no. Creating directory."
    mkdir $HOME/.zsh.d
fi

# Link zsh.d files
echo "Linking .zsh.d files.."
for file in $(ls $PWD/zsh.d); do
    echo -n "$file "
    if [ -h $HOME/.zsh.d/$file ]; then
	echo "is a symbolic link. Skipping."
    else
	echo "not installed yet. applying symlink."
	ln -s $PWD/zsh.d/$file $HOME/.zsh.d/$file
    fi
done

echo "Done."

