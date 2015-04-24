
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

### Fedora
ApplyPatch fedora-disable-resolv.conf-symlink.patch
ApplyPatch fedora-add-bridge-sysctl-configuration.patch

### Arch
ApplyPatch 0001-tmpfiles-avoid-creating-duplicate-acl-entries.patch
ApplyPatch 0001-tmpfiles-quietly-ignore-ACLs-on-unsupported-filesyst.patch
ApplyPatch 0001-nspawn-when-connected-to-pipes-for-stdin-stdout-pass.patch
ApplyPatch 0001-core-shared-in-deserializing-match-same-files-reache.patch
ApplyPatch 0001-tmpfiles-Fix-handling-of-duplicate-lines.patch
ApplyPatch 0001-core-do-not-spawn-jobs-or-touch-other-units-during-c.patch
ApplyPatch 0001-use-x-machine-unix-prefix-for-the-container-bus-on-dbus1.patch
ApplyPatch 0001-core-rework-device-state-logic.patch
ApplyPatch 0001-unit-use-weaker-dependencies-between-mount-and-devic.patch
ApplyPatch 0001-core-don-t-change-removed-devices-to-state-tentative.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
