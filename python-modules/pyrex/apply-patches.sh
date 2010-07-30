
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-0.9.6.4-setuptools-workaround.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
