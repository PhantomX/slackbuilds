
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.8.9-fix-handlers-vector-length.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.8.9-destroy-movieroot-before-clearing-moviefactory.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.8.9-scripting-support-fixes.patch

set +e +o pipefail
