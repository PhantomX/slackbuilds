
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Search applications/kde4, applications/wine and support X-Wine in desktop files
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-more-search.patch

set +e +o pipefail
