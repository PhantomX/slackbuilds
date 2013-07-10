
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Arch Linux
patch -p0 -E --backup --verbose -d ${RSRCDIR} -i ${SB_PATCHDIR}/linux-3.8.patch
# http://4front-tech.com/forum/viewtopic.php?f=3&t=5247
patch -p0 -E --backup --verbose -d ${RSRCDIR} -i ${SB_PATCHDIR}/linux-3.10.patch

set +e +o pipefail
