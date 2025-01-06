#!/bin/bash

declare -A FORMAT_EXCEPTIONS=(
    ["Bspwm"]="Desktop"
    ["obs"]="OBS"
)


function get_wm_class() {
    local window_id

    window_id="$(xdotool getmouselocation | cut --delimiter=':' --fields=5)"

    [ "${window_id}" -eq "0" ] && return 0
    xprop -id "${window_id}" 'WM_CLASS' \
        | awk '{print $NF}' \
        | tr --delete '"'
}

function format_wm_class() {
    local class="${1^}"

    [ -z "${class}" ] && return 0
    [ -n "${FORMAT_EXCEPTIONS[$1]}" ] && class="${FORMAT_EXCEPTIONS[$1]}"
    echo "${class}" | sed --expression='s/^/[/' --expression='s/$/]/'
}

function main() {
    format_wm_class "$(get_wm_class)"
}

main

