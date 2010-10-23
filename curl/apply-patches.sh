
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# patch making libcurl multilib ready
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/curl-7.20.0-multilib.patch
# prevent configure script from discarding -g in CFLAGS
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0102-curl-7.21.2-debug.patch

set +e +o pipefail
