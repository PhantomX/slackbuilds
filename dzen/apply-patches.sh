
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
if [ "${SNAPBUILD}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/${NAME}-svn-option.patch.gz | patch -p0 -E --backup --verbose
else
  zcat ${SB_PATCHDIR}/${NAME}-0.8.5-option.patch.gz | patch -p0 -E --backup --verbose
fi

set +e +o pipefail
