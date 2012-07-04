
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/track_dynamic_library_handles_and_free_them_on_exit.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/link-with-libx11.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/simplify-dlopen-path-length-error-handling.patch
sed -e "s|/lib/|/lib${LIBDIRSUFFIX}/|g" \
  ${SB_PATCHDIR}/vdpau-module-searchpath.patch | patch -p1 -E --backup --verbose
# http://lists.freedesktop.org/archives/vdpau/2012-May/000022.html
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/z_bluefaces.patch

set +e +o pipefail
