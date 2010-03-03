
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-4.2.2-workaround-kolorpaintcrash.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
