
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Extra library paths from Chinforinfula packages
patch -p0 -E --backup -z .ldpaths --verbose -i ${SB_PATCHDIR}/${NAME}-0.2.5-ldpaths.patch

set +e +o pipefail
