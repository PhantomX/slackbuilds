
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.7.90-no_mpxj.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-switch-to-librevenge-based-import-libs.patch

set +e +o pipefail
