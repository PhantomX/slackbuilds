
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Adds handler for ogg audio metadata by default.  Submitted upstream: http://sourceforge.net/tracker/?func=detail&aid=3064466&group_id=129766&atid=715782
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.12.1.fixogg.patch
# Fixes issue where video files > 999 minutes in length overrun the minutes buffer.
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.12.1.fixbufferoverrun.patch
# Fix build issues related to GCC 4.6 (missing definitions.)  Submitted upstream
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.12.1.fixbuild.patch
#Port to js-1.8 (thanks Jan!)  Submitted upstream: http://sourceforge.net/tracker/?func=detail&aid=3409482&group_id=129766&atid=715782
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.12.1.tonewjs.patch
# Fixes to the js/native code to allow custom js parsing. Submitted upstream (with above)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.12.1-jsparse.patch 
# Allows timeseeking on ps3.  http://sourceforge.net/tracker/?func=detail&aid=3309436&group_id=129766&atid=715782
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.12.1.ps3_timeseekrange.patch
# Enable album art for FLAC based on libflac.  http://sourceforge.net/tracker/?func=detail&aid=2960326&group_id=129766&atid=715782
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.12.1.flacart.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.12.1.flacart.config.patch
# Fix youtube support.  RHBZ#747023, upstream bug http://sourceforge.net/tracker/?func=detail&aid=3382320&group_id=129766&atid=715780
patch -p3 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.12.1.fixyoutube.patch
# Fix for gcc 4.7 build errors
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.12.1.gcc47.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.12.1-libav7.patch

set +e +o pipefail
