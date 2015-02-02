
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# rhbz#1035503
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/iotop-0.6-noendcurses.patch

set +e +o pipefail
