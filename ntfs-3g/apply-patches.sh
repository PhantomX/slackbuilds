
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-1.2216-nomtab.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2010.8.8-context-mount-option.patch
zcat ${SB_PATCHDIR}/mount-readlink-hang-workaround.diff.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
