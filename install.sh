#!/bin/bash
# Erdlöwe theme by DarthWound - install/update

rm ~/.bin/erdlowe.sh # if a previous version is already installed
mkdir ~/.bin
wget -P ~/.bin https://raw.githubusercontent.com/DarthWound/erdlowe-theme/master/erdlowe.sh
chmod +x ~/.bin/erdlowe.sh
printf "\n\n\e[1mScript installed\e[0m - run it with '~/.bin/erdlowe.sh' command.\n\n"
