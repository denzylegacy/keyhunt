#!/bin/bash

TEMP_LIMIT=75

get_cpu_temp() {
  sensors | grep 'Package id 0:' | awk '{print $4}' | cut -d '+' -f2 | cut -d '.' -f1
}

while true; do
  TEMP=$(get_cpu_temp)
  
  if [ -n "$TEMP" ] && [ "$TEMP" -gt "$TEMP_LIMIT" ]; then
    echo "----------------------------------------"
    echo " High Temperature Alert: ${TEMP}°C"
    echo " keyhunt will sleep for 10m..."
    echo "----------------------------------------"
    sleep 10m  # Rest for 10 minutes if temperature is high
  else
    if [ -n "$TEMP" ]; then
      echo "----------------------------------------"
      echo " Temperature Stable: ${TEMP}°C"
      echo " Running program now..."
      echo "----------------------------------------"
    else
      echo "----------------------------------------"
      echo " Warning: Unable to retrieve temperature"
      echo " Proceeding with program execution by default..."
      echo "----------------------------------------"
    fi
    ./keyhunt -m bsgs -f tests/140.txt -b 140 -t 4 -s 10 -R &
    sleep 30m
    pkill -f keyhunt
  fi
done
