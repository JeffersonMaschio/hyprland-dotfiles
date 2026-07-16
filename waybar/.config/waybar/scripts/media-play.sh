#!/bin/bash
playerctl_safe() {
    if command -v timeout >/dev/null 2>&1; then
        timeout 0.35s playerctl "$@" 2>/dev/null
    else
        playerctl "$@" 2>/dev/null
    fi
}

while true; do
    STATUS=$(playerctl_safe status)
    if [ "$STATUS" = "Playing" ]; then
        printf '{"text":"\uf28b","class":"playing"}\n' || exit 0
    elif [ "$STATUS" = "Paused" ]; then
        printf '{"text":"\uf144","class":"paused"}\n' || exit 0
    else
        printf '{"text":"\uf144","class":"stopped"}\n' || exit 0
    fi
    sleep 0.2
done
