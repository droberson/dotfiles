# keychain integration

which keychain >/dev/null

if [ $? -eq 0 ]; then
	keychain -Q -q ~/.ssh/id_rsa
	source ~/.keychain/`hostname`-sh
fi

