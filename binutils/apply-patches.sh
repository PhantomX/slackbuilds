
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

unset PATCH_VERBOSE_OPT
[ "${PATCH_VERBOSE}" = "YES" ] && PATCH_VERBOSE_OPT="--verbose"
[ "${PATCH_SVERBOSE}" = "YES" ] && set -o xtrace

PATCHCOM="patch -p1 -s -F1 --backup ${PATCH_VERBOSE_OPT}"

ApplyPatch() {
  local patch=$1
  shift
  if [ ! -f ${SB_PATCHDIR}/${patch} ]; then
    exit 1
  fi
  echo "Applying ${patch}"
  case "${patch}" in
  *.bz2) bzcat "${SB_PATCHDIR}/${patch}" | ${PATCHCOM} ${1+"$@"} ;;
  *.gz) zcat "${SB_PATCHDIR}/${patch}" | ${PATCHCOM} ${1+"$@"} ;;
  *) ${PATCHCOM} ${1+"$@"} -i "${SB_PATCHDIR}/${patch}" ;;
  esac
}

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
ApplyPatch binutils-2.20.51.0.2-libtool-lib64.patch
ApplyPatch binutils-2.25-version.patch
ApplyPatch binutils-2.25-set-long-long.patch
ApplyPatch binutils-2.20.51.0.10-sec-merge-emit.patch
ApplyPatch binutils-2.22.52.0.1-relro-on-by-default.patch
ApplyPatch binutils-2.22.52.0.1-export-demangle.h.patch
# Disable checks that config.h has been included before system headers.  BZ #845084
ApplyPatch binutils-2.22.52.0.4-no-config-h-check.patch
# Fix addr2line to use the dynamic symbol table if it could not find any ordinary symbols.
ApplyPatch binutils-2.23.52.0.1-addr2line-dynsymtab.patch

ApplyPatch binutils-2.25.1-cleansweep.patch -p0
ApplyPatch binutils-2.26-fix-compile-warnings.patch
# Import H.J.Lu's Kernel LTO patch.
ApplyPatch binutils-2.26-lto.patch
# Fix computation of sh_info field for .dynsym sections
ApplyPatch binutils-2.27-local-dynsym-count.patch
# Put sections in a monotonically increasing order of file offset.
ApplyPatch binutils-2.27-monotonic-section-offsets.patch
# Make ARM and AArch64 ports properly support relro on by default.
ApplyPatch binutils-2.27-arm-aarch64-default-relro.patch
# Skip PR14918 linker test for ARM native targets.
ApplyPatch binutils-2.27-skip-rp14918-test-for-arm.patch
# Fix GOLD for ARM/AARCh64.
ApplyPatch binutils-2.28-gold.patch -p0
# Improve objdump's disassembly of dynamic executables.
ApplyPatch binutils-2.27-objdump-improvements.patch
# Improve objdump's speed when mixing disassembly with source code
ApplyPatch binutils-2.27-dwarf-parse-speedup.patch

set +e +o pipefail
