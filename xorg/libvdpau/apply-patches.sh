
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/link-with-libx11.patch
#sed -e "s|/lib/|/lib${LIBDIRSUFFIX}/|g" \
#  ${SB_PATCHDIR}/vdpau-module-searchpath.patch | patch -p1 -E --backup --verbose

set +e +o pipefail
