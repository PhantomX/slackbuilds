
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.20.51.0.2-libtool-lib64.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.20.51.0.2-version.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.20.51.0.2-set-long-long.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.20.51.0.10-copy-osabi.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.20.51.0.10-sec-merge-emit.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.22.52.0.1-relro-on-by-default.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.22.52.0.1-export-demangle.h.patch
# Disable checks that config.h has been included before system headers.  BZ #845084
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.22.52.0.4-no-config-h-check.patch
# Fix decoding of abstract instance names using DW_FORM_ref_addr.
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.24-DW_FORM_ref_addr.patch
# Fix compiling using gcc 4.9
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.24-set-section-macros.patch
# Fix detections of uncompressed .debug_str sections that look like they have been compressed.
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.24-fake-zlib-sections.patch
# Fix detections little endian PPC shared libraries
#patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.24-ldforcele.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.24-corrupt-binaries.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.24-strings-default-all.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.24-corrupt-ar.patch

set +e +o pipefail
