  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-2.0-getstartpage.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Upstream patches

if [ "${SB_OFFICIAL}" = "YES" ] ;then
  # Required by Mozilla Corporation
  zcat ${SB_PATCHDIR}/mozilla-firstrun.patch.gz | patch -p1 -E --backup --verbose || exit 1
fi
