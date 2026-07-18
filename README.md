
# Few-Shot Radar Person Identification Poster

LaTeX source files for the KU Leuven conference poster:

**"Few-Shot Radar Person Identification via Tracking-Integrated InISAR and Pre-Trained Meta-Learning"**

This repository contains only the poster generation pipeline.

The poster is built using:

- LaTeX / Beamerposter
- KU Leuven poster template
- GNU Make
- pdflatex
- optional Mermaid diagram generation

No R, RMarkdown, Pandoc, or additional processing pipeline is required.

---

# Repository Structure

```

.
├── poster.tex                  # Main LaTeX entry point
├── Makefile                    # Automated build script
├── definitions.tex             # KU Leuven colors and LaTeX definitions
├── references.bib              # Bibliography file (if required)
│
├── blocks/                     # Poster content sections
│   ├── 01_BeyondVision.tex
│   ├── 02_RadarSensing.tex
│   ├── 03_Challenges.tex
│   ├── 04_Framework.tex
│   ├── 05_DeepDive.tex
│   ├── 06_Results.tex
│   └── 07_Contributions.tex
│
├── figures/                    # All poster figures
│   ├── fig_motivation_cluster.png
│   ├── fig_radar_vs_camera.png
│   ├── 01_system_architecture.png
│   └── ...
│
├── templates/                  # KU Leuven logos and poster assets
│
└── README.md

````

---

# Environment Setup

The project requires only a LaTeX environment.

## Linux (Ubuntu/Debian)

Install required packages:

```bash
sudo apt update

sudo apt install \
    make \
    texlive-full \
    poppler-utils
````

`texlive-full` is recommended because the poster uses several LaTeX packages:

* beamer
* beamerposter
* xcolor
* graphicx
* siunitx
* hyperref
* booktabs
* tabularx
* multirow

---

## macOS

### 1. Install Homebrew

If Homebrew is not installed:

[https://brew.sh/](https://brew.sh/)

### 2. Install LaTeX

Recommended:

```bash
brew install --cask mactex
```

After installation, restart the terminal.

Verify:

```bash
pdflatex --version
```

Expected output:

```
pdfTeX ...
TeX Live ...
```

---

## Windows

Install:

### 1. MiKTeX

Download:

[https://miktex.org/download](https://miktex.org/download)

During installation:

Enable:

```
Install missing packages on-the-fly: Yes
```

### 2. GNU Make

Recommended:

Install either:

* Git Bash
* MSYS2

Check:

```bash
make --version
```

---

# Optional: Mermaid Diagram Support

The current poster does not require Mermaid generation.

However, the Makefile contains support for `.mmd` Mermaid diagrams.

If needed:

## Install Node.js

Download:

[https://nodejs.org/](https://nodejs.org/)

Check:

```bash
node --version
npm --version
```

Install Mermaid CLI:

```bash
npm install -g @mermaid-js/mermaid-cli
```

Verify:

```bash
mmdc --version
```

---

# Building the Poster

Clone the repository:

```bash
git clone <repository-url>

cd kuleuven-templates
```

Compile:

```bash
make
```

The generated file:

```
poster.pdf
```

will appear in the project folder.

---

# Viewing the Poster

macOS:

```bash
make view
```

Linux:

```bash
xdg-open poster.pdf
```

Windows:

Open:

```
poster.pdf
```

manually.

---

# Cleaning Build Files

Remove temporary LaTeX files:

```bash
make clean
```

This removes:

```
*.aux
*.log
*.nav
*.out
*.snm
*.toc
*.pdf
```

---

# Editing the Poster

## Modify Text

Do NOT directly edit the entire poster file.

Content is separated into blocks:

```
blocks/
```

Each file corresponds to one poster section:

| File                 | Section           |
| -------------------- | ----------------- |
| 01_BeyondVision.tex  | Motivation        |
| 02_RadarSensing.tex  | Radar sensing     |
| 03_Challenges.tex    | Challenges        |
| 04_Framework.tex     | Overall framework |
| 05_DeepDive.tex      | Technical details |
| 06_Results.tex       | Experiments       |
| 07_Contributions.tex | Contributions     |

Example:

```latex
\begin{block}{Why Not Just Use a Camera?}

Poster text here.

\end{block}
```

---

## Modify Figures

All images are stored in:

```
figures/
```

When replacing an image:

Keep the same filename, or update the corresponding LaTeX reference:

Example:

```latex
\includegraphics[
width=\linewidth
]{figures/new_image.png}
```

---

# LaTeX Compilation Notes

The Makefile runs:

```bash
pdflatex
```

multiple times because:

* references
* table of contents
* hyperlinks

require multiple compilation passes.

Equivalent manual compilation:

```bash
pdflatex poster.tex
pdflatex poster.tex
pdflatex poster.tex
```

---

# Troubleshooting

## Error: Missing LaTeX package

Example:

```
! LaTeX Error: File `xxx.sty' not found
```

Solution:

### Linux

```bash
sudo apt install texlive-full
```

### macOS

Update MacTeX:

```bash
sudo tlmgr update --self --all
```

### Windows

Open MiKTeX Console:

```
Updates → Update now
```

---

## Error: Undefined color

Example:

```
Package xcolor Error:
Undefined color `kulxxx'
```

Make sure:

```
definitions.tex
```

exists and is included in:

```latex
\input{definitions.tex}
```

inside:

```
poster.tex
```

---

## Error: Figure not found

Example:

```
File `figures/example.png' not found
```

Check:

1. File exists
2. Filename capitalization matches exactly

Linux/macOS are case-sensitive.

Example:

Wrong:

```
Figure.png
```

LaTeX:

```latex
figures/figure.png
```

---

# Development Workflow

Recommended workflow:

1. Modify one block:

```
blocks/XX_section.tex
```

2. Replace figures if needed:

```
figures/
```

3. Compile:

```bash
make
```

4. Review:

```
poster.pdf
```

5. Commit changes.

---

# Authors

Poster prepared for EUSIPCO 2026.

````

---

A few notes based on your actual project:

### 1. Remove `texlive-full` if you want lightweight installation
Your poster currently uses:

- `beamerposter`
- `beamer`
- `xcolor`
- `siunitx`
- `hyperref`
- `graphicx`
- `booktabs`
- `tabularx`
- `multirow`
- `changepage`

A minimal TeX Live install can work, but for teammates with unknown OS, `texlive-full` / MacTeX / MiKTeX is much safer.

### 2. Your Makefile has one unnecessary part

This:

```make
MMD_SRC = $(wildcard *.mmd)
MMD_PDF = $(MMD_SRC:.mmd=.pdf)
````

is leftover from Mermaid experiments.

Since your repository has no `.mmd` currently, it does nothing. But keeping it is harmless.
