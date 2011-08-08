
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .path --verbose -i ${SB_PATCHDIR}/qwt-5.2.2-install_qt.patch

set +e +o pipefail
