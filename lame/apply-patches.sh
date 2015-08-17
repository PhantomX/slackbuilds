
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/lame-noexecstack.patch.gz | patch -p1 -E --backup --verbose

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lame-3.99.5-automake-2.12.patch

# http://sourceforge.net/p/lame/patches/62/
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gtk3-port.patch
# autoconf things
patch -p0 -E --backup -z.gtk3 --verbose -i ${SB_PATCHDIR}/lame-mp3x-gtk3.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
