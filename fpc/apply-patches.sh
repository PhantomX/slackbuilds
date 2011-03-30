
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/fpc-2.4.2-samplecfg_32and64bit.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/fpc-2.4.2-r15671.patch

set +e +o pipefail
