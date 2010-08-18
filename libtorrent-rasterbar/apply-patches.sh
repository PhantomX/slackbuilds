
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.dpatch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/disable-valloc.dpatch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rb_libtorrent-0.14.10-gcc45.patch

set +e +o pipefail
