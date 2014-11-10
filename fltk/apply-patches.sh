
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fltk-1.1.9-fltk_config.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fltk-1.1.8-fluid_desktop.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fltk-1.3.0-rh708185.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fltk-1.3.3-visibility.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/fltk-1.3.3-visibility-2.patch

set +e +o pipefail
