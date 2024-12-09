#!/bin/bash

# Define the output directory for JBrowse
output_dir="/opt/homebrew/var/www/jbrowse2"  # Update if needed

for gff_file in *.gff3; do
    base_name=$(basename "$gff_file" .gff3)

    echo "Sorting GFF3 file: $gff_file"
    jbrowse sort-gff "$gff_file" > "${base_name}_sorted.gff"

    echo "Compressing sorted GFF file: ${base_name}_sorted.gff"
    bgzip -f "${base_name}_sorted.gff"

    echo "Indexing compressed GFF file: ${base_name}_sorted.gff.gz"
    tabix -p gff "${base_name}_sorted.gff.gz"

    echo "Adding track for $base_name"
    jbrowse add-track "${base_name}_sorted.gff.gz" \
        --assemblyNames "$base_name" \
        --out "$output_dir" \
        --load copy
done

echo "All GFF3 files have been processed and added as tracks!"
