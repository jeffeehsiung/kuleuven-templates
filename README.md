
# EUSIPCO 2026 Poster  
## Few-Shot Radar Person Identification via Tracking-Integrated InISAR and Pre-Trained Meta-Learning

This repository contains the LaTeX source files for the EUSIPCO 2026 conference poster.

The project provides two poster versions:

1. **Current poster (recommended)**
   - `poster.tex`
   - KU Leuven corporate design
   - Built using `beamerposter`

2. **Previous draft version**
   - `poster-v1.tex`
   - Built using `tikzposter`
   - Kept for reference only

---

# Repository Structure

```
.
├── poster.tex                     # Main poster source (final version)
├── poster-v1.tex                # Old draft poster source
├── Makefile                       # Build script
├── definitions.tex                # KU Leuven colors and LaTeX definitions
├── references.bib                 # Bibliography (if needed)
│
├── blocks/                        # Poster content blocks
│   ├── 01_BeyondVision.tex
│   ├── 02_RadarSensing.tex
│   ├── 03_Challenges.tex
│   ├── 04_Framework.tex
│   ├── 05_DeepDive.tex
│   ├── 06_Results.tex
│   └── 07_Contributions.tex
│
├── figures/                       # All poster figures
│   ├── system diagrams
│   ├── radar illustrations
│   ├── PCT/MAML diagrams
│   └── result plots
│
├── templates/                     # KU Leuven logos and assets
│
└── graphics/                      # Additional graphical assets

````

---

# Requirements

The project requires a LaTeX environment capable of compiling:

- `beamerposter`
- `tikzposter` (only required for the old draft)
- common LaTeX packages


---

# Installation

## macOS

### 1. Install Homebrew

If Homebrew is not installed:

https://brew.sh/


### 2. Install TeX Live

Install MacTeX:

```bash
brew install --cask mactex
````

After installation, restart the terminal.

Check:

```bash
pdflatex --version
```

---

## Linux (Ubuntu)

Install TeX Live:

```bash
sudo apt update

sudo apt install \
texlive-full \
make
```

Check:

```bash
pdflatex --version
make --version
```

---

## Windows

Recommended:

Install MiKTeX:

[https://miktex.org/download](https://miktex.org/download)

During installation:

* Enable "Install missing packages on-the-fly"
* Install Make (for example through MSYS2)

Alternative:

Install TeX Live:

[https://tug.org/texlive/](https://tug.org/texlive/)

---
z
# Required LaTeX Packages

The following packages are required.

For the final poster:

```
beamer
beamerposter
graphicx
xcolor
booktabs
multirow
tabularx
csquotes
hyperref
changepage
siunitx
lmodern
type1cm
```

For the old draft:

```
tikzposter
tikz
qrcode
pifont
array
booktabs
anyfontsize
```

**Install using ocmmand e.g. (macos):**
```bash
sudo tlmgr install tikzposter qrcode pifont booktabs array
```

If using TeX Live full installation, all packages are already included.

---

# Building the Poster

## Build final poster

From the repository root:

```bash
make
```

or:

```bash
make all
```

The generated file:

```
poster.pdf
```

will be created.

---

## Build old draft poster

The old draft can be compiled directly:

```bash
pdflatex poster-v1.tex
```

or add it to Makefile as a separate target:

```bash
make draft
```

which generates:

```
poster-v1.pdf
```

---

# Makefile Commands

## Compile

```bash
make
```

Builds the final poster.

---

## Clean generated files

```bash
make clean
```

Removes:

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

## Open PDF (macOS)

```bash
make view
```

---

# Editing Content

The final poster content is separated into blocks.

Modify:

```
blocks/
```

instead of editing `poster.tex`.

For example:

```
blocks/01_BeyondVision.tex
```

contains the motivation section.

```
blocks/06_Results.tex
```

contains the experiment results.

After editing:

```bash
make
```

to regenerate the poster.

---

# Troubleshooting

## Missing LaTeX package

If LaTeX reports:

```
File xxx.sty not found
```

Install the missing package.

For TeX Live:

```bash
tlmgr install <package-name>
```

For MiKTeX:

```
MiKTeX Console → Packages → Install
```

---

## Undefined color errors

Make sure:

```
definitions.tex
```

exists in the project root.

---

## Figure not found

Check that:

1. The figure exists inside:

```
figures/
```

2. The filename matches exactly.

Linux is case-sensitive:

```
figure.png
Figure.png
```

are different files.

---

# Authors

Jeffee Hsiung
Rengin Torun
S. Hamed Javadi
Hichem Sahli

EUSIPCO 2026
Bruges, Belgium

````

---

## For your Makefile, I would also simplify it

Your current Makefile has Mermaid support:

```make
MMD_SRC = $(wildcard *.mmd)
````

but your repository **does not contain any `.mmd` files anymore**. So remove Mermaid completely.

Use:

```make
MAIN = poster

all: $(MAIN).pdf

$(MAIN).pdf:
	pdflatex -interaction=nonstopmode $(MAIN).tex
	pdflatex -interaction=nonstopmode $(MAIN).tex
	pdflatex -interaction=nonstopmode $(MAIN).tex


draft:
	pdflatex poster-v1.tex
	pdflatex poster-v1.tex


clean:
	rm -f *.aux *.log *.nav *.out *.snm *.toc *.pdf


view:
	open $(MAIN).pdf


.PHONY: all draft clean view
```

---