
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# kde#339144
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Prevent-crash-if-index-if-out-of-QList-range.patch

set +e +o pipefail
