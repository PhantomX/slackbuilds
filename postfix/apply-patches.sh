
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.7.0-config.patch
zcat ${SB_PATCHDIR}/${NAME}-2.6.1-files.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-alternatives.patch
zcat ${SB_PATCHDIR}/${NAME}-large-fs.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
