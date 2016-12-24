
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
ApplyPatch udev-microsoft-3000-keymap.patch -p0
# From Slackware
ApplyPatch 60-cdrom_id.rules.diff -p0

# Upstream
( SB_PATCHDIR=backports
  [ -f ${CWD}/${PSRCARCHIVES} ] || exit 0
  mkdir -p backports
  cp ${DOWNDIR}/* backports/
  cat ${CWD}/${PSRCARCHIVES} | while IFS= read -r source ;do
    commit="$(echo "${source}" | awk '{print $1}')"
    ApplyPatch ${commit}.patch
  done
)
ApplyPatch 3d4cf7de48a74726694abbaa09f9804b845ff3ba.patch


### Fedora

### Arch
# https://github.com/systemd/systemd/issues/4789
ApplyPatch 0001-nspawn-don-t-hide-bind-tmp-mounts.patch
# these patches aren't upstream, but they make v232 more useable.
# https://github.com/systemd/systemd/issues/4575
ApplyPatch 0001-disable-RestrictAddressFamilies-on-i686.patch
# https://github.com/systemd/systemd/issues/4595
# https://github.com/systemd/systemd/issues/3826
ApplyPatch 0001-Revert-nspawn-try-to-bind-mount-resolved-s-resolv.co.patch

### Debian
ApplyPatch Don-t-enable-audit-by-default.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
