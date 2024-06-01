#!/bin/bash
# grep 'Experimental = ' /etc/bluetooth/main.conf
# Experimental = true
# MUST be set to `true`.

IS_CONNECTED='Connected: yes'


function main() {
    local earphones_name
    local earphones_mac
    local earphones_status

    bluetoothctl power on &
    wait

    earphones_name="$1"

    earphones_mac=$(bluetoothctl devices \
        | awk -v name="${earphones_name}" '{if ($3 == name) print $2}')

    earphones_status=$(bluetoothctl info "${earphones_mac}" \
        | grep -c "${IS_CONNECTED}")

    if [ "${earphones_status}" -eq "0" ]; then 
        bluetoothctl connect "${earphones_mac}"
    else
        bluetoothctl disconnect "${earphones_mac}" 
    fi
}

main "$@"

