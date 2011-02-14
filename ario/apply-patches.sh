
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# http://sourceforge.net/tracker/index.php?func=detail&aid=3106565&group_id=197448&atid=961512
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/ario-libnotify-0.7.0-fix.patch

set +e +o pipefail
