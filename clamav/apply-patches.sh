
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-0.92-private.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.92-open.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.95-cliopts.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.95.3-umask.patch

set +e +o pipefail
