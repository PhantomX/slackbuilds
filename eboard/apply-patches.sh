
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-1.1.1-gcc44.patch.gz | patch -p1 --verbose --backup
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.1-dlopen.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.1-ovflfix.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.1-libpng15.patch

set +e +o pipefail
