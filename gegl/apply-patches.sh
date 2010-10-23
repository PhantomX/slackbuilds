
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# "process: don't leak each node set on a GeglProcessor"
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gegl-0.1.2-processor-leak.patch
# avoid buffer overflow in gegl_buffer_header_init()
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gegl-0.1.2-buffer-save-overflow.patch
# don't leak "root" symbol which clashes with equally broken 3rd party input
# methods (xvnkb)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gegl-0.1.2-leaked-symbol.patch

set +e +o pipefail
