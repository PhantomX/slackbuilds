
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wine-1.1.15-winegcc.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-winemenubuilder-silence-an-err.patch

# Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wine-cjk.patch

# bugfixes
# http://bugs.winehq.org/show_bug.cgi?id=7698
# http://bugs2.winehq.org/attachment.cgi?id=6853
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wine-csd.patch

if [ "${SB_STAGING}" = "YES" ] ;then
  sed -i \
    -e '/autoreconf -f/d' \
    -e '/\.\/tools\/make_requests/d' \
    ${STSRCDIR}/patches/Makefile
#  for ignore in configure-Detect_Gnutls wined3d-FFP_Fog ;do
#    sed -i -e "/${ignore}.ok \\\/d" ${STSRCDIR}/patches/Makefile
#  done
  make -C ${STSRCDIR}/patches DESTDIR="${SB_SROOT}" install

elif [ "${SB_PA}" = "YES" ] ;then
  for p in $(ls ${STSRCDIR}/patches/winepulse-PulseAudio_Support/*patch); do
    patch -p1 -i ${p}
  done
fi

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
