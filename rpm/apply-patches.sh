
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/rpm-4.5.90-devel-autodep.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/rpm-4.5.90-pkgconfig-path.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/rpm-4.5.90-gstreamer-provides.patch.gz | patch -p1 -E --backup --verbose || exit 1
# XXX only create provides for pkgconfig and libtool initially
zcat ${SB_PATCHDIR}/rpm-4.6.x-no-pkgconfig-reqs.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Patches already in upstream
zcat ${SB_PATCHDIR}/rpm-4.6.0-rc1-permit-tab.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/rpm-4.6.0-rc1-skip-equal-nevr.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/rpm-4.6.0-rc1-noarch-subpkg.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/rpm-4.6.0-rc1-defaultdocdir.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/rpm-4.6.0-rc1-fp-hash.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/rpm-4.6.0-rc1-file-debuginfo.patch.gz | patch -p1 -E --backup --verbose || exit 1
