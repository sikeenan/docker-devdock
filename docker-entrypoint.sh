#!/bin/bash
#
replaceconfig () {
    local configtag=$1
    local replacewith=$2
    local configfile=$3

    echo "$configtag"
    cat $configfile | sed -e "s/$configtag/$replacewith/g" > /tmp/tempfile.$$
    if [ $? -eq 0 ]
    then
        cp /tmp/tempfile.$$ $3
        
    else
        exit 1
    fi
}

# just the date/time we started up
echo "$(date): Container started."

# If you want to do something each time you re-make the container, using your persistent volum
# then make sure you update this shell script with you reqirements.
if [ -f /development/stuff-todo-when-starting.sh ]
then
    chmod +x /stuff-todo-when-starting.sh
    sh -x /stuff-todo-when-starting.sh
fi

# sleep forever
sleep infinity