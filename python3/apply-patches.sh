
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Set to test (some patches require others, so, is not 100%)
PATCH_DRYRUN=${PATCH_DRYRUN:-NO}

unset PATCH_DRYRUN_OPT PATCH_VERBOSE_OPT

[ "${PATCH_DRYRUN}" = "YES" ] && PATCH_DRYRUN_OPT="--dry-run"
[ "${PATCH_VERBOSE}" = "YES" ] && PATCH_VERBOSE_OPT="--verbose"
[ "${PATCH_SVERBOSE}" = "YES" ] && set -o xtrace

PATCHCOM="patch ${PATCH_DRYRUN_OPT} -p1 -F1 -s ${PATCH_VERBOSE_OPT}"

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

# From Gentoo
for patches in \
  04_all_non-zero_exit_status_on_failure.patch \
  05_all_regenerate_platform-specific_modules.patch \
  21_all_distutils_c++.patch \
  24_all_expat-2.2.patch \
  ;do
  patch -p0 --backup --verbose -i patches/${patches}
done

### Fedora
ApplyPatch Python-3.1.1-rpath.patch
if [ "${ARCH}" = "x86_64" ]; then
  ApplyPatch 00102-lib64.patch
  ApplyPatch 00104-lib64-fix-for-test_install.patch
fi
ApplyPatch 00111-no-static-lib-slk.patch
ApplyPatch 00155-avoid-ctypes-thunks.patch
ApplyPatch 00157-uid-gid-overflows.patch
ApplyPatch 00178-dont-duplicate-flags-in-sysconfig.patch
ApplyPatch 00184-ctypes-should-build-with-libffi-multilib-wrapper.patch
ApplyPatch 00186-dont-raise-from-py_compile.patch
ApplyPatch 00205-make-libpl-respect-lib64.patch
ApplyPatch 00250-guard-HAVE_LONG_LONG-definition-to-prevent-redefinition.patch
# https://bugs.python.org/issue26470
ApplyPatch Port-Python-s-SSL-module-to-OpenSSL-1.1.0-5.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
