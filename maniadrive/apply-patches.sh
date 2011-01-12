
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.2-fixes.patch
zcat ${SB_PATCHDIR}/${NAME}-1.2-php-5.2.8-fix.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.2-fix-ode-assert.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
