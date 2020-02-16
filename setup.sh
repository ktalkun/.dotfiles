#!/usr/bin/env bash

# make sure we have pulled in and updated any submodules
git submodule init
git submodule update

declare -A entries

entries=(
    ["bash"]="${HOME}"
    ["bat"]="${HOME}"
    ["dunst"]="${HOME}"
    ["htop"]="${HOME}"
    ["i3"]="${HOME}"
    ["i3status"]="${HOME}"
    ["office"]="${HOME}"
    ["ranger"]="${HOME}"
    ["tmux"]="${HOME}"
    ["urxvt"]="${HOME}"
    ["vim"]="${HOME}"
    ["xorg"]="/"
    ["zsh"]="${HOME}"
)

# what directories should be installable by all users including the root user
base=(
    vim
    bash
    urxvt
    i3
    htop
    ranger
    bat
)

# folders that should, or only need to be installed for a local user
useronly=(
    git
)

# run the stow command for the passed in directory ($2) in location $1
stowit() {
    usr=$1
    app=$2
    # -v verbose
    # -R recursive
    # -t target
    stow -v -R -t ${usr} ${app}
}

echo ""
echo "Stowing apps for user: ${whoami}"

# install apps available to local users and root
#for app in ${base[@]}; do
#    stowit "${HOME}" $app 
#done

for key in ${!entries[@]}; do
	#echo "${entries[$key]}" $key
	stowit "${entries[$key]}" $key
done
