
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nose-py32.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nose-manpage.patch

set +e +o pipefail
