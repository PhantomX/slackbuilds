
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-5.4.1-pie.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-5.5-dir-fix.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-5.5-multilib.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-5.5-sensors3.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-5.5-udptable-index.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-5.5-missing-bcast.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-5.5-tcp-pid.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --verbose -i ${SB_PATCHDIR}/${NAME}-5.5-test-tmpdir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.5-include-struct.patch

set +e +o pipefail
