# golang stuff

# add newer go directories to $PATH if they exist
if [ -d /usr/lib/go-1.10/bin ]; then
        PATH="/usr/lib/go-1.10/bin:${PATH}"
        export PATH
fi

export GOPATH="${HOME}/go"

