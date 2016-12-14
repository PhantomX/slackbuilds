
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Gentoo
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wine-1.5.26-winegcc.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wine-1.6-memset-O3.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-winemenubuilder-silence-an-err.patch

### Fedora
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

  [ "${SB_NINE}" = "YES" ] && patch -p1 -E --backup --verbose -i ${NSRCDIR}/staging-helper.patch

  # fix parallelized build
  sed -i -e 's!^loader server: libs/port libs/wine tools.*!& include!' Makefile.in

elif [ "${SB_PA}" = "YES" ] ;then
  for p in $(ls ${STSRCDIR}/patches/winepulse-PulseAudio_Support/*patch); do
    patch -p1 -i ${p}
  done
fi

[ "${SB_NINE}" = "YES" ] && patch -p1 -E --backup --verbose -i ${NSRCDIR}/${NNAME}.patch

### AUR - https://aur.archlinux.org/packages/wine-gaming-nine
# Steam patch, Crossover Hack version
# https://bugs.winehq.org/show_bug.cgi?id=39403
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/steam.patch
# Heap allocation perfomance improvement patc
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/heap_perf.patch
# Increase fragment samplers threshold
# https://bugs.winehq.org/show_bug.cgi?id=41213
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/increase_max_frag_samplers.patch
# Wbemprox videocontroller query fix v2
# https://bugs.winehq.org/show_bug.cgi?id=38879
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wbemprox_query_v2.patch
# Keybind patch reversion
patch -p1 -E --backup --verbose -R -i ${SB_PATCHDIR}/keybindings.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
