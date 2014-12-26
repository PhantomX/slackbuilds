
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Link against the shared Python library rather than the static one
patch -p1 -E --backup -z .pylibs --verbose -i ${SB_PATCHDIR}/${NAME}-2.8.10-FindPythonLibs.patch
patch -p1 -E --backup -z .libform --verbose -i ${SB_PATCHDIR}/${NAME}-2.8.10-libform.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.0.0-FindBLAS.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.0.0-FindLAPACK.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.8.12-qt5.patch
zcat ${SB_PATCHDIR}/${NAME}-2.8.0-kde3-include.patch.gz | patch -p0 -E --backup --verbose
# Patch to find DCMTK in Fedora (bug #720140)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-dcmtk.patch
# Patch to fix RindRuby vendor settings
# http://public.kitware.com/Bug/view.php?id=12965
# https://bugzilla.redhat.com/show_bug.cgi?id=822796
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cmake-findruby.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cmake-2.8.11-rc4-lua-5.2.patch
# Add -fno-strict-aliasing when compiling cm_sha2.c
# http://www.cmake.org/Bug/view.php?id=14314
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cmake-strict_aliasing.patch

# Dirty fix for ruby 2.2.0
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/cmake-findruby22.patch

set +e +o pipefail
