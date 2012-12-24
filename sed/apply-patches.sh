
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .copy --verbose -i ${SB_PATCHDIR}/sed-4.2.2-copy.patch

set +e +o pipefail
