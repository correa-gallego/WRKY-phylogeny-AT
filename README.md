# Análisis filogenético comparativo de factores de transcripción WRKY
**Sebastián Correa Gallego** · Ciencia de Datos en Ciencias de la Vida · Universidad EAFIT · 2026

Análisis filogenético de ML de la superfamilia WRKY en *Arabidopsis thaliana* (71), *Oryza sativa* (39) y *Solanum lycopersicum* (40) — 150 secuencias en total.

---

## Notebook

📓 [`WRKY_Phylogeny_Reporte_Final.ipynb`](./WRKY_Phylogeny_Reporte_Final.ipynb) — reporte completo con métodos, resultados, figuras y discusión.

> GitHub renderiza el notebook directamente al hacer clic en el archivo.

---

## Estructura

```
WRKY-phylogeny-AT/
├── 00_raw/          # Proteomas completos (.fa)
├── 01_ids/          # IDs de genes WRKY de At
├── 02_seqtk/        # Secuencias WRKY extraídas
├── 03_blast/        # Resultados BLAST (TSV)
├── 04_alignment/    # Alineamiento MAFFT (3,729 col.)
├── 05_iqtree/       # Árbol ML + logs IQ-TREE
├── figures/         # Figuras del reporte (SVG, PNG)
├── 00_setup.sh      # Configuración entorno conda
├── 01_download.sh   # Descarga proteomas
├── 02_extract_ids.sh
├── 03_seqtk.sh
├── 04_blast.sh
├── 05_megafasta.sh
└── 06_phylo.sh      # MAFFT + IQ-TREE
```

---

## Pipeline resumido

```
Proteomas → seqtk (71 AtWRKY) → BLAST (39 Os + 40 Sl) → megafasta (150 seqs)
         → MAFFT FFT-NS-i → IQ-TREE LG+I+G4 + UFBoot 1000 → iTOL v6
```

---

## Resultados clave

| Parámetro | Valor |
|:---|:---:|
| Modelo evolutivo | LG+I+G4 |
| Sitios informativos | 1,300 / 3,729 (34.9%) |
| Nodos UFBoot ≥ 80 | 74.3% |
| Tiempo de cómputo | 23 min 38 s (MacBook Air M4) |

**Hipótesis confirmadas:** monofilia de Group I/III (H1 ✓), co-segregación de ortólogos (H2 ✓), polifiletismo de Group II (H3 ✓).

---

## Reproducibilidad

```bash
git clone https://github.com/correa-gallego/WRKY-phylogeny-AT.git
cd WRKY-phylogeny-AT
bash 00_setup.sh
bash 01_download.sh   # solo si se quiere reproducir desde cero
bash 02_extract_ids.sh && bash 03_seqtk.sh && bash 04_blast.sh
bash 05_megafasta.sh && bash 06_phylo.sh
```

Los archivos intermedios ya están incluidos en el repositorio.

---

## Software

BLAST+ 2.15 · MAFFT v7.526 · IQ-TREE v3.0.1 · iTOL v6 · Python 3.12 · macOS Tahoe 26.3.1 (Apple M4)

---

## Referencias

1. Eulgem *et al.* (2000) *Trends Plant Sci* 5(5):199–206
2. Rushton *et al.* (2010) *Trends Plant Sci* 15(5):247–258
3. Katoh & Standley (2013) *Mol Biol Evol* 30(4):772–780
4. Nguyen *et al.* (2015) *Mol Biol Evol* 32(1):268–274
5. Letunic & Bork (2024) *Nucleic Acids Res*
