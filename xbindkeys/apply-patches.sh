
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${CWD}/${PSRCARCHIVE2} | patch -p1 -E --backup -z .pdeb --verbose -d ${SRCDIR2}

set +e +o pipefail
