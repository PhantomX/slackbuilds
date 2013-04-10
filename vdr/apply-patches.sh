
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
if [ "${PATCHLEVEL}" -gt 0 ] ;then
  mkdir -p patches
  cp ${SB_PATCHDIR}/updates/vdr-${SVER}-*.diff patches/

  ( SB_PATCHDIR=patches
    for i in $( seq -w ${PATCHLEVEL} ) ; do
      patch -p1 --backup --verbose -i ${SB_PATCHDIR}/vdr-${SVER}-${i}.diff
    done
  )
fi

for ignore in 04 06 08 11 16 81 82 99 ;do
  sed -i -e "/^${ignore}_.*$/d" debian/patches/series
done
sed -i -e "/^fix-.*$/d" debian/patches/series
for i in $(<debian/patches/series); do
  patch -p1 --verbose --backup --suffix=".pdeb" -i debian/patches/${i}
done


patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vdr-channel+epg.patch
zcat ${DOWNDIR}/${EPSRCARCHIVE01} | patch -p1 -E --backup --verbose
zcat ${DOWNDIR}/${EPSRCARCHIVE02} | patch -p1 -E --backup --verbose
# Extracted from http://copperhead.htpc-forum.de/downloads/extensionpatch/extpngvdr1.7.21v1.diff.gz
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vdr-1.7.21-plugin-missing.patch
sed \
  -e "s|__CACHEDIR__|${cachedir}|" \
  -e "s|__CONFIGDIR__|${configdir}|" \
  -e "s|__PLUGINDIR__|${plugindir}|" \
  -e "s|__VARDIR__|${vardir}|" \
  -e "s|__VIDEODIR__|${videodir}|" \
  ${SB_PATCHDIR}/vdr-1.7.41-paths.patch | patch -p1
patch -p1 -F 2 -E --backup --verbose -i ${DOWNDIR}/${EPSRCARCHIVE03}
# http://article.gmane.org/gmane.linux.vdr/36097
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vdr-1.5.18-syncearly.patch
patch -p1 -E --backup --verbose -i ${DOWNDIR}/${EPSRCARCHIVE04}
# Extracted from http://copperhead.htpc-forum.de/downloads/extensionpatch/extpngvdr1.7.21v1.diff.gz
# Original at http://toms-cafe.de/vdr/download/vdr-jumpplay-1.0-1.7.6.diff
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vdr-1.7.28-vasarajanauloja-jumpplay.patch
# http://www.udo-richter.de/vdr/patches.en.html#hlcutter
#patch -p1 -F 2 -E --backup --verbose -i ${DOWNDIR}/${EPSRCARCHIVE05}
# http://article.gmane.org/gmane.linux.vdr/43590
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vdr-1.7.38-mainmenuhooks101.patch
# http://projects.vdr-developer.org/git/vdr-plugin-epgsearch.git/plain/patches/timercmd-0.1_1.7.17.diff
# Modified so that it applies over the timer-info patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vdr-1.7.21-timercmd.patch
#patch -p1 -E --backup --verbose -i ${DOWNDIR}/${EPSRCARCHIVE06}
#zcat ${DOWNDIR}/${EPSRCARCHIVE07} | patch -p1 -E --backup --verbose
# http://www.linuxtv.org/pipermail/vdr/2013-April/027668.html
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/vdr-2.0.0-fixkeeptracksinit.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vdr-1.7.37-fedora-pkgconfig.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vdr-1.7.21-jumpplay-finnish.patch
#patch -p1 -F 3 -E --backup --verbose -i ${DOWNDIR}/${EPSRCARCHIVE08}
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vdr-timer-info-1.7.28.patch

set +e +o pipefail
