
set -e -o pipefail

SB_PATCHDIR=${CWD}/tpatches

zcat ${SB_PATCHDIR}/${NAME}-102434.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup -z .cookie --verbose -i ${SB_PATCHDIR}/tigervnc-cookie.patch
zcat ${SB_PATCHDIR}/${NAME}-viewer-reparent.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
