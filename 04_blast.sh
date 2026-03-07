#!/bin/bash
set -euo pipefail

RAW="/Users/scorrea/Documents/proteomics_AT/00_raw"
QUERY="/Users/scorrea/Documents/proteomics_AT/02_seqtk/AT_WRKY.fa"
OUT="/Users/scorrea/Documents/proteomics_AT/03_blast"
FMT="6 qseqid sseqid pident length evalue bitscore"

mkdir -p "$OUT"

for SPECIES in Osativa Slycopersicum; do
  FA="$RAW/${SPECIES}_protein.fa"
  DB="$OUT/${SPECIES}_db"

  [ -f "${DB}.pin" ] || conda run -n blast makeblastdb -in "$FA" -dbtype prot -parse_seqids -out "$DB"

  conda run -n blast blastp \
    -query "$QUERY" \
    -db "$DB" \
    -evalue 1e-10 \
    -max_target_seqs 1 \
    -num_threads 4 \
    -outfmt "$FMT" \
    -out "$OUT/AT_WRKY_vs_${SPECIES}.tsv"

  echo "$SPECIES hits: $(wc -l < "$OUT/AT_WRKY_vs_${SPECIES}.tsv")"
done
