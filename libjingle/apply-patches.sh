
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-0.3.12-gcc44.patch.gz | patch -p1 -E --backup --verbose || exit 1
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.3.12-openssl.patch

set +e +o pipefail
