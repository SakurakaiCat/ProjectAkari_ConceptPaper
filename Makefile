# =============================================================================
#  Project Akari Concept Paper --- build
#
#  Requirements: XeLaTeX + latexmk (TeX Live). No other tooling is needed;
#  the class was written so that a stock TeX Live installation is sufficient.
#
#  make            build build/main.pdf
#  make watch      rebuild on file change
#  make clean      remove intermediate files, keep the PDF
#  make distclean  remove build/ entirely
#  make check      build and report warnings that matter
#  make fonts      re-render the brand logo assets
# =============================================================================

MAIN     := main
BUILD    := build
LATEXMK  := latexmk
LATEXMKFLAGS := -xelatex -interaction=nonstopmode -halt-on-error \
                -file-line-error -synctex=1 -outdir=$(BUILD)

# Let TeX find akari.cls in style/ without installing it system-wide.
export TEXINPUTS := .:$(CURDIR)/style:$(CURDIR)/figures:$(TEXINPUTS)
export BIBINPUTS := .:$(CURDIR)/refs:$(BIBINPUTS)

SOURCES := $(wildcard *.tex) $(wildcard style/*.cls) $(wildcard style/*.sty) \
           $(wildcard chapters/*.tex) $(wildcard frontmatter/*.tex) \
           $(wildcard backmatter/*.tex) $(wildcard refs/*.tex) \
           $(wildcard refs/*.bib) $(wildcard figures/**/*)

.PHONY: all watch clean distclean check fonts

all: $(BUILD)/$(MAIN).pdf

$(BUILD)/$(MAIN).pdf: $(SOURCES)
	@mkdir -p $(BUILD)
	$(LATEXMK) $(LATEXMKFLAGS) $(MAIN).tex

watch:
	@mkdir -p $(BUILD)
	$(LATEXMK) $(LATEXMKFLAGS) -pvc $(MAIN).tex

# Report the warnings that actually indicate a defect, and fail if any are
# found. The long tail of font-shape substitution noise that TeX Gyre emits by
# design is deliberately not checked.
LOG := $(BUILD)/$(MAIN).log

check: $(BUILD)/$(MAIN).pdf
	@fail=0; \
	for pat in "undefined reference" "undefined citation" "Missing character"; do \
	  if grep -qi "$$pat" $(LOG); then \
	    echo "FAIL [$$pat]"; grep -i "$$pat" $(LOG) | head -20; fail=1; \
	  fi; \
	done; \
	overfull=$$(grep -cE "Overfull \\\\hbox \\(([0-9]{2,}|[5-9])\." $(LOG) || true); \
	if [ "$$overfull" -gt "0" ]; then \
	  echo "FAIL [$$overfull overfull box(es) > 5pt]"; \
	  grep -E "Overfull \\\\hbox \\(([0-9]{2,}|[5-9])\." $(LOG) | head -20; fail=1; \
	fi; \
	if [ "$$fail" -eq "0" ]; then echo "check: clean"; else exit 1; fi

# Regenerate figures/brand/*.pdf and *.png from the source SVG.
fonts:
	rsvg-convert -f pdf -o figures/brand/akari-logo.pdf figures/brand/akari-logo.svg
	rsvg-convert -f png -w 512 -o figures/brand/akari-logo.png figures/brand/akari-logo.svg

clean:
	$(LATEXMK) -c -outdir=$(BUILD) $(MAIN).tex
	@rm -f $(BUILD)/$(MAIN).fls $(BUILD)/$(MAIN).fdb_latexmk

distclean:
	@rm -rf $(BUILD)
	@mkdir -p $(BUILD)
	@touch $(BUILD)/.gitkeep
