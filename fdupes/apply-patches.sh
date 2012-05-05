
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${CWD}/${PSRCARCHIVE} | patch -p1 -E --verbose 

for ignore in 05;do
  sed -i -e "/^${ignore}_.*$/d" debian/patches/00list
done
for i in $(<debian/patches/00list); do
  patch -p1 --verbose --backup --suffix=".pdeb" -i debian/patches/${i}.dpatch
done

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fdupes-1.50-destdir.patch

set +e +o pipefail
