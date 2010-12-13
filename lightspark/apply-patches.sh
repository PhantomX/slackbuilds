
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.4.4.3-cmakelists.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.4.5-allow-disabling-pulseaudio.patch

set +e +o pipefail
