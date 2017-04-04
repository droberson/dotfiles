# keychain integration

# check if keychain is installed
if ! program_exists keychain; then
	return
fi

# check if rsa key exists
if [ -e ~/.ssh/id_rsa ]; then
	keychain -Q -q ~/.ssh/id_rsa
	source ~/.keychain/`hostname`-sh
fi

