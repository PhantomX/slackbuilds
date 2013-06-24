
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/ghostscript-8.62-versioned_ijs.patch.gz | patch -p0 --verbose

# Fix ijs-config not to have multilib conflicts
zcat ${SB_PATCHDIR}/ghostscript-multilib.patch.gz | patch -p1 --verbose
# Fix some shell scripts
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-scripts.patch
# Build igcref.c with -O0 to work around bug rh#150771.
zcat ${SB_PATCHDIR}/ghostscript-noopt.patch.gz | patch -p1 --verbose
# Fix ./autgen.sh in ijs sub-project
# Define .runlibfileifexists.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-runlibfileifexists.patch
# Fixed missing error check when setting ICC profile.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-icc-missing-check.patch
# Install CUPS filter convs files in the correct place.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-cups-filters.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-Fontmap.local.patch
# Don't assume %rom% device is available for initial ICC profile dir.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-iccprofiles-initdir.patch
# gdevcups: don't use uninitialized variables in debugging output.
patch -p1 -E --backup -z .gdevcups-debug-uninit --verbose -i ${SB_PATCHDIR}/ghostscript-gdevcups-debug-uninit.patch
# Back-ported locale fix (bug rh#961149).
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-gs_sprintf.patch
# Upstream patch to fix pdfwrite segfault (bug rh#962120).
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-pdfwrite-segfault.patch
# Upstream patch from bug #690692 to handle strange fonts (bug rh#969660).
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-strange-fonts.patch


set +e +o pipefail
