
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/autogen-5.12-autoopts-config.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/autogen-5.12-pkgconfig.patch

set +e +o pipefail
