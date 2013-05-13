
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

sed -i -e '/^#/d' debian/patches/series
for ignore in 05 20 60 ; do
  sed -i -e "/^${ignore}-.*$/d" debian/patches/series
done
for i in $(<debian/patches/series); do
  patch -p1 --verbose --backup --suffix=".pdeb" -i debian/patches/${i}
done

patch -p1 -E --backup -z.destdir --verbose -i ${SB_PATCHDIR}/fdupes-1.51-destdir.patch

set +e +o pipefail
