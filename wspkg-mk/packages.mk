# vim: set ts=8 sts=8 sw=8 ft=make:

V=               0

DO_NADA=         @true
DO_FAIL=         ; false
RM_IF_FAIL=      || { rm -f "$@" && false; }
BACKENDDIR=      $(WSPKGDIR)/$(BACKEND)
WSPKG_MK=        $(WSPKGDIR)/wspkg-mk
WSPKG_SH=        $(WSPKGDIR)/wspkg-sh

# Include silent rules
include $(WSPKG_MK)/silent.mk

MKLIST=           $(MKLIST_$(USE_MACRO))
MKLIST_none=      $(DO_NADA)
MKLIST_cpp=       $(AT_CPP)CPPFLAGS="-I$(BACKENDDIR)" \
                      $(WSPKG_SH)/packages-cpp.sh $(WSPKG_IN_COMMON) \
                      -$(BACKEND) -$(NAME) | \
                      sort | uniq | \
                      sed -f $(WSPKG_IN_PLATFORM_SED) | \
                      sort | uniq > \
                      $(WSPKG_OUT_LIST) $(RM_IF_FAIL)
MKLIST_m4=        @echo "Sorry, m4 is not currently supported." $(DO_FAIL)

DEPLIST=          $(DEPLIST_$(USE_MACRO))
DEPLIST_none=
DEPLIST_regular=  $(WSPKG_IN_COMMON) \
                  $(WSPKG_IN_PLATFORM_PKG) \
                  $(WSPKG_IN_PLATFORM_SED)
DEPLIST_cpp=      $(DEPLIST_regular)
DEPLIST_m4=       $(DEPLIST_regular)


# Do tasks
all: $(WSPKG_OUT_LIST) $(BACKEND)
$(WSPKG_OUT_LIST): $(DEPLIST)
	@mkdir -p $(INDIR) $(OUTDIR)
	$(MKLIST)

# Include backend-specific makefiles
include $(BACKENDDIR)/$(BACKEND).mk
