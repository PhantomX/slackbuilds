
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.12.0-rpath.patch
zcat ${SB_PATCHDIR}/${NAME}-user-cflags.patch.gz | patch -p1 -E --backup --verbose
# Fix for RHBZ#691896.  This is upstream in 3.12.1.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0007-Fix-ocamlopt-w.r.t.-binutils-2.21.patch

set +e +o pipefail
