
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -R -E --backup --verbose -d plugins/zzogl-pg/opengl -i ${SB_PATCHDIR}/${NAME}-revert-r5422.patch

set +e +o pipefail
