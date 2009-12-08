  
SB_PATCHDIR=${CWD}/patches

# Prevent crash when HOME is unset (bug #90663).
zcat ${SB_PATCHDIR}/${NAME}-0.11.0-ssl-noegd.patch.gz | patch -p1 -E --backup --verbose || exit 1
# UTF-8 by default
zcat ${SB_PATCHDIR}/${NAME}-0.10.1-utf_8_io-default.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.10.1-pkgconfig.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Make getaddrinfo call use AI_ADDRCONFIG.
zcat ${SB_PATCHDIR}/${NAME}-0.11.0-getaddrinfo.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Don't put so much information in the user-agent header string (bug #97273).
zcat ${SB_PATCHDIR}/${NAME}-0.11.0-sysname.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Fix xterm terminal: "Linux" driver seems better than "VT100" (#128105)
zcat ${SB_PATCHDIR}/${NAME}-0.10.1-xterm.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Fix #157300 - Strange behavior on ppc64
zcat ${SB_PATCHDIR}/${NAME}-0.11.0-union.patch.gz | patch -p1 -E --backup --verbose || exit 1
# fix for open macro in new glibc 
zcat ${SB_PATCHDIR}/${NAME}-0.11.3-macropen.patch.gz | patch -p1 -E --backup --verbose || exit 1
#upstream fix for out of screen dialogs
zcat ${SB_PATCHDIR}/${NAME}-scroll.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Port elinks to use NSS library for cryptography
zcat ${SB_PATCHDIR}/${NAME}-nss.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Port elinks to use NSS library for cryptography (#346861) - incremental patch
zcat ${SB_PATCHDIR}/${NAME}-nss-inc.patch.gz | patch -p1 -E --backup --verbose || exit 1

if [ "$(echo ${RUBYVER} | cut -d. -f1)" -ge 1 ] && [ "$(echo ${RUBYVER} | cut -d. -f2)" -ge 9 ] ;then
  sed -i \
    -e '/exit/s|VERSION or ||g' \
    -e '/rubyhdrdir=/s|archdir|rubyhdrdir|g' \
    config/m4/ruby.m4 || exit 1
  zcat ${SB_PATCHDIR}/elinks-0.12pre5-ruby1.9.patch.gz | patch -p0 -E --backup --verbose || exit 1
fi
