
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/iface.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/netstatus-libs.patch
# cjk help fails to build
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/help.patch

set +e +o pipefail
