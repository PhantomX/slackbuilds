
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

( cd xc
  zcat ${CWD}/${PSRCARCHIVE} | patch -p1 -E --backup -z .pdeb --verbose
  for patch in $(< debian/patches/00list) ;do
    patch -p1 -E --backup -z .pdeb --verbose -i debian/patches/${patch}.dpatch
  done
  sed -i -e '/^SOXAWREV = 6.1/d' lib/Xaw3d/Imakefile
)
find . -type f -name '*.pdeb' -size 0 -print0 | xargs -0 rm -f
ln -s .. xc/lib/Xaw3d/X11
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xaw3d.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Xaw3d-ia64.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Xaw3d-1.5E-warnings.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Xaw3d-1.5E-3Dlabel.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Xaw3d-1.5E-compat.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Xaw3d-1.5E-fontset.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Xaw3d-1.5E-hsbar.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Xaw3d-1.5E-null.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Xaw3d-1.5E-thumb.patch

set +e +o pipefail
