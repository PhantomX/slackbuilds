
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Use libdir properly
zcat ${SB_PATCHDIR}/xmms2-0.7-use-libdir.patch.gz | patch -p1 -E --backup -z .libdir --verbose

if [ "${SB_PA}" = "YES" ] ;then
  # Set default output to pulse
  zcat ${SB_PATCHDIR}/xmms2-0.6DrMattDestruction-pulse-output-default.patch.gz | patch -p1 -E --backup --verbose
fi

# Don't add extra CFLAGS, we're smart enough, thanks.
zcat ${SB_PATCHDIR}/xmms2-0.7-no-O0.patch.gz | patch -p1 -E --backup --verbose
# More sane versioning
zcat ${SB_PATCHDIR}/xmms2-0.7-moresaneversioning.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
