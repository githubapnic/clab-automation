#!/bin/bash

# Iterate over YAML files
for yaml_file in *.yaml *.yml; do
    if [ -e "$yaml_file" ]; then
        # Check if corresponding .gcp file exists
        gcp_file="${yaml_file}.gcp"
        if [ -e "$gcp_file" ]; then
            # Rename YAML file with .orig extension
            mv "$yaml_file" "${yaml_file}.orig"

            # Rename corresponding .gcp file
            mv "$gcp_file" "$yaml_file"
        else
            echo "Corresponding .gcp file not found for $yaml_file. Skipping."
        fi
    fi
done

echo "Renaming completed."

