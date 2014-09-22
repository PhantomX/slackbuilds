
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

## upstreamable patches

## upstream patches
# kde bugs 325580, 339210
patch -p1 -E --backup --verbose -d core -i ${SB_PATCHDIR}/digikam-4.3.0-fix-job-crash.patch

set +e +o pipefail
