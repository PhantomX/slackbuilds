
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/ghostscript-8.62-versioned_ijs.patch.gz | patch -p0 --verbose

# Fix ijs-config not to have multilib conflicts
zcat ${SB_PATCHDIR}/ghostscript-multilib.patch.gz | patch -p1 --verbose
# Fix some shell scripts
zcat ${SB_PATCHDIR}/ghostscript-scripts.patch.gz | patch -p1 --verbose
# Build igcref.c with -O0 to work around bug #150771.
zcat ${SB_PATCHDIR}/ghostscript-noopt.patch.gz | patch -p1 --verbose
# Fix shared library build.
zcat ${SB_PATCHDIR}/ghostscript-fPIC.patch.gz | patch -p1 --verbose
# Define .runlibfileifexists.
zcat ${SB_PATCHDIR}/ghostscript-runlibfileifexists.patch.gz | patch -p1 --verbose
# Use the system jasper library.
zcat ${SB_PATCHDIR}/ghostscript-system-jasper.patch.gz | patch -p1 --verbose
# Fix pksmraw output.
zcat ${SB_PATCHDIR}/ghostscript-pksmraw.patch.gz | patch -p1 --verbose
# Applied patch to fix NULL dereference in JBIG2 decoder.
zcat ${SB_PATCHDIR}/ghostscript-jbig2dec-nullderef.patch.gz | patch -p1 --verbose
# Fix scripts so they don't get broken on install
zcat ${SB_PATCHDIR}/ghostscript-gs-executable.patch.gz | patch -p1 --verbose
# Install CUPS filter convs files in the correct place.
zcat ${SB_PATCHDIR}/ghostscript-cups-filters.patch.gz | patch -p1 --verbose
# Fix debugging output from gdevcups.
zcat ${SB_PATCHDIR}/ghostscript-CVE-2009-4270.patch.gz | patch -p1 --verbose
# Harden ghostscript's debugging output functions.
zcat ${SB_PATCHDIR}/ghostscript-vsnprintf.patch.gz | patch -p1 --verbose
# Fixed pdftoraster so that it waits for its sub-process to exit.
zcat ${SB_PATCHDIR}/ghostscript-pdftoraster-exit.patch.gz | patch -p1 --verbose
# Fixed LDFLAGS when building dynamically linked executables.
zcat ${SB_PATCHDIR}/ghostscript-ldflags.patch.gz | patch -p1 --verbose
# Fixed pdf2dsc.ps.
zcat ${SB_PATCHDIR}/ghostscript-pdf2dsc.patch.gz | patch -p1 --verbose
# Reallocate memory in gdevcups when color depth changes.
zcat ${SB_PATCHDIR}/ghostscript-cups-realloc-color-depth.patch.gz | patch -p1 --verbose
# Don't segfault closing tiffg3 device if opening failed
zcat ${SB_PATCHDIR}/ghostscript-tif-fail-close.patch.gz | patch -p1 --verbose
# Restore the TIFF default strip size of 0
zcat ${SB_PATCHDIR}/ghostscript-tiff-default-strip-size.patch.gz | patch -p1 --verbose
# Backported some more TIFF fixes.
zcat ${SB_PATCHDIR}/ghostscript-tiff-fixes.patch.gz | patch -p1 --verbose

# libpng 1.4
zcat ${SB_PATCHDIR}/ghostscript-libpng14.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
