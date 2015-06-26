TARGET = VerifyingSoftwareWithWhiley
DEPS = listings.tex abstract.tex introduction.tex specifications.tex reasoning.tex loopinvariants.tex vcg.tex hoarelogic.tex

all: $(TARGET).pdf

%.pdf : %.tex $(DEPS)
	@for X in 1 2 3 ; do \
        ( echo "---------------- Latex ($$X) ----------------" && pdflatex $< ) \
	done

clean:
	rm *.bbl *.aux *.dvi *.log *.ps *.pdf *~ *.blg *.bak