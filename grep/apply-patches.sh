
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p1 --verbose --backup -i ${SB_PATCHDIR}/${NAME}.patch
# upstream ticket 39444
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/grep-2.27-man-fix-gs.patch
# upstream ticket 39445
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/grep-2.27-help-align.patch

for ignore in 03 ;do
  sed -i -e "/^${ignore}-.*$/d" -e '/^#/d' debian/patches/series
done
for i in $(<debian/patches/series); do
  patch -p1 --verbose --backup --suffix=".pdeb" -i debian/patches/${i}
done

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
