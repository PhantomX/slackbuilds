
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/libtiff-mantypo.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/libtiff-scanlinesize.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libtiff-getimage-64bit.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libtiff-ycbcr-clamp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libtiff-3samples.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libtiff-subsampling.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libtiff-unknown-fix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libtiff-checkbytecount.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libtiff-tiffdump.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libtiff-CVE-2011-0192.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libtiff-CVE-2011-1167.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libtiff-gif2tiff-overrun.patch

set +e +o pipefail
