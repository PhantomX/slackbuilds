
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-unbundle-enet.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0005-unbundle-wiiuse.patch

set +e +o pipefail
