
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.2.4-perms.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-sighuptest.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-dupdeclaration.patch

set +e +o pipefail
