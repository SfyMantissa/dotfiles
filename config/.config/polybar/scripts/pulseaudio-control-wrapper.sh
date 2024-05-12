#!/bin/bash

# Uses a customized fork of `pulseaudio-control` with Bluetooth device battery
# output.
function pulseaudio_control_wrap() {
    "${PULSEAUDIO_CONTROL}" \
         --icons-volume "󰕿,󰖀,󰕾" \
         --icon-muted "󰝟" \
         --color-muted "ffb86c" \
         --node-nickname "${SPEAKER}:󰓃" \
         --node-nickname "${EARPHONES}:󰋋 " \
         --icons-bluetooth-battery "󰤾 ,󰤿 ,󰥀 ,󰥁 ,󰥂 ,󰥃 ,󰥄 ,󰥅 ,󰥆 ,󰥈 " \
         --hide-bluetooth-battery-level \
         listen
}

function main() {
    pulseaudio_control_wrap
}

main "$@"

