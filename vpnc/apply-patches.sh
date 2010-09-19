
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vpnc-0.5.3-cloexec.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vpnc-0.5.1-dpd.patch

set +e +o pipefail
