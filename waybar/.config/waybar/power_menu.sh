#!/bin/bash
options=" Shutdown\n Reboot\n Suspend\n󰤄 Hibernate\n󰗽 Logout"
choice=$(echo -e "$options" | fuzzel --dmenu -p "Power Menu ❯" --width 15 --lines 5 --font="JetBrainsMono Nerd Font:size=14")

case "$choice" in
    *"Shutdown"*) systemctl poweroff ;;
    *"Reboot"*) systemctl reboot ;;
    *"Suspend"*) systemctl suspend ;;
    *"Hibernate"*) systemctl hibernate ;;
    *"Logout"*) hyprctl dispatch exit ;;
esac
