
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/guichan-0.8.1-extended-utf8-support.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/guichan-0.8.2-as-needed.patch

set +e +o pipefail
