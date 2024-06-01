#!/bin/bash

readonly RECORDS_DIR="${HOME}/media/records"


function record() {
    local default_sink_monitor
    local recording_file

    default_sink_monitor="$(pactl get-default-sink).monitor"
    recording_file="$(date +%F-%T%:::z | tr ':+' '-').mp4"

    ffmpeg \
        -f x11grab -framerate 60 -i :0 \
        -f pulse -ac 2 -i default \
        -f pulse -ac 2 -i "${default_sink_monitor}" \
        -filter_complex "[1:a][2:a]amix=inputs=2:duration=longest" \
        -c:v libx264 -crf 32 -preset ultrafast \
        -c:a aac -b:a 128k \
        -vsync 2 \
        "${RECORDS_DIR}/${recording_file}"
}

function main() {
    mkdir --parents "${RECORDS_DIR}"

    if ! pgrep -x ffmpeg >/dev/null; then
        notify-send --app-name 'Polybar' "$(printf '\nRecording started')"
        polybar-msg action ffmpeg hook 1
        record
    else
        notify-send --app-name 'Polybar' "$(printf '\nRecording finished')"
        polybar-msg action ffmpeg hook 0
        pkill ffmpeg
    fi
}

main

