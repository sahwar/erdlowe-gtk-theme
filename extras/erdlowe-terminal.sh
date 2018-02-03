#!/bin/bash
# GNOME Terminal scheme using SUSE® palette

trpr=$(dconf read /org/gnome/terminal/legacy/profiles:/default | tr -d \')

dconf write /org/gnome/terminal/legacy/profiles:/:$trpr/use-theme-colors "false"
dconf write /org/gnome/terminal/legacy/profiles:/:$trpr/bold-color-same-as-fg "false"
dconf write /org/gnome/terminal/legacy/profiles:/:$trpr/bold-color "'rgb(0,192,129)'"
dconf write /org/gnome/terminal/legacy/profiles:/:$trpr/foreground-color "'rgb(2,211,95)'"
dconf write /org/gnome/terminal/legacy/profiles:/:$trpr/background-color "'rgb(13,44,64)'"
dconf write /org/gnome/terminal/legacy/profiles:/:$trpr/palette "['rgb(0,0,0)', 'rgb(222,0,128)', 'rgb(160,255,95)', 'rgb(237,105,36)', 'rgb(0,7,176)', 'rgb(132,23,129)', 'rgb(0,178,226)', 'rgb(167,169,172)', 'rgb(95,95,95)', 'rgb(255,153,212)', 'rgb(194,255,153)', 'rgb(247,191,161)', 'rgb(153,156,255)', 'rgb(240,168,237)', 'rgb(153,233,255)', 'rgb(220,221,222)']"
