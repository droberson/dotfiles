# Send myself an email/text reminder.
# usage: remind <militarytime> <email/sms> <message>
# TODO: check if <militarytime> is actualy a military time
# TODO: check if email is valid for arg2
# TODO: address book
# TODO: check if at/atd is even available.
remind() {
    if [ $# -lt 3 ]; then
        echo "usage: $0 <militarytime> <702xxxxxx@vmobl.com> <message>"
        echo " ex: $0 2000 7025555555@vmobl.com remember to buy milk"
        echo " -- schedules a text to myself at 8PM to remember the milk!"

        return 1
    fi

    # Build string to send
    count=0
    unset MSG
    for word in $* ; do
        count=$(($count + 1))

        if [ $count -gt 2 ]; then
            MSG="$MSG $word"
        fi
    done

    # Schedule with 'at'
    echo "echo $MSG | mail $2" | at $1 2> /dev/null
    if [ $? -eq 1 ]; then
        echo "$0 failed. Check syntax and try again."
        return 1
    fi

    echo "Message scheduled for delivery. Type 'atq' to view queue."
    return 0
}

