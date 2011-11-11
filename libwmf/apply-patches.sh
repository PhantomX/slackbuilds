
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
# CVE-2007-0455
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libwmf-0.2.8.4-CVE-2007-0455.patch
# CVE-2007-3472
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libwmf-0.2.8.4-CVE-2007-3472.patch
# CVE-2007-3473
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libwmf-0.2.8.4-CVE-2007-3473.patch
# CVE-2006-2906 affects GIFs, which is not implemented here
# CVE-2006-4484 affects GIFs, which is not implemented here
# CVE-2007-3474 affects GIFs, which is not implemented here
# CVE-2007-3475 affects GIFs, which is not implemented here
# CVE-2007-3476 affects GIFs, which is not implemented here
# CVE-2007-3477
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libwmf-0.2.8.4-CVE-2007-3477.patch
# CVE-2007-3478 affects shared ttf files across threads, which is not implemented here
# CVE-2007-2756
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libwmf-0.2.8.4-CVE-2007-2756.patch
# CAN-2004-0941
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libwmf-0.2.8.4-CAN-2004-0941.patch
# CVE-2009-3546
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libwmf-0.2.8.4-CVE-2009-3546.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libwmf-0.2.8.4-pngfix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libwmf-0.2.8.4-libpng-1.5.patch

set +e +o pipefail
