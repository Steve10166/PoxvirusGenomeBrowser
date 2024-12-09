#!/bin/bash


echo "Step 1: Merging all FASTA files..."
cat *.fasta > all_species.fasta


if [ ! -s all_species.fasta ]; then
    echo "Error: Merged FASTA file 'all_species.fasta' is empty. Ensure the directory contains valid FASTA files."
    exit 1
fi
echo "All FASTA files have been merged into 'all_species.fasta'."


echo "Step 2: Filtering sequences longer than 50,000 bases..."
seqkit seq -m 50000 all_species.fasta > filtered_species.fasta


if [ ! -s filtered_species.fasta ]; then
    echo "Error: Filtered FASTA file 'filtered_species.fasta' is empty. No sequences passed the filter."
    exit 1
fi
echo "Sequences longer than 50,000 bases have been removed. Filtered file: 'filtered_species.fasta'."


echo "Step 3: Replacing ambiguous bases (N -> A)..."
sed -i 's/N/A/g' filtered_species.fasta
echo "Ambiguous bases replaced in 'filtered_species.fasta'."


echo "Step 4: Performing multiple sequence alignment with MAFFT..."
mafft --auto filtered_species.fasta > aligned_species.fasta


if [ ! -s aligned_species.fasta ]; then
    echo "Error: Alignment file 'aligned_species.fasta' is empty. Check MAFFT installation and input data."
    exit 1
fi
echo "Alignment completed. Results saved in 'aligned_species.fasta'."


echo "Step 5: Trimming alignment with trimAl..."
trimal -in aligned_species.fasta -out trimmed_species.fasta -automated1


if [ ! -s trimmed_species.fasta ]; then
    echo "Error: Trimmed alignment file 'trimmed_species.fasta' is empty. Check trimAl installation and alignment."
    exit 1
fi
echo "Trimming completed. Results saved in 'trimmed_species.fasta'."

echo "Data processing completed successfully! Proceed to phylogenetic tree construction."
