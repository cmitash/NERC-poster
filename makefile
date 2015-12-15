DOCUMENT := RSS

TEMPLDIR   := ~/repositories/templates/latex

FORMATDIR  :=  ./format:$(TEMPLDIR)/ieee_format:$(TEMPLDIR)/acm_format:$(TEMPLDIR)/kostas_style:$(TEMPLDIR)/other_format:../$(TEMPLDIR)/ieee_format:../$(TEMPLDIR)/acm_format:../$(TEMPLDIR)/kostas_style:../$(TEMPLDIR)/other_format

FIGUREDIR  := ./figures
BINDIR     := ./bin

export TEXINPUTS=.:$(FORMATDIR):$(FIGUREDIR)::

COMP_VERSION = .compversion
CURRENT_COMP := latex

.PHONY: all
-include $(COMP_VERSION)

DVI_OPTIONS := -Ppdf -G0 -t a0
PS2PDF_OPTIONS := -dCompatibilityLevel=1.3 -dMAxSubsetPct=100 -dSubsetFonts=true -dEmbedAllFonts=true -sPAPERSIZE=a0

$(COMP_VERSION):
	@echo "Setting up compilation version: latex"
	@echo "all: latex" > $(COMP_VERSION)

latex:  CURRENT_COMP := latex
latex:
	latex $(DOCUMENT)
	mv $(DOCUMENT).dvi $(BINDIR)
	dvips $(BINDIR)/$(DOCUMENT).dvi $(DVI_OPTIONS) -o $(BINDIR)/$(DOCUMENT).ps 
	\rm -rf *.aux *.dvi *.log *.bbl *.blg *.toc *.lof *.out *.snm *.nav
	ps2pdf $(PS2PDF_OPTIONS) $(BINDIR)/$(DOCUMENT).ps $(BINDIR)/$(DOCUMENT).pdf
	#@echo -e "\nCompiled with version:" $(CURRENT_COMP) "\n"

clean:
	@\rm -rf *.aux *.dvi *.log *.ps *.pdf *.bbl *.blg *.out *.toc *.lof *.idx $(BINDIR)/$(DOCUMENT).dvi $(BINDIR)/$(DOCUMENT).ps  $(BINDIR)/$(DOCUMENT).pdf $(COMP_VERSION)
	@echo "Cleaning directories"




