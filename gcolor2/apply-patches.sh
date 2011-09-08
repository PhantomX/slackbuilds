
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-0.4-missing-includes.patch.gz | patch -p1 -E --backup --verbose
# From Arch
[ "${ARCH}" = "x86_64" ] && patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.4-amd64.patch

set +e +o pipefail
