#!/bin/bash

wordlist=$(find . | grep -w "wordlist.txt"| head -n 1)
touch $wordlist
wordlist_found=$?

if [[ "$wordlist_found" -eq 0 ]]; then
    cp $wordlist .
else
    echo "wordlist.txt not found, using default\n"
    cp /wordlist.txt .
fi


spellcheck=$(find . | grep -w "spellcheck.yaml"| head -n 1)
touch $spellcheck
spellcheck_found=$?
if [[ "$spellcheck_found" -eq 0 ]]; then
    cp $spellcheck .
else
    echo "spellcheck.yaml not found, using default\n"
    cp /spellcheck.yaml .
fi


pyspelling -c spellcheck.yaml
