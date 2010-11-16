
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-0.4.3-png14.patch.gz | patch -p0 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.4.3-gtk.patch
patch -p0 -E --backup -z .libdir --verbose -i ${SB_PATCHDIR}/${NAME}-0.4.3-libdir.patch

set +e +o pipefail
