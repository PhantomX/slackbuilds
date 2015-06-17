
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

# patch -p0 --verbose -i ${SB_PATCHDIR}/${NAME}.patch
ApplyPatch x11.startwithblackscreen.diff

### Fedora
# Submitted upstream
ApplyPatch 0001-headers-Fix-build-errors-with-latest-glibc.patch

# This really could be done prettier.
ApplyPatch xserver-1.4.99-ssh-isnt-local.patch

# ajax needs to upstream this
ApplyPatch xserver-1.6.99-right-of.patch
#zcat ${SB_PATCHDIR}/xserver-1.6.99-hush-prerelease-warning.patch.gz | patch -p1 --verbose

ApplyPatch 0001-Always-install-vbe-and-int10-sdk-headers.patch

# submitted: http://lists.x.org/archives/xorg-devel/2013-October/037996.html
ApplyPatch exa-only-draw-valid-trapezoids.patch

# because the display-managers are not ready yet, do not upstream
ApplyPatch 0001-Fedora-hack-Make-the-suid-root-wrapper-always-start-.patch

# rhbz1203780, submitted upstream
ApplyPatch 0001-linux-Add-linux_parse_vt_settings-and-linux_get_keep.patch
ApplyPatch 0002-linux-Add-a-may_fail-paramter-to-linux_parse_vt_sett.patch
ApplyPatch 0003-systemd-logind-Only-use-systemd-logind-integration-t.patch

# rhbz1208992, already upstream
ApplyPatch 0001-dix-Add-unaccelerated-valuators-to-the-ValuatorMask.patch
ApplyPatch 0002-dix-hook-up-the-unaccelerated-valuator-masks.patch

# misc
ApplyPatch 0001-Fix-segfault-when-killing-X-with-ctrl-alt-backspace.patch

ApplyPatch xserver-force-hal-disable.patch
ApplyPatch xserver-1.7.0-systemd209.patch

### Arch
ApplyPatch v2-xserver-Fix-a-crash-with-XDMCP-error-handler.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
