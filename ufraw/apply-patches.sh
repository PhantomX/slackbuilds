
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Submitted upstream at: https://sourceforge.net/tracker/index.php?func=detail&aid=3213478&group_id=127649&atid=709086#
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ufraw-0.18-darkframe.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=634235
# https://sourceforge.net/tracker/?func=detail&aid=3310116&group_id=127649&atid=709086
# backported from upstream CVS
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ufraw-0.18-crop-area.patch
# backported from upstream CVS
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ufraw-0.18-gimp-2.8.patch

set +e +o pipefail
