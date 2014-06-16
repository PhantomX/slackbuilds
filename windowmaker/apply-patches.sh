
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Arch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/giflib_510.diff

set +e +o pipefail
