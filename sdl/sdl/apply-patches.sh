
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/SDL-1.2.12-multilib.patch.gz | patch -p1 -E --backup --verbose
# Submitted to upstream as sdl1155, rh480065
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/SDL-1.2.10-GrabNotViewable.patch


if [ "${SB_ALSA}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/SDL-1.2.14-default-alsa.patch.gz | patch -p0 -E --backup --verbose
fi

set +e +o pipefail
