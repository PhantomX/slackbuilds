
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
if [ "${SNAPBUILD}" != "YES" ] ;then
  zcat ${SB_PATCHDIR}/${PNAME}-1.1.1-gcc43.patch.gz | patch -p0 -E --backup --verbose
  zcat ${SB_PATCHDIR}/${PNAME}-1.1.1-ffmpeg.patch.gz | patch -p1 -E --backup --verbose
fi

set +e +o pipefail
