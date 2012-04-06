
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
if [ "${SB_SLKART}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/xfdesktop-4.5.92-backdrop-image-slk.patch.gz | patch -p1 --verbose
fi
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.9.2-fix-desktop.patch

set +e +o pipefail
