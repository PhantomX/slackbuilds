
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

patch -p1 -E --backup -z .tinyxml --verbose -i ${SB_PATCHDIR}/${NAME}-system-tinyxml.patch
rm -rf libs/hydrogen/src/xml

patch -p0 < patches/portaudio.patch

set +e +o pipefail
