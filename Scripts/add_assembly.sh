#!/bin/bash

# Define the APACHE_ROOT variable (modify this if necessary)
APACHE_ROOT="/opt/homebrew/var/www"

# List of assembly files
assemblies=(
    "Monkeypox_virus_KJ642619.1.fasta"
    "Variola virus_PP405600.1.fasta"
    "Cowpox virus_KY463519.1.fasta"
    "Camelpox virus_AF438165.1.fasta"
    "Swinepox virus_NC_003389.1.fasta"
    "Sheeppox virus_AY077832.1.fasta"
    "Ectromelia virus_NC_004105.1.fasta"
    "Fowlpox virus_MG702259.1.fasta"
    "Rabbitpox virus_AY484669.1.fasta"
    "Horsepox virus_NC_066642.1.fasta"
    "Salmon Gill Poxvirus_NC_027707.1.fasta"
    "Buffalopox virus_MK239755.1.fasta"
    "Deerpox virus_NC_006966.1.fasta"

)

# Loop through the assemblies and add them
for assembly in "${assemblies[@]}"
do
    echo "Adding assembly: $assembly"
    jbrowse add-assembly "$assembly" --out "$APACHE_ROOT/jbrowse2" --load copy

    # Check if the command was successful
    if [ $? -eq 0 ]; then
        echo "Successfully added assembly: $assembly"
    else
        echo "Failed to add assembly: $assembly"
        exit 1
    fi
done

echo "All assemblies added successfully!"
