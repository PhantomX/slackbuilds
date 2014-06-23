
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Arch #40914
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-va-release-VADisplayContext-at-the-end-of-vaTerminat.patch

set +e +o pipefail
