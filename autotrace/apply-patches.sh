
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## Debian
for patch in $(< debian/patches/series) ;do
  patch -p1 -E --backup --verbose -i debian/patches/${patch}
done

## Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0001-Modify-GetOnePixel-usage-to-build-against-current-Im.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0002-Fixed-underquoted-AM_PATH_AUTOTRACE-definition.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.31.1-CVE-2013-1953.patch

## Gentoo
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.31.1-pkgconfig.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.31.1-swf-output.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.31.1-libpng14.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.31.1-libpng-1.5.patch

# Multilib and overlinking fix
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.31.1-multilib.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
