
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/libtool-2.2.4-nomovedwarning.patch.gz | patch -p1 --verbose --backup --verbose
patch -p0 -E --backup -z .rpath --verbose -i ${SB_PATCHDIR}/libtool-2.2.8-rpath.patch

set +e +o pipefail
