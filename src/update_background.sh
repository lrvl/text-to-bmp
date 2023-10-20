#!/bin/bash

BASE_DIR="/tmp/text-to-bmp"
TEXT_FILE="$BASE_DIR/last_journal_bg_text.txt"
OUTPUT_IMAGE="$BASE_DIR/output.bmp"
mkdir -p "$BASE_DIR"

while true; do
    # Extract latest logs to $TEXT_FILE (Modify this as per your requirements)
    sudo journalctl -n 500 | grep -v "sudo\[" | tail -n 65 | sudo tee $TEXT_FILE > /dev/null
    
    # Convert text to image
    docker run --rm -e XDG_RUNTIME_DIR=/tmp \
    -v $TEXT_FILE:/app/logs.txt \
    -v /tmp/text-to-bmp:/app/output text-to-bmp /app/text-to-bmp /app/logs.txt
    
    # Set image as desktop background
    feh --bg-fill $OUTPUT_IMAGE
    
    # Wait for a few seconds before next update
    sleep 10
done

