#!/bin/bash

# Function to filter CSV file based on column position
filter_csv() {
    local input_file="$1"
    local column_name="$2"

    # Find the position of the column
    local column_position=$(awk -F, -v col="$column_name" 'NR==1 {for (i=1; i<=NF; i++) if ($i == col) print i}' "$input_file")

    # Check if the column exists
    if [ -z "$column_position" ]; then
        echo "Column '$column_name' not found in the CSV file."
        exit 1
    fi

    # Extract data based on column position
    awk -F, -v col_pos="$column_position" '{if (NR % col_pos == 1) print $col_pos}' "$input_file"
}

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_csv_file> <column_name>"
    exit 1
fi

# Call the filter_csv function with provided arguments
filter_csv "$1" "$2"
