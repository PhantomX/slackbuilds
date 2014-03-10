
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Arch (adapted)
patch -p5 -E --backup --verbose -i ${SB_PATCHDIR}/qwebview.patch

set +e +o pipefail
