
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kid3-2.0.1-mp4v2-1.9.1_p479.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-build-with-g-4.7.0-include-unistd.h-for-getpid.patch

set +e +o pipefail
