#!/bin/bash

MAX_LEN=35
VISUALIZER_WIDTH=5
VISUALIZER_GAP=2
BAR_CHARS=("▁" "▂" "▃" "▄" "▅" "▆" "▇")
PAUSED_BARS="▁▂▁▃▁"
POS=0
LAST_TITLE=""
LAST_BARS="$PAUSED_BARS"
SEP=$'\x1f'

playerctl_safe() {
    if command -v timeout >/dev/null 2>&1; then
        timeout 0.35s playerctl "$@" 2>/dev/null
    else
        playerctl "$@" 2>/dev/null
    fi
}

pango_esc() {
    local s="$1"
    s=${s//&/&amp;}
    s=${s//</&lt;}
    s=${s//>/&gt;}
    printf '%s' "$s"
}

json_esc() {
    local s="$1"
    s=${s//\\/\\\\}
    s=${s//\"/\\\"}
    s=${s//$'\n'/\\n}
    s=${s//$'\r'/}
    printf '%s' "$s"
}

emit() {
    printf '{"text":"%s\\n%s","class":"%s"}\n' \
        "$(json_esc "$1")" "$(json_esc "$2")" "$3" || return 1
}

markup_spaces() {
    local count="$1"
    local spaces=""

    while [ "$count" -gt 0 ]; do
        spaces="${spaces}&#160;"
        count=$((count - 1))
    done

    printf '%s' "$spaces"
}

make_bars() {
    local bars=""
    local idx
    local previous=-1

    for ((i = 0; i < VISUALIZER_WIDTH; i++)); do
        idx=$((RANDOM % ${#BAR_CHARS[@]}))

        if [ "$idx" -eq "$previous" ]; then
            idx=$(((idx + 1 + RANDOM % (${#BAR_CHARS[@]} - 1)) % ${#BAR_CHARS[@]}))
        fi

        bars="${bars}${BAR_CHARS[$idx]}"
        previous="$idx"
    done

    if [ "$bars" = "$LAST_BARS" ]; then
        bars=""
        previous=-1
        for ((i = 0; i < VISUALIZER_WIDTH; i++)); do
            idx=$((RANDOM % ${#BAR_CHARS[@]}))
            if [ "$idx" -eq "$previous" ]; then
                idx=$(((idx + 1) % ${#BAR_CHARS[@]}))
            fi
            bars="${bars}${BAR_CHARS[$idx]}"
            previous="$idx"
        done
    fi

    printf '%s' "$bars"
}

TITLE_INDENT=$(markup_spaces "$((VISUALIZER_WIDTH + VISUALIZER_GAP))")
IDLE_INDENT=$(markup_spaces 3)

while true; do
    METADATA=$(playerctl_safe metadata --format "{{status}}${SEP}{{title}}${SEP}{{artist}}")
    STATUS=${METADATA%%"$SEP"*}

    if [ -z "$STATUS" ] || [ "$STATUS" = "Stopped" ]; then
        LAST_TITLE=""
        POS=0
        LAST_BARS="$PAUSED_BARS"
        IDLE_ICON=$'\uf001'
        LINE1="<span foreground='#666666'>${IDLE_ICON}</span>  <b>No music playing</b>"
        LINE2="<span size='small' weight='400' foreground='#777777'>${IDLE_INDENT}Ready when you press play</span>"
        emit "$LINE1" "$LINE2" "stopped" || exit 0
        sleep 0.5
        continue
    fi

    REST=${METADATA#*"$SEP"}
    TITLE=${REST%%"$SEP"*}
    ARTIST=${REST#*"$SEP"}

    [ -z "$TITLE" ] && TITLE="Unknown track"
    [ -z "$ARTIST" ] && ARTIST="Unknown artist"

    # Reset scroll position when track changes
    if [ "$TITLE" != "$LAST_TITLE" ]; then
        POS=0
        LAST_TITLE="$TITLE"
    fi

    # Scrolling with seamless wrap
    if [ ${#TITLE} -gt $MAX_LEN ]; then
        PADDED="$TITLE   "
        PAD_LEN=${#PADDED}
        # Double the string so substring never falls off the end
        DOUBLED="$PADDED$PADDED"
        DISPLAY="${DOUBLED:$POS:$MAX_LEN}"
        POS=$(( (POS + 1) % PAD_LEN ))
    else
        DISPLAY="$TITLE"
    fi

    # A randomized equalizer feels closer to audio movement than a fixed wave.
    if [ "$STATUS" = "Playing" ]; then
        BARS=$(make_bars)
        LAST_BARS="$BARS"
    else
        BARS="$LAST_BARS"
    fi

    T=$(pango_esc "$DISPLAY")
    A=$(pango_esc "$ARTIST")

    LINE1="<span foreground='#D95F3B'>${BARS}</span>  <b>${T}</b>"
    LINE2="<span size='small' weight='400' foreground='#888888'>${TITLE_INDENT}${A}</span>"

    emit "$LINE1" "$LINE2" "${STATUS,,}" || exit 0

    sleep 0.1
done
