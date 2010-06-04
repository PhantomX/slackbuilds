
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/rpm-4.7.90-devel-autodep.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/rpm-4.5.90-pkgconfig-path.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/rpm-4.5.90-gstreamer-provides.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rpm-4.8.0-no-man-dirs.patch

# Patches already in upstream
zcat ${SB_PATCHDIR}/rpm-4.8.0-url-segfault.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/rpm-4.8.0-verify-exitcode.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rpm-4.8.0-pythondeps-parallel.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rpm-4.8.0-python-bytecompile.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rpm-4.8.0-lazy-statfs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rpm-4.8.0-erasure-dsi.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rpm-4.8.0-prep-keep-empty.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rpm-4.8.0-python-nocontexts.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rpm-4.8.0-python-mibool.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rpm-4.8.0-python-emptyds.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rpm-4.8.0-findlang-localedirs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rpm-4.8.0-spec-readline.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rpm-4.8.0-fsm-sbits.patch

# These are not yet upstream
zcat ${SB_PATCHDIR}/rpm-4.6.0-niagara.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/rpm-4.7.1-geode-i686.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rpm-4.8.0-pkgconfig-private.patch

set +e +o pipefail
