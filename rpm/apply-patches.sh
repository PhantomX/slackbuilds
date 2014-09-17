
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Disable autoconf config.site processing (rh#962837)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rpm-4.11.x-siteconfig.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rpm-4.9.90-no-man-dirs.patch
# gnupg2 comes installed by default, avoid need to drag in gnupg too
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rpm-4.8.1-use-gpg2.patch

# Patches already in upstream

# These are not yet upstream
zcat ${SB_PATCHDIR}/rpm-4.7.1-geode-i686.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rpm-4.9.1.1-ld-flags.patch
# Compressed debuginfo support (rh#833311)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rpm-4.10.0-dwz-debuginfo.patch
# Minidebuginfo support (rh#834073)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rpm-4.10.0-minidebuginfo.patch
# Fix CRC32 after dwz (rh#971119)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rpm-4.11.1-sepdebugcrcfix.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
