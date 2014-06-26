TARGET = WhileyIntermediateLanguage
DEPS = title.tex introduction.tex format.tex constants_types.tex functions_methods.tex bytecodes.tex glossary.tex references.bib

all: $(TARGET).pdf

%.pdf : %.tex $(DEPS)
	@for X in 1 2 3 ; do \
        ( echo "---------------- Latex ($$X) ----------------" && pdflatex $< && makeglossaries $(TARGET) && bibtex $* ) \
	done

clean:
	rm *.toc *.bbl *.aux *.dvi *.log *.ps *.pdf *~ *.blg *.glo *.gls *.glg *.idx *.xdy *.out *.ist *.bak
