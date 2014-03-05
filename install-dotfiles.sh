#!/bin/sh

# install-dotfiles.sh -- Creates symlinks to dotfiles contained in
#                     -- this repo. Additionally backs up old ones
#                     -- if they are present.
# By Daniel Roberson
#
# TODO: Add more error checking.

OLDDIR="$HOME/.dotfiles-backup"
DOTFILES="profile zshrc kshrc emacs muttrc vimrc xbindkeysrc Xresources"

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

echo "Done."
