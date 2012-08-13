
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/udev-microsoft-3000-keymap.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-systemctl-fix-issue-with-systemctl-daemon-reexec.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-shutdown-recursively-mark-root-as-private-before-piv.patch
  
set +e +o pipefail
