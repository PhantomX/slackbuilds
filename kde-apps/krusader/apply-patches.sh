
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://sourceforge.net/tracker/?func=detail&aid=2873567&group_id=6488&atid=306488
# adds default MIME type handlers for (tar.)lzma legacy archives
# fixes bz2 (non-tar) MIME type
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.3.0-beta1-default-mimetypes.patch
# Fix build failure with g++ 4.7
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.4.0-beta1-fix-for-g++47.patch

set +e +o pipefail
