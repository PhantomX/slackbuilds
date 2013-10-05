
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-dracut.sh-harden-host_modalias-reading.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-ifup-do-not-dhcp-on-network-interface-of-secondary-s.patch

set +e +o pipefail
