
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/avoid-using-ext2_fs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/handle-ctors-dtors-via-init_array-and-fini_array.patch

set +e +o pipefail
