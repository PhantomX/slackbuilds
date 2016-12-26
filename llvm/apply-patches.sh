
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
ApplyPatch 0001-This-code-block-breaks-the-docs-build-http-lab.llvm..patch
ApplyPatch 0001-fix-docs-2.patch
ApplyPatch 0001-fix-docs-3.patch
ApplyPatch 0001-docs-fix-cmake-code-block-warning.patch
# backport from upstream to fix lldb out of tree
ApplyPatch 0001-cmake-Install-CheckAtomic.cmake-needed-by-lldb.patch
# backports cribbed from https://github.com/rust-lang/llvm/
ApplyPatch rust-lang-llvm-pr47.patch
ApplyPatch rust-lang-llvm-pr48.patch
ApplyPatch rust-lang-llvm-pr51.patch
ApplyPatch rust-lang-llvm-pr53.patch
ApplyPatch rust-lang-llvm-pr54.patch
ApplyPatch rust-lang-llvm-pr55.patch
ApplyPatch rust-lang-llvm-pr57.patch

set +e +o pipefail
