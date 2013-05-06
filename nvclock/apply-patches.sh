
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
for i in $(<debian/patches/series); do
  patch -p1 --verbose --backup --suffix=".pdeb" -i debian/patches/${i}
done

patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/nvclock-noqtdir.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES


set +e +o pipefail
