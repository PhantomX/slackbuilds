
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p1 --verbose --backup -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/grep-2.9-gnulib-tests-rm-f.patch

for ignore in 03;do
  sed -i -e "/^${ignore}-.*$/d" debian/patches/series
done
for i in $(<debian/patches/series); do
  patch -p1 --verbose --backup --suffix=".pdeb" -i debian/patches/${i}
done

set +e +o pipefail
