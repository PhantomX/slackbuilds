
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
# Use the system jasper library.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-system-jasper.patch
# Fix pksmraw output.
zcat ${SB_PATCHDIR}/ghostscript-pksmraw.patch.gz | patch -p1 --verbose
# Applied patch to fix NULL dereference in JBIG2 decoder.
zcat ${SB_PATCHDIR}/ghostscript-jbig2dec-nullderef.patch.gz | patch -p1 --verbose
# Install CUPS filter convs files in the correct place.
zcat ${SB_PATCHDIR}/ghostscript-cups-filters.patch.gz | patch -p1 --verbose
# Harden ghostscript's debugging output functions.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-vsnprintf.patch
# Avoid another NULL pointer dereference in jbig2 code.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-jbig2-image-refcount.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-Fontmap.local.patch
# Don't assume %rom% device is available for initial ICC profile dir.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-iccprofiles-initdir.patch
# gdevcups: don't use uninitialized variables in debugging output.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-gdevcups-debug-uninit.patch
# gdevcups: use correct width and height values when allocating memory
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-width-height.patch
# Applied upstream ICC fix
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-icc-fix.patch
# Bugfix (retrieved from Slackware stock)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript.rev11948.diff

set +e +o pipefail
