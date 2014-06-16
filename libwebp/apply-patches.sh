
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## Arch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libwebp-0.4.0-giflib-5.1.0.patch

set +e +o pipefail
