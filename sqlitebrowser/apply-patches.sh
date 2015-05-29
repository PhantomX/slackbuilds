
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}_unbundle.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}_skiptest.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}_build.patch

set +e +o pipefail
