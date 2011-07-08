
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-prefix.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-prefix.patch

set +e +o pipefail
