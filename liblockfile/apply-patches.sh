
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Makefile.in.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/688074-Makefile.in-NVER.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix-buffer-overflows.patch

set +e +o pipefail
