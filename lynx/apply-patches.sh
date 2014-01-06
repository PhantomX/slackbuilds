
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches
# Apply recolorizing patch:
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lynx.cfg.diff

# Adapted from Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lynx-2.8.8-slk.patch
### Fedora
patch -p1 -E --backup -z .build --verbose -i ${SB_PATCHDIR}/lynx-build-fixes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lynx-CVE-2008-4690.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lynx-2.8.8-locale.patch

set +e +o pipefail
