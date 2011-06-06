
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mc-extensions.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mc-mcviewsegfault.patch

set +e +o pipefail
