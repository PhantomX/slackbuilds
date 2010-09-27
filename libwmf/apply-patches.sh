
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/libwmf-0.2.8.3-relocatablefonts.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/libwmf-0.2.8.4-fallbackfont.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/libwmf-0.2.8.4-deps.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/libwmf-0.2.8.4-multiarchdevel.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/libwmf-0.2.8.4-intoverflow.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/libwmf-0.2.8.4-reducesymbols.patch.gz | patch -p1 -E --backup --verbose
# CVE-2009-1364, Use-after-free vulnerability in the modified embedded GD library
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libwmf-0.2.8.4-useafterfree.patch
# adapt to standalone gdk-pixbuf
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libwmf-0.2.8.4-pixbufloaderdir.patch
zcat ${SB_PATCHDIR}/libwmf-libpng14.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
