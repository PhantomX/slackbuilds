
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

cp ${SB_PATCHDIR}/*.{diff,patch} ${SB_SROOT}/patches/
export DISTRIBUTION_PATCHES="patches/fontconfig-paths.diff \
  patches/openjdk7_nonreparenting-wm.diff \
  patches/java-1.7.0-openjdk-freetype-check-fix.patch\
  patches/giflib_5.1.diff"

set +e +o pipefail
