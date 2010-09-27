
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
if [ "${ARCH}" = "x86_64" ] ;then
  zcat ${SB_PATCHDIR}/${NAME}-multishlib.patch.gz | patch -p1 -E --backup --verbose
fi

set +e +o pipefail
