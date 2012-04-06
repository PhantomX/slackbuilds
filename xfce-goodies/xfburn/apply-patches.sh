
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
for i in $(<debian/patches/series); do
  patch -p1 --verbose --backup --suffix=".pdeb" -i debian/patches/${i}
done
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/xfburn-0.4.3-update_desktop_entry.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/xfburn-0.4.3-empty_directory_segmentation_fault-2.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/xfburn-0.4.3-gobject_h.patch

set +e +o pipefail
