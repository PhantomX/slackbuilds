
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-fix-supported-format-check-for-libe-book.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-fix-return-value.patch

set +e +o pipefail
