
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Use-RPM-compiler-options.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/c-ares-1.8.0-multilib.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
