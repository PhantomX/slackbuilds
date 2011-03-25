
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/awn-applet-simple.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dso.patch

set +e +o pipefail
