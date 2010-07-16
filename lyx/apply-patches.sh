
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lyx-1.6.6-xdg_open.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lyx-1.6.6-ImplicitDSOLinking_X11.patch

set +e +o pipefail
