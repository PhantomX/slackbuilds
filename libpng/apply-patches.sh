
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/libpng-1.2.36-pngconf-setjmp.patch.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/libpng-1.4.0-multilib.patch.gz | patch -p0 --verbose
zcat ${SB_PATCHDIR}/libpng14-enable-read-dither.patch.gz | patch -p1 --verbose

set +e +o pipefail
