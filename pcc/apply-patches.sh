
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p2 -E --backup --verbose -d ${LSRCDIR} -i ${SB_PATCHDIR}/pcc-090808-optflags.patch

set +e +o pipefail
