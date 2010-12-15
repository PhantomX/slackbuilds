
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/2.5.1-coreImage-parallel-build.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.5.1-build-plugins-fix.patch.gz | patch -p1 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.5.3-fontconfig.patch

set +e +o pipefail
