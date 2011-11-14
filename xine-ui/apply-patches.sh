
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Patch to use UTF-8 documentation, BZ #512598
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.99.5-utf8doc.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.99.6-fix-help-crash.patch
# curl/types.h has been empty since 2006, MIA 2011
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.99.6-curl-types.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.99.6-libpng15.patch

set +e +o pipefail
