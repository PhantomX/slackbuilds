
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
if [ "${SB_PA}" = "YES" ] ; then
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.7.4-pulseaudio.patch
fi
zcat ${SB_PATCHDIR}/xfce-utils-4.4.3-xfterm4-bug.patch.gz | patch -p1 --verbose
patch -p1 --verbose -i ${SB_PATCHDIR}/xfce-utils-4.7.1-startxfce-data-dirs.patch
zcat ${SB_PATCHDIR}/xfce-utils-4.6.1-xdgconfig.patch.gz | patch -p1 --verbose

set +e +o pipefail
