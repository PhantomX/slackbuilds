
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/udev-microsoft-3000-keymap.patch
# From Slackware
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/60-cdrom_id.rules.diff

# Upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Reintroduce-f_type-comparison-macro.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-core-killall-use-procfs_file_alloca.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-crypt-setup-generator-correctly-check-return-of-strd.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
