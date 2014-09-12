
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xinit-1.0.2-client-session.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-startx-Pass-nolisten-tcp-by-default.patch

set +e +o pipefail
