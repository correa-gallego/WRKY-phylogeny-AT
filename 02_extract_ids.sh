#!/bin/bash
set -euo pipefail

RAW="/Users/scorrea/Documents/proteomics_AT/00_raw"
IDS="/Users/scorrea/Documents/proteomics_AT/01_ids"
LOCI="$IDS/wrky_loci.txt"
AT="$RAW/Athaliana_protein.fa"

mkdir -p "$IDS"

cat > "$LOCI" << 'LOCI'
At2g04880
At1g55600
At4g31550
At2g44745
At4g39410
At1g30650
At2g23320
At5g45050
At2g24570
At4g31800
At4g12020
At5g56270
At4g26640
At2g30590
At4g01250
At2g47260
At5g41570
At2g30250
At5g07100
At5g52830
At4g18170
At4g23550
At2g03340
At5g24110
At4g22070
At4g30935
At2g38470
At4g26440
At2g34830
At1g69810
At5g22570
At3g04670
At1g13960
At1g80840
At4g11070
At4g04450
At2g46130
At2g37260
At3g01970
At2g46400
At4g01720
At5g49520
At5g43290
At5g26170
At5g64810
At5g45270
At4g23810
At2g40750
At2g40740
At1g64000
At1g69310
At3g01080
At2g21900
At1g62300
At2g25000
At1g18860
At5g01900
At1g66600
At1g66560
At1g29280
At1g80590
At1g66550
At3g62340
At3g58710
At4g24240
At3g56400
At1g29860
At5g15130
At5g28650
At5g13080
At5g46350
At1g68150
LOCI

grep "^>" "$AT" | grep -if "$LOCI" | sed 's/^>//' | awk '{print $1}' > "$IDS/wrky_ids.txt"

MATCHED=$(wc -l < "$IDS/wrky_ids.txt")
TOTAL=$(wc -l < "$LOCI")

echo "Loci input:  $TOTAL"
echo "IDs matched: $MATCHED"

if [ "$MATCHED" -lt "$TOTAL" ]; then
  echo ""
  echo "Unmatched loci (not found in proteome):"
  while read locus; do
    grep -qi "$locus" "$IDS/wrky_ids.txt" || echo "  MISSING: $locus"
  done < "$LOCI"
  echo "Note: missing loci may be absent from this proteome version. Proceeding with $MATCHED sequences."
fi
