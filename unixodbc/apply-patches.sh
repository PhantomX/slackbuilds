
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/export-symbols.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/so-version-bump.patch
zcat ${SB_PATCHDIR}/keep-typedefs.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
