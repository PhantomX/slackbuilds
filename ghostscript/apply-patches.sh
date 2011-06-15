
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/ghostscript-8.62-versioned_ijs.patch.gz | patch -p0 --verbose

# Fix ijs-config not to have multilib conflicts
zcat ${SB_PATCHDIR}/ghostscript-multilib.patch.gz | patch -p1 --verbose
# Fix some shell scripts
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-scripts.patch
# Build igcref.c with -O0 to work around bug #150771.
zcat ${SB_PATCHDIR}/ghostscript-noopt.patch.gz | patch -p1 --verbose
# Define .runlibfileifexists.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-runlibfileifexists.patch
# Prevent segfault when running gstoraster outside CUPS.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-colord.patch
# Fix pksmraw output.
zcat ${SB_PATCHDIR}/ghostscript-pksmraw.patch.gz | patch -p1 --verbose
# Applied patch to fix NULL dereference in JBIG2 decoder.
zcat ${SB_PATCHDIR}/ghostscript-jbig2dec-nullderef.patch.gz | patch -p1 --verbose
# Install CUPS filter convs files in the correct place.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-cups-filters.patch
# Harden ghostscript's debugging output functions.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-vsnprintf.patch
# Avoid another NULL pointer dereference in jbig2 code.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-jbig2-image-refcount.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-Fontmap.local.patch
# Don't assume %rom% device is available for initial ICC profile dir.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-iccprofiles-initdir.patch
# gdevcups: don't use uninitialized variables in debugging output.
patch -p1 -E --backup -z .gdevcups-debug-uninit --verbose -i ${SB_PATCHDIR}/ghostscript-gdevcups-debug-uninit.patch
# pxl: match landscape page sizes (bug #692165).
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-pxl-landscape.patch
# http://bugs.ghostscript.com/show_bug.cgi?id=692176
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-change-error-return-confusion.patch

set +e +o pipefail
