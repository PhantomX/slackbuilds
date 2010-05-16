
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-20090224-pythondl.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-20090923-libpng14.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
