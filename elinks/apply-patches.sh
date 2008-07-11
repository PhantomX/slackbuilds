  
SB_PATCHDIR=${CWD}/patches

# Prevent crash when HOME is unset (bug #90663).
zcat ${SB_PATCHDIR}/${NAME}-0.11.0-ssl-noegd.patch.gz | patch -p1 -E --backup --verbose || exit 1
# UTF-8 by default
#zcat ${SB_PATCHDIR}/${NAME}-0.10.1-utf_8_io-default.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.10.1-pkgconfig.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Make getaddrinfo call use AI_ADDRCONFIG.
zcat ${SB_PATCHDIR}/${NAME}-0.11.0-getaddrinfo.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Don't put so much information in the user-agent header string (bug #97273).
zcat ${SB_PATCHDIR}/${NAME}-0.11.0-sysname.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Fix xterm terminal: "Linux" driver seems better than "VT100" (#128105)
zcat ${SB_PATCHDIR}/${NAME}-0.10.1-xterm.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Fix #157300 - Strange behavior on ppc64
zcat ${SB_PATCHDIR}/${NAME}-0.11.0-union.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Fix #194096 – elinks should support negotiate-auth
zcat ${SB_PATCHDIR}/${NAME}-0.11.1-negotiate.patch.gz | patch -p1 -E --backup --verbose || exit 1
# fix for open macro in new glibc 
zcat ${SB_PATCHDIR}/${NAME}-0.11.3-macropen.patch.gz | patch -p1 -E --backup --verbose || exit 1
# fix for broken gzip compression for chunked pages
zcat ${SB_PATCHDIR}/${NAME}-0.11.4rc0-chunkedgzip.patch.gz | patch -p1 -E --backup --verbose || exit 1
