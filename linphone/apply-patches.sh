
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .ext --verbose -i ${SB_PATCHDIR}/${NAME}-3.3.0-external-mstreamer.patch
zcat ${SB_PATCHDIR}/${NAME}-3.1.0-nls.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
