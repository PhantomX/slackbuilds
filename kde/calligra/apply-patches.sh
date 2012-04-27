
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# scripts missed tables->sheets rename
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/calligra-2.3.92-tables_to_sheets.patch

set +e +o pipefail
