
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# From Arch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-openobex17.patch

set +e +o pipefail
