
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.2.4-enable_lua.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-libtool-pie.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.6.1-group-msg.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.6.0-soname.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.8.2-python-symbols.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
