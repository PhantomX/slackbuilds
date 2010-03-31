
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# RH bug #243296
zcat ${SB_PATCHDIR}/${NAME}-1.11.5-fix-64bit-acinclude.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
