  
SB_PATCHDIR=${CWD}/patches

# Use libdir properly
zcat ${SB_PATCHDIR}/xmms2-0.7-use-libdir.patch.gz | patch -p1 -E --backup -z .libdir --verbose || exit 1

if [ "${SB_PA}" = "YES" ] ;then
  # Set default output to pulse
  zcat ${SB_PATCHDIR}/xmms2-0.6DrMattDestruction-pulse-output-default.patch.gz | patch -p1 -E --backup --verbose || exit 1
fi

# Don't add extra CFLAGS, we're smart enough, thanks.
zcat ${SB_PATCHDIR}/xmms2-0.7-no-O0.patch.gz | patch -p1 -E --backup --verbose || exit 1
# More sane versioning
zcat ${SB_PATCHDIR}/xmms2-0.7-moresaneversioning.patch.gz | patch -p1 -E --backup --verbose || exit 1
