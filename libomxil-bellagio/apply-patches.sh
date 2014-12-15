
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bellagio-0.9.3-dynamicloader-linking.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bellagio-0.9.3-parallel-build.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bellagio-0.9.3-segfault-on-removeFromWaitResource.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libomxil-bellagio-0.9.3-fix_Werror.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libomxil-bellagio-0.9.3-nodoc.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libomxil-bellagio-0.9.3-unused.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/omxil_version.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
