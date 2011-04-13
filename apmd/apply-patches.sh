
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
#zcat ${SB_PATCHDIR}/${NAME}-3.2-build.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-3.2-umask.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-3.2-error.patch.gz | patch -p1 -E --backup --verbose
if [ "${SB_X}" != "YES" ] ;then
  zcat ${SB_PATCHDIR}/${NAME}-3.2-x.patch.gz | patch -p1 -E --backup --verbose
fi
set +e +o pipefail
