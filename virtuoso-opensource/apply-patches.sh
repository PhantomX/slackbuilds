
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-6.1.0-external_iodbc.patch
zcat ${SB_PATCHDIR}/${NAME}-6.1.0-nodemos_buildfix.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
