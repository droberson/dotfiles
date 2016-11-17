# Control+X inserts "sudo" at the start of line
# insert_sudo () {
#   [[-z $BUFFER ]] && zle up-history
#   if [[ $BUFFER != sudo\ * ]]; then
#     zle beginning-of-line;
#     zle -U "sudo "
#   fi
# }
# zle -N insert-sudo insert_sudo
# bindkey "^X" insert-sudo

