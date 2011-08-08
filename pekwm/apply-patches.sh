
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
sed -e "s,_SLK_DIST,${SLKDIST},g" ${SB_PATCHDIR}/${NAME}-menu-slk.patch | \
  patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.1.11-xdg.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
