
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Prevent crash when HOME is unset (bug #90663).
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/elinks-0.11.0-ssl-noegd.patch
# UTF-8 by default
zcat ${SB_PATCHDIR}/${NAME}-0.10.1-utf_8_io-default.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.10.1-pkgconfig.patch.gz | patch -p1 -E --backup --verbose
# Make getaddrinfo call use AI_ADDRCONFIG.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/elinks-0.11.0-getaddrinfo.patch
# Don't put so much information in the user-agent header string (bug #97273).
zcat ${SB_PATCHDIR}/${NAME}-0.11.0-sysname.patch.gz | patch -p1 -E --backup --verbose
# Fix xterm terminal: "Linux" driver seems better than "VT100" (#128105)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/elinks-0.10.1-xterm.patch
# fix for open macro in new glibc 
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/elinks-0.11.3-macropen.patch
#upstream fix for out of screen dialogs
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/elinks-scroll.patch
# Port elinks to use NSS library for cryptography
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/elinks-nss.patch
# Port elinks to use NSS library for cryptography (#346861) - incremental patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-nss-inc.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/elinks-0.12pre5-js185.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/elinks-0.12pre5-ddg-search.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/elinks-0.12pre6-autoconf.patch

if [ "$(echo ${RUBYVER} | cut -d. -f1)" -ge 1 ] && [ "$(echo ${RUBYVER} | cut -d. -f2)" -ge 9 ] ;then
  sed -i \
    -e '/exit/s|VERSION or ||g' \
    -e '/rubyhdrdir=/s|archdir|rubyhdrdir|g' \
    config/m4/ruby.m4
  zcat ${SB_PATCHDIR}/elinks-0.12pre5-ruby1.9.patch.gz | patch -p0 -E --backup --verbose
fi

set +e +o pipefail
