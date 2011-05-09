
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gpm-1.20.6-multilib.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gpm-1.20.1-lib-silent.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gpm-1.20.3-gcc4.3.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gpm-1.20.5-close-fds.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gpm-1.20.1-weak-wgetch.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gpm-1.20.6-libtool.patch

set +e +o pipefail
