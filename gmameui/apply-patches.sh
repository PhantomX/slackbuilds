
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.2.12-glib2.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.2.12-libarchive.patch

set +e +o pipefail
