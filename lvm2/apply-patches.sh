
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lvm2-set-default-preferred_names.patch
zcat ${SB_PATCHDIR}/10-dm.rules.in.diff.gz | patch -p1

set +e +o pipefail
