
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
[ "${SNAPBUILD}" = "YES" ] || sed -e "s|_INCDIR_|/usr/include/vdr|g" ${SB_PATCHDIR}/${NAME}-makefile.patch \
  | patch -p1 -E --backup -z .mkfix --verbose

set +e +o pipefail
