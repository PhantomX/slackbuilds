
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.10-hardcoded_cc.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.20-gcc47-test7-workaround.patch

set +e +o pipefail
