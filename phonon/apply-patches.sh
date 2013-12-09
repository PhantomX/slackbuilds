
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/phonon-4.7.0-rpath_use_link_path.patch 
# workaround cmake bogosity calculating relative dirs + /usr-move
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/phonon-4.7.0-rootDir.patch

set +e +o pipefail
