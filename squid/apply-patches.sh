
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
if [ "${PVER}" != "0" ] ;then
  for i in ${PVER} ; do
    patch -p0 --backup --verbose -i ${SB_PATCHDIR}/updates/${NAME}-${SVER}-${i}.patch \
      || patch -p0 --backup --verbose -i ${SB_PATCHDIR}/updates/${NAME}-${SSVER}-${i}.patch
  done
fi

zcat ${SB_PATCHDIR}/squid-3.1.0.9-config.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/squid-3.1.0.9-location.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/squid-3.0.STABLE1-perlpath.patch.gz | patch -p1 -E --backup --verbose
patch -p1 --backup -z .fpic --verbose -i ${SB_PATCHDIR}/squid-3.2.0.12-fpic.patch
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/squid-3.1.9-ltdl.patch

set +e +o pipefail
