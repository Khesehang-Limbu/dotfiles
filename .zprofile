if [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
    export XDG_SESSION_TYPE=wayland
    export GDK_BACKEND=wayland
    export QT_QPA_PLATFORM=wayland
    exec hyprland
fi

