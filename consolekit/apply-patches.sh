
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/consolekit-0.2.10-cleanup_console_tags.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/consolekit-shutdown-reboot-without-policies.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/consolekit-udev-acl-install_to_usr.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
