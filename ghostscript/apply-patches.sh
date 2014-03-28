
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
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-Fontmap.local.patch
# Don't assume %rom% device is available for initial ICC profile dir.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-iccprofiles-initdir.patch
# gdevcups: don't use uninitialized variables in debugging output.
patch -p1 -E --backup -z .gdevcups-debug-uninit --verbose -i ${SB_PATCHDIR}/ghostscript-gdevcups-debug-uninit.patch
# Use more caution when converting floats to strings (bug rh#980085).
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-wrf-snprintf.patch
# Use upstream patch to fix gs segfault (bug #1036428).
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-gs694154.patch
# # Fix build when using system zlib.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-sys-zlib.patch

set +e +o pipefail
