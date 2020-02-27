#!/bin/bash
if [ ! -f ./spellcheck.yaml ]; then
    echo "spellcheck.yaml not found, using default\n"
    cp /spellcheck.yaml .
fi

if [ ! -f ./wordlist.txt ]; then
    echo "wordlist.txt not found, using default\n"
    cp /wordlist.txt .
fi

pyspelling -c spellcheck.yaml
