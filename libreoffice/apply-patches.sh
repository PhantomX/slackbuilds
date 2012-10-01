
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

( cd ${PKG}/usr/lib${LIBDIRSUFFIX}/${NAME}/program
  # Support /etc/default/${NAME}
  patch -p0 --backup -z .orig --verbose -i ${CWD}/patches/${NAME}-defaults.patch
  rm -vf *.orig
)
( cd ${PKG}/usr/lib${LIBDIRSUFFIX}/${NAME}/share/fonts/truetype
  # Fix for fontconfig 2.10
  patch -p0 --backup -z .orig --verbose -i ${CWD}/patches/${NAME}-fontconfig.patch
  rm -vf *.orig
)

set +e +o pipefail
