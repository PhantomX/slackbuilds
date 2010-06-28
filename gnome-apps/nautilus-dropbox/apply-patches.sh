
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
sed -e "s|_LIBDIR_|/usr/lib${LIBDIRSUFFIX}|g" ${SB_PATCHDIR}/${NAME}-0.6.2-system-daemon.patch \
  | patch -p0 -E --backup --verbose

set +e +o pipefail
