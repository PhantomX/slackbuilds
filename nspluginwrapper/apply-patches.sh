
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.4.4-make.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.0-directory.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.0-compiz.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.0-comp.patch
THREAD_LIBS=$(pkg-config --libs gthread-2.0)
sed -e "s/__PTHREAD_LIBS__/${THREAD_LIBS}/" ${SB_PATCHDIR}/${NAME}-pthread.patch > pthread.patch
patch -p1 -b --suffix .version --fuzz=0 -i pthread.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-arm.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.4.4-restart.patch
( cd ${PCSRCDIR}
  patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/plugin-config-setuid.patch
  patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/plugin-config-umask.patch
  patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/plugin-config-print.patch
  patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/plugin-config-non-native.patch
  patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/plugin-config-time-check.patch
  patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/plugin-config-help.patch
)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/plugin-config-dlopen.patch

set +e +o pipefail
