
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 --verbose -i ${SB_PATCHDIR}/Thunar-1.0.1-dsofix.patch

set +e +o pipefail
