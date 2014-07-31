# vim: set ts=8 sts=8 sw=8 ft=make:
# Default settings for FreeBSD

# Makefile template
FREEBSD_OUT_PORTS=      $(OUTDIR)/$(NAME).ports
FREEBSD_IN_MAKEFILE_IN= $(INDIR)/$(NAME).makefile.in
FREEBSD_OUT_MAKEFILE=   $(OUTDIR)/$(NAME).makefile

# Output ports directory
FREEBSD_IN_PKGDESC=     $(INDIR)/$(NAME).local.$(PKGNAME).pkg-descr
FREEBSD_OUT_PKGDIR=     $(OUTDIR)/$(PKGNAME)
FREEBSD_OUT_PKGDESC=    $(FREEBSD_OUT_PKGDIR)/pkg-descr
FREEBSD_OUT_PKG=        $(FREEBSD_OUT_PKGDIR)/Makefile

# Update the ports tree
FREEBSD_OUT_PORTS_CATEGORY_MAKEFILE=     $(INDIR)/$(NAME).local.Makefile
FREEBSD_OUT_PORTS_CATEGORY_MAKEFILE_INC= $(INDIR)/$(NAME).local.Makefile.inc
FREEBSD_OUT_PORTS_CATEGORY=              local
