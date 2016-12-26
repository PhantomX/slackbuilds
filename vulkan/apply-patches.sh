
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-layers-Don-t-set-an-rpath.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0008-demos-Don-t-build-tri-or-cube.patch

set +e +o pipefail
