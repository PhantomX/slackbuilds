
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.99.8-lib64.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-workaround-RHBZ-904790.patch

set +e +o pipefail
