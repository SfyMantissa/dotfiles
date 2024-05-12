#!/bin/bash

function get_openvpn_status() {
    [ -z "$(pgrep --exact 'openvpn')" ] && echo '󰒎 ' || echo '󰒍 '
}

function main() {
    get_openvpn_status
}

main "$@"

