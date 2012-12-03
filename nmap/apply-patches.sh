
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-4.03-mktemp.patch.gz | patch -p1 -E --backup --verbose
# rhbz#637403, workaround for rhbz#621887=gnome#623965
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/zenmap-621887-workaround.patch

set +e +o pipefail
