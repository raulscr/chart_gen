#----------------------------------------------------------------------------
# Universidade Tecnológica Federal do Paraná - UTFPR
# Makefile da Customização da Classe abnTeX2 para as normas da UTFPR
#
# Projeto: http://tcc.tsi.gp.utfpr.edu.br/paginas/modelos-latex-da-utfpr
#-----------------------------------------------------------------------------

# Definindo as variáveis

SOURCE      = chart_gen
LATEX       = pdflatex
LATEXMK     = latexmk
BIBTEX      = bibtex
MAKEINDEX   = makeindex
GHOSTSCRIPT = gs
OPENPDF     = evince
OPENPDFPC   = pdfpc
FLAGSPDFPC  = -s -Z 1366:768

# Executando o processo completo de limpeza, compilação e compressão

all: clean compile2 clean2 open

# Compilar o código fonte

compile:
	@echo "Compilando os Arquivos"
	$(LATEX) $(SOURCE).tex
	@echo "Ok"


# Comprimir o PDF gerado

compress:
	@echo "Comprimindo o PDF"
	@$(GHOSTSCRIPT) -q -dNOPAUSE -dBATCH -dSAFER \
		-sDEVICE=pdfwrite \
		-dEmbedAllFonts=true \
		-dSubsetFonts=true \
		-sOutputFile=$(SOURCE)-compactado.pdf \
		$(SOURCE).pdf
	@echo "Ok"

# Remover os arquivos temporários e PDF

clean:
	@echo "Limpando arquivos temporarios"
	@find . -type f -iname "*.aux" -delete
	@find . -type f -iname "*.log" -delete
	@find . -type f -iname "*.fdb_latexmk" -delete
	@find . -type f -iname "*.*~" -delete
	@rm -f *.bak *.bbl *.blg *.brf *.dvi *.fls *.glo *.idx *.ilg *.ind *.l* *.nav *.out *.ps *.snm *.toc *.wsp *.synctex.*
	@rm -f $(SOURCE).pdf $(SOURCE)-compactado.pdf
	@echo "Ok"

# Visualizar o arquivo PDF gerado

open:
	@echo "Abrindo o PDF"
	@$(OPENPDF) $(SOURCE).pdf &
	@echo "Ok"

convertgif:
	@echo "Convertendo pdf para gif"
	@convert -verbose -delay 2 -loop 0 -density 150 $(SOURCE).pdf $(SOURCE).gif
	@echo "Ok"

convertavi:
	@echo "Convertendo gif para avi"
	@convert $(SOURCE).gif $(SOURCE).avi
	@echo "Ok"

