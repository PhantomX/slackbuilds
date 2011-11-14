
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-1.5-gcc44.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.5-plugindir.patch.gz | sed \
  -e "s|%PUT_PLUGIN_PATH_HERE%|/usr/lib${LIBDIRSUFFIX}/mupen64plus/|g" | \
  patch -p1 -E --backup --verbose || exit 1
  
set +e +o pipefail
