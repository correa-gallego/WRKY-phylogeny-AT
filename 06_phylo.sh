#!/bin/bash
set -euo pipefail

ALN="/Users/scorrea/Documents/proteomics_AT/04_alignment"
OUT="/Users/scorrea/Documents/proteomics_AT/05_iqtree"

mkdir -p "$OUT"

conda run -n phylo mafft --auto --thread -1 "$ALN/all_WRKY.fa" > "$ALN/all_WRKY_aln.fa"

echo "Aligned: $(grep -c '^>' "$ALN/all_WRKY_aln.fa") sequences"

conda run -n phylo iqtree -s "$ALN/all_WRKY_aln.fa" -m TEST -B 1000 -T AUTO --prefix "$OUT/WRKY_3spp" --redo

echo "Tree: $OUT/WRKY_3spp.treefile"
