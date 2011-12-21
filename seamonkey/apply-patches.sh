
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Upstream patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-23-path.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/seamonkey-8.0-enable-addons.patch

set +e +o pipefail
