
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

for ignore in 66;do
  sed -i -e "/^${ignore}_.*$/d" debian/patches/series
done
for i in $(<debian/patches/series); do
  patch -p1 --verbose --backup --suffix=".pdeb" -i debian/patches/${i}
done

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
# link against libnotify
# https://sourceforge.net/tracker/?func=detail&aid=3280223&group_id=239&atid=100239
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xchat-2.8.8-link-against-libnotify.patch
# http://sourceforge.net/tracker/?func=detail&aid=3535920&group_id=239&atid=100239
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Autoload-from-.xchat2-plugins-also-as-like-perl-plug.patch
# http://sourceforge.net/tracker/?func=detail&aid=3536005&group_id=239&atid=100239
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-add-missing-include-to-prevent-implicit-declaration.patch
# http://sourceforge.net/tracker/?func=detail&aid=3538147&group_id=239&atid=100239
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xchat-2.8.8-tld.patch
# http://sourceforge.net/tracker/?func=detail&aid=3539345&group_id=239&atid=100239
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/xchat-2.8.8-log_create_pathname.patch
#http://sourceforge.net/tracker/?func=detail&aid=3539580&group_id=239&atid=100239
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xchat-2.8.8-url-suffixes.patch

set +e +o pipefail
