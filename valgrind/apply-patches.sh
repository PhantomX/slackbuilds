
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

### Fedora
ApplyPatch ${NAME}-3.9.0-cachegrind-improvements.patch
# KDE#211352 - helgrind races in helgrind's own mythread_wrapper
ApplyPatch ${NAME}-3.9.0-helgrind-race-supp.patch
ApplyPatch ${NAME}-3.9.0-ldso-supp.patch
# KDE#371396 - workaround helgrind and drd pth_cond_destroy_busy testcase hangs
ApplyPatch ${NAME}-3.12.0-skip-cond-var.patch
# RHBZ#1390282 upstream svn r16134
# Cleanup none/tests/nocwd.vgtest tmp dirs.
ApplyPatch ${NAME}-3.12.0-nocwd-cleanup.patch

### Arch

set +e +o pipefail
