
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${PNAME}-3.12.0-syslibs.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-3.12.0-doxygen.patch.gz | patch -p1 -E --backup --verbose
patch -p0 -E --backup -z .png15 --verbose -i ${SB_PATCHDIR}/${PNAME}-3.12.0-libpng15.patch

set +e +o pipefail
