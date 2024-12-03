#!/bin/bash

# List of Accession IDs with Descriptive Names
ids=(
    "KJ642619.1|Monkeypox_virus_Gabon_1988"
    "NC_001802.1|HIV1_complete_genome" # Example of another ID
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
