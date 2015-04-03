
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .droid --verbose -i ${SB_PATCHDIR}/${NAME}-2.73-droid.patch

set +e +o pipefail
