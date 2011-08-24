
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Upstream patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-23-path.patch

set +e +o pipefail
