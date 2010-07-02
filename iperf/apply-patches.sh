
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/iperf-2.0.4-debuginfo.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/iperf-2.0.4-tcpdual.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/iperf-2.0.4-svn20091201.patch

set +e +o pipefail
