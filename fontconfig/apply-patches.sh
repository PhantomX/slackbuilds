
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# The wonderful extended version of the font so generously
# opened up for free modification and distribution by one
# for the previously proprietary font founderies, and that
# Stepan Roh did such a marvelous job on getting the ball
# rolling with should clearly (IMHO) be the default font:
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fontconfig.dejavu.diff

# Hardcode the default font search path rather than having
# fontconfig figure it out (and possibly follow symlinks, or
# index ugly bitmapped fonts):
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fontconfig.font.dir.list.diff

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fontconfig-2.8.0-sleep-less.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Copy-all-values-from-pattern-to-font-if-the-font-doe.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-fc-cache-crash-caused-by-looking-up-NULL-object-.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Bug_59385_-_Do_the_right_thing_for_intermixed_edit_a.patch

set +e +o pipefail
