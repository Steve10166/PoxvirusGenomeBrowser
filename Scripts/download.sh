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

    # Construct URLs for FASTA and GFF3
    fasta_url="${base_url}?db=nucleotide&id=${id}&rettype=fasta"
    gff3_url="${base_url}?db=nucleotide&id=${id}&rettype=gff3"

    # Define output filenames
    fasta_filename="${description}_${id}.fasta"
    gff3_filename="${description}_${id}.gff3"

    # Download the FASTA file
    wget -O "$fasta_filename" "$fasta_url"
    if [ $? -eq 0 ]; then
        echo "Downloaded FASTA: $fasta_filename"

        # Generate the FASTA index file (.fai)
        samtools faidx "$fasta_filename"
        if [ $? -eq 0 ]; then
            echo "Generated FASTA index: ${fasta_filename}.fai"
        else
            echo "Failed to generate FASTA index for: $fasta_filename"
        fi
    else
        echo "Failed to download FASTA: $id"
    fi

    # Download the GFF3 file
    wget -O "$gff3_filename" "$gff3_url"
    if [ $? -eq 0 ]; then
        echo "Downloaded GFF3: $gff3_filename"
    else
        echo "Failed to download GFF3: $id"
    fi
done
