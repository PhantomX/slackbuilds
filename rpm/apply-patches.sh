
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/rpm-4.4.1-prereq.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/rpm-4.4.2-ghost-conflicts.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/rpm-4.4.2-trust.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/rpm-4.4.2.2-devel-autodep.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/rpm-4.4.2-rpmfc-skip.patch.gz | patch -p1 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/rpm-4.4.2.2-matchpathcon.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/rpm-4.4.2.1-no-popt.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/rpm-4.4.2.3-nss.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/rpm-4.4.2.2-autofoo.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/rpm-4.4.2.2-pkgconfig-path.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/rpm-4.4.2.3-queryformat-arch.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/rpm-4.4.2.3-no-order-rescan-limit.patch.gz | patch -p1 -E --backup --verbose || exit 1
