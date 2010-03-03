
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-4.4.0-show-akonadi-kcm.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
