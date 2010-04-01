
SB_PATCHDIR=${CWD}/patches

#zcat ${SB_PATCHDIR}/${NAME}-2.8.4-redhat-desktop.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.8.7-use-sysconf-to-detect-cpus.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.0.2-freenode.patch.gz | patch -p0 -E --backup --verbose || exit 1
# see #241923
zcat ${SB_PATCHDIR}/${NAME}-2.8.4-disable-tray-icon-by-default.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.8.4-shm-pixmaps.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Upstream XChat 2.8.6 defaults to Latin1 (what upstream calls the "IRC"
# encoding). Default to UTF-8 instead (as previous versions did, at least when
# running under a UTF-8 locale).
# Both the "IRC" and "UTF-8" settings will try to accept both Latin1 and UTF-8
# when it comes in, however "IRC" sends Latin1, "UTF-8" sends UTF-8.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xchat-2.8.6-default-utf8.patch
# fix literal underscore in "C_onnect" button (#512034, Edward Sheldrake)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xchat-2.8.6-connect-mnemonic.patch
# patch to add ability to change to tab with most recent activity
# See http://sourceforge.net/tracker/?func=detail&aid=2022871&group_id=239&atid=350239
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xchat-2.8.6-change-page-activity.patch

zcat ${SB_PATCHDIR}/xc286-smallfixes.diff.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-new-gtk-type.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-query.patch.gz | patch -p0 -E --backup --verbose || exit 1
