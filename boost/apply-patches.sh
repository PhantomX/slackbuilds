
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/boost-version-override.patch.gz | patch -p0 -E --backup --verbose
sed "s/__SONAME__/${SONAMEVER}/" ${SB_PATCHDIR}/boost-gcc-soname.patch | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/boost-graph-compile.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/boost-1.41.0-shared_ptr_serialization.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
