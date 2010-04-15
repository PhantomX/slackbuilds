
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/awn-applet-simple.patch

set +e +o pipefail
