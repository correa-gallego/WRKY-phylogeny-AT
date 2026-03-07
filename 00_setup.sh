#!/bin/zsh
set -euo pipefail

PROJECT="/Users/scorrea/Documents/proteomics_AT"
mkdir -p "$PROJECT"/{00_raw,01_ids,02_seqtk,03_blast,04_alignment,05_iqtree,logs,scripts}

conda create -n seqtk -c bioconda seqtk -y 2>/dev/null || true
conda create -n blast  -c bioconda blast  -y 2>/dev/null || true
conda create -n phylo  -c bioconda mafft iqtree -y 2>/dev/null || true

conda env list
