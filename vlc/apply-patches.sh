
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/vlc-trunk-default_font.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/0001-Default-libv4l2-to-true.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/020_all_check_headers_regexps.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/300_all_pic.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/320_all_cachegen.patch
sed -i.dmo_pic -e 's/fno-PIC/fPIC/' libs/loader/Makefile.in
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/vlc-1.1.7-removed-mkv-header.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vlc-1.1.7-libnotify-0.7.patch

set +e +o pipefail
