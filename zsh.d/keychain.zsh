# keychain integration

if [ -e `which keychain` ]; then
	keychain -Q -q ~/.ssh/id_rsa
	source ~/.keychain/`hostname`-sh
fi

