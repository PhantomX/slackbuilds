
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/arts-acinclude.patch.gz | patch -p1 --verbose --backup
zcat ${SB_PATCHDIR}/kdesdk-3.5.10-gcc44.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/kdesdk-3.5.7-subversion.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
