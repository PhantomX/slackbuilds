
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

#patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.4.5-format.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-fixbuild.patch

set +e +o pipefail
