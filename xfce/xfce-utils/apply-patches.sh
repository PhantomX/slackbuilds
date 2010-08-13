
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
if [ "${SB_PA}" = "YES" ] ; then
  zcat ${SB_PATCHDIR}/xfce-utils-4.4.2-pulseaudio.patch.gz | patch -p1 --verbose
fi
zcat ${SB_PATCHDIR}/xfce-utils-4.4.3-xfterm4-bug.patch.gz | patch -p1 --verbose
patch -p1 --verbose -i ${SB_PATCHDIR}/xfce-utils-4.6.1-startxfce-data-dirs.patch
zcat ${SB_PATCHDIR}/xfce-utils-4.6.1-xdgconfig.patch.gz | patch -p1 --verbose

set +e +o pipefail
