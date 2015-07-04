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
makefile_deps_script        = $(BACKENDDIR)/freebsd.deps.sh
makefile_nopkg_setup_script = $(BACKENDDIR)/freebsd.nopkg-setup.sh
makefile_nopkg_deps_script  = $(BACKENDDIR)/freebsd.nopkg-deps.sh
makefile_deps   = \
	$(makefile_deps_script)		\
	$(makefile_nopkg_setup_script)	\
	$(makefile_nopkg_deps_script)	\
	$(FREEBSD_IN_MAKEFILE_IN)	\
	$(FREEBSD_OUT_PORTS)

$(FREEBSD_OUT_MAKEFILE): $(makefile_deps)
	$(AT_GEN)sed \
		-e "s|@NAME|$(NAME)|g" \
		-e "s|@PKGNAME@|$(PKGNAME)|g" \
		-e "s|@TODAY@|`date '+%Y.%m.%d'`|g" \
		-e "s|@DEPS@|`$(makefile_deps_script) $(FREEBSD_OUT_PORTS)`|g" \
		-e "s|@NOPKG_SETUP@|`$(makefile_nopkg_setup_script) $(FREEBSD_OUT_PORTS)`|g" \
		-e "s|@NOPKG_DEPS@|`$(makefile_nopkg_deps_script) $(FREEBSD_OUT_PORTS)`|g" \
		$(FREEBSD_IN_MAKEFILE_IN) | \
		tr '^' '\\' | tr '%' '\n' \
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

freebsd-show:
	@echo "-- Ports mapping"
	@echo "O: FREEBSD_OUT_PORTS (generated ports mapping)            = $(FREEBSD_OUT_PORTS)"
	@echo ""
	@echo "-- Meta-ports Makefile"
	@echo "I: FREEBSD_IN_MAKEFILE_IN (Makefile template)             = $(FREEBSD_IN_MAKEFILE_IN)"
	@echo "O: FREEBSD_OUT_MAKEFILE (generated Makefile)              = $(FREEBSD_OUT_MAKEFILE)"
	@echo ""
	@echo "-- Meta-ports"
	@echo "I: FREEBSD_IN_PKGDESC (meta-ports description)            = $(FREEBSD_IN_PKGDESC)"
	@echo "O: FREEBSD_OUT_PKGDIR (meta-ports)                        = $(FREEBSD_OUT_PKGDIR)"
	@echo "O: FREEBSD_OUT_PKGDESC (copied meta-ports description)    = $(FREEBSD_OUT_PKGDESC)"
	@echo "O: FREEBSD_OUT_PKG (copied meta-ports Makefile)           = $(FREEBSD_OUT_PKG)"
