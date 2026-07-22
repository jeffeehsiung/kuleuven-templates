# Makefile for EUSIPCO 2026 Poster
# Builds standalone TikZ figures and any of the poster versions

# ------------------------------------------------------------
# Configuration
# ------------------------------------------------------------
FIG_DIR = tikz-radar-lib
FIG_NAMES = problem_panel radar_pipeline_final tracking_comparison tracking_removes_ghosts tracking_spectrum_vs_3d
FIG_PDFS = $(addprefix $(FIG_DIR)/, $(addsuffix .pdf, $(FIG_NAMES)))

# Possible poster files (without extension)
POSTERS = poster poster-v1 poster-v2
# Default target: build poster
MAIN = poster

# ------------------------------------------------------------
# Default target
# ------------------------------------------------------------
all: $(MAIN).pdf

# ------------------------------------------------------------
# Build standalone TikZ figures (PDFs in same directory as .tex)
# ------------------------------------------------------------
$(FIG_DIR)/%.pdf: $(FIG_DIR)/%.tex
	@echo "Building TikZ figure: $<"
	cd $(FIG_DIR) && pdflatex -interaction=nonstopmode $*.tex

# Force rebuild of all figures
rebuild-figs:
	@echo "Forcing rebuild of all figures..."
	cd $(FIG_DIR) && rm -f $(addsuffix .pdf, $(FIG_NAMES))
	$(MAKE) $(FIG_PDFS)

# ------------------------------------------------------------
# Build posters
# ------------------------------------------------------------
# Generic rule: any poster PDF depends on its .tex and the figure PDFs
poster.pdf: poster.tex $(FIG_PDFS)
	@echo "Building poster.tex"
	pdflatex -shell-escape -interaction=nonstopmode poster.tex
	-if [ -f poster.aux ] && grep -q "bibdata" poster.aux; then bibtex poster; fi
	pdflatex -shell-escape -interaction=nonstopmode poster.tex
	pdflatex -shell-escape -interaction=nonstopmode poster.tex

poster-v1.pdf: poster-v1.tex $(FIG_PDFS)
	@echo "Building poster-v1.tex"
	pdflatex -shell-escape -interaction=nonstopmode poster-v1.tex
	-if [ -f poster-v1.aux ] && grep -q "bibdata" poster-v1.aux; then bibtex poster-v1; fi
	pdflatex -shell-escape -interaction=nonstopmode poster-v1.tex
	pdflatex -shell-escape -interaction=nonstopmode poster-v1.tex

poster-v2.pdf: poster-v2.tex $(FIG_PDFS)
	@echo "Building poster-v2.tex"
	pdflatex -shell-escape -interaction=nonstopmode poster-v2.tex
	-if [ -f poster-v2.aux ] && grep -q "bibdata" poster-v2.aux; then bibtex poster-v2; fi
	pdflatex -shell-escape -interaction=nonstopmode poster-v2.tex
	pdflatex -shell-escape -interaction=nonstopmode poster-v2.tex

# ------------------------------------------------------------
# View targets
# ------------------------------------------------------------
view: $(MAIN).pdf
	open $(MAIN).pdf

view-poster: poster.pdf
	open poster.pdf

view-v1: poster-v1.pdf
	open poster-v1.pdf

view-v2: poster-v2.pdf
	open poster-v2.pdf

# ------------------------------------------------------------
# Clean
# ------------------------------------------------------------
clean:
	@echo "Removing generated files..."
	# Remove auxiliary files for all posters
	rm -f poster.aux poster.log poster.nav poster.out poster.snm poster.toc poster.vrb poster.bbl poster.blg poster.run.xml poster-blx.bib poster.pdf
	rm -f poster-v1.aux poster-v1.log poster-v1.nav poster-v1.out poster-v1.snm poster-v1.toc poster-v1.vrb poster-v1.bbl poster-v1.blg poster-v1.run.xml poster-v1-blx.bib poster-v1.pdf
	rm -f poster-v2.aux poster-v2.log poster-v2.nav poster-v2.out poster-v2.snm poster-v2.toc poster-v2.vrb poster-v2.bbl poster-v2.blg poster-v2.run.xml poster-v2-blx.bib poster-v2.pdf
	# Remove figure auxiliary and PDFs
	cd $(FIG_DIR) && rm -f $(addsuffix .aux, $(FIG_NAMES)) \
	                        $(addsuffix .log, $(FIG_NAMES)) \
	                        $(addsuffix .pdf, $(FIG_NAMES)) 2>/dev/null || true
	# Remove any stray files (like .out, .toc from figures)
	cd $(FIG_DIR) && rm -f *.aux *.log *.out *.toc *.nav *.snm 2>/dev/null || true
	# Remove Mermaid PDFs if any (legacy)
	rm -f *.mmd.pdf 2>/dev/null || true
	# Remove build directory if using standalone with build mode (if exists)
	rm -rf tikz-radar-lib/build 2>/dev/null || true

cleanfigs:
	@echo "Removing figure PDFs only..."
	cd $(FIG_DIR) && rm -f $(addsuffix .pdf, $(FIG_NAMES))

# ------------------------------------------------------------
# Deep clean (remove everything, including all PDFs)
# ------------------------------------------------------------
distclean: clean
	@echo "Removing all generated files including figures and build directories..."
	rm -f poster.pdf poster-v1.pdf poster-v2.pdf
	cd $(FIG_DIR) && rm -f *.pdf *.aux *.log *.out *.toc *.nav *.snm
	rm -rf tikz-radar-lib/build

# ------------------------------------------------------------
# Help
# ------------------------------------------------------------
help:
	@echo "Available targets:"
	@echo "  all          : Build the main poster (poster-v2, default)"
	@echo "  view         : Open the main poster (poster-v2)"
	@echo "  view-poster  : Open poster.tex"
	@echo "  view-v1      : Open poster-v1.tex"
	@echo "  view-v2      : Open poster-v2.tex"
	@echo "  clean        : Remove auxiliary files (keep PDFs)"
	@echo "  cleanfigs    : Remove only the TikZ figure PDFs"
	@echo "  distclean    : Remove everything (including PDFs)"
	@echo "  rebuild-figs : Force rebuild of all TikZ figures"
	@echo "  help         : Show this help"

.PHONY: all view clean cleanfigs distclean rebuild-figs help view-poster view-v1 view-v2