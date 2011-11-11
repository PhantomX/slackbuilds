
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

for patch in $(< debian/patches/series) ;do
  patch -p1 -E --backup --verbose -i debian/patches/${patch}
done
zcat ${SB_PATCHDIR}/${NAME}-0.31.1-GetOnePixel.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-aclocal18.patch.gz | patch -p0 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.31.1-pkgconfig.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.31.1-multilib.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.31.1-swf-output.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.31.1-libpng14.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.31.1-libpng-1.5.patch

set +e +o pipefail
