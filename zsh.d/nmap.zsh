# Log nmap scans to ~/.nmap

NMAP_BIN=$(which nmap)
if [ $? -eq 0 ]; then
    if [ ! -d $HOME/.nmap ]; then
        mkdir $HOME/.nmap
    fi
    nmap () { $NMAP_BIN $@ |tee $HOME/.nmap/nmap-$(date +%F-%T.%N).log }
fi

