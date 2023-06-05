#!/bin/bash

function show_help {
    echo ""
    echo "Usage: ${0} [-h | CONNECTION_URL]"
    echo ""
    echo "Connection URL format should be :"
    echo " For TCP : tcp://[server_host][:server_port]"
    echo " For UDP : udp://[bind_host][:bind_port]"
    echo " For Serial : serial:///path/to/serial/dev[:baudrate]"
    echo "For example, to connect to the simulator use URL: udp://:14540";
    echo ""
    echo "By default, the connection is udp://:14540."
}

OPTIND=1 # Reset in case getopts has been used previously in the shell.

while getopts "h?" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    esac
done

shift $((OPTIND-1))

if [ "$#" -eq 0 ]; then
    CONNECTION_URL="udp://:14540"
elif [ "$#" -eq 1 ]; then
    CONNECTION_URL="$1"
elif [ "$#" -eq 2 ]; then
    CONNECTION_URL="$1"
elif [ "$#" -gt 1 ]; then
    show_help
    exit 1;
fi

cd ${FIRMWARE_DIR} &&
./download_log_auto ${CONNECTION_URL}