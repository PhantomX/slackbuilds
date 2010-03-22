
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

#zcat ${SB_PATCHDIR}/${NAME}.ins_base.diff.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
