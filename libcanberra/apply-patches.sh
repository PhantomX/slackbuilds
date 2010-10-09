
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
if [ "${SB_ALSA}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/${NAME}-0.18-alsa-default.patch.gz | patch -p0 -E --backup --verbose
fi

set +e +o pipefail
