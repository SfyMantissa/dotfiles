#!/bin/bash

function main() {
    local led_mask
    local layout

    led_mask="$(xset -q | awk '/LED/ {print $10}')"

    case "${led_mask}" in
        "00000000" | "00000002" | "00000004" | "00000006") layout='En' ;;
        "00000001" | "00000003" | "00000005" | "00000007") layout='EN' ;;
        "00001000" | "00001002" | "00001004" | "00001006") layout='Ru' ;;
        "00001001" | "00001003" | "00001005" | "00001007") layout='RU' ;;
        *) layout="??" ;;
    esac

    echo "󰗊 ${layout}"
}

main

