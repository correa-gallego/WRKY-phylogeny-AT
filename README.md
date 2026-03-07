# Análisis filogenético comparativo de factores de transcripción WRKY

**Sebastián Correa Gallego**  
Ciencia de Datos en Ciencias de la Vida · Universidad EAFIT · 2026

---

## Descripción

Este repositorio documenta un pipeline bioinformático completo para el análisis filogenético comparativo de la superfamilia de factores de transcripción **WRKY** en tres especies vegetales:

| Especie | Abreviatura | Genes WRKY analizados |
|:---|:---:|:---:|
| *Arabidopsis thaliana* | AT | 71 |
| *Oryza sativa* | OS | 39 |
| *Solanum lycopersicum* | SL | 40 |
| **Total** | | **150** |

El análisis cubre descarga de proteomas, extracción de secuencias WRKY, búsqueda de homólogos por BLAST, alineamiento múltiple con MAFFT, inferencia filogenética de máxima verosimilitud con IQ-TREE, y visualización anotada en iTOL v6.

---

## Notebook principal

El reporte completo del análisis se encuentra en:

📓 [`WRKY_Phylogeny_Reporte_Final.ipynb`](./WRKY_Phylogeny_Reporte_Final.ipynb)

Incluye introducción, métodos detallados con código de cada paso, resultados con figuras, discusión por hipótesis, conclusiones, material suplementario (Tablas S1–S2, Nota S1) y referencias.

> GitHub renderiza los notebooks `.ipynb` automáticamente. Para verlo, haz clic en el archivo directamente desde el repositorio.

---

## Estructura del repositorio

```
WRKY-phylogeny-AT/
│
├── 00_raw/                        # Proteomas completos descargados (.fa)
│   ├── Athaliana_protein.fa           (27,416 secuencias)
│   ├── Osativa_protein.fa             (39,049 secuencias)
│   └── Slycopersicum_protein.fa       (34,663 secuencias)
│
├── 01_ids/                        # IDs de genes WRKY de A. thaliana
│   ├── wrky_loci.txt                  (72 loci TAIR)
│   └── wrky_ids.txt                   (71 IDs con formato ATxGxxxxx.1|PACid)
│
├── 02_seqtk/                      # Secuencias WRKY extraídas de At
│   └── AT_WRKY.fa                     (71 secuencias proteicas)
│
├── 03_blast/                      # Resultados BLAST — homólogos
│   ├── AT_WRKY_vs_Osativa.tsv
│   └── AT_WRKY_vs_Slycopersicum.tsv
│
├── 04_alignment/                  # Alineamiento múltiple
│   ├── all_WRKY.fa                    (150 secuencias — megafasta)
│   └── all_WRKY_aln.fa                (alineamiento MAFFT, 3,729 columnas)
│
├── 05_iqtree/                     # Inferencia filogenética
│   ├── WRKY_3spp.treefile             (árbol ML en formato Newick)
│   ├── WRKY_3spp.iqtree               (log completo IQ-TREE)
│   └── WRKY_3spp.log
│
├── figures/                       # Figuras del reporte
│   ├── WRKY_tree_with_groups.svg      (árbol circular anotado — iTOL)
│   ├── WRKY_Phylogeny-rectangular.svg (árbol rectangular con UFBoot ≥ 80)
│   ├── fig1_TAIR_table.png            (tabla genes AtWRKY — TAIR)
│   ├── fig2_WRKY_domain_paper.png     (dominio WRKY — Eulgem et al. 2000)
│   └── fig3_alignment_WRKY_domain.png (motivo WRKYGQK — AliView)
│
├── 00_setup.sh                    # Configuración del entorno conda
├── 01_download.sh                 # Descarga de proteomas desde NCBI/Phytozome
├── 02_extract_ids.sh              # Extracción de IDs WRKY desde proteoma At
├── 03_seqtk.sh                    # Extracción de secuencias con seqtk
├── 04_blast.sh                    # BLAST At vs Os y At vs Sl
├── 05_megafasta.sh                # Construcción del megafasta (150 seqs)
├── 06_phylo.sh                    # MAFFT + IQ-TREE (pipeline completo)
├── itol_colorstrip_final.txt      # Dataset de anotación por especie para iTOL
└── WRKY_Phylogeny_Reporte_Final.ipynb
```

---

## Pipeline

```
Proteomas (.fa)
      │
      ▼
01_download.sh ──────────────── descarga At, Os, Sl desde NCBI/Phytozome
      │
      ▼
02_extract_ids.sh ───────────── localiza 71/72 IDs WRKY en proteoma At
03_seqtk.sh ─────────────────── extrae secuencias proteicas (seqtk subseq)
      │
      ▼
04_blast.sh ─────────────────── blastp At→Os (39 hits únicos)
                                 blastp At→Sl (40 hits únicos)
                                 e-value ≤ 1×10⁻¹⁰
      │
      ▼
05_megafasta.sh ─────────────── consolida 150 secuencias (71 AT + 39 OS + 40 SL)
      │
      ▼
06_phylo.sh — MAFFT ─────────── alineamiento FFT-NS-i · 10 hilos · 3,729 columnas
      │
      ▼
06_phylo.sh — IQ-TREE ───────── modelo LG+I+G4 (ModelFinder, BIC)
                                 1,000 réplicas UFBoot · 23 min 38 s
      │
      ▼
iTOL v6 + anotación Python ──── árbol circular y rectangular
                                 colorstrip por especie · soportes UFBoot ≥ 80
```

---

## Software y versiones

| Herramienta | Versión | Función |
|:---|:---:|:---|
| macOS Tahoe | 26.3.1 | Sistema operativo (Apple M4, ARM64) |
| Python | 3.12 | Análisis, tablas, anotación SVG |
| conda | 24.x | Gestión de entornos |
| seqtk | 1.4 | Extracción de secuencias FASTA |
| BLAST+ | 2.15 | Búsqueda de homólogos (blastp) |
| MAFFT | v7.526 | Alineamiento múltiple (FFT-NS-i) |
| IQ-TREE | v3.0.1 | Inferencia filogenética ML + UFBoot |
| iTOL | v6 | Visualización y anotación del árbol |
| pandas | latest | Tablas y estadísticas BLAST |
| matplotlib | latest | Gráficos de distribución UFBoot |
| BioPython | latest | Lectura y parsing de treefile |
| lxml / svgwrite | latest | Anotación de SVG exportado |

---

## Resultados principales

| Parámetro | Valor |
|:---|:---:|
| Modelo evolutivo | LG+I+G4 |
| Longitud total del árbol | 118.826 sust./sitio |
| Parámetro α (Gamma) | 1.359 |
| Columnas del alineamiento | 3,729 |
| Sitios informativos | 1,300 (34.9%) |
| Nodos con UFBoot ≥ 80 | 110/148 (74.3%) |
| Nodos con UFBoot ≥ 95 | 82/148 (55.4%) |
| Tiempo de cómputo | 23 min 38 s |
| Hardware | Apple MacBook Air M4 · 24 GB RAM |

### Hipótesis evaluadas

| # | Hipótesis | Resultado |
|:---:|:---|:---:|
| H1 | Los grupos WRKY son monofiléticos en *A. thaliana* | ✓ Confirmada |
| H2 | Los ortólogos de *Os* y *Sl* co-segregan con sus grupos At | ✓ Confirmada |
| H3 | El Grupo II es polifilético | ✓ Confirmada |
| H4 | Las expansiones génicas son especie-específicas | ~ Parcial |

---

## Reproducibilidad

El análisis fue ejecutado íntegramente en macOS local. Para reproducirlo desde cero:

```bash
# 1. Clonar el repositorio
git clone https://github.com/correa-gallego/WRKY-phylogeny-AT.git
cd WRKY-phylogeny-AT

# 2. Configurar entorno conda
bash 00_setup.sh

# 3. Descargar proteomas
bash 01_download.sh

# 4. Correr pipeline en orden
bash 02_extract_ids.sh
bash 03_seqtk.sh
bash 04_blast.sh
bash 05_megafasta.sh
bash 06_phylo.sh
```

> Los archivos intermedios (TSV de BLAST, alineamiento, treefile) ya están incluidos en el repositorio. Solo es necesario ejecutar `01_download.sh` si se desea reproducir desde los proteomas crudos.

---

## Referencias

1. Eulgem, T., *et al.* (2000). The WRKY superfamily of plant transcription factors. *Trends in Plant Science*, 5(5), 199–206. https://doi.org/10.1016/S1360-1385(00)01600-9
2. Rushton, P.J., *et al.* (2010). WRKY transcription factors. *Trends in Plant Science*, 15(5), 247–258. https://doi.org/10.1016/j.tplants.2010.02.006
3. Katoh, K., & Standley, D.M. (2013). MAFFT v7. *Molecular Biology and Evolution*, 30(4), 772–780. https://doi.org/10.1093/molbev/mst010
4. Nguyen, L.T., *et al.* (2015). IQ-TREE. *Molecular Biology and Evolution*, 32(1), 268–274. https://doi.org/10.1093/molbev/msu300
5. Letunic, I., & Bork, P. (2024). iTOL v6. *Nucleic Acids Research*. https://doi.org/10.1093/nar/gkae268

---

## Autor

**Sebastián Correa Gallego**  
Universidad EAFIT · Ciencia de Datos en Ciencias de la Vida  
GitHub: [@correa-gallego](https://github.com/correa-gallego)
