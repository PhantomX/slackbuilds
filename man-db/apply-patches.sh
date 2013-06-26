
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.5.9-sgr.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.6.1-locale-fallback.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.6.2-invalid-cache.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.6.3-overrides.patch
# fixed memory leaks detected by valgrind
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.6.3-valgrind.patch
# fixed certain man pages to match options with --help and --usage
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.6.3-man-options.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
