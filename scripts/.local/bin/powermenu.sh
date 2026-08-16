#! /bin/sh

CHOSEN=$(echo -e "Sleep\nHibernate\nReboot\nShutdown" | rofi -dmenu -theme ~/.config/rofi/powermenu.rasi -mesg "Power Menu" -u 1:4 -a 1)

case "$CHOSEN" in
    "Sleep") systemctl suspend ;;
    "Hibernate") systemctl hibernate ;;
    "Reboot") reboot ;;
    "Shutdown") shutdown -h now ;;
    *) exit 0 ;;
esac
