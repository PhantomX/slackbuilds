
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .glx --verbose -i ${SB_PATCHDIR}/${NAME}-0.6.9-glx.patch
patch -p0 -E --backup -z .api --verbose -i ${SB_PATCHDIR}/${NAME}-0.6.9-api.patch

set +e +o pipefail
