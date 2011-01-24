
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix_plugin_path.patch
for i in $(< debian/patches/series); do
  patch -p1 --verbose --backup --suffix=".pdeb" < debian/patches/${i}
done

set +e +o pipefail
