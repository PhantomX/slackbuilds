
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.4-no_rpath.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.5.57-plugindir.patch

## Upstream patches

set +e +o pipefail
