
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

if [ "${PVER}" != "0" ] ;then
  for i in ${PVER} ; do
    patch -p0 --backup --verbose -i ${SB_PATCHDIR}/updates/${NAME}-${SVER}-${i}.patch
  done
fi

zcat ${SB_PATCHDIR}/squid-3.1.0.9-config.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/squid-3.1.0.9-location.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/squid-3.0.STABLE1-perlpath.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/squid-3.1.0.15-smb-path.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/squid-3.0.STABLE7-from_manpg.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/squid-3.1.0.16-noufsdump.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
