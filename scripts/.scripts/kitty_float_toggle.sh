#!/bin/bash
# Add the rule to `.config/bspwm/bspwmrc`:
# `bspc rule -a kitty:kitty_float state=floating center=true rectangle=1024x768+0+0`

readonly KITTY_FLOAT_WM_CLASS='kitty_float'


function _handle_kitty_float() {
    local kitty_float_id="$1"
    local kitty_float_desktop
    local current_desktop

    kitty_float_desktop="$(bspc query -D -n "${kitty_float_id}")"
    current_desktop="$(bspc query -D -d 'focused')"

    if [ "${kitty_float_desktop}" != "${current_desktop}" ]; then
        bspc node "${kitty_float_id}" \
            --to-desktop 'focused' \
            --focus
    else
        bspc node "${kitty_float_id}" --flag 'hidden=on'
    fi
}

function get_id_wm_class_mappings() {
    local wm_class
    local id

    bspc query -N -n '.window' | while read -r id; do 
        wm_class=$(xprop -id "${id}" 'WM_CLASS' 2>/dev/null \
            | awk -F ' = ' '{print $2}' \
            | tr -d '"')
        echo "${id} ${wm_class}"
    done
}

function toggle_kitty_float() {
    local kitty_float_id="$1"

    if [ -z "$(bspc query -N -n "${kitty_float_id}.hidden")" ]; then
        _handle_kitty_float "${kitty_float_id}"
    else
        bspc node "${kitty_float_id}" \
            --flag 'hidden=off' \
            --to-desktop 'focused' \
            --focus
    fi
}

function main() {
    local kitty_float
    local kitty_float_id

    kitty_float=$(get_id_wm_class_mappings \
        | grep "${KITTY_FLOAT_WM_CLASS}")

    if [ -z "${kitty_float}" ]; then
        kitty --name "${KITTY_FLOAT_WM_CLASS}"
    else
        kitty_float_id=$(echo "${kitty_float}" | cut -d ' ' -f 1)
        toggle_kitty_float "${kitty_float_id}"
    fi
}

main

