
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Upstream patches
sed \
  -e "s/__RPM_VERSION_INTERNAL__/${IC_DIR_VER}/" \
  ${SB_PATCHDIR}/firefox-version.patch | patch -p1 -E --backup --verbose

set +e +o pipefail
