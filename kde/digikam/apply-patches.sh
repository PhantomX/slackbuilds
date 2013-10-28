
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

## upstreamable patches
# https://bugs.kde.org/show_bug.cgi?id=319664
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.5.0-no_libPropertyBrowser.patch

## upstream patches

set +e +o pipefail
