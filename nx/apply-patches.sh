
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nx-3.5.0-optflags.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nx-3.5.0-syslibs.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/nx-3.5.0-libpng15.patch

set +e +o pipefail
