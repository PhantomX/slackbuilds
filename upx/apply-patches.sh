
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
if [ "${SB_LZMA}" = "YES" ] && [ "${SB_LZMASYS}" = "YES" ] ;then
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/upx-3.07-use-lzma-sdk-lib.patch
fi

set +e +o pipefail
