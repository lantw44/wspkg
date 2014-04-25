# vim: set ts=8 sts=8 sw=8 ft=make:
# Create meta-ports for FreeBSD

freebsd: $(FREEBSD_OUT_PKG) $(FREEBSD_OUT_PKGDESC)

# freebsd.list --(freebsd.ports.sh + freebsd.ports.find)-> freebsd.ports
ports_script = $(BACKENDDIR)/freebsd.ports.sh
ports_bin    = $(BACKENDDIR)/freebsd.ports.find
ports_deps   = \
	$(ports_script)		\
	$(ports_bin)		\
	$(WSPKG_OUT_LIST)

$(FREEBSD_OUT_PORTS): $(ports_deps)
	$(AT_GEN)$(ports_script) $(WSPKG_OUT_LIST) \
		> $(FREEBSD_OUT_PORTS) $(RM_IF_FAIL)

# freebsd.makefile.in + freebsd.ports --(freebsd.makefile.sh)-> freebsd.makefile
makefile_script = $(BACKENDDIR)/freebsd.makefile.sh
makefile_deps   = \
	$(makefile_script)		\
	$(FREEBSD_IN_MAKEFILE_IN)	\
	$(FREEBSD_OUT_PORTS)

$(FREEBSD_OUT_MAKEFILE): $(makefile_deps)
	$(AT_GEN)$(makefile_script) \
		$(FREEBSD_IN_MAKEFILE_IN) $(FREEBSD_OUT_PORTS) \
		> $(FREEBSD_OUT_MAKEFILE) $(RM_IF_FAIL)

# freebsd.makefile -> 217/Makefile
$(FREEBSD_OUT_PKG): $(FREEBSD_OUT_MAKEFILE)
	-@mkdir -p $(FREEBSD_OUT_PKGDIR)
	$(AT_COPY)cp -pf $(FREEBSD_OUT_MAKEFILE) $(FREEBSD_OUT_PKG)

# freebsd.local.217.pkg-descr -> 217/pkg-descr
$(FREEBSD_OUT_PKGDESC): $(FREEBSD_IN_PKGDESC)
	-@mkdir -p $(FREEBSD_OUT_PKGDIR)
	$(AT_COPY)cp -pf $(FREEBSD_IN_PKGDESC) $(FREEBSD_OUT_PKGDESC)


# Install meta-ports for FreeBSD
freebsd-install: freebsd
	$(AT_INSTALL)$(BACKENDDIR)/freebsd.install.sh \
		$(FREEBSD_OUT_PORTS_CATEGORY) \
		$(FREEBSD_OUT_PORTS_CATEGORY_MAKEFILE) \
		$(FREEBSD_OUT_PORTS_CATEGORY_MAKEFILE_INC) \
		$(FREEBSD_OUT_PKGDIR)
