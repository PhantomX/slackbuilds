
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/pdftk.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pdftk-1.44-Makefile.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pdftk-1.44-LDFLAGS.patch

set +e +o pipefail
