
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-3.6-getcwd.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6-gettextfix.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6-as-if.patch
zcat ${CWD}/${PSRCARCHIVE} | patch -p1 -E --backup --verbose
#sed -i '1i#include ' src/argmatch.c

set +e +o pipefail
