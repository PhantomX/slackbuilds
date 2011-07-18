
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.9.2.1-gnome_ini.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix_libdir.patch

set +e +o pipefail
