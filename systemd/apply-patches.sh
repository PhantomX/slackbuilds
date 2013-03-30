
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/udev-microsoft-3000-keymap.patch
# From Slackware
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/60-cdrom_id.rules.diff

# Upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-udev-check-return-value-of-uname.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-utmp-wtmp-don-t-try-to-read-past-end-of-string.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
