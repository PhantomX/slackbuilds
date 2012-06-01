
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libdb-multiarch.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/db-4.6.21-1.85-compat.patch
#zcat ${SB_PATCHDIR}/db-4.5.20-jni-include-dir.patch.gz | patch -p1 -E --backup --verbose

( cd ${DBCSRCDIR}
  if [ "${DBCPATCHLEVEL}" -gt 0 ] ;then
    for i in $( seq -w 2 ${DBCPATCHLEVEL} ) ; do
      patch -p0 --backup --verbose -i ${SB_PATCHDIR}/updates/patch.1.${i}
    done
  fi
  zcat ${SB_PATCHDIR}/db-1.85-errno.patch.gz | patch -p1 -E --backup --verbose
  cd PORT/linux
  patch -p0 --backup --verbose -i ${SB_PATCHDIR}/updates/patch.1.1
)

set +e +o pipefail
