# various reverse engineering things.

# objdump syntax highlighting using vim
function disas () {
    # make sure an argument was supplied
    if [ -z $1 ]; then
	echo "usage: disas <file>"
	return 1
    fi

    # this relies on vim and objdump being present
    if [ ! program_exists vim  || ! program_exists objdump ]; then
	echo "disas: vim and objdump must be installed"
	return 1
    fi

    if [ ! -e $1 ]; then
	echo "file does not exist: $1"
	return 1
    fi

    # view is included with vim. opens files read only, so you
    # do not get prompted to save changes when you exit.
    objdump -xRDT $1 | view -c ':set syntax=asm' -
}


# md5move
function md5move () {
     # TODO add -force/-f
     if [ -z $1 ]; then
	 echo "usage: md5move <file>"
	 return 1
     fi

     if [ ! -e $1 ]; then
	 echo "md5move: cannot move '$1': No such file or directory"
	 return 1
     fi

     MD5SUM=$(md5sum $1 | awk {'print $1'})
     if [ -e $MD5SUM ]; then
	 while true; do
	     echo -n "md5move: overwrite '$MD5SUM'? "
	     read yn
	     case $yn in
		 [Yy]* ) mv $1 "$MD5SUM";;
		 [Nn]* ) return 1;;
		 * ) return 1;;
	     esac
	 done
     else
	 mv $1 "$MD5SUM"
     fi
}

# sha256move
function sha256move () {
    # TODO add -force/-f
    if [ -z $1 ]; then
	echo "usage: sha256move <file>"
	return 1
    fi

    if [ ! -e $1 ]; then
	echo "sha265move: cannot move '$1': No such file or directory"
	return 1
    fi

    SHA256SUM=$(sha256sum $1 | awk {'print $1'})
    if [ -e $SHA256SUM ]; then
	while true; do
	    echo -n "sha256move: overwrite '$SHA256SUM'? "
	    read yn
	    case $yn in
		[Yy]* ) mv $1 "$SHA256SUM";;
		[Nn]* ) return 1;;
		* ) return 1;;
	    esac
	done
    else
	mv $1 "$SHA256SUM"
    fi
}
