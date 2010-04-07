
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ppl-0.10.2-Makefile.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ppl-0.10.2-gmp5.patch

set +e +o pipefail
