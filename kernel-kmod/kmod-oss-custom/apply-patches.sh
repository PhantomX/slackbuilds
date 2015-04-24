
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -d ${RSRCDIR} -i ${SB_PATCHDIR}/oss-linux-4.0.patch
### Arch
patch -p0 -E --backup --verbose -d ${RSRCDIR} -i ${SB_PATCHDIR}/ossvermagic.patch

set +e +o pipefail
