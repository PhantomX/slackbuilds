
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

if [ "${PATCHLEVEL}" -gt 0 ] ;then
  for i in $( seq -w ${PATCHLEVEL} ) ; do
    patch -p0 -i ${SVER//.}u${i}.diff
  done
fi

[ -f ${SB_PATCHDIR}/${HSSRCARCHIVE}.patch ] && cp -f ${SB_PATCHDIR}/${HSSRCARCHIVE}.patch ${HSSRCARCHIVE}.diff
[ "${SB_HS}" = "YES" ] && patch -p0 -E --backup -z .hiscore --verbose -i ${HSSRCARCHIVE}.diff

patch -p0 -E --backup -z .inline --verbose -i ${SB_PATCHDIR}/sdlmame-inline.patch

set +e +o pipefail
