#!/usr/bin/env bash

# Check if the directory path is provided as an argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

# Check if the provided path is a directory
if [ ! -d "$1" ]; then
    echo "Error: '$1' is not a directory."
    exit 1
fi

# Get the list of files in the directory
files=("$1"/*)

# Check if there are any files in the directory
if [ ${#files[@]} -eq 0 ]; then
    echo "Error: No files found in the directory."
    exit 1
fi

# Choose a random file from the directory
random_file=${files[RANDOM % ${#files[@]}]}

# Call feh to set the background with the randomly chosen file
feh --bg-scale "$random_file"

# Set the colour theme
#wallust run "$random_file"

# Load the Wallpaper into the lockscreen
betterlockscreen -u "$random_file"
echo "Background set to: $random_file"

