
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.20.51.0.2-libtool-lib64.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.25-version.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.25-set-long-long.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.20.51.0.10-copy-osabi.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.20.51.0.10-sec-merge-emit.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.22.52.0.1-relro-on-by-default.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.22.52.0.1-export-demangle.h.patch
# Disable checks that config.h has been included before system headers.  BZ #845084
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.22.52.0.4-no-config-h-check.patch
# Fix addr2line to use the dynamic symbol table if it could not find any ordinary symbols.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.23.52.0.1-addr2line-dynsymtab.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.25-kernel-ld-r.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.23.2-aarch64-em.patch
# Fix allocation of space for x86_64 PIE relocs.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/binutils-2.25-x86_64-pie-relocs.patch

set +e +o pipefail
