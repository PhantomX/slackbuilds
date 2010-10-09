
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# RH bug #243296
zcat ${SB_PATCHDIR}/${NAME}-1.11.5-fix-64bit-acinclude.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
