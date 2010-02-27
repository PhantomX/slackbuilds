
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# This patch removes the upstream restrictions on the GPLv2+ source
zcat ${SB_PATCHDIR}/${NAME}-copyright-notice.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Fixes some compilation errors with gcc 4.4
zcat ${SB_PATCHDIR}/${NAME}-gcc44.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Adds support for ClamAV > 0.95
zcat ${SB_PATCHDIR}/${NAME}-clamav095.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Fix some typos ;) (Bug #515363)
zcat ${SB_PATCHDIR}/${NAME}-must-be-successful.patch.gz | patch -p1 -E --backup --verbose || exit 1

set +e +o pipefail
