
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/conky-1.8.1-nvidia-x.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/conky-1.8.1-xmms2.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/conky-1.8.1-secunia-SA43225.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/conky-1.8.1-acpitemp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/conky-1.8.1-curl-headers.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/conky-1.8.1-maxinterfaces.patch

set +e +o pipefail
