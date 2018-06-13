# golang stuff

# Add newer go directories to $PATH if they exist
if [ -d /usr/lib/go-1.10/bin ]; then
        PATH="/usr/lib/go-1.10/bin:${GOPATH}/bin:${PATH}"
	export PATH
fi

# Set GOPATH if go is installed
which go >/dev/null
if [ $? -eq 0 ]; then
	export GOPATH="${HOME}/go"
	PATH="${GOPATH}/bin:${PATH}"
	export PATH
fi

