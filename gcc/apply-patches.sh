# The set of patches from hell :)

SB_PATCHDIR=${CWD}/patches

# Smite the fixincludes:
zcat ${SB_PATCHDIR}/gcc-no_fixincludes.diff.gz | patch -p0 || exit 1

zcat ${SB_PATCHDIR}/gcc44-hash-style-both.patch.gz | patch -p0 || exit 1
zcat ${SB_PATCHDIR}/gcc44-libtool-no-rpath.patch.gz | patch -p0 -E --backup --verbose || exit 1
