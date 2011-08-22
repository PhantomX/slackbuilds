
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/soundtouch-1.6.0-x86_64-asm-broken.patch

case "${ARCH}" in
  i[3-6]86)
    patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/soundtouch-1.6.0-mmx-sse-compile-fix.patch
    ;;
  *)
    sed -i 's|-O3 -msse2||' source/SoundTouch/Makefile.*
    ;;
esac

set +e +o pipefail
