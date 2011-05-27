
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Build patches
sed \
  -e "s/__RPM_VERSION_INTERNAL__/${FF_DIR_VER}/" \
  ${SB_PATCHDIR}/firefox-version.patch | patch -p1 -E --backup --verbose

patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-stub.patch

# Upstream patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-4.0-moz-app-launcher.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-4.0-gnome3.patch

set +e +o pipefail
