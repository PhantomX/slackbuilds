
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-util-never-follow-symlinks-in-rm_rf_children.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-journal-PAGE_SIZE-is-not-known-on-ppc-and-other-arch.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-service-place-control-command-in-subcgroup-control.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-transaction-cancel-jobs-non-recursively-on-isolate.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0005-timedated-introduce-systemd-timedated-ntp.target-whi.patch

set +e +o pipefail
