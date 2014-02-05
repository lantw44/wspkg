// vim: ft=c: et

#define NULL

// Include distribution-specific mapping files
#if   (defined LIST)
#elif (defined DEBIAN)
# include "debian.pkg"
#elif (defined FREEBSD)
# include "freebsd.pkg"
#else
# define WSPKG_NO_DEFAULT
# error "Neither DEBIAN nor FREEBSD is defined!"
#endif

#ifndef WSPKG_NO_DEFAULT
# define WSPKG_KEYRING
# define WSPKG_STANDARD
# define WSPKG_SHELL
# define WSPKG_ADMIN
# define WSPKG_DATABASE
# define WSPKG_DEVEL
# define WSPKG_DOC
# define WSPKG_EDITORS
# define WSPKG_ELECTRONICS
# define WSPKG_FONTS
# define WSPKG_GNOME
# define WSPKG_GRAPHICS
# define WSPKG_HASKELL
# define WSPKG_INTERPRETERS
# define WSPKG_LIB
# define WSPKG_LISP
# define WSPKG_LUA
# define WSPKG_MACHINE_LEARNING
# define WSPKG_MAIL
# define WSPKG_MATH
# define WSPKG_MISC
# define WSPKG_NET
# define WSPKG_PARALLEL
# define WSPKG_PERL
# define WSPKG_PYTHON
# define WSPKG_RUBY
# define WSPKG_SCIENCE
# define WSPKG_SOUND
# define WSPKG_TEX
# define WSPKG_TEXT
# define WSPKG_UTILS
# define WSPKG_WEB
# define WSPKG_X11
#endif

// ===========================================================================
// Packages definition started from here
// ===========================================================================

// Keyring
#ifdef WSPKG_KEYRING
#endif

// Standard
#ifdef WSPKG_STANDARD
BC              BIND            FILE            FINGER          FTP
INETD           ISPELL          LESS            LOCATE          lsof
m4              mime-support    NCURSES_TERM    PATCH           PCI
PERL            PYTHON2         PYTHON3         SHARUTILS       SSH
STRACE          TELNET          TIME            USB             WAMERICAN
wget            WHOIS
#endif

// Shell
#ifdef WSPKG_SHELL
bash            bash-completion KSH             TCSH            zsh
#endif

// Admin
#ifdef WSPKG_ADMIN
ACPI            CPUFREQ         IOTOP           MENU            MCELOG
PARTED          SYSSTAT
FDISK           GDISK           // added by b01902062@csie.ntu.edu.tw
#endif

// Database
#ifdef WSPKG_DATABASE
MYSQL_CLIENT    sqlite3
#endif

// Devel
#ifdef WSPKG_DEVEL
ANT             autoconf        automake        bison           ccache
CLANG           cmake           cvs             ddd             f2c
flex            GCC             GDB             GOLANG          gperf
GIT             gprolog         INDENT          libtool         MAKE
MINGW           nasm            OPENJDK6        OPENJDK7        scala
scons           SUBVERSION      TCL             TK              valgrind
mercurial       bzr             // added by b01902062@csie.ntu.edu.tw
#endif

// Doc
#ifdef WSPKG_DOC
LIBC_DOC        MAKE_DOC        MANPAGES        MANPAGES_POSIX  PERL_DOC
PYTHON2_DOC     PYTHON3_DOC     TCL_DOC         TK_DOC
GCC_DOC         // added by b01902062@csie.ntu.edu.tw
#endif

// Editors
#ifdef WSPKG_EDITORS
CTAGS           EMACS           joe             LIBREOFFICE     vim
VIM_GTK
cscope          global          // added by b01902062@csie.ntu.edu.tw
#endif

// Electronics
#ifdef WSPKG_ELECTRONICS
iverilog
#endif

// Fonts
#ifdef WSPKG_FONTS
ARPHIC          BAEKMUK         CJKUNIFONTS     LIBERATION      IPAFONT
WQY             XFONTS_CYRILLIC XFONTS_INTL_CHINESE             XFONTS_WQY
#endif

// GNOME
#ifdef WSPKG_GNOME
alacarte        evince          file-roller     gcalctool       GDM
gnome-backgrounds               gnome-keyring   gnome-nettool   gnome-screensaver
gnome-themes    GNOME_USER_DOCS GTK2_ENGINES    GVFS            REMMINA
seahorse        xdg-user-dirs   zenity
// added by b01902062@linux5.csie.ntu.edu.tw
BAOBAB          devhelp         epiphany        eog             gedit
ghex            GLADE           GTK2            GTK3            gnome-terminal
GNOME_SCREENSHOT                gnome-system-monitor            nautilus
vinagre
#endif

// Graphics
#ifdef WSPKG_GRAPHICS
gimp            geeqie          IMAGEMAGICK     JPEG            graphviz
#endif

// Haskell
#ifdef WSPKG_HASKELL
ghc             HUGS            HASKELL_PLATFORM                HASKELL_OPENGL
#endif

// Interpreters
#ifdef WSPKG_INTERPRETERS
gawk            swig
#endif

// KDE
#ifdef WSPKG_KDE
kchmviewer      okular          // added by b01902062@csie.ntu.edu.tw
#endif

// Lib
#ifdef WSPKG_LIB
LIBC_DEV        LIBEVENT_DEV    FFTW_DEV        GSL_DEV         JPEG_DEV
LTDL_DEV        NCURSES_DEV     QT4_DEV         QT5_DEV         PERL_DEV
MYSQLXX_DEV     OPENMPI_DEV     GFLAGS_DEV      BOOST_DEV       IMLIB2_DEV
EXOSIP2_DEV     // voip
OPENCV_DEV      // opencv suite
FFMPEG_DEV      // ffmpeg suite
#endif

// Lisp
#ifdef WSPKG_LISP
clisp
#endif

// Lua
#ifdef WSPKG_LUA
LUA51           LUA52
#endif

// Machine Learning
#ifdef WSPKG_MACHINE_LEARNING
weka
#endif

// Mail
#ifdef WSPKG_MAIL
alpine          fetchmail       mpack           mutt            MAILX
VM              // requested by cj
#endif

// Math
#ifdef WSPKG_MATH
GSL             gnuplot         octave          OCTAVE_DEV      R_BASE
#endif

// Misc
#ifdef WSPKG_MISC
KERNEL_PACKAGE  poppler-data    screen          tmux            XSLTPROC
PROTOBUF
#endif

// Net
#ifdef WSPKG_NET
denyhosts       filezilla       iftop           irssi           lftp
MTR             ncftp           nmap            oidentd         rsync
STUNNEL         tcpdump         VNCVIEWER       curl            aria2
mosh            NS2             NS3
// added by b01902062@csie.ntu.edu.tw
x11vnc          SPICE_CLIENT    XSPICE          rdesktop        ldapvi
PCMANX
#endif

// Parallel Programming
#ifdef WSPKG_PARALLEL
mpich2
#endif

// Perl
#ifdef WSPKG_PERL
PERL_BDB        PERL_DATA_SERIALIZER            PERL_DBD_MYSQL  PERL_DBD_SQLITE3
PERL_IO_ALL     PERL_JSON       PERL_LIBWWW
#endif

// Python
#ifdef WSPKG_PYTHON
IPYTHON         // PYTHON2 and PYTHON3 are included in standard section
PYPY            // added by b01902062@csie.ntu.edu.tw
PYTHON_BSDDB3   PYTHON_IMAGING  PYTHON_NUMPY    PYTHON_SETUPTOOLS
PYTHON_LIBSVM
// request by d97009@csie.ntu.edu.tw
PYTHON_MARKDOWN PYTHON_MEMPROF  PYTHON_PSUTIL   PYTHONTRACER
// by request
PYTHON_MYSQLDB  PYTHON_CJSON    PYTHON_SQLITE   PYTHON_BEAUTIFULSOUP
PYTHON_TK       PYTHON_SIMPLEJSON               PYTHON_MATPLOTLIB
PYTHON_LXML     PYTHON_OPENCV   PYTHON_COGENT   PYTHON_REDIS    PYTHON_YAML
PYTHON_GDATA    PYTHON_CURL     PYTHON_LDAP     PYTHON_SMBPASSWD
PYTHON_SPHINX   PYTHON_SCIKITS_LEARN            PYTHON_IGRAPH
PYTHON_PSYCOPG2 PYTHON_NETWORKX PYTHON_VIRTUALENV
#endif

// Ruby
#ifdef WSPKG_RUBY
RUBY            RUBY_MYSQL
#endif

// Science
#ifdef WSPKG_SCIENCE
BLAST2          BLITZ
#endif

// Sound
#ifdef WSPKG_SOUND
ALSA            alsa-utils
#endif

// TeX
#ifdef WSPKG_TEX
AUCTEX          bibtool         LATEX_CJK       latex2html      BIBER
TEXLIVE
texlive-full    // Added by Artoo on 2008.12.14, requested by cjlin@csie.ntu.edu.tw
#endif

// Text
#ifdef WSPKG_TEXT
a2ps            ASPELL_EN       dict            GS_CJK_RESOURCE gv
mpage           poppler-utils   psutils         SPELL           xpdf
html2ps         zh-autoconvert
pdftk           // Added by lydian on 2011/8/3, requested by cjlin
#endif

// Utils
#ifdef WSPKG_UTILS
BZIP2           fakeroot        GPW             LM_SENSORS      PROCINFO
scim            SCIM_CHEWING    pv              rar             tree
TOFRODOS        unrar           unzip           xdg-utils       zip
// added by b01902062@csie.ntu.edu.tw
BSDCPIO         BSDTAR          bochs           CDIALOG         cgdb
chrpath         convmv          DEV86           diffstat        FAKECHROOT
fdupes          HTE             htop            meld            menumaker
MKISOFS         ncdu            PATCHELF        QEMU            rpm2cpio
socat           tig             UIM_FEP         UNAR            UNIX2DOS
upx
#endif

// Web
#ifdef WSPKG_WEB
FLASH_PLUGIN    FIREFOX         lynx            w3m             W3M_EL
JAVA_PLUGIN     // added by b01902062@csie.ntu.edu.tw
#endif

// X11
#ifdef WSPKG_X11
afterstep       DESKTOP_BASE    fvwm            IM_SWITCH       mlterm
MLTERM_TOOLS    rxvt            RXVT_ML         VNCSERVER       WINDOWMAKER
xchm            xorg            xscreensaver    xterm           XVFB
// added by b01902062@csie.ntu.edu.tw
fbpanel         obconf          openbox         XEPHYR          xrestop
#endif
