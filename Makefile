# vim: set ts=8 sts=8 sw=8 ft=make:

.POSIX:
.SUFFIXES:
.SUFFIXES: .txt .html .xml .pdf

V=               0
CC=              c99
ASCIIDOC=        asciidoc
PANDOC=          pandoc

# Include silent rules
include wspkg-mk/silent.mk

all_binaries=    freebsd/freebsd.ports.find
all_docs_html=   README.html wspkg-doc/debian.html wspkg-doc/freebsd.html
all_docs_pdf=    $(all_docs_html:.html=.pdf)

all: $(all_binaries) $(all_docs_html) $(all_docs_pdf)

freebsd/freebsd.ports.find: freebsd/freebsd.ports.find.c
	$(AT_CC)$(CC) -DHASH_TABLE_SIZE=50000 \
		freebsd/freebsd.ports.find.c -o \
		freebsd/freebsd.ports.find

# Generate documentation using asciidoc and pandoc
.txt.html:
	-$(AT_DOC)$(ASCIIDOC) -a toc2 -b html -o - "$<" | \
		sed 's/,serif/,sans-serif/' > "$@" $(RM_IF_FAIL)
.txt.xml:
	-$(AT_DOC)$(ASCIIDOC) -b docbook -o "$@" "$<"
.xml.pdf:
	-$(AT_DOC)$(PANDOC) -f docbook -t latex --latex-engine=xelatex \
		-V geometry:margin=1in -H wspkg-doc/chinese.tex -o "$@" "$<"

clean:
	rm -f $(all_binaries)
distclean: clean
	rm -f $(all_docs_html) $(all_docs_pdf)
