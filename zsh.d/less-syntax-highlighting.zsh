# less syntax highlighting
# requires source-highlighting package

if [ `uname` = "Linux" ]; then
    export LESSOPEN="|/usr/share/source-highlight/src-hilite-lesspipe.sh %s"
elif [ `uname` = "Darwin" ]; then
    export LESSOPEN="|/usr/local/Cellar/source-highlight/3.1.8_3/bin/src-hilite-lesspipe.sh %s"
fi

export LESS=" -R "

