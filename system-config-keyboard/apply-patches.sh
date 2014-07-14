
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/sck-1.3.1-firstboot.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/sck-1.3.1-firstboot-functions.patch

set +e +o pipefail
