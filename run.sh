#!/bin/bash

options=(
    "-v -i 5 -s 1"
    "-v -i 7 -s 2"
    "-v -i 10 -s 4"
    "-v -i 15 -s 7"
)

base_command() {
    ./bin/lab3 "$@"
}

print_verbose_results() {
    for i in "${options[@]}"; 
    do
        time base_command ${i}
        echo "==================================="
    done
}

print_verbose_results
