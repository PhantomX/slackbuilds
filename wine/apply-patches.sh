
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wine-1.1.15-winegcc.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-winemenubuilder-silence-an-err.patch

# Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wine-cjk.patch

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

if [ "${SB_STAGING}" = "YES" ] ;then
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wine-gcc5-st.patch
else
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wine-gcc5.patch
fi
#https://bugs.winehq.org/show_bug.cgi?id=38653#c15
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/wine-gcc5-wineboot.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wine-relocate-base.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
