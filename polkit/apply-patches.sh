
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/polkit-0.97-subject-scanning.patch
# http://bugs.gentoo.org/291116
xzcat ${CWD}/${PSRCARCHIVE} | patch -p1 -E --backup --verbose

set +e +o pipefail
