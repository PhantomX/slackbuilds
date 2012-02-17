
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.0-alpha1-xmms-skindir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.1-beta1-ladspa.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.2-beta1-gmodule-pkgconfig.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-ffmpeg.patch

set +e +o pipefail
