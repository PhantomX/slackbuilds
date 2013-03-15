
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/qdbm-1.8.77-ruby1.9.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
