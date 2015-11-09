
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.7-alpha1-xmms-skindir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6-ladspa.patch

set +e +o pipefail
