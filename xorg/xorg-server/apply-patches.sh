
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

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

# Fix multiple monitors in reverse optimus configurations
ApplyPatch 0001-pixmap-fix-reverse-optimus-support-with-multiple-hea.patch

# submitted: http://lists.x.org/archives/xorg-devel/2013-October/037996.html
ApplyPatch exa-only-draw-valid-trapezoids.patch

# because the display-managers are not ready yet, do not upstream
ApplyPatch 0001-Fedora-hack-Make-the-suid-root-wrapper-always-start-.patch

# submitted http://lists.x.org/archives/xorg-devel/2014-July/042936.html
ApplyPatch 0001-xwayland-Snap-damage-reports-to-the-bounding-box.patch

# misc
ApplyPatch 0001-Fix-segfault-when-killing-X-with-ctrl-alt-backspace.patch

ApplyPatch xserver-force-hal-disable.patch

### Arch
# Use nouveau/nv/nvidia drivers for nvidia devices
ApplyPatch autoconfig-nvidia.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
