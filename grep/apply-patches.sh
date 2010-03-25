
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 --backup --verbose -i ${SB_PATCHDIR}/grep-2.6-sigsegv.patch

zcat ${CWD}/${PSRCARCHIVE} | patch -p1 --verbose
sed -i -e '/^#@@/d' debian/patches/64-egf-speedup.patch
#for i in $(<debian/patches/series); do
  #patch -p1 --verbose --backup --suffix=".pdeb" -i debian/patches/${i}
#done

set +e +o pipefail
