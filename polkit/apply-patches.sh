
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/polkit-0.108-fix-libmozjs185-soname-slk.patch
# Patch the patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/polkit-fix-deb-patch.patch

for ignore in 01 05 06 ;do
  sed -i -e "/^${ignore}.*$/d" debian/patches/series
done
for i in $(<debian/patches/series); do
  patch -p1 --verbose --backup --suffix=".pdeb" -i debian/patches/${i}
done

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
