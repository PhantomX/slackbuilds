
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/phonon-4.7.0-rpath_use_link_path.patch 
# workaround cmake bogosity calculating relative dirs + /usr-move
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/phonon-4.7.0-rootDir.patch

## upstream patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-sync-FindQt4-from-kdelibs-master-to-unbreak-build-wi.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-don-t-emit-backendchanged-when-we-have-no-backend.patch

set +e +o pipefail
