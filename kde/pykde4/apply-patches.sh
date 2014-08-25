
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pykde4-4.13.97-use_system_sip_dir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pykde4-4.12.3-python_library_realpath.patch

# debian patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/add_qt_kde_definitions.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix_kpythonpluginfactory_build.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/make_pykde4_respect_sip_flags.diff

set +e +o pipefail
