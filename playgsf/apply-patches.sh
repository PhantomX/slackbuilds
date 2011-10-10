
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .gcc46 --verbose -i ${SB_PATCHDIR}/${NAME}-0.7.1-gcc46.patch
patch -p1 -E --backup -z .bsys --verbose -i ${SB_PATCHDIR}/${NAME}-0.7.1-buildsystem.patch

set +e +o pipefail
