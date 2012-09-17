
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.2-fixes.patch
zcat ${SB_PATCHDIR}/${NAME}-1.2-php-5.2.8-fix.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.2-fix-ode-assert.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.2-fix-modifying-php-strings-inline.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.2-ode-0.12.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.2-fix-build.patch

set +e +o pipefail
