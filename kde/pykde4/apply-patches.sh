
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/make_pykde4_respect_sip_flags.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix_kpythonpluginfactory_build.diff
# https://bugs.kde.org/show_bug.cgi?id=307676
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/pykde-pyqt-4.9.5.patch

set +e +o pipefail
