
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0721-make.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0751-locale.patch

set +e +o pipefail
