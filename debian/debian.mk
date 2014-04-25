# vim: set ts=8 sts=8 sw=8 ft=make:
# Create .deb meta-package for Debian

debian: $(DEBIAN_OUT_PKG)

# debian.control.in + debian.list --(debian.control.sh)-> debian.control
control_script = $(BACKENDDIR)/debian.control.sh
control_deps   = \
	$(control_script)	\
	$(DEBIAN_IN_CONTROL_IN)	\
	$(WSPKG_OUT_LIST)

$(DEBIAN_OUT_CONTROL): $(control_deps)
	$(AT_GEN)$(control_script) $(DEBIAN_IN_CONTROL_IN) $(WSPKG_OUT_LIST) \
		> $(DEBIAN_OUT_CONTROL) $(RM_IF_FAIL)

# debian.control -> 217-meta.deb
$(DEBIAN_OUT_PKG): $(DEBIAN_OUT_CONTROL)
	-@mkdir -p $(DEBIAN_OUT_PKGDIR)/DEBIAN
	$(AT_COPY)cp -pf $(DEBIAN_OUT_CONTROL) \
		$(DEBIAN_OUT_PKGDIR)/DEBIAN/control
	$(AT_PKG)dpkg-deb --build \
		$(DEBIAN_OUT_PKGDIR) $(DEBIAN_OUT_PKG)

debian-install: $(DEBIAN_OUT_PKG)
	-@mkdir -p $(DEBIAN_OUT_REPO)
	$(AT_INSTALL)cp -pf $(DEBIAN_OUT_PKG) $(DEBIAN_OUT_REPO)
	$(AT_SCAN)dpkg-scanpackages $(DEBIAN_OUT_REPO) | \
		gzip -9 > $(DEBIAN_OUT_REPO)/Packages.gz
