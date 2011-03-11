
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}.smaller.min.height.diff.gz | patch -p1 -E --backup --verbose
#zcat ${SB_PATCHDIR}/${NAME}-1.1-20070227-incdir.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.1-20071028-multilib.patch.gz | patch -p1 -E --backup --verbose
#zcat ${SB_PATCHDIR}/${NAME}-1.1-20071028-libs.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
