#!/bin/bash

SPEAKER_SINK="$(pactl list | grep -m 1 -o 'alsa.*Speaker__sink')"


function get_earphones_sink() {
    local earphones_name="$1"
    local earphones_mac_underscores

    earphones_mac_underscores=$(bluetoothctl devices \
        | awk -v earphones_name="${earphones_name}" \
        '{if ($3 == earphones_name) print $2}' \
        | tr ':' '_')

    echo "bluez_sink.${earphones_mac_underscores}.a2dp_sink"
}

# Uses a customized fork of `pulseaudio-control` with Bluetooth device battery
# output. `PACTL` contains the path to the customized script.
function pulseaudio_control_wrap() {
    "${PACTL}" \
         --icons-volume "󰕿,󰖀,󰕾" \
         --icon-muted "󰝟" \
         --color-muted "ffb86c" \
         --node-nickname "${SPEAKER_SINK}:󰓃" \
         --node-nickname "${EARPHONES_SINK}: " \
         --node-nickname "${EARPHONES_NEW_SINK}:󱡏 " \
         --icons-bluetooth-battery "󰤾 ,󰤿 ,󰥀 ,󰥁 ,󰥂 ,󰥃 ,󰥄 ,󰥅 ,󰥆 ,󰥈 " \
         --hide-bluetooth-battery-level \
         listen
}

function main() {
    EARPHONES_SINK="$(get_earphones_sink 'earphones')"
    EARPHONES_NEW_SINK="$(get_earphones_sink 'earphones-new')"

    pulseaudio_control_wrap
}

main

