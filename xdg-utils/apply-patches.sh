
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
if [ "${SNAPBUILD}" = "YES" ] ;then
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-htmlview.patch
else
  sed -e 's|scripts/xdg-open.in|scripts/xdg-open|g' \
    ${SB_PATCHDIR}/${NAME}-htmlview.patch | patch -p1 -E --backup --verbose
fi

set +e +o pipefail
