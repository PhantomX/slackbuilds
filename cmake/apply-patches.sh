
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Link against the shared Python library rather than the static one
patch -p1 -E --backup -z .pylibs --verbose -i ${SB_PATCHDIR}/${NAME}-2.8.10-FindPythonLibs.patch
patch -p1 -E --backup -z .libform --verbose -i ${SB_PATCHDIR}/${NAME}-2.8.10-libform.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.8.7-FindBLAS.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.8.7-FindLAPACK.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.8.8-FindPkgConfig.patch
zcat ${SB_PATCHDIR}/${NAME}-2.8.0-kde3-include.patch.gz | patch -p0 -E --backup --verbose
# Patch to find DCMTK in Fedora (bug #720140)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-dcmtk.patch
# Patch to fix RindRuby vendor settings
# http://public.kitware.com/Bug/view.php?id=12965
# https://bugzilla.redhat.com/show_bug.cgi?id=822796
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cmake-findruby.patch
# Patch to fix FindPostgreSQL
# https://bugzilla.redhat.com/show_bug.cgi?id=828467
# http://public.kitware.com/Bug/view.php?id=13378
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cmake-FindPostgreSQL.patch
# Patch to fix ccmake DEL issue
# https://bugzilla.redhat.com/show_bug.cgi?id=869769
# http://public.kitware.com/Bug/view.php?id=13604
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cmake-ccmake-del-in-first-column.patch

set +e +o pipefail
