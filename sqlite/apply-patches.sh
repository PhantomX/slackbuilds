  
SB_PATCHDIR=${CWD}/patches

# Fix build with --enable-load-extension, upstream ticket #3137
zcat ${SB_PATCHDIR}/sqlite-3.6.6.2-libdl.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Avoid insecure sprintf(), use a system path for lempar.c, patch from Debian
zcat ${SB_PATCHDIR}/sqlite-3.6.6.2-lemon-snprintf.patch.gz | patch -p1 -E --backup --verbose || exit 1
