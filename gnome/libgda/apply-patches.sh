
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.99.8-lib64.patch
zcat ${SB_PATCHDIR}/${NAME}-3.0.0-man.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.99.8-lib64.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.2.4-sqlite3.patch

set +e +o pipefail
