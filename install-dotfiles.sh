#!/usr/bin/env bash

# install-dotfiles.sh -- Creates symlinks to dotfiles contained in
#                     -- this repo. Additionally backs up old ones
#                     -- if they are present.
# By Daniel Roberson
#
# TODO: Add more error checking.

OLDDIR="$HOME/.dotfiles-backup"
DOTFILES="emacs muttrc vimrc xbindkeysrc Xresources"

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
    fi
else
    echo "no.. Attempting to create."

    mkdir $OLDDIR
    if [ $? -eq 1 ]; then
	echo "Failure. Ensure that $OLDDIR is a suitable location."
	exit 1
    fi

    echo "Success."
fi

# Back up old dotfiles
for file in $DOTFILES; do
    echo "Backing up $file"
    mv $HOME/.$file $OLDDIR
done

# Create symlinks.
for file in $DOTFILES; do
    echo "Installing symlink for $file"
    ln -s $PWD/$file $HOME/.$file
done

echo "Done."
