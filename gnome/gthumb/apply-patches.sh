
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# http://git.gnome.org/browse/gthumb/commit/?h=gthumb-2-12&id=8302e856dae93b2df1cdb56c7683485aaec7727c
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-correctly-activate-the-default-extensions-when-start.patch
# http://git.gnome.org/browse/gthumb/commit/?h=gthumb-2-12&id=42bb51756bc4e9d95ae01c004f050ca183573809
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Compile-with-fPIC-DPIC.patch
# http://git.gnome.org/browse/gthumb/commit/?h=gthumb-2-12&id=cc1ac5ee3a1f27040d310c24f55f6b76514f519c
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-fixed-crash-on-thumbnail-generation.patch
# http://git.gnome.org/browse/gthumb/commit/?h=gthumb-2-12&id=1834cea61050e476e97e3831538169a40af8a72f
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Enable-building-with-exiv2-0.21-349150.patch

set +e +o pipefail
