
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
#patch -p0 -E --backup -z .orig --verbose -i ${SB_EPDIR}/${PSRCARCHIVE}

set +e +o pipefail
