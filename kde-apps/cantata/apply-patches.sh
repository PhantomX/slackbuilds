
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.4-system-qtiocompressor.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.4-system-qxt.patch
# mae libsolidlite explicitly static
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.4-libsolid_static.patch

set +e +o pipefail
