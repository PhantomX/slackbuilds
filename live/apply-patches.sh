
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i  ${SB_PATCHDIR}/live-recursive.patch
zcat ${SB_PATCHDIR}/live-safe_setlocale.diff.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/live-2010.01.15-gcc44.patch.gz | patch -p0 -E --backup --verbose 

set +e +o pipefail
