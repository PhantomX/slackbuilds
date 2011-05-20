
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p1 --verbose --backup -i ${SB_PATCHDIR}/${NAME}.patch
#patch -p1 --verbose --backup -i ${SB_PATCHDIR}/grep-2.7-const-range-exp.patch

sed -i -e '/^.*dlopen-pcre.*/d' debian/patches/series
for ignore in \#55 80 90;do
  sed -i -e "/^${ignore}-.*$/d" debian/patches/series
done
for i in $(<debian/patches/series); do
  patch -p1 --verbose --backup --suffix=".pdeb" -i debian/patches/${i}
done

set +e +o pipefail
