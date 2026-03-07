#!/bin/bash
set -euo pipefail

RAW="/Users/scorrea/Documents/proteomics_AT/00_raw"
IDS="/Users/scorrea/Documents/proteomics_AT/01_ids"
OUT="/Users/scorrea/Documents/proteomics_AT/02_seqtk"

mkdir -p "$OUT"

conda run -n seqtk seqtk subseq "$RAW/Athaliana_protein.fa" "$IDS/wrky_ids.txt" > "$OUT/AT_WRKY.fa"

echo "Sequences extracted: $(grep -c '^>' "$OUT/AT_WRKY.fa")"
