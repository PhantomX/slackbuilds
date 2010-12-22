
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
sed -e "s|_LIBDIR_|/usr/lib${LIBDIRSUFFIX}|g" ${SB_PATCHDIR}/${NAME}-0.4.5-system-daemon.patch \
 | patch -p1 -E --backup -z .paths --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.4.5-po.patch

set +e +o pipefail
