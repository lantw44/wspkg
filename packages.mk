# vim: set ts=8 sts=8 sw=8 ft=make:

.POSIX:
.PHONY: all clean clean-exe clean-doc distclean $(PLATFORM)
.SUFFIXES:
.SUFFIXES: .txt .html

V=               0
CC=              c99
ASCIIDOC=        asciidoc

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
all: README.html $(PLATFORM)

# Generate top-level directory documentation
.txt.html:
	-$(AT_DOC)$(ASCIIDOC) -b html -o "$@" "$<"

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
	rm -f *.html $(CLEAN_DOC_FILES)

distclean: clean clean-exe clean-doc
