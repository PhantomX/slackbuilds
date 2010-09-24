
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p1 --verbose --backup -i ${SB_PATCHDIR}/${NAME}.patch

sed -i -e '/^.*dlopen-pcre.*/d' debian/patches/series
for ignore in 55 05 06 ;do
  sed -i -e "/^${ignore}-.*$/d" debian/patches/series
done
for i in $(<debian/patches/series); do
  patch -p1 --verbose --backup --suffix=".pdeb" -i debian/patches/${i}
done

set +e +o pipefail
