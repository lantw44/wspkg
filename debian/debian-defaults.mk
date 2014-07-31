# vim: set ts=8 sts=8 sw=8 ft=make:
# Default settings for Debian

# Control files and output packages
DEBIAN_IN_CONTROL_IN=   $(INDIR)/$(NAME).control.in
DEBIAN_OUT_CONTROL=     $(OUTDIR)/$(NAME).control
DEBIAN_OUT_PKGDIR=      $(OUTDIR)/$(PKGNAME)
DEBIAN_OUT_PKG=         $(OUTDIR)/$(PKGNAME).deb

# Repository
DEBIAN_OUT_REPO=        $(OUTDIR)/repo
