
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## Fedora
# https://bugzilla.redhat.com/show_bug.cgi?id=652913
# Fix crash in race selection screen when random keys are pressed
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.4-random-keypress-crash.patch
# Build with newer libpng versions, modifies configure.ac
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.4-libpng.patch
# Call memset() with correctly ordered parameters
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.4-memset.patch

set +e +o pipefail
