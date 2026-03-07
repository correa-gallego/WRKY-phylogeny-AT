#!/bin/zsh
set -euo pipefail

RAW="/Users/scorrea/Documents/proteomics_AT/00_raw"
mkdir -p "$RAW"

AT="$RAW/Athaliana_protein.fa"
OS="$RAW/Osativa_protein.fa"
SL="$RAW/Slycopersicum_protein.fa"

[[ -s "$AT" ]] || curl -L -o "$AT" \
  "https://raw.githubusercontent.com/UniversidadEAFIT/compubiol_course/refs/heads/master/Athaliana_167_protein_primaryTranscriptOnly.fa"

[[ -s "$OS" ]] || curl -L -o "$OS" \
  "https://raw.githubusercontent.com/UniversidadEAFIT/compubiol_course/refs/heads/master/Osativa_204_protein_primaryTranscriptOnly.fa"

[[ -s "$SL" ]] || {
  curl -L -o "${SL}.gz" \
    "https://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/reference_proteomes/Eukaryota/UP000004994/UP000004994_4081.fasta.gz"
  gunzip "${SL}.gz"
}

for f in "$AT" "$OS" "$SL"; do
  echo "$(basename $f): $(grep -c '^>' $f) sequences"
done
