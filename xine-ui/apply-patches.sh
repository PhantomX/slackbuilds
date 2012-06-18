
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Patch to use UTF-8 documentation, BZ #512598
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.99.5-utf8doc.patch

set +e +o pipefail
