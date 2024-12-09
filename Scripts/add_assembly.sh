#!/bin/bash

# Define the APACHE_ROOT variable (modify this if necessary)
APACHE_ROOT="/opt/homebrew/var/www"

assemblies=(
    "Monkeypox_virus_KJ642619.1.fasta"
    "Variola virus_PP405600.1.fasta"
    "Cowpox virus_KY463519.1.fasta"
    "Camelpox virus_AF438165.1.fasta"
    "Swinepox virus_NC_003389.1.fasta"
    "Sheeppox virus_AY077832.1.fasta"
    "Ectromelia virus_NC_004105.1.fasta"
)

for assembly in "${assemblies[@]}"
do
    echo "Adding assembly: $assembly"
    jbrowse add-assembly "$assembly" --out "$APACHE_ROOT/jbrowse2" --load copy

    if [ $? -eq 0 ]; then
        echo "Successfully added assembly: $assembly"
    else
        echo "Failed to add assembly: $assembly"
        exit 1
    fi
done

echo "All assemblies added successfully!"
