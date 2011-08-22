
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-2.3.1-opencvconfig.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-2.3.1-numpy.patch

set +e +o pipefail
