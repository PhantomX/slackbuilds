
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .jx --verbose -i ${SB_PATCHDIR}/glew-1.9.0-makefile.patch
# From Arch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/glxew_export_fix.diff

set +e +o pipefail
