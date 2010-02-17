
SB_PATCHDIR=${CWD}/patches

# https://bugs.freedesktop.org/show_bug.cgi?id=23297
zcat ${SB_PATCHDIR}/0001-Squash-underscores-and-dashes-in-errors-when-convert.patch.gz | patch -p1 -E --backup --verbose || exit 1
