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
# define WSPKG_BROWSER
# define WSPKG_MAIL
# define WSPKG_ADMIN
# define WSPKG_DATABASE
# define WSPKG_DEBUG
# define WSPKG_DEVEL
# define WSPKG_DOC
# define WSPKG_EDITORS
# define WSPKG_ELECTRONICS
# define WSPKG_FONTS
# define WSPKG_GNOME
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
WHOIS
#endif

// Shell
#ifdef WSPKG_SHELL
bash            BASH_COMPLETION KSH             TCSH            zsh
#endif

// Browser
#ifdef WSPKG_BROWSER
W3M
#endif

// Mail
#ifdef WSPKG_MAIL
alpine          fetchmail       mpack           mutt            MAILX
VM              // requested by cj
#endif

// Admin
#ifdef WSPKG_ADMIN
ACPI            CPUFREQ         IOTOP           MENU            MCELOG
PARTED          SYSSTAT
FDISK           GDISK           // added by b01902062@csie.ntu.edu.tw
#endif

// Database
#ifdef WSPKG_DATABASE
MYSQL_CLIENT
#endif

// Debug
#ifdef WSPKG_DEBUG
LIBC_DEBUG
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
baobab          devhelp         epiphany        eog             gedit
ghex            glade           GTK2            GTK3            gnome-terminal
gnome-screenshot                gnome-system-monitor            nautilus
vinagre
#endif
