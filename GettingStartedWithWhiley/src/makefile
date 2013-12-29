TARGET = getting-started
DEPS = listings.tex abstract.tex introduction.tex walkthrough.tex typing.tex functional-or-not.tex calculator.tex objects.tex verification.tex indexof.tex microwave.tex

all: $(TARGET).pdf

%.pdf : %.tex $(DEPS)
	@for X in 1 2 3 ; do \
        ( echo "---------------- Latex ($$X) ----------------" && pdflatex $<) \
	done

clean:
	rm *.bbl *.aux *.dvi *.log *.ps *.pdf *~ *.blg *.bak
