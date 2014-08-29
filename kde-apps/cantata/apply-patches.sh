
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.4.1-system-qtiocompressor.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.4.1-system-qxt.patch
# fix kde support (kde4_includes)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.3-kde4_includes.patch
# mae libsolidlite explicitly static
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.4-libsolid_static.patch
# avoid/fix crashes in icons.cpp
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.4.1-icons_crash.patch

# Menubar enabled by default
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.4.1-menubar.patch

set +e +o pipefail
