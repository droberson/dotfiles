# various reverse engineering things.

# objdump syntax highlighting using vim
function disas () {
	# make sure an argument was supplied
	if [ -z $1 ]; then
		echo "usage: disas <file>"
		return 1
	fi

	# this relies on vim and objdump being present
	if ! program_exists vim ] || ! program_exists objdump; then
		echo "disas: vim and objdump must be installed"
		return 1
	fi

	if [ ! -e $1 ]; then
		echo "file $1 does not exist"
		return 1
	fi

	# view is included with vim. opens files read only, so you
	# do not get prompted to save changes when you exit.
	objdump -xRDT $1 | view -c ':set syntax=asm' -
}

