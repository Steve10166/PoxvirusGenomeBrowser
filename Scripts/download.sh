#!/bin/bash

# List of Accession IDs with Descriptive Names
ids=(
    "KJ642619.1|Monkeypox_virus"
    "PP405600.1|Variola virus"
    "KY463519.1|Cowpox virus"
    "AF438165.1|Camelpox virus"
    "NC_003389.1|Swinepox virus"
    "AY077832.1|Sheeppox virus"
    "NC_004105.1|Ectromelia virus"
    # Example of another ID
)

# Base URL for NCBI E-utilities
base_url="http://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi"

# Loop through IDs and download each file
for entry in "${ids[@]}"
do
    # Split the ID and description
    id="${entry%%|*}"        # Extract the accession ID
    description="${entry##*|}" # Extract the description

    # Construct the full URL
    url="${base_url}?db=nucleotide&id=${id}&rettype=fasta"

    # Define the output filename
    filename="${description}_${id}.fasta"

    # Download the file
    wget -O "$filename" "$url"

    # Check if download succeeded
    if [ $? -eq 0 ]; then
        echo "Downloaded: $filename"
    else
        echo "Failed to download: $id"
    fi
done
