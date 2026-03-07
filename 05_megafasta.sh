#!/bin/bash
set -euo pipefail

RAW="/Users/scorrea/Documents/proteomics_AT/00_raw"
BLAST="/Users/scorrea/Documents/proteomics_AT/03_blast"
SEQTK="/Users/scorrea/Documents/proteomics_AT/02_seqtk"
OUT="/Users/scorrea/Documents/proteomics_AT/04_alignment"

mkdir -p "$OUT"

for SPECIES in Osativa Slycopersicum; do
  [ "$SPECIES" = "Osativa" ] && PREFIX="OS" || PREFIX="SL"
  awk '{print $2}' "$BLAST/AT_WRKY_vs_${SPECIES}.tsv" | sort -u > "$BLAST/${SPECIES}_homologs.txt"
  conda run -n seqtk seqtk subseq "$RAW/${SPECIES}_protein.fa" "$BLAST/${SPECIES}_homologs.txt" \
    | sed "s/^>/>${PREFIX}_/" > "$OUT/${SPECIES}_WRKY.fa"
  echo "$SPECIES: $(grep -c '^>' "$OUT/${SPECIES}_WRKY.fa") sequences"
done

sed 's/^>/>AT_/' "$SEQTK/AT_WRKY.fa" > "$OUT/AT_WRKY.fa"

cat "$OUT/AT_WRKY.fa" "$OUT/Osativa_WRKY.fa" "$OUT/Slycopersicum_WRKY.fa" > "$OUT/all_WRKY.fa"

echo "Megafasta total: $(grep -c '^>' "$OUT/all_WRKY.fa")"
echo "  AT: $(grep -c '^>AT_' "$OUT/all_WRKY.fa")"
echo "  OS: $(grep -c '^>OS_' "$OUT/all_WRKY.fa")"
echo "  SL: $(grep -c '^>SL_' "$OUT/all_WRKY.fa")"
