
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.11.65-python27.patch
zcat ${SB_PATCHDIR}/${NAME}-2.21.2-gcc44-relocate.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
