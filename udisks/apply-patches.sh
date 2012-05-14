
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
sed -i -e '/^#/d' debian/patches/series
for i in $(<debian/patches/series); do
  patch -p1 --verbose --backup --suffix=".pdeb" -i debian/patches/${i}
done

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/udisks-1.0.4-neuter-stdout-and-stderr.patch

set +e +o pipefail
