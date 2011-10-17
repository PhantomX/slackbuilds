
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-0.7.3-desktop.patch.gz | patch -p0 -E --backup --verbose
[ -f ${CWD}/${NAME}-pt_BR.po.gz ] && zcat ${SB_PATCHDIR}/${NAME}-0.7.4-pt_BR.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
