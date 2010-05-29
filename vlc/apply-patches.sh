
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/vlc-trunk-default_font.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/0001-Default-libv4l2-to-true.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/300_all_pic.patch
sed -i.dmo_pic -e 's/fno-PIC/fPIC/' libs/loader/Makefile.in

set +e +o pipefail
