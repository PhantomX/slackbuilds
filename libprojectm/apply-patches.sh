
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Remove fonts from package:
zcat ${SB_PATCHDIR}/lib${PNAME}-fonts.patch.gz | patch -p1 -E --backup --verbose
# Bump soname
zcat ${SB_PATCHDIR}/lib${PNAME}-soname.patch.gz | patch -p1 -E --backup --verbose
# Turn off USE_THREADS until the bug is fixed upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libprojectM-USE_THREADS.patch
# Patches for clementine
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/01-change-texture-size.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/04-change-preset-duration.patch

set +e +o pipefail
