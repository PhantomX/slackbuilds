
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-64bit.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-esd.patch
zcat ${SB_PATCHDIR}/${NAME}-strip-lib.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-multilib.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-CVE-2007-6720.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-CVE-2009-0179.patch

set +e +o pipefail
