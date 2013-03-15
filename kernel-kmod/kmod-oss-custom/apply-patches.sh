
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Arch Linux
patch -p0 -E --backup --verbose -d ${RSRCDIR} -i ${SB_PATCHDIR}/linux-3.8.patch

set +e +o pipefail
