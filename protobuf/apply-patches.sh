
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-2.2.0-fedora-gtest.patch.gz | patch -p2 -E --backup --verbose

set +e +o pipefail
