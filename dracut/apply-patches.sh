
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-network-understand-ip-.-dns1-dns2.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-dracut.sh-only-set-the-owner-of-files-to-0-0-if-gene.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-dracut-functions.sh-also-search-in-the-updates-direc.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0005-network-net-lib.sh-parse-ibft-nameserver-settings.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0006-network-ifup.sh-handle-dns1-and-dns2-from-ip-setting.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0007-base-rdsosreport.sh-add-dracut-version-to-rdsosrepor.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0008-test-include-the-same-Makefile.testdir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0009-network-ifup-do-not-ifup-an-already-setup-network-in.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0010-network-ifup-do-not-run-dhclient-twice-on-the-same-i.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0011-nfs-nfsroot-symlink-dev-null-to-dev-nfs-as-a-marker-.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0012-systemd-dracut-pre-pivot-run-for-dev-nfs-root-and-cl.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0013-Do-not-reload-systemd-with-wait_for_dev.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0014-systemd-add-sys-kernel-config.mount.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0015-Factor-out-all-the-type-V-commands.patch

set +e +o pipefail
