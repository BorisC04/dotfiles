#! /bin/sh

CHOSEN=$(echo -e "Sleep\nHibernate\nReboot\nShutdown" | wofi --conf="$HOME"/.config/wofi/powermenu_config)

case "$CHOSEN" in
    "Sleep") systemctl suspend-then-hibernate ;;
    "Hibernate") systemctl hibernate ;;
    "Reboot") reboot ;;
    "Shutdown") shutdown -h now ;;
esac
