
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/wxGTK-2.8.7-mmedia.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup -z odbc --verbose -i ${SB_PATCHDIR}/wxGTK-2.8.11-unicode-odbc.patch

set +e +o pipefail
