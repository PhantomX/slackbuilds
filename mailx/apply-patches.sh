
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nail-11.25-config.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mailx-12.3-pager.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mailx-12.4-openssl.patch

set +e +o pipefail
