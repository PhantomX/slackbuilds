
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/arts-acinclude.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
zcat ${SB_PATCHDIR}/kdesdk-3.5.10-gcc44.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/kdesdk-3.5.7-subversion.patch.gz | patch -p1 -E --backup --verbose || exit 1

set +e +o pipefail
