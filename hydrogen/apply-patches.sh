
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

patch -p1 -E --backup -z .tinyxml --verbose -i ${SB_PATCHDIR}/${NAME}-system-tinyxml.patch
rm -rf libs/hydrogen/src/xml

patch -p0 < patches/portaudio.patch
# portmidi-200 needs a new patch.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-portmidi-200.patch
# Fix DSO linking.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-linking.patch
# Fix ladspa plugin path in 64bit systems
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-lib64.patch
# Fix wasp ladspa plugin linking
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wasp-linking.patch
# Fix qt-4.7 build issue
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-qt47.patch

set +e +o pipefail
