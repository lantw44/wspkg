# vim: set ts=8 sts=8 sw=8 ft=make:

.POSIX:
.PHONY: all clean clean-exe clean-doc distclean $(PLATFORM)
.SUFFIXES:
.SUFFIXES: .txt .html .xml .pdf

V=               0
CC=              c99
ASCIIDOC=        asciidoc
PANDOC=          pandoc

RM_IF_FAIL=      || { rm -f "$@" && false; }

PLATFORM_SH=   $(PLATFORM).sh
PLATFORM_IN=   $(PLATFORM).in
PLATFORM_OUT=  $(PLATFORM).out
PLATFORM_DOC=  $(PLATFORM).doc

PKGLIST_IN=  $(PLATFORM_IN)/$(PLATFORM).pkg
PKGLIST_SED= $(PLATFORM_IN)/$(PLATFORM).sed
PKGLIST_OUT= $(PLATFORM_OUT)/$(PLATFORM).list

# Include silent rules
include silent.mk

# Do platform-independent tasks
all: README.html README.pdf $(PLATFORM)

# Generate top-level directory documentation
.txt.html:
	-$(AT_DOC)$(ASCIIDOC) -a toc2 -b html -o - "$<" | \
		sed 's/,serif/,sans-serif/' > "$@" $(RM_IF_FAIL)
.txt.xml:
	-$(AT_DOC)$(ASCIIDOC) -b docbook -o "$@" "$<"
.xml.pdf:
	-$(AT_DOC)$(PANDOC) -f docbook -t latex --latex-engine=xelatex \
		-V geometry:margin=1in -H chinese.tex -o "$@" "$<"

# Generate package list
$(PKGLIST_OUT): $(PKGLIST_IN) $(PKGLIST_SED) packages.h packages.sh
	-@mkdir -p $(PLATFORM_OUT)
	$(AT_CPP)CPPFLAGS="-I. -I$(PLATFORM_IN)" ./packages.sh $(PLATFORM) \
		| sort | uniq | sed -f $(PKGLIST_SED) \
		| sort | uniq > $(PKGLIST_OUT) $(RM_IF_FAIL)

# Clean files
clean:
	rm -rf *.out $(CLEAN_FILES)
clean-exe:
	rm -f $(CLEAN_EXE_FILES)
clean-doc:
	rm -f *.html *.xml *.pdf $(CLEAN_DOC_FILES)

distclean: clean clean-exe clean-doc
