
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pykde4-4.12.3-python_library_realpath.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pykde4-4.12.3-sip_4_15_5.patch

# debian patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/add_qt_kde_definitions.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix_kpythonpluginfactory_build.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/make_pykde4_respect_sip_flags.diff

set +e +o pipefail
