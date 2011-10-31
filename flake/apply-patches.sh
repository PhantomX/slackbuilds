
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .shared --verbose -i ${SB_PATCHDIR}/${NAME}-0.11-shared.patch

set +e +o pipefail
