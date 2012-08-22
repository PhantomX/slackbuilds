
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-COPYING-updated-to-recent-version-of-http-www.gnu.or.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-dracut.conf.d-gentoo.conf.example-fix-header.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-dracut.conf.5.asc-s-dracut-conf.d-dracut.conf.d-g.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-include-the-omap_hsmmc-module-on-arm.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0005-mdraid-always-create-need_shutdown-if-we-have-assemb.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0006-add-back-scsi_wait_scan.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0007-network-reintroduce-rd.neednet.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0008-fips-set-boot-as-symlink-to-sysroot-boot-if-no-boot-.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0009-install-dracut-install.c-Ensure-deps-are-resolved-wh.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0010-install-dracut-install.c-Deal-gracefully-with-paths-.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0011-install-dracut-install.c-No-need-to-compare-the-NULL.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0012-udev-rules-Pre-usrmove-systemd-installs-might-not-fi.patch

set +e +o pipefail
