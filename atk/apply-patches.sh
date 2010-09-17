
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-build-problem-with-jhbuild.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-introspection-Associate-.gir-with-pkg-config-file.patch

set +e +o pipefail
