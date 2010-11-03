
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/soundtouch-1.4.0-x86_64-asm-broken.patch.gz | patch -p1 -E --backup --verbose

case "${ARCH}" in
  i[3-6]86)
    zcat ${SB_PATCHDIR}/soundtouch-1.4.0-mmx-sse-compile-fix.patch.gz | patch -p1 -E --backup --verbose
    ;;
  *)
    sed -i 's|-O3 -msse2||' source/SoundTouch/Makefile.*
    ;;
esac

set +e +o pipefail
