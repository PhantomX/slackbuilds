
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tilda-0.9.6-fix-glib-include.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tilda-0.9.6-fix-pointers.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tilda-0.9.6-add-xrandr.patch

set +e +o pipefail
