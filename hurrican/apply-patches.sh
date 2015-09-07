
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-windowmode.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-comment.patch

set +e +o pipefail
