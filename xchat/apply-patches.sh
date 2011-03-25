
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-1.8.7-use-sysconf-to-detect-cpus.patch.gz | patch -p0 -E --backup --verbose
# Upstream XChat 2.8.6 defaults to Latin1 (what upstream calls the "IRC"
# encoding). Default to UTF-8 instead (as previous versions did, at least when
# running under a UTF-8 locale).
# Both the "IRC" and "UTF-8" settings will try to accept both Latin1 and UTF-8
# when it comes in, however "IRC" sends Latin1, "UTF-8" sends UTF-8.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xchat-2.8.6-default-utf8.patch
# patch to add ability to change to tab with most recent activity
# See http://sourceforge.net/tracker/?func=detail&aid=2022871&group_id=239&atid=350239
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xchat-2.8.6-change-page-activity.patch
# add port numbers for Freenode (Debarshi Ray)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xchat-2.8.6-freenode-ports.patch
# work with libnotify 0.7
# https://sourceforge.net/tracker/?func=detail&aid=3109838&group_id=239&atid=100239
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xchat-2.8.8-libnotify07.patch

#zcat ${SB_PATCHDIR}/${NAME}-new-gtk-type.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
