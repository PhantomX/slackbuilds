
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .orig --verbose -i ${SB_PATCHDIR}/q7z-0.8.0-config.patch

set +e +o pipefail
