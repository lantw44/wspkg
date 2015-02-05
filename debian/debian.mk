# vim: set ts=8 sts=8 sw=8 ft=make:
# Create .deb meta-package for Debian

DEBIAN_INSTALL=      $(DEBIAN_INSTALL_$(DEBIAN_SIGN))
DEBIAN_INSTALL_yes=  debian-install-repo debian-install-sign
DEBIAN_INSTALL_no=   debian-install-repo

debian: $(DEBIAN_OUT_PKG)

# debian.control.in + debian.list --(debian.control.sh)-> debian.control
control_script = $(BACKENDDIR)/debian.deps.sh
control_deps   = \
	$(control_script)	\
	$(DEBIAN_IN_CONTROL_IN)	\
	$(WSPKG_OUT_LIST)

$(DEBIAN_OUT_CONTROL): $(control_deps)
	$(AT_GEN)sed \
		-e "s|@NAME|$(NAME)|g" \
		-e "s|@PKGNAME@|$(PKGNAME)|g" \
		-e "s|@TODAY@|`date '+%Y.%m.%d'`|g" \
		-e "s|@DEPS@|`$(control_script) $(WSPKG_OUT_LIST)`|g" \
		$(DEBIAN_IN_CONTROL_IN) > $(DEBIAN_OUT_CONTROL) $(RM_IF_FAIL)

# debian.control -> 217-meta.deb
$(DEBIAN_OUT_PKG): $(DEBIAN_OUT_CONTROL)
	$(AT_MKDIR)mkdir -p $(DEBIAN_OUT_PKGDIR)/DEBIAN
	$(AT_COPY)cp -pf $(DEBIAN_OUT_CONTROL) \
		$(DEBIAN_OUT_PKGDIR)/DEBIAN/control
	$(AT_GEN)dpkg-deb --build \
		$(DEBIAN_OUT_PKGDIR) $(DEBIAN_OUT_PKG)

debian-install-repo: $(DEBIAN_OUT_PKG)
	$(AT_MKDIR)mkdir -p $(DEBIAN_OUT_REPO)
	$(AT_COPY)cp -pf $(DEBIAN_OUT_PKG) $(DEBIAN_OUT_REPO)
	$(AT_GEN)cd $(DEBIAN_OUT_REPO) && dpkg-scanpackages . > Packages
	$(AT_GEN)gzip -9c $(DEBIAN_OUT_REPO)/Packages \
		> $(DEBIAN_OUT_REPO)/Packages.gz

debian-install-sign:
	$(AT_SIGN)dpkg-sig -k $(DEBIAN_KEY_PKGSIGN) -s origin $(DEBIAN_OUT_PKG)
	$(AT_GEN)cd $(DEBIAN_OUT_REPO) && apt-ftparchive release . > Release
	$(AT_GEN)cd $(DEBIAN_OUT_REPO) && rm -f InRelease Release.gpg
	$(AT_SIGN)cd $(DEBIAN_OUT_REPO) && gpg \
		--default-key $(DEBIAN_KEY_PKGSIGN) \
		--clearsign -o InRelease Release
	$(AT_SIGN)cd $(DEBIAN_OUT_REPO) && gpg \
		--default-key $(DEBIAN_KEY_PKGSIGN) -abs -o Release.gpg Release

debian-install: $(DEBIAN_INSTALL)

debian-show:
	@echo "-- Control file"
	@echo "I: DEBIAN_IN_CONTROL_IN (control file template)           = $(DEBIAN_IN_CONTROL_IN)"
	@echo "O: DEBIAN_OUT_CONTROL (generated control file)            = $(DEBIAN_OUT_CONTROL)"
	@echo ""
	@echo "-- Meta-package"
	@echo "O: DEBIAN_OUT_PKGDIR (package source directory)           = $(DEBIAN_OUT_PKGDIR)"
	@echo "O: DEBIAN_OUT_PKG (built meta-package)                    = $(DEBIAN_OUT_PKG)"
	@echo ""
	@echo "-- Repository"
	@echo "O: DEBIAN_OUT_REPO                                        = $(DEBIAN_OUT_REPO)"
	@echo ""
	@echo "-- Signature"
	@echo "V: DEBIAN_SIGN                                            = $(DEBIAN_SIGN)"
	@echo "V: DEBIAN_KEY_PKGSIGN                                     = $(DEBIAN_KEY_PKGSIGN)"
