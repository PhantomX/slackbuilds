
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Gentoo
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.6-filenames.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.6-usage.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.6-munpack.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.6-compile.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.6-paths.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.6-cve-2011-4919.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.6-clang.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
