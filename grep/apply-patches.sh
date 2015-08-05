
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p1 --verbose --backup -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/grep-2.11-gnulib-tests-rm-f.patch
# upstream ticket 39444
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/grep-2.21-man-fix-gs.patch
# upstream ticket 39445
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/grep-2.21-help-align.patch
# fix buffer overrun for grep -F, rhbz#1183653
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/grep-2.21-buf-overrun-fix.patch
# backported from upstream
# http://git.savannah.gnu.org/cgit/grep.git/commit/?id=c8b9364d5900a40809827aee6cc53705073278f6
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/grep-2.21-recurse-behaviour-change-doc.patch
# http://www.mail-archive.com/bug-gnulib%40gnu.org/msg31638.html
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/grep-2.21-gnulib.patch

for ignore in 03 99;do
  sed -i -e "/^${ignore}-.*$/d" -e '/^#/d' debian/patches/series
done
for i in $(<debian/patches/series); do
  patch -p1 --verbose --backup --suffix=".pdeb" -i debian/patches/${i}
done

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
