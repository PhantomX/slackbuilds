
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
#zcat ${SB_PATCHDIR}/${NAME}-1.6.0-deplibs.patch.gz | patch -p1 -E --backup --verbose
#zcat ${SB_PATCHDIR}/${NAME}-1.6.1-rpath.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.6.11-pie.patch
if [ "${SB_JAVA}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/${NAME}-1.1.3-java.patch.gz | patch -p1 -E --backup --verbose
fi
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.6.6-kwallet.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.6.12-disable-client-test.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-MakeMaker.patch

set +e +o pipefail
