
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/kdebindings-4.5.95-valgrind.patch

set +e +o pipefail
