
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-005-readlink.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-005-missing-includes.patch

set +e +o pipefail
