
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
# Install headers and add extra file to compilation
# Patch originally from Mageia Linux
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-files.patch
# Do not create libminiupnpc.so.1.5 and libminiupnpc.so.8 linking to it
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-version.patch
# Link to and find libminiupnpc
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-tests.patch

set +e +o pipefail
