Here's the updated `README.md` that reflects the current state of your project:

```markdown
# EUSIPCO 2026 Poster
## Few-Shot Radar Person Identification via Tracking-Integrated InISAR and Pre-Trained Meta-Learning

This repository contains the LaTeX source files for the EUSIPCO 2026 conference poster.

The project provides two poster versions:

1. **Current poster (recommended)**
   - `poster-v2.tex`
   - Built using `tikzposter` with custom Radar Night color palette
   - Includes full TikZ library for radar processing diagrams

2. **Previous draft version**
   - `poster-v1.tex`
   - Built using `tikzposter`
   - Kept for reference only

---

## Repository Structure

```
.
├── poster-v2.tex                 # Main poster source (final version)
├── poster-v1.tex                 # Old draft poster source
├── poster-v3.tex                 # Alternative draft
├── Makefile                      # Build script (compiles figures + poster)
├── references.bib                # Bibliography database
├── references.tex                # Generate standalone references PDF
│
├── tikz-radar-lib/               # TikZ library for all figures
│   ├── radar_styles.tex          # Colors, fonts, process cards, arrows
│   ├── radar_icons.tex           # Radar processing icons (FFT, ISAR, etc.)
│   ├── geometry_icons.tex        # 3D geometry icons (point clouds, ICP)
│   ├── tracking_icons.tex        # Tracking icons (EKF, JPDA, ghosts)
│   └── ml_icons.tex              # Deep learning icons (PCT, MAML, Transformer)
│
├── figures/                      # All PNG/PDF figures
│   ├── system architecture diagrams
│   ├── radar illustrations
│   ├── PCT/MAML diagrams
│   └── result plots (IoU, MoCap comparison)
│
├── blocks/                       # Poster content blocks (optional, for beamerposter)
├── templates/                    # KU Leuven logos and assets
└── definitions.tex               # KU Leuven colors and LaTeX definitions
```

---

## Requirements

The project requires a LaTeX environment with:

- `tikzposter`
- `tikz`
- `amsmath`, `amssymb`
- `graphicx`
- `booktabs`
- `array`
- `pifont`
- `hyperref`
- `qrcode`
- `anyfontsize`
- `standalone`
- `multicol`
- `xcolor`

---

## Installation

### macOS

Install MacTeX via Homebrew:

```bash
brew install --cask mactex
```

After installation, restart the terminal and verify:

```bash
pdflatex --version
```

### Linux (Ubuntu)

```bash
sudo apt update
sudo apt install texlive-full make
```

### Windows

Install MiKTeX from [https://miktex.org/download](https://miktex.org/download) and enable "Install missing packages on-the-fly".

---

## Building the Poster

### Build Everything (Figures + Poster)

From the repository root:

```bash
make all
```

This will:
1. Build all TikZ figures in `tikz-radar-lib/`
2. Build `poster-v2.pdf`

### Build Only the Poster (If Figures Are Already Built)

```bash
make poster-v2.pdf
```

### Build Standalone References PDF

```bash
make references.pdf
```

### Force Rebuild of All Figures

```bash
make rebuild-figs
```

---

## Makefile Commands

| Command | Action |
|---------|--------|
| `make all` | Builds the main poster (`poster-v2.pdf`) and references PDF |
| `make poster-v1.pdf` | Builds the old draft |
| `make poster-v2.pdf` | Builds the main poster |
| `make poster-v3.pdf` | Builds alternative draft |
| `make references.pdf` | Builds standalone bibliography PDF |
| `make view` | Opens the main poster (macOS) |
| `make view-v1` | Opens the old draft |
| `make view-v2` | Opens the main poster |
| `make view-refs` | Opens the references PDF |
| `make rebuild-figs` | Force rebuild all TikZ figures |
| `make clean` | Removes auxiliary files (keeps PDFs) |
| `make cleanfigs` | Removes only figure PDFs |
| `make distclean` | Removes everything (including PDFs) |

---

## Key Files Explained

### `poster-v2.tex`
The main poster file. It uses:
- `tikzposter` class
- Custom "Radar Night" color palette
- Manual bibliography via `\begin{thebibliography}` (no BibTeX required)

### `tikz-radar-lib/`
A reusable TikZ graphics library:
- `radar_styles.tex`: Defines colors, fonts, process cards, flow arrows
- `radar_icons.tex`: Radar sensor, FFT, ISAR, interferometry, CFAR, EKF-JPDA
- `geometry_icons.tex`: 3D point clouds, coordinate frames, bounding boxes
- `tracking_icons.tex`: DBSCAN, EKF-JPDA, ghost targets, trajectories
- `ml_icons.tex`: PCT, Transformer, MAML, offset-attention, neighbor embedding

### `references.bib`
All citation entries in BibTeX format. Used to generate `references.pdf` for the QR code.

### `references.tex`
Generates a standalone bibliography PDF (`references.pdf`), which is linked via QR code on the poster.

---

## Overleaf Setup

### Import from GitHub (Recommended)

1. Go to [Overleaf](https://www.overleaf.com)
2. **New Project** → **Import from GitHub**
3. Authorize Overleaf
4. Select `jeffeehsiung/kuleuven-templates`
5. Set **Main File** to `poster-v2.tex`
6. Click **Recompile**

### Manual Upload (Alternative)

1. Download a ZIP of this repository
2. Upload to a new Overleaf project
3. Set `poster-v2.tex` as the main file
4. Recompile

### Overleaf Notes

- Overleaf includes `tikzposter` and all required packages
- The bibliography is embedded in the poster (no BibTeX needed)
- Font warnings (`T1/aer/bx/sc undefined`) are harmless — ignore them

---

## Editing Content

### Main Poster Content

Edit `poster-v2.tex` directly to change:
- Text in blocks
- Tables and figures
- Sections and layout

### TikZ Figures

To modify diagrams:
1. Edit the corresponding `.tex` file in `tikz-radar-lib/`
2. Rebuild figures:
   ```bash
   make rebuild-figs
   make poster-v2.pdf
   ```

### Bibliography

To update references:
1. Edit `references.bib`
2. Build the references PDF:
   ```bash
   make references.pdf
   ```

---

## Troubleshooting

### "File `IEEEtran.sty' not found"
You don't need it for the poster. Only `IEEEtran.bst` is required for `references.tex`. If you get this error, comment out `\usepackage{IEEEtran}` in `references.tex`.

### "T1/aer/bx/sc undefined"
This is a harmless font warning from the `ae` package. The poster compiles correctly with fallback fonts.

### Figure not found
Check that:
1. The figure exists in `figures/` or `tikz-radar-lib/`
2. The filename matches exactly (Linux is case-sensitive)
3. The path in `\includegraphics{}` is correct

### QR code URL not working
Update the URL in the `\qrcode{}` command in `poster-v2.tex` to point to your GitHub Pages or hosted content.

---

## Supplementary Materials (QR Code)

The poster QR code links to a GitHub Pages page containing:
- **Videos**: DBSCAN vs EKF-JPDA tracking comparison
- **GIFs**: Preprocessing pipeline visualization
- **PDFs**: Full paper, poster, and references

The source for this page is in a separate repository or folder with `index.html`.

---

## Authors

| Name | Affiliation |
|------|-------------|
| Jeffee Hsiung* | KU Leuven |
| Rengin Torun* | KU Leuven |
| S. Hamed Javadi† | imec |
| Hichem Sahli† | imec / Vrije Universiteit Brussel |

*Equal contribution (first authors)
†Equal contribution (supervisors)

---

**EUSIPCO 2026**  
Bruges, Belgium

---

## Contact

- Jeffee Hsiung: [jeffee.hsiung@icloud.com](mailto:jeffee.hsiung@icloud.com)
- Rengin Torun: [torun10@imec.be](mailto:torun10@imec.be)
```

---

## Summary of Changes

| Section | Update |
|---------|--------|
| **Structure** | Updated to reflect `poster-v2.tex` as main, added `tikz-radar-lib/` details |
| **Requirements** | Added all required packages (`tikzposter`, `standalone`, `multicol`, etc.) |
| **Makefile commands** | Added `references.pdf`, `view-refs`, `rebuild-figs` |
| **Overleaf Setup** | Added detailed import instructions |
| **Key Files** | Explained `tikz-radar-lib/` components |
| **Troubleshooting** | Added common issues and fixes |
| **Supplementary** | Explained QR code content |
| **Contact** | Added email addresses |