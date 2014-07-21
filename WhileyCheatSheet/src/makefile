TARGET = WhileyCheatSheet
DEPS = 

all: $(TARGET).pdf

%.pdf : %.tex $(DEPS)
	@for X in 1 2 ; do \
        ( echo "---------------- Latex ($$X) ----------------" && pdflatex $< ) \
	done

clean:
	rm *.bbl *.aux *.dvi *.log $(TARGET).pdf *~ *.blg *.bak *.toc *.vrb *.snm *.out *.nav
