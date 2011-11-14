
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-1.3.12-perl_linkage.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.7-debian-fixed.patch
bzcat ${CWD}/${PSRCARCHIVE} | patch -p1 -E --backup --verbose


set +e +o pipefail
