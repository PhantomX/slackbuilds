
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fix POD, CPAN RT #54410
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-1.05-pod-errors.patch
# Fix POD, CPAN RT #54410
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-1.05-spelling.patch
# Fix POD, CPAN RT #11659
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-1.05-pod_item.patch

set +e +o pipefail
