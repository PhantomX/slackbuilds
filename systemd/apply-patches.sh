
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/udev-microsoft-3000-keymap.patch
# From Slackware
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/60-cdrom_id.rules.diff

# Upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-acpi-fptd-fix-memory-leak-in-acpi_get_boot_usec.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-fix-lingering-references-to-var-lib-backlight-random.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-acpi-make-sure-we-never-free-an-uninitialized-pointe.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
