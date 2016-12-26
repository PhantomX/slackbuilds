
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
if [ "${PVER}" != "0" ] ;then
  mkdir -p patches
  SB_CP="filterdiff -p0 -x 'doc/release-notes/*'"
  for i in $(eval echo "${PVER}") ; do
    ${SB_CP} ${SB_PATCHDIR}/updates/${NAME}-${SVER}-${i}.patch \
      > patches/${NAME}-${SVER}-${i}.patch \
    || ${SB_CP} ${SB_PATCHDIR}/updates/${NAME}-${SVER}-${i}.patch \
      > patches/${NAME}-${SSVER}-${i}.patch
  done
  patch -p0 --backup --verbose -i patches/${NAME}-${SVER}-${i}.patch \
    || patch -p0 --backup --verbose -i patches/${NAME}-${SSVER}-${i}.patch
fi

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/squid-4.0.11-config.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/squid-3.1.0.9-location.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/squid-3.5.9-include-guards.patch

set +e +o pipefail
