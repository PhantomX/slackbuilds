
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pwauth-make.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pwauth-strchr.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pwauth-cleanup.patch

set +e +o pipefail
