
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-desktop_fix.patch.gz | patch -p1 -E --backup --verbose || exit 1
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.4.7-ldflags.patch

set +e +o pipefail
