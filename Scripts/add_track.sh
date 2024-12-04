#!/bin/bash

# Define the output directory for JBrowse
output_dir="/opt/homebrew/var/www/jbrowse2"  # Update if needed

# Loop through all GFF3 files in the directory
for gff_file in *.gff3; do
    # Extract the base name for the file (without extensions)
    base_name=$(basename "$gff_file" .gff3)

    # Step 1: Sort the GFF3 file
    echo "Sorting GFF3 file: $gff_file"
    jbrowse sort-gff "$gff_file" > "${base_name}_sorted.gff"

    # Step 2: Compress the sorted GFF file
    echo "Compressing sorted GFF file: ${base_name}_sorted.gff"
    bgzip -f "${base_name}_sorted.gff"

    # Step 3: Index the compressed GFF file
    echo "Indexing compressed GFF file: ${base_name}_sorted.gff.gz"
    tabix -p gff "${base_name}_sorted.gff.gz"

    # Step 4: Add the track to JBrowse
    echo "Adding track for $base_name"
    jbrowse add-track "${base_name}_sorted.gff.gz" \
        --assemblyNames "$base_name" \
        --out "$output_dir" \
        --load copy
done

echo "All GFF3 files have been processed and added as tracks!"
