
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# rhbz#540433 - KPPP is unable to add DNS entries to /etc/resolv.conf
zcat ${SB_PATCHDIR}/kdenetwork-4.3.3-resolv-conf-path.patch.gz | patch -p2 -E --backup --verbose
# warning: dereferencing type-punned pointer will break strict-aliasing rules
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/kdenetwork-4.10-kppp-strict-aliasing.patch

set +e +o pipefail
