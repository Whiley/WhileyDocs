TARGET = WhileyLanguageSpec
DEPS = title.tex introduction.tex lexical.tex compilation-units.tex types.tex expressions.tex statements.tex typing.tex verification.tex errors.tex glossary.tex references.bib

all: $(TARGET).pdf

%.pdf : %.tex $(DEPS)
	@for X in 1 2 3 ; do \
        ( echo "---------------- Latex ($$X) ----------------" && pdflatex $< && makeglossaries $(TARGET) && bibtex $* ) \
	done

clean:
	rm *.toc *.bbl *.aux *.dvi *.log *.ps *.pdf *~ *.blg *.glo *.gls *.glg *.idx *.xdy *.out *.ist *.bak
