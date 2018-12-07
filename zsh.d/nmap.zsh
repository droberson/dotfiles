# Log nmap scans to ~/.nmap

NMAP_BIN=$(which nmap)
if [ $? -eq 0 ]; then
    if [ ! -d $HOME/.nmap ]; then
        mkdir $HOME/.nmap
    fi
    nmap () {
        NMAP_LOGFILE=$HOME/.nmap/nmap-$(date +%F-%T.%N).log
        echo "nmap $@\n\n" > $NMAP_LOGFILE
        $NMAP_BIN $@ |tee -a $NMAP_LOGFILE
    }
fi

