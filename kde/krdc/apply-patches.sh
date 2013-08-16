
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## upstreamable patches
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/kdenetwork-4.10.4-krdc_icon.patch

set +e +o pipefail
