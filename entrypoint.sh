#!/bin/bash


find_file(){
    # Find a desired file and copy it to pwd
    DEAFULT=.github/default/$1
    CUSTOM=.github/custom/$1

    if test -f "$CUSTOM"; then
        # Try the custom file
        cp $CUSTOM .
    else
        if test -f "$DEAFULT"; then
            # Try the default file
            cp $DEAFULT .
        else
            file=$(find . | grep -w "$1"| head -n 1)
            touch $file
            found_file=$?
            if [[ "$found_file" -eq 0 ]]; then
                # Try find file at other location 
                cp $file .
            else
                # Use the default one with the package
                echo "$1 not found, using default\n"
                cp /$1 .
            fi
        fi
    fi
}

find_file "wordlist.txt"
find_file "spellcheck.yaml"


pyspelling -c spellcheck.yaml
