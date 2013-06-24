
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
mv src/luaconf.h src/luaconf.h.template.in
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lua-5.2.2-autotoolize.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lua-5.2.2-idsize.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lua-5.2.2-luac-shared-link-fix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lua-5.2.2-configure-compat-module.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lua-5.2.2-configure-linux.patch

set +e +o pipefail
