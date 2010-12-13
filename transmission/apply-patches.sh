
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
sed -e "s|_PKGDATADIR_|/usr/share/${NAME}|g" ${SB_PATCHDIR}/${NAME}-qt-ts-dir.patch \
  | patch -p0 -E --backup --verbose

set +e +o pipefail
