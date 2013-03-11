
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
if [ "${SB_SLKART}" = "YES" ] ;then
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.9.3-backdrop-image-slk.patch
fi
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.9.2-fix-desktop.patch

set +e +o pipefail
