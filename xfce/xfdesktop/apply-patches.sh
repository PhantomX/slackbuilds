
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
if [ "${SB_SLKART}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/xfdesktop-4.5.92-backdrop-image.patch.gz | patch -p1 --verbose
fi

set +e +o pipefail
