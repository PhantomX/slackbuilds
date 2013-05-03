
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .fix --verbose -i ${SB_PATCHDIR}/${NAME}-5.0.2-fixes.patch

set +e +o pipefail
