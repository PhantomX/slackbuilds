
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p1 --verbose --backup -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/grep-2.11-gnulib-tests-rm-f.patch
# Fix a bug where tiny text files were incorrectly detected as binary
# on filesystems that store small files in metadata with an apparent
# size of 0. (From Slackware)
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/grep.tiny.text.files.not.binary.diff 
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/grep.compressed.not.binary.diff 
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/grep.remove.stat-size.diff 

for ignore in 03 90;do
  sed -i -e "/^${ignore}-.*$/d" debian/patches/series
done
for i in $(<debian/patches/series); do
  patch -p1 --verbose --backup --suffix=".pdeb" -i debian/patches/${i}
done

set +e +o pipefail
