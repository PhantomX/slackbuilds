
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-2.0-no-blanks-on-data-names.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
