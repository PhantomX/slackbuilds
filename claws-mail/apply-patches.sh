
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
if [ "${PVER}" != "0" ] ;then
  for i in ${PVER} ; do
    patch -p0 --backup --verbose -i ${SB_PATCHDIR}/updates/${NAME}-${VERSION}-cvs${i}.patch
  done
fi

zcat ${SB_PATCHDIR}/11mark_trashed_as_read.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
