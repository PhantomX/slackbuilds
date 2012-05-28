
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/01-config-file-path.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/02-fix-compilation-of-timeout-extension.patch

set +e +o pipefail
