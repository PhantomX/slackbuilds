
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
#for i in $(<debian/patches/series); do
#  patch -p1 --verbose --backup --suffix=".pdeb" -i debian/patches/${i}
#done

set +e +o pipefail
