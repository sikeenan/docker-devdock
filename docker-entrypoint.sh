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

echo "$(date): Container started."

if [ -f /stuff-todo-when-starting.sh ]
then
    chmod +x /stuff-todo-when-starting.sh
    sh -x /stuff-todo-when-starting.sh
fi

sleep infinity