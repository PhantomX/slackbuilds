
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-config.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.2.4.Makefile.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/nessus-config-multi.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
