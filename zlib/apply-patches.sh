
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/zlib-1.2.5-minizip-fixuncrypt.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/zlib-1.2.7-optimized-s390.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/zlib-1.2.7-z-block-flush.patch
# http://mail.madler.net/pipermail/zlib-devel_madler.net/2013-August/003081.html
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/zlib-1.2.8-minizip-include.patch

set +e +o pipefail
