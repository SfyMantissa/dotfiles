#!/bin/bash

function main() {
    if pgrep --exact 'screenkey' >/dev/null; then
        pkill 'screenkey'
    else
        screenkey \
            -s small \
            -p top \
            -g 512x1024+1405-107 \
            -t 1 \
            --bg-color '#2B2A3B' \
            --ignore BackSpace \
            --font 'Iosevka' \
            &
    fi
}

main

