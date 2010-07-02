
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-prefix.patch
zcat ${SB_PATCHDIR}/${NAME}-prefix.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
