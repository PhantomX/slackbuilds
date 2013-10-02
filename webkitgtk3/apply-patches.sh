
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/webkit-1.3.10-nspluginwrapper.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-2.1.1-yarr.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
