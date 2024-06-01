#!/bin/bash

function main() {
    if [ "$(dunstctl is-paused)" == false ]; then
        notify-send -u critical "All notifications are paused!"
        sleep 1
        dunstctl set-paused toggle
    else
        dunstctl set-paused toggle
        notify-send -u critical "All notifications are unpaused!"
    fi
}

main

