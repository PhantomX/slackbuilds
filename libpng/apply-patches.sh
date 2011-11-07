
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
sed -e "s|_VER_|${SVER//.}|g" ${SB_PATCHDIR}/libpng-multilib.patch | \
  patch -p1 -E --backup --verbose

set +e +o pipefail
