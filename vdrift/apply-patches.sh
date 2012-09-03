
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
filterdiff -p0 -x 'data/*' -z ${SB_EPDIR}/${PSRCARCHIVE} > ${PSRCARCHIVE}
patch -p0 -E --backup --verbose -i ${PSRCARCHIVE}

set +e +o pipefail
