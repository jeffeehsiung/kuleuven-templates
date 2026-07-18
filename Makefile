# Makefile for KU Leuven poster with Mermaid diagrams
# Uses only pdflatex + bibtex (no latexmk required)

# Name of the main .tex file (without extension)
MAIN = poster
FONTSLOG = missfonts
# Find all .mmd files
MMD_SRC = $(wildcard *.mmd)
MMD_PDF = $(MMD_SRC:.mmd=.pdf)

# Default target: build the poster
all: $(MAIN).pdf

# Rule to convert .mmd to .pdf using mermaid-cli
%.pdf: %.mmd
	mmdc -i $< -o $@ -b white

# Rule to build the LaTeX poster with pdflatex + bibtex
# (Run bibtex only if a .bib file exists, otherwise skip gracefully)
$(MAIN).pdf: $(MAIN).tex $(MMD_PDF)
	pdflatex -shell-escape -interaction=nonstopmode $(MAIN).tex
	-if [ -f $(MAIN).aux ] && grep -q "bibdata" $(MAIN).aux; then bibtex $(MAIN); fi
	pdflatex -shell-escape -interaction=nonstopmode $(MAIN).tex
	pdflatex -shell-escape -interaction=nonstopmode $(MAIN).tex

# Clean up auxiliary files (keep the PDF)
clean:
	rm -f $(MAIN).aux $(MAIN).log $(MAIN).nav $(MAIN).out \
	      $(MAIN).snm $(MAIN).toc $(MAIN).vrb $(MAIN).bbl \
	      $(MAIN).blg $(MAIN).run.xml $(MAIN)-blx.bib \
		  $(MAIN).pdf \
		  $(FONTSLOG).log
	rm -f $(MMD_PDF)

# View the PDF (macOS default)
view: $(MAIN).pdf
	open $(MAIN).pdf

.PHONY: all clean view