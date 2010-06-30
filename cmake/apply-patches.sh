
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Link against the shared Python library rather than the static one
zcat ${SB_PATCHDIR}/${NAME}-FindPythonLibs.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-FindPythonInterp.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.8.0-kde3-include.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
