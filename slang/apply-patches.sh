
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# fix file permissions, library symlink, parallel build, remove RPATH
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.2.3-makefile.patch

set +e +o pipefail
