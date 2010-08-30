
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/OpenEXR-1.6.1-pkgconfig.patch.gz | patch -p1 -E --backup --verbose
# missing #include <cstring>
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.7.0-cstring.patch

set +e +o pipefail
