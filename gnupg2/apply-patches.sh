
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gnupg-2.0.16-tests-s2kcount.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gnupg-2.0.14-secmem.patch

## upstream patches
# Security Alert for GnuPG 2.0 - Realloc bug in GPGSM
# http://lists.gnupg.org/pipermail/gnupg-announce/2010q3/000302.html
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gnupg-2.0.16-gpgsm_realloc.patch

set +e +o pipefail
