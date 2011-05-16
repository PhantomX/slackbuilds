
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${CWD}/${PSRCARCHIVE} | patch -p1 -E --backup --verbose || exit 1
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/time-1.7-ru_maxrss-is-in-kilobytes-on-Linux.patch

set +e +o pipefail
