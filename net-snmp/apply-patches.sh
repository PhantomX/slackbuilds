
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.6-pie.patch
zcat ${SB_PATCHDIR}/${NAME}-5.5-dir-fix.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.6-multilib.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.5-include-struct.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.5-apsl-copying.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.5-perl-linking.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.6-test-debug.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.6.1-mysql.patch

set +e +o pipefail
