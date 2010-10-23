
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
if [ "${PATCHLEVEL}" -gt 0 ] ;then
  for i in $( seq -w ${PATCHLEVEL} ) ; do
    patch -p0 -i ${SVER//.}u${i}.diff
  done
fi

if [ "${SB_GCONF}" != "YES" ] ;then
  patch -p0 -E --backup -z .nogconf --verbose -i ${SB_PATCHDIR}/sdlmame-0.139.u4-nogconf.patch
fi

set +e +o pipefail
