
SB_PATCHDIR=${CWD}/patches

if [ "${PATCHLEVEL}" != "0" ] ;then
  for i in ${PVER} ; do
    patch -p0 --backup --verbose -i ${SB_PATCHDIR}/updates/${NAME}-${SVER}-${i}.patch || exit 1
  done
fi

zcat ${SB_PATCHDIR}/squid-3.1.0.9-config.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/squid-3.1.0.9-location.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/squid-3.0.STABLE1-perlpath.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/squid-3.1.0.15-smb-path.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/squid-3.0.STABLE7-from_manpg.patch.gz | patch -p1 -E --backup --verbose || exit 1
