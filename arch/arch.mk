# vim: set ts=8 sts=8 sw=8 ft=make:
# Create PKBUILD for Archlinux

arch: $(ARCH_OUT_PKGBUILD)

# arch.pkgbuild.in + arch.list -> PKGBUILD
pkgbuild_script = $(BACKENDDIR)/arch.deps.sh
pkgbuild_deps   = \
	$(pkgbuild_script)	\
	$(ARCH_IN_pkgbuild_IN)	\
	$(WSPKG_OUT_LIST)

$(ARCH_OUT_PKGBUILD): $(pkgbuild_deps)
	$(AT_GEN)sed \
		-e "s|@NAME@|$(NAME)|g" \
		-e "s|@PKGNAME@|$(PKGNAME)|g" \
		-e "s|@TODAY@|`date '+%Y.%m.%d'`|g" \
		-e "s|@DEPS@|`$(pkgbuild_script) $(WSPKG_OUT_LIST)`|g" \
		$(ARCH_IN_PKGBUILD_IN) > $(ARCH_OUT_PKGBUILD) $(RM_IF_FAIL)

arch-show:
	@echo "-- PKGBUILD file"
	@echo "I: ARCH_IN_PKGBUILD_IN (PKDBUILD file template)           = $(ARCH_IN_PKGBUILD_IN)"
	@echo "O: ARCH_OUT_PKGBUILD (generated PKDBUILD file)            = $(ARCH_OUT_PKGBUILD)"
