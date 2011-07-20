
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Report partitions changes when using blkext major numbers
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/parted-2.3-lpn.patch
# Document the align-check command
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/parted-2.3-Document-align-check-642476.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/parted-3.0-libparted-fix-snap-radius-so-that-it-is-using-half.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/parted-3.0-libparted-don-t-allow-values-less-than-1.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/parted-3.0-tests-add-test-for-radius-divide-by-2-fix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/parted-3.0-tests-add-test-for-value-less-than-1.patch
# Fix for kernel 3.0 new version numbering.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/parted-3.0-libparted-accommodate-two-component-linux-version-nu.patch

set +e +o pipefail
