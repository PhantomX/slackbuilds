
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Data files should be installed with timestamps preserved
zcat ${SB_PATCHDIR}/llvm-2.6-timestamp.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
