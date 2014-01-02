TARGET = WhileyLanguageSpec
DEPS = introduction.tex lexical.tex compilation-units.tex types.tex expressions.tex statements.tex glossary.tex

all: $(TARGET).pdf

%.pdf : %.tex $(DEPS)
	@for X in 1 2 3 ; do \
        ( echo "---------------- Latex ($$X) ----------------" && pdflatex $< ; makeglossaries $(TARGET) ) \
	done

clean:
	rm *.toc *.bbl *.aux *.dvi *.log *.ps *.pdf *~ *.blg *.bak
