
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.5.63-rpath.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.6.0-raptor2.patch

set +e +o pipefail
