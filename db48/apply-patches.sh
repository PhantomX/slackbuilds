
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
if [ "${PATCHLEVEL}" -gt 0 ] ;then
  for i in $( seq -w ${PATCHLEVEL} ) ; do
    patch -p0 --backup --verbose -i ${SB_PATCHDIR}/updates/patch.${SVER}.${i} || exit 1
  done
fi

zcat ${SB_PATCHDIR}/db-4.6.21-1.85-compat.patch.gz | patch -p1 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/db-4.5.20-jni-include-dir.patch.gz | patch -p1 -E --backup --verbose || exit 1

( cd ${DBCSRCDIR} || exit 1
  if [ "${DBCPATCHLEVEL}" -gt 0 ] ;then
    for i in $( seq -w 2 ${DBCPATCHLEVEL} ) ; do
      patch -p0 --backup --verbose -i ${SB_PATCHDIR}/updates/patch.1.${i} || exit 1
    done
  fi
  zcat ${SB_PATCHDIR}/db-1.85-errno.patch.gz | patch -p1 -E --backup --verbose || exit 1
  cd PORT/linux || exit 1
  patch -p0 --backup --verbose -i ${SB_PATCHDIR}/updates/patch.1.1
)



set +e +o pipefail
