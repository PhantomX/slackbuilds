
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .dso --verbose -i ${SB_PATCHDIR}/e16-1.0.2-dso.patch

set +e +o pipefail
