
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fix logout with multiple sessions asking for save. 
# https://bugzilla.xfce.org/show_bug.cgi?id=5379
# http://git.xfce.org/xfce/xfce4-session/patch/?id=9f3077be682355e1cd07e9a9463e76307292208c
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.10.0-session-save.patch
# fix for some glib2 crasher issues. 
# commit dee0200fa5dc4de064f288281ddd13199ba7fcde
# commit ab391138cacc62ab184a338e237c4430356b41f9
# https://bugzilla.xfce.org/show_bug.cgi?id=9709
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.10.0-glib2.patch

set +e +o pipefail
