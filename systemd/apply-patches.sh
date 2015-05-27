
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
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/udev-microsoft-3000-keymap.patch
# From Slackware
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/60-cdrom_id.rules.diff

# Upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-udev-net_id-Only-read-the-first-64-bytes-of-PCI-conf.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-bootctl-ferror-must-be-called-before-FILE-is-closed.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-bootctl-fix-an-error-check.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-udevd-worker-fully-clean-up-unnecessary-fds.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-udevd-worker-modernize-a-bit.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-udevd-event-fix-event-queue-in-daemenozied-mode.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-shared-generator-correct-path-to-systemd-fsck.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-udev-fix-inotify-handling.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-treewide-fix-typos.patch

### Fedora

### Arch

### Debian
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Don-t-enable-audit-by-default.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
