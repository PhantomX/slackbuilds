
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/nl.euro.diff.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.15-keycodes-man.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.15-unicode_start.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.15-resizecon-x86_64.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.15-serial-types.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
