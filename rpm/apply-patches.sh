
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/rpm-4.7.90-devel-autodep.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/rpm-4.5.90-pkgconfig-path.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/rpm-4.5.90-gstreamer-provides.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Patches already in upstream
zcat ${SB_PATCHDIR}/rpm-4.8.0-url-segfault.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/rpm-4.8.0-verify-exitcode.patch.gz | patch -p1 -E --backup --verbose || exit 1

# These are not yet upstream
zcat ${SB_PATCHDIR}/rpm-4.6.0-niagara.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/rpm-4.7.1-geode-i686.patch.gz | patch -p1 -E --backup --verbose || exit 1
