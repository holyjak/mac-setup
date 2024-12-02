#!/bin/zsh
FILE=~/.oh-my-zsh/oh-my-zsh.sh
if ! [ -f "$FILE" ]; then
    echo "$FILE does not exist and we install ohmyzsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
fi