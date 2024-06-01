#!/bin/bash
# Add to `sudoers`:
# %sudo   ALL=NOPASSWD: /usr/bin/wg-client --wg-up
# %sudo   ALL=NOPASSWD: /usr/bin/wg-client --wg-dn

function main() {
    local action
    local hook
    local message

    if [[ "$(wg-client --show-wg-running)" == 'False' ]]; then
        action='--wg-up'; hook=1; message='VPN On'
    else
        action='--wg-dn'; hook=0; message='VPN Off'
    fi

    sudo wg-client "${action}"
    polybar-msg action vpn hook "${hook}"
    notify-send --app-name 'Polybar' "$(printf '\n%s' "${message}")"
}

main

