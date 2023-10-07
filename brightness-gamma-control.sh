#!/bin/bash

# Initialize the last_gamma variable with an initial value
last_gamma=""

# Function to set gamma based on brightness level
set_gamma() {
    local brightness=$(light -G | awk '{printf "%.0f\n", $1}')
    local new_gamma

    if [ "$brightness" -ge 50 ] && [ "$brightness" -lt 75 ]; then
        new_gamma=1.1
    elif [ "$brightness" -ge 75 ]; then
        new_gamma=1.2
    else
        new_gamma=1
    fi

    # Check if the new gamma value is different from the last one
    if [ "$new_gamma" != "$last_gamma" ]; then
        xgamma -gamma "$new_gamma"
        last_gamma="$new_gamma"
    fi
}

# Continuously monitor and adjust gamma
while true; do
    set_gamma
    sleep 15  # Adjust the sleep interval as needed
done

