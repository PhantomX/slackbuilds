
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/udev-microsoft-3000-keymap.patch
# From Slackware
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/60-cdrom_id.rules.diff

# Upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-random-seed-we-should-return-errno-of-failed-loop_wr.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-core-cgroup-first-print-then-free.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-swap-fix-reverse-dependencies.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-cgroup-add-missing-equals-for-BlockIOWeight.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-nspawn-be-less-liberal-about-creating-bind-mount-des.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-polkit-Avoid-race-condition-in-scraping-proc.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
