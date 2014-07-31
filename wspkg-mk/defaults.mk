# vim: set ts=8 sts=8 sw=8 ft=make:

# Default input and output directories
INDIR=                  $(NAME)
OUTDIR=                 $(NAME)/out

# Default platform-independent settings
WSPKG_IN_PLATFORM_PKG=  $(INDIR)/$(NAME).pkg
WSPKG_IN_PLATFORM_SED=  $(INDIR)/$(NAME).sed
WSPKG_OUT_LIST=         $(OUTDIR)/$(NAME).list

include $(WSPKGDIR)/$(BACKEND)/$(BACKEND)-defaults.mk
