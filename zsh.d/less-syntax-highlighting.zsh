# less syntax highlighting
# requires source-highlighting package


if [ $(uname) = "Linux" ]; then
    if [ -x "/usr/share/source-highlight/src-hilite-lesspipe.sh" ]; then
        export LESSOPEN="|/usr/share/source-highlight/src-hilite-lesspipe.sh %s"
    fi
elif [ $(uname) = "Darwin" ]; then
    if [ -x "/usr/local/Cellar/source-highlight/3.1.8_3/bin/src-hilite-lesspipe.sh" ]; then
        export LESSOPEN="|/usr/local/Cellar/source-highlight/3.1.8_3/bin/src-hilite-lesspipe.sh %s"
    fi
fi

export LESS=" -R "

