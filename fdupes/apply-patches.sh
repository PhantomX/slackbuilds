
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fdupes-1.50-destdir.patch
# http://bugs.debian.org/213385
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fdupes-1.50-compare-file.patch
# http://bugs.debian.org/447601
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fdupes-1.50-lfs.patch
# http://bugs.debian.org/353789
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fdupes-1.50-typo.patch

set +e +o pipefail
