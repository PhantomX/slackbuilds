
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=564746
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lxpanel-0.5.5-dsofix.patch
# http://sourceforge.net/tracker/?func=detail&aid=3033293&group_id=180858&atid=894869
# http://lxde.git.sourceforge.net/git/gitweb.cgi?p=lxde/lxpanel;a=commit;h=4a974f2686d2fafdcda4a180b0483a7b17fd2d71
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lxpanel-0.5.6-Fix-build-issue-with-symbol-alarm-showing-up-on-F14-.patch 

set +e +o pipefail
