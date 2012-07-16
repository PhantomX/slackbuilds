
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-gcc44.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-cflags.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
