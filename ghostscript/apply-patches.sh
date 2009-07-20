  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-8.62-versioned_ijs.patch.gz | patch -p0 --verbose || exit 1

zcat ${SB_PATCHDIR}/${NAME}-multilib.patch.gz | patch -p1 --verbose || exit 1
# Fix some shell scripts
zcat ${SB_PATCHDIR}/${NAME}-scripts.patch.gz | patch -p1 --verbose || exit 1
# Build igcref.c with -O0 to work around bug #150771.
zcat ${SB_PATCHDIR}/${NAME}-noopt.patch.gz | patch -p1 --verbose || exit 1
# Fix shared library build.
zcat ${SB_PATCHDIR}/${NAME}-fPIC.patch.gz | patch -p1 --verbose || exit 1
# Define .runlibfileifexists.
zcat ${SB_PATCHDIR}/${NAME}-runlibfileifexists.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-system-jasper.patch.gz | patch -p1 --verbose || exit 1
# Fix pksmraw output (bug #308211).
zcat ${SB_PATCHDIR}/${NAME}-pksmraw.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-bitcmyk.patch.gz | patch -p1 --verbose || exit 1

zcat ${SB_PATCHDIR}/${NAME}-CVE-2009-0583,0584.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-CVE-2009-0792.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-CVE-2009-0196.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-jbig2dec-nullderef.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-gs-executable.patch.gz | patch -p1 --verbose || exit 1
