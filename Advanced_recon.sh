#!/bin/bash

# get the target IP address
echo "Enter the target IP address:"
read IP_ADDRESS

# get the port range to scan
echo "Enter the port range to scan (e.g. 1-1024):"
read PORT_RANGE

# split the port range into start and end
PORT_RANGE=(${PORT_RANGE//-/ })
START_PORT=${PORT_RANGE[0]}
END_PORT=${PORT_RANGE[1]}

# create an empty list for open ports
OPEN_PORTS=()

# scan the target IP address for open ports
for port in $(seq $START_PORT $END_PORT)
do
  nc -z $IP_ADDRESS $port &> /dev/null
  if [ $? -eq 0 ]; then
    OPEN_PORTS+=($port)
  fi
done

# print the list of open ports
echo "Open ports on $IP_ADDRESS: ${OPEN_PORTS[@]}"
