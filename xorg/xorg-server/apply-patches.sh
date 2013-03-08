
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

# Patches from Fedora

# This really could be done prettier.
ApplyPatch xserver-1.4.99-ssh-isnt-local.patch

# don't build the (broken) acpi code
ApplyPatch xserver-1.6.0-less-acpi-brokenness.patch

# ajax needs to upstream this
ApplyPatch xserver-1.6.99-right-of.patch
#zcat ${SB_PATCHDIR}/xserver-1.6.99-hush-prerelease-warning.patch.gz | patch -p1 --verbose

# backport pci slot claiming fix for kms drivers
# needed when building without xorg (aka s390x)
ApplyPatch xserver-1.12.2-xorg-touch-test.patch

ApplyPatch 0001-Always-install-vbe-and-int10-sdk-headers.patch

ApplyPatch 0001-xf86-return-NULL-for-compat-output-if-no-outputs.patch

# mustard: make the default queue length bigger to calm abrt down
ApplyPatch 0001-mieq-Bump-default-queue-size-to-512.patch

# some hotplug fixes/workaround
ApplyPatch 0001-xf86crtc-don-t-use-display-for-vx-vy-for-gpu-screens.patch
# autoconfig: send events
ApplyPatch 0001-randr-don-t-directly-set-changed-bits-in-randr-scree.patch
ApplyPatch 0001-randr-make-SetChanged-modify-the-main-protocol-scree.patch
ApplyPatch 0001-randr-only-respected-changed-on-the-protocol-screen.patch
ApplyPatch 0001-randr-report-changes-when-we-disconnect-a-GPU-slave.patch

# on way upstream: fixes for reverse optimus
ApplyPatch 0001-dix-allow-pixmap-dirty-helper-to-be-used-for-non-sha.patch

# misc
ApplyPatch 0001-Fix-segfault-when-killing-X-with-ctrl-alt-backspace.patch

ApplyPatch xserver-force-hal-disable.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
