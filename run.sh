#!/bin/bash
while true; do
  timeout 30m ./keyhunt -m bsgs -f tests/140.txt -b 140 -t 4 -s 10 -R
  sleep 10m
done
