# keychain integration

# check if keychain is installed
which keychain >/dev/null
if [ $? -eq 1 ]; then
	exit
fi

# check if rsa key exists
if [ -e ~/.ssh/id_rsa ]; then
	keychain -Q -q ~/.ssh/id_rsa
	source ~/.keychain/`hostname`-sh
fi

