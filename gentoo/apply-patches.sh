
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gentoo-0.15.2-cflags.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gentoo-0.19.2-locales.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
