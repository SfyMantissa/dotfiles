#!/bin/bash

# Using custom command instead of default `date` implementation in `polybar`
# because it does not work properly with the `%:::z` formatting sequence.
function get_datetime() {
    echo -n '󱛡 '
    date +'%a %F %T UTC%:::z'
}

function main() {
    get_datetime
}

main "$@"

