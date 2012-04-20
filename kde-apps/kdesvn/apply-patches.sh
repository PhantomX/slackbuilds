
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.5.3-kdex.patch
# Remove problematic virtual inheritance
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kdesvn-virtual.patch
# Compile with gcc 4.7
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kdesvn-gcc47.patch

set +e +o pipefail
