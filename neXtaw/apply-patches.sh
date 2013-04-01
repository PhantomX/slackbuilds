
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fix an ANSCI C strict aliasing violation
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-alias.patch
# Add missing includes
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-header.patch

set +e +o pipefail
