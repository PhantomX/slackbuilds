
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Fix /usr/local paths and libdir paths
sed -e "s#@SLACK_LIBDIR@#/usr/lib${LIBDIRSUFFIX}/#g" ${SB_PATCHDIR}/lynx.path.diff \
 | patch -p1 --verbose

# Apply recolorizing patch:
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lynx.cfg.diff

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lynx-build-fixes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lynx-CVE-2008-4690.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lynx-2.8.7-bm-del.patch

set +e +o pipefail
