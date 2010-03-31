
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/user-segfault.patch.gz | patch -p0 -E --backup --verbose || exit 1
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.8.1-categories.patch

set +e +o pipefail
