
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# From Fedora
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/newrpms-barrage-datadir.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/barrage-1.0.2-menu-overflow.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/barrage-1.0.2-dsolink.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/barrage-1.0.2-spelling.patch

set +e +o pipefail
