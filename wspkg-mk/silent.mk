# vim: set ts=8 sts=8 sw=8 ft=make:

AT_M4=$(AT_M4_$(V))
AT_M4_0=@echo "  M4      "$@;
AT_M4_1=

AT_CC=$(AT_CC_$(V))
AT_CC_0=@echo "  CC      "$@;
AT_CC_1=

AT_CPP=$(AT_CPP_$(V))
AT_CPP_0=@echo "  CPP     "$@;
AT_CPP_1=

AT_DOC=$(AT_DOC_$(V))
AT_DOC_0=@echo "  DOC     "$@;
AT_DOC_1=

AT_GEN=$(AT_GEN_$(V))
AT_GEN_0=@echo "  GEN     "$@;
AT_GEN_1=

AT_PKG=$(AT_PKG_$(V))
AT_PKG_0=@echo "  PKG     "$@;
AT_PKG_1=

AT_COPY=$(AT_COPY_$(V))
AT_COPY_0=@echo "  COPY    "$@;
AT_COPY_1=

AT_SCAN=$(AT_SCAN_$(V))
AT_SCAN_0=@echo "  SCAN    "$@;
AT_SCAN_1=

AT_INSTALL=$(AT_INSTALL_$(V))
AT_INSTALL_0=@echo "  INSTALL "$@;
AT_INSTALL_1=
