
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 --verbose --backup --verbose -i ${SB_PATCHDIR}/libtool.no.moved.warning.diff
patch -p1 -E --backup -z .rpath --verbose -i ${SB_PATCHDIR}/libtool-2.2.10-rpath.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libtool-2.4.2-TEMPORARY-disable-gcj-tests.patch

set +e +o pipefail
